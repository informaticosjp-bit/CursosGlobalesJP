using System.Security.Claims;
using CursosCertificadosApp.Models.ViewModels;
using CursosCertificadosApp.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CursosCertificadosApp.Controllers
{
    [Authorize]
    public class CurriculumController : Controller
    {
        private readonly ICvService _cvService;
        private readonly IPaymentService _paymentService;
        private readonly IBcvRateService _bcvRateService;

        public CurriculumController(ICvService cvService, IPaymentService paymentService, IBcvRateService bcvRateService)
        {
            _cvService = cvService;
            _paymentService = paymentService;
            _bcvRateService = bcvRateService;
        }

        private int GetCurrentUserId()
        {
            var idClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            return int.TryParse(idClaim, out var id) ? id : 0;
        }

        // ==========================================
        // 1. VISTA PRINCIPAL DEL GENERADOR DE CV
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> Index()
        {
            var userId = GetCurrentUserId();
            var model = await _cvService.GetOrCreateUserCvAsync(userId);
            return View(model);
        }

        // ==========================================
        // 2. GUARDAR DATOS DEL CV
        // ==========================================
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Guardar(CvViewModel model)
        {
            var userId = GetCurrentUserId();
            await _cvService.SaveUserCvAsync(userId, model);
            TempData["SuccessMessage"] = "Tu información curricular ha sido guardada exitosamente.";
            return RedirectToAction(nameof(Index));
        }

        // ==========================================
        // 3. GENERADOR DE RESUMEN / "SOBRE MÍ" CON IA
        // ==========================================
        [HttpPost]
        public IActionResult GenerarResumenIa([FromBody] IaSummaryRequest request)
        {
            try
            {
                if (request == null)
                {
                    return BadRequest(new IaSummaryResponse { Success = false, Message = "Solicitud inválida" });
                }

                var summary = _cvService.GenerateProfessionalSummaryAi(request);
                return Json(new IaSummaryResponse
                {
                    Success = true,
                    Summary = summary,
                    Message = "Perfil profesional generado exitosamente con Inteligencia Artificial."
                });
            }
            catch (Exception ex)
            {
                return Json(new IaSummaryResponse
                {
                    Success = false,
                    Message = $"Error al generar resumen: {ex.Message}"
                });
            }
        }

        // ==========================================
        // 4. SOLICITUD DE DESBLOQUEO / PAGO ($1 USD)
        // ==========================================
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> SolicitarDesbloqueo(string paymentMethod, string transactionRef, IFormFile? proofFile)
        {
            var userId = GetCurrentUserId();
            if (string.IsNullOrWhiteSpace(transactionRef))
            {
                TempData["ErrorMessage"] = "Debes ingresar el número de referencia del pago realizado.";
                return RedirectToAction(nameof(Index));
            }

            if (proofFile == null || proofFile.Length == 0)
            {
                TempData["ErrorMessage"] = "La captura de pantalla o comprobante de pago es obligatorio.";
                return RedirectToAction(nameof(Index));
            }

            try
            {
                await _paymentService.RegisterCvPaymentAsync(userId, paymentMethod, transactionRef, proofFile);
                TempData["SuccessMessage"] = "¡Reporte de pago enviado con éxito! El Administrador Maestro validará tu comprobante y referencia para liberar la descarga oficial de tu Currículum en PDF.";
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Error al procesar el pago: {ex.Message}";
            }

            return RedirectToAction(nameof(Index));
        }

        // ==========================================
        // 5. VISTA DE IMPRESIÓN Y DESCARGA EN PDF (A4)
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> Imprimir(string? template, string? palette)
        {
            var userId = GetCurrentUserId();
            var model = await _cvService.GetOrCreateUserCvAsync(userId);

            if (!string.IsNullOrEmpty(template))
            {
                model.SelectedTemplate = template;
            }
            if (!string.IsNullOrEmpty(palette))
            {
                model.ColorPalette = palette;
            }

            var isUnlocked = model.IsUnlocked || User.IsInRole("Admin");
            ViewBag.IsUnlocked = isUnlocked;

            return View("Imprimir", model);
        }

        // ==========================================
        // 6. VER CV DE CUALQUIER USUARIO (ADMIN)
        // ==========================================
        [HttpGet]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> VerCv(int userId, string? template, string? palette)
        {
            var model = await _cvService.GetOrCreateUserCvAsync(userId);
            if (!string.IsNullOrEmpty(template))
            {
                model.SelectedTemplate = template;
            }
            if (!string.IsNullOrEmpty(palette))
            {
                model.ColorPalette = palette;
            }
            ViewBag.IsUnlocked = true;
            return View("Imprimir", model);
        }
    }
}
