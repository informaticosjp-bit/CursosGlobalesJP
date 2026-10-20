using CursosCertificadosApp.Data;
using CursosCertificadosApp.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace CursosCertificadosApp.Controllers
{
    [Authorize]
    public class AulaController : Controller
    {
        private readonly IProgressService _progressService;
        private readonly AppDbContext _context;

        public AulaController(IProgressService progressService, AppDbContext context)
        {
            _progressService = progressService;
            _context = context;
        }

        // Aula Virtual: Lecturas interactivas y presentaciones
        [HttpGet]
        public async Task<IActionResult> Aula(string slug, int? lessonId)
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId)) return Unauthorized();

            var session = await _progressService.GetStudySessionAsync(userId, slug, lessonId);
            if (session == null) return NotFound();

            return View(session);
        }

        // Marcar lectura completada y avanzar
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CompletarLeccion(int lessonId, string courseSlug)
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId)) return Unauthorized();

            var result = await _progressService.CompleteLessonAsync(userId, lessonId);

            // Redirigir a la siguiente lectura si existe
            var currentLesson = await _context.Lessons
                .Include(l => l.Module)
                .FirstOrDefaultAsync(l => l.Id == lessonId);

            if (currentLesson != null)
            {
                var nextLesson = await _context.Lessons
                    .Where(l => l.Module.CourseId == currentLesson.Module.CourseId &&
                                (l.Module.OrderIndex > currentLesson.Module.OrderIndex ||
                                (l.Module.OrderIndex == currentLesson.Module.OrderIndex && l.OrderIndex > currentLesson.OrderIndex)))
                    .OrderBy(l => l.Module.OrderIndex)
                    .ThenBy(l => l.OrderIndex)
                    .FirstOrDefaultAsync();

                if (nextLesson != null)
                {
                    return RedirectToAction("Aula", new { slug = courseSlug, lessonId = nextLesson.Id });
                }
            }

            // Si ya terminó todas las lecturas, enviar a la vista de evaluación final
            if (result.AllReadingsCompleted)
            {
                TempData["SuccessMessage"] = "¡Has completado todas las lecturas obligatorias! Ahora presenta la evaluación corta para validar tus conocimientos y desbloquear tu certificado.";
                return RedirectToAction("Evaluacion", new { slug = courseSlug });
            }

            return RedirectToAction("Aula", new { slug = courseSlug });
        }

        // Vista de Evaluación Corta de Fin de Curso
        [HttpGet]
        public async Task<IActionResult> Evaluacion(string slug)
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId)) return Unauthorized();

            var session = await _progressService.GetStudySessionAsync(userId, slug, null);
            if (session == null || session.Quiz == null) return NotFound();

            return View(session);
        }

        // Procesar respuestas del Cuestionario
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RendirEvaluacion(int quizId, string courseSlug, IFormCollection form)
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId)) return Unauthorized();

            var selectedOptions = new Dictionary<int, int>();
            foreach (var key in form.Keys)
            {
                if (key.StartsWith("question_") && int.TryParse(key.Replace("question_", ""), out int qId))
                {
                    if (int.TryParse(form[key], out int optionId))
                    {
                        selectedOptions[qId] = optionId;
                    }
                }
            }

            var result = await _progressService.SubmitQuizAsync(userId, quizId, selectedOptions);

            if (result.IsPassed)
            {
                TempData["SuccessMessage"] = $"¡Excelente! Aprobaste la evaluación con {result.ScorePercentage:F0}% ({result.CorrectAnswers} de {result.TotalQuestions} correctas). Tu certificado oficial ha sido generado.";
                return RedirectToAction("Completado", "Certificados", new { id = result.CertificateId });
            }
            else
            {
                TempData["ErrorMessage"] = $"Tu calificación fue de {result.ScorePercentage:F0}% ({result.CorrectAnswers} de {result.TotalQuestions} correctas). Necesitas un mínimo de 70% para aprobar. Revisa el contenido y vuelve a intentarlo.";
                return RedirectToAction("Evaluacion", new { slug = courseSlug });
            }
        }
    }
}
