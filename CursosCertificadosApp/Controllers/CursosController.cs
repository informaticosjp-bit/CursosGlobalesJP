using CursosCertificadosApp.Data;
using CursosCertificadosApp.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace CursosCertificadosApp.Controllers
{
    public class CursosController : Controller
    {
        private readonly AppDbContext _context;
        private readonly IProgressService _progressService;

        public CursosController(AppDbContext context, IProgressService progressService)
        {
            _context = context;
            _progressService = progressService;
        }

        // Catálogo general de cursos y rutas formativas
        [HttpGet]
        public async Task<IActionResult> Index(string? categoria, string? q)
        {
            var categories = await _context.Categories
                .Where(c => c.Courses.Any(co => co.IsPublished))
                .OrderBy(c => c.DisplayOrder)
                .ToListAsync();

            var query = _context.Courses
                .Include(c => c.Category)
                .Include(c => c.Modules)
                    .ThenInclude(m => m.Lessons)
                .Where(c => c.IsPublished);

            if (!string.IsNullOrEmpty(categoria))
            {
                query = query.Where(c => c.Category.Slug == categoria);
                ViewBag.CurrentCategory = categoria;
            }

            if (!string.IsNullOrEmpty(q))
            {
                query = query.Where(c => c.Title.ToLower().Contains(q.ToLower()) || c.ShortDescription.ToLower().Contains(q.ToLower()));
                ViewBag.SearchTerm = q;
            }

            var courses = await query.ToListAsync();
            ViewBag.Categories = categories;

            return View(courses);
        }

        // Detalle de un curso específico
        [HttpGet]
        public async Task<IActionResult> Detalle(string slug)
        {
            var course = await _context.Courses
                .Include(c => c.Category)
                .Include(c => c.Modules.OrderBy(m => m.OrderIndex))
                    .ThenInclude(m => m.Lessons.OrderBy(l => l.OrderIndex))
                .FirstOrDefaultAsync(c => c.Slug == slug);

            if (course == null) return NotFound();

            bool isEnrolled = false;
            decimal progress = 0;

            if (User.Identity?.IsAuthenticated == true)
            {
                var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
                if (int.TryParse(userIdStr, out int userId))
                {
                    var enrollment = await _context.CourseEnrollments
                        .FirstOrDefaultAsync(e => e.UserId == userId && e.CourseId == course.Id);

                    if (enrollment != null)
                    {
                        isEnrolled = true;
                        progress = enrollment.ProgressPercentage;
                    }
                }
            }

            ViewBag.IsEnrolled = isEnrolled;
            ViewBag.Progress = progress;

            return View(course);
        }

        // Inscribirse en un curso (100% Gratuito)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Inscribirse(int courseId)
        {
            if (User.Identity?.IsAuthenticated != true)
            {
                return RedirectToAction("Login", "Account", new { returnUrl = Url.Action("Detalle", new { slug = (await _context.Courses.FindAsync(courseId))?.Slug }) });
            }

            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId)) return Unauthorized();

            var enrollment = await _progressService.EnrollStudentAsync(userId, courseId);
            var course = await _context.Courses.FindAsync(courseId);

            TempData["SuccessMessage"] = $"¡Te has inscrito con éxito en '{course?.Title}'! Todo el contenido está libre para ti.";
            return RedirectToAction("Aula", "Aula", new { slug = course?.Slug });
        }
    }
}
