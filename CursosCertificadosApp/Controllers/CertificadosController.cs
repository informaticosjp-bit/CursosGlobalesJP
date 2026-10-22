using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models.Entities;
using CursosCertificadosApp.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace CursosCertificadosApp.Controllers
{
    public class CertificadosController : Controller
    {
        private readonly ICertificateService _certificateService;
        private readonly IPaymentService _paymentService;
        private readonly IBcvRateService _bcvRateService;
        private readonly AppDbContext _context;

        public CertificadosController(
            ICertificateService certificateService, 
            IPaymentService paymentService, 
            IBcvRateService bcvRateService,
            AppDbContext context)
        {
            _certificateService = certificateService;
            _paymentService = paymentService;
            _bcvRateService = bcvRateService;
            _context = context;
        }

        // Pantalla de celebración y checkout de $1 USD
        [Authorize]
        [HttpGet]
        public async Task<IActionResult> Completado(string id)
        {
            var cert = await _certificateService.GetCertificateByIdAsync(id);
            if (cert == null) return NotFound();

            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            bool isAdmin = User.IsInRole("Admin");
            if (!isAdmin && (!int.TryParse(userIdStr, out int userId) || cert.UserId != userId))
            {
                return Forbid();
            }

            var bcv = await _bcvRateService.GetCurrentRateAsync();
            ViewBag.BcvRate = bcv;

            return View(cert);
        }

        // Descarga de PDF oficial (Solo si está emitido/pagado)
        [Authorize]
        [HttpGet]
        public async Task<IActionResult> Descargar(string id)
        {
            var cert = await _certificateService.GetCertificateByIdAsync(id);
            if (cert == null) return NotFound();

            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            bool isAdmin = User.IsInRole("Admin");
            if (!isAdmin && (!int.TryParse(userIdStr, out int userId) || cert.UserId != userId))
            {
                return Forbid();
            }

            if (cert.Status != CertificateStatus.Issued)
            {
                TempData["ErrorMessage"] = "Tu certificado se encuentra bloqueado. Para descargarlo sin marca de agua debes registrar el pago de $1 USD.";
                return RedirectToAction("Completado", new { id });
            }

            var pdfBytes = _certificateService.GenerateOfficialPdf(cert);
            var fileName = $"Certificado_CursosGlobalesJP_{cert.VerificationCode}.pdf";

            return File(pdfBytes, "application/pdf", fileName);
        }

        // Registrar Solicitud de Certificado (Pago Móvil / Transferencia) con comprobante obligatorio
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> PagarManual(string certificateId, string paymentMethod, string transactionReference, IFormFile? proofFile)
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId)) return Unauthorized();

            if (string.IsNullOrWhiteSpace(transactionReference))
            {
                TempData["ErrorMessage"] = "Debes ingresar el número de referencia bancaria emitido por tu banco.";
                return RedirectToAction("Completado", new { id = certificateId });
            }

            if (proofFile == null || proofFile.Length == 0)
            {
                TempData["ErrorMessage"] = "Debes adjuntar obligatoriamente la captura o comprobante de pago bancario.";
                return RedirectToAction("Completado", new { id = certificateId });
            }

            await _paymentService.RegisterManualPaymentAsync(certificateId, userId, paymentMethod, transactionReference.Trim(), proofFile);

            TempData["SuccessMessage"] = $"¡Solicitud de certificado enviada con éxito! Tu reporte con referencia {transactionReference.Trim()} se encuentra en revisión administrativa. Una vez aprobado, tu diploma oficial se liberará automáticamente para descarga.";
            return RedirectToAction("Completado", new { id = certificateId });
        }

        // Página de Verificación Pública (Abierta a reclutadores, empresas y LinkedIn)
        [HttpGet]
        public async Task<IActionResult> Verificar(string? id)
        {
            if (string.IsNullOrWhiteSpace(id))
            {
                return View("PortalValidacion");
            }

            var cleanId = id.Trim();
            var cert = await _certificateService.GetCertificateByVerificationCodeAsync(cleanId)
                       ?? await _certificateService.GetCertificateByIdAsync(cleanId);

            if (cert == null)
            {
                ViewBag.NotFoundCode = cleanId;
                return View("NoEncontrado");
            }

            return View(cert);
        }
    }
}
