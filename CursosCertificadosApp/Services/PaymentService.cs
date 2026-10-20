using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace CursosCertificadosApp.Services
{
    public class PaymentService : IPaymentService
    {
        private readonly AppDbContext _context;
        private readonly ICertificateService _certificateService;
        private readonly IWebHostEnvironment _env;

        public PaymentService(AppDbContext context, ICertificateService certificateService, IWebHostEnvironment env)
        {
            _context = context;
            _certificateService = certificateService;
            _env = env;
        }

        public async Task<Payment> ProcessAutomaticPaymentAsync(string certificateId, int userId, string paymentMethod, string transactionRef)
        {
            var certificate = await _context.Certificates.Include(c => c.Course).FirstOrDefaultAsync(c => c.Id == certificateId);
            if (certificate == null) throw new ArgumentException("Certificado no encontrado.");

            var coursePrice = certificate.Course?.Price ?? 1.00m;

            var payment = new Payment
            {
                CertificateId = certificateId,
                UserId = userId,
                Amount = coursePrice,
                PaymentMethod = paymentMethod,
                TransactionReference = transactionRef,
                Status = "Approved",
                CreatedAt = DateTime.UtcNow,
                ProcessedAt = DateTime.UtcNow,
                AdminNotes = "Aprobado automáticamente por Pasarela Digital"
            };

            _context.Payments.Add(payment);
            await _context.SaveChangesAsync();

            // Emitir certificado inmediatamente
            await _certificateService.IssueCertificateAsync(certificateId);

            return payment;
        }

        public async Task<Payment> RegisterManualPaymentAsync(string certificateId, int userId, string paymentMethod, string transactionRef, IFormFile? proofFile)
        {
            var certificate = await _context.Certificates.Include(c => c.Course).FirstOrDefaultAsync(c => c.Id == certificateId);
            if (certificate == null) throw new ArgumentException("Certificado no encontrado.");

            string? proofUrl = null;

            if (proofFile != null && proofFile.Length > 0)
            {
                var webRoot = _env.WebRootPath ?? Path.Combine(_env.ContentRootPath, "wwwroot");
                var uploadsDir = Path.Combine(webRoot, "uploads", "comprobantes");
                if (!Directory.Exists(uploadsDir))
                {
                    Directory.CreateDirectory(uploadsDir);
                }

                var ext = Path.GetExtension(proofFile.FileName);
                var fileName = $"Voucher_{certificate.VerificationCode}_{Guid.NewGuid():N}{ext}";
                var filePath = Path.Combine(uploadsDir, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await proofFile.CopyToAsync(stream);
                }

                proofUrl = $"/uploads/comprobantes/{fileName}";
            }

            var coursePrice = certificate.Course?.Price ?? 1.00m;

            var payment = new Payment
            {
                CertificateId = certificateId,
                UserId = userId,
                Amount = coursePrice,
                PaymentMethod = paymentMethod,
                TransactionReference = transactionRef,
                ProofImageUrl = proofUrl,
                Status = "Pending",
                CreatedAt = DateTime.UtcNow
            };

            _context.Payments.Add(payment);

            // Cambiar certificado a estado Pendiente de Validación
            certificate.Status = CertificateStatus.PendingPayment;
            await _context.SaveChangesAsync();

            return payment;
        }

        public async Task<Payment> RegisterMembershipPaymentAsync(int userId, string paymentMethod, string transactionRef, IFormFile? proofFile)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == userId);
            if (user == null) throw new ArgumentException("Usuario no encontrado.");

            string? proofUrl = null;

            if (proofFile != null && proofFile.Length > 0)
            {
                var webRoot = _env.WebRootPath ?? Path.Combine(_env.ContentRootPath, "wwwroot");
                var uploadsDir = Path.Combine(webRoot, "uploads", "comprobantes");
                if (!Directory.Exists(uploadsDir))
                {
                    Directory.CreateDirectory(uploadsDir);
                }

                var ext = Path.GetExtension(proofFile.FileName);
                var fileName = $"Membresia_{user.Id}_{Guid.NewGuid():N}{ext}";
                var filePath = Path.Combine(uploadsDir, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await proofFile.CopyToAsync(stream);
                }

                proofUrl = $"/uploads/comprobantes/{fileName}";
            }

            var payment = new Payment
            {
                CertificateId = null,
                UserId = userId,
                Amount = 10.00m,
                PaymentType = "CreatorMembership",
                PaymentMethod = paymentMethod,
                TransactionReference = transactionRef,
                ProofImageUrl = proofUrl,
                Status = "Pending",
                CreatedAt = DateTime.UtcNow
            };

            _context.Payments.Add(payment);
            await _context.SaveChangesAsync();

            return payment;
        }

        public async Task<Payment> RegisterCvPaymentAsync(int userId, string paymentMethod, string transactionRef, IFormFile? proofFile)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == userId);
            if (user == null) throw new ArgumentException("Usuario no encontrado.");

            string? proofUrl = null;

            if (proofFile != null && proofFile.Length > 0)
            {
                var webRoot = _env.WebRootPath ?? Path.Combine(_env.ContentRootPath, "wwwroot");
                var uploadsDir = Path.Combine(webRoot, "uploads", "comprobantes");
                if (!Directory.Exists(uploadsDir))
                {
                    Directory.CreateDirectory(uploadsDir);
                }

                var ext = Path.GetExtension(proofFile.FileName);
                var fileName = $"CvPago_{user.Id}_{Guid.NewGuid():N}{ext}";
                var filePath = Path.Combine(uploadsDir, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await proofFile.CopyToAsync(stream);
                }

                proofUrl = $"/uploads/comprobantes/{fileName}";
            }

            var payment = new Payment
            {
                CertificateId = null,
                UserId = userId,
                Amount = 1.00m,
                PaymentType = "CvGenerator",
                PaymentMethod = paymentMethod,
                TransactionReference = transactionRef,
                ProofImageUrl = proofUrl,
                Status = "Pending",
                CreatedAt = DateTime.UtcNow
            };

            _context.Payments.Add(payment);
            await _context.SaveChangesAsync();

            return payment;
        }

        public async Task<bool> ApprovePaymentAsync(int paymentId, string? adminNotes)
        {
            var payment = await _context.Payments
                .Include(p => p.Certificate)
                    .ThenInclude(c => c!.Course)
                .Include(p => p.User)
                .FirstOrDefaultAsync(p => p.Id == paymentId);

            if (payment == null) return false;

            payment.Status = "Approved";
            payment.ProcessedAt = DateTime.UtcNow;
            payment.AdminNotes = adminNotes ?? "Aprobado en revisión administrativa";

            if (payment.PaymentType == "CreatorMembership")
            {
                var user = payment.User ?? await _context.Users.FindAsync(payment.UserId);
                if (user != null)
                {
                    user.Role = "Creator";
                }

                var notif = new UserNotification
                {
                    UserId = payment.UserId,
                    Title = "🎉 ¡Membresía de Creador Aprobada!",
                    Message = "¡Felicidades! Tu membresía anual como Creador Oficial de Cursos Globales JP ha sido aprobada. Ahora tienes acceso al selector 'Modo Creador' para estructurar tus propios cursos y ganar el 80% de comisión por cada certificado emitido.",
                    Type = "Success",
                    IsRead = false,
                    CreatedAt = DateTime.UtcNow
                };
                _context.UserNotifications.Add(notif);
            }
            else if (payment.PaymentType == "CvGenerator")
            {
                var notif = new UserNotification
                {
                    UserId = payment.UserId,
                    Title = "📄 ¡Generador de Currículum Desbloqueado!",
                    Message = "¡Felicidades! Tu pago de $1.00 USD para el Generador Inteligente de Currículum ha sido aprobado con éxito. Ya puedes exportar y descargar tu CV profesional en formato PDF con todas las plantillas disponibles.",
                    Type = "Success",
                    IsRead = false,
                    CreatedAt = DateTime.UtcNow
                };
                _context.UserNotifications.Add(notif);
            }
            else
            {
                if (!string.IsNullOrEmpty(payment.CertificateId))
                {
                    await _certificateService.IssueCertificateAsync(payment.CertificateId);
                }

                var notif = new UserNotification
                {
                    UserId = payment.UserId,
                    Title = "🎓 ¡Pago de Certificado Aprobado!",
                    Message = "Tu pago para el certificado oficial ha sido verificado con éxito. Ya puedes descargarlo en formato PDF de alta resolución desde tu panel de estudiante.",
                    Type = "Success",
                    IsRead = false,
                    CreatedAt = DateTime.UtcNow
                };
                _context.UserNotifications.Add(notif);
            }

            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> RejectPaymentAsync(int paymentId, string reason)
        {
            var payment = await _context.Payments
                .Include(p => p.Certificate)
                .FirstOrDefaultAsync(p => p.Id == paymentId);

            if (payment == null) return false;

            payment.Status = "Rejected";
            payment.ProcessedAt = DateTime.UtcNow;
            payment.AdminNotes = $"Rechazado: {reason}";

            if (payment.PaymentType == "CreatorMembership")
            {
                var notif = new UserNotification
                {
                    UserId = payment.UserId,
                    Title = "⚠️ Solicitud de Membresía Rechazada",
                    Message = $"Tu pago para la membresía de Creador no pudo ser verificado. Motivo: {reason}. Por favor verifica el comprobante e intenta nuevamente.",
                    Type = "Warning",
                    IsRead = false,
                    CreatedAt = DateTime.UtcNow
                };
                _context.UserNotifications.Add(notif);
            }
            else
            {
                if (payment.Certificate != null)
                {
                    payment.Certificate.Status = CertificateStatus.Locked;
                }

                var notif = new UserNotification
                {
                    UserId = payment.UserId,
                    Title = "⚠️ Solicitud de Certificado Rechazada",
                    Message = $"Tu pago para el certificado no pudo ser verificado. Motivo: {reason}. Puedes registrar nuevamente tu comprobante con el número de referencia correcto.",
                    Type = "Warning",
                    IsRead = false,
                    CreatedAt = DateTime.UtcNow
                };
                _context.UserNotifications.Add(notif);
            }

            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<List<Payment>> GetPendingPaymentsAsync()
        {
            return await _context.Payments
                .Include(p => p.User)
                .Include(p => p.Certificate)
                    .ThenInclude(c => c!.Course)
                .Where(p => p.Status == "Pending")
                .OrderByDescending(p => p.CreatedAt)
                .ToListAsync();
        }

        public async Task<List<Payment>> GetApprovedPaymentsAsync()
        {
            return await _context.Payments
                .Include(p => p.User)
                .Include(p => p.Certificate)
                    .ThenInclude(c => c!.Course)
                .Where(p => p.Status == "Approved")
                .OrderByDescending(p => p.ProcessedAt ?? p.CreatedAt)
                .ToListAsync();
        }

        public async Task<List<Payment>> GetAllPaymentsAsync()
        {
            return await _context.Payments
                .Include(p => p.User)
                .Include(p => p.Certificate)
                    .ThenInclude(c => c!.Course)
                .OrderByDescending(p => p.CreatedAt)
                .ToListAsync();
        }
    }
}
