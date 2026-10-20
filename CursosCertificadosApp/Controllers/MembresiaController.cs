using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models.Entities;
using CursosCertificadosApp.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace CursosCertificadosApp.Controllers
{
    [Authorize]
    public class MembresiaController : Controller
    {
        private readonly AppDbContext _context;
        private readonly IPaymentService _paymentService;
        private readonly IBcvRateService _bcvRateService;

        public MembresiaController(
            AppDbContext context, 
            IPaymentService paymentService, 
            IBcvRateService bcvRateService)
        {
            _context = context;
            _paymentService = paymentService;
            _bcvRateService = bcvRateService;
        }

        // Pantalla de checkout de la membresía anual de creador ($10 USD)
        [HttpGet]
        public async Task<IActionResult> Creador()
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId)) return RedirectToAction("Login", "Account");

            var user = await _context.Users.FindAsync(userId);
            if (user == null) return NotFound();

            var bcv = await _bcvRateService.GetCurrentRateAsync();
            ViewBag.BcvRate = bcv;
            ViewBag.User = user;

            // Revisar si ya es creador
            ViewBag.IsCreator = user.Role == "Creator" || user.Role == "Admin";

            // Revisar si tiene pago de membresía pendiente
            var pendingPayment = await _context.Payments
                .Where(p => p.UserId == userId && p.PaymentType == "CreatorMembership" && p.Status == "Pending")
                .OrderByDescending(p => p.CreatedAt)
                .FirstOrDefaultAsync();

            ViewBag.PendingPayment = pendingPayment;

            return View(user);
        }

        // Procesar reporte de pago de membresía ($10 USD)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> PagarMembresia(string paymentMethod, string transactionReference, IFormFile? proofFile)
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId)) return Unauthorized();

            if (string.IsNullOrWhiteSpace(transactionReference))
            {
                TempData["ErrorMessage"] = "Debes ingresar el número de referencia emitido por tu banco o plataforma de pago.";
                return RedirectToAction("Creador");
            }

            if (proofFile == null || proofFile.Length == 0)
            {
                TempData["ErrorMessage"] = "Debes adjuntar obligatoriamente el comprobante o captura de pantalla del pago.";
                return RedirectToAction("Creador");
            }

            try
            {
                await _paymentService.RegisterMembershipPaymentAsync(userId, paymentMethod, transactionReference.Trim(), proofFile);
                TempData["SuccessMessage"] = $"¡Comprobante de membresía enviado con éxito! Tu referencia {transactionReference.Trim()} ha sido enviada al Administrador para su aprobación. Al validarse, se activará tu acceso a 'Modo Creador' y recibirás una notificación en tu cuenta.";
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = "Error al procesar la solicitud: " + ex.Message;
            }

            return RedirectToAction("Creador");
        }
    }
}
