using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models.Entities;
using Microsoft.EntityFrameworkCore;
using QRCoder;
using QuestPDF.Fluent;
using QuestPDF.Helpers;
using QuestPDF.Infrastructure;
using System.Security.Cryptography;

namespace CursosCertificadosApp.Services
{
    public class CertificateService : ICertificateService
    {
        private readonly AppDbContext _context;
        private readonly IWebHostEnvironment _env;

        public CertificateService(AppDbContext context, IWebHostEnvironment env)
        {
            _context = context;
            _env = env;
            QuestPDF.Settings.License = LicenseType.Community;
        }

        public async Task<Certificate> GenerateLockedCertificateAsync(int enrollmentId, decimal? quizScore = null)
        {
            var enrollment = await _context.CourseEnrollments
                .Include(e => e.User)
                .Include(e => e.Course)
                .FirstOrDefaultAsync(e => e.Id == enrollmentId);

            if (enrollment == null)
            {
                throw new ArgumentException("Inscripción no encontrada.");
            }

            var existing = await _context.Certificates
                .FirstOrDefaultAsync(c => c.UserId == enrollment.UserId && c.CourseId == enrollment.CourseId);

            if (existing != null)
            {
                if (quizScore.HasValue) existing.QuizScore = quizScore.Value;
                await _context.SaveChangesAsync();
                return existing;
            }

            var randomHex = Convert.ToHexString(RandomNumberGenerator.GetBytes(3));
            var verificationCode = $"CGJP-{DateTime.UtcNow.Year}-{randomHex}";

            var qrCodeBase64 = GenerateQrCodeBase64($"https://cursos.globalesjp.net/Certificados/Verificar/{verificationCode}");

            var certificate = new Certificate
            {
                Id = Guid.NewGuid().ToString("N"),
                VerificationCode = verificationCode,
                UserId = enrollment.UserId,
                CourseId = enrollment.CourseId,
                CreatedAt = DateTime.UtcNow,
                Status = CertificateStatus.Locked,
                QuizScore = quizScore,
                QrCodeBase64 = qrCodeBase64
            };

            _context.Certificates.Add(certificate);
            await _context.SaveChangesAsync();

            return certificate;
        }

        public async Task<Certificate?> IssueCertificateAsync(string certificateId)
        {
            var cert = await _context.Certificates
                .Include(c => c.User)
                .Include(c => c.Course)
                .FirstOrDefaultAsync(c => c.Id == certificateId);

            if (cert == null) return null;

            cert.Status = CertificateStatus.Issued;
            cert.IssuedAt = DateTime.UtcNow;

            var webRoot = _env.WebRootPath ?? Path.Combine(_env.ContentRootPath, "wwwroot");
            var certificatesDir = Path.Combine(webRoot, "generated-certificates");
            if (!Directory.Exists(certificatesDir))
            {
                Directory.CreateDirectory(certificatesDir);
            }

            var fileName = $"Certificado_{cert.VerificationCode}.pdf";
            var fullPath = Path.Combine(certificatesDir, fileName);

            var pdfBytes = GenerateOfficialPdf(cert);
            await File.WriteAllBytesAsync(fullPath, pdfBytes);

            cert.FinalPdfPath = $"/generated-certificates/{fileName}";
            await _context.SaveChangesAsync();

            return cert;
        }

        public async Task<Certificate?> GetCertificateByIdAsync(string certificateId)
        {
            return await _context.Certificates
                .Include(c => c.User)
                .Include(c => c.Course)
                .Include(c => c.Payments)
                .FirstOrDefaultAsync(c => c.Id == certificateId);
        }

        public async Task<Certificate?> GetCertificateByVerificationCodeAsync(string code)
        {
            if (string.IsNullOrWhiteSpace(code)) return null;
            var cleanCode = code.Trim().ToUpper();
            return await _context.Certificates
                .Include(c => c.User)
                .Include(c => c.Course)
                .FirstOrDefaultAsync(c => c.VerificationCode.ToUpper() == cleanCode || c.Id.ToUpper() == cleanCode);
        }

        public byte[] GenerateOfficialPdf(Certificate cert)
        {
            var webRoot = _env.WebRootPath ?? Path.Combine(_env.ContentRootPath, "wwwroot");
            var logoPath = Path.Combine(webRoot, "images", "logo-jp.png");
            byte[]? logoBytes = File.Exists(logoPath) ? File.ReadAllBytes(logoPath) : null;
            var isLocked = cert.Status != CertificateStatus.Issued;
            var verificationUrl = $"https://cursos.globalesjp.net/Certificados/Verificar/{cert.VerificationCode}";
            var issueDate = (cert.IssuedAt ?? cert.CreatedAt).ToString("dd 'de' MMMM 'de' yyyy", new System.Globalization.CultureInfo("es-ES"));

            byte[]? qrBytes = null;
            try
            {
                using var qrGenerator = new QRCodeGenerator();
                using var qrCodeData = qrGenerator.CreateQrCode(verificationUrl, QRCodeGenerator.ECCLevel.Q);
                using var pngByteCode = new PngByteQRCode(qrCodeData);
                qrBytes = pngByteCode.GetGraphic(20);
            }
            catch
            {
                if (!string.IsNullOrEmpty(cert.QrCodeBase64))
                {
                    qrBytes = Convert.FromBase64String(cert.QrCodeBase64);
                }
            }

            var modulesCount = cert.Course.Modules?.Count ?? 0;
            var modulesText = modulesCount > 0 ? $" | {modulesCount} Módulos" : "";

            var document = Document.Create(container =>
            {
                container.Page(page =>
                {
                    page.Size(PageSizes.A4.Landscape());
                    page.Margin(0);
                    page.PageColor(Colors.White);

                    page.Content().Layers(layers =>
                    {
                        // Marca de Agua suave si está bloqueado / vista previa
                        if (isLocked)
                        {
                            layers.Layer().AlignCenter().AlignMiddle().Rotate(-25).Text("VISTA PREVIA NO VÁLIDA · PENDIENTE DE DESBLOQUEO")
                                .FontColor("#F1F5F9")
                                .FontSize(26)
                                .Bold();
                        }

                        var titleLength = cert.Course.Title?.Length ?? 0;
                        var footerPadding = titleLength > 50 ? 125 : 145;
                        var leftBottomPadding = footerPadding + 35;

                        // Capa principal dividida en dos columnas según el diseño exacto de referencia
                        layers.PrimaryLayer().Row(row =>
                        {
                            // PANEL LATERAL IZQUIERDO (Ancho ~225pt)
                            row.ConstantItem(225).BorderRight(1).BorderColor("#E2E8F0").PaddingHorizontal(28).PaddingVertical(32).Column(leftCol =>
                            {
                                // Logo + Cursos Globales JP / Aprendizaje Online
                                leftCol.Item().Row(lr =>
                                {
                                    if (logoBytes != null)
                                    {
                                        lr.ConstantItem(36).Image(logoBytes);
                                        lr.ConstantItem(10);
                                    }

                                    lr.RelativeItem().Column(bc =>
                                    {
                                        bc.Item().Row(nr =>
                                        {
                                            nr.AutoItem().Text("CURSOS GLOBALES").FontSize(11).Bold().FontColor("#0F172A");
                                            nr.AutoItem().Text("JP").FontSize(11).ExtraBold().FontColor("#DC2626");
                                        });
                                        bc.Item().Text("Aprendizaje Online").FontSize(9.5f).FontColor("#64748B");
                                    });
                                });

                                // Texto medio descriptivo
                                leftCol.Item().PaddingTop(120).Text("Credencial oficial electrónica con código de verificación emitida por la plataforma de capacitación continua.")
                                    .FontSize(7).FontColor("#94A3B8").LineHeight(1.35f);

                                // Espacio para ubicar el QR exactamente al pie de la página
                                leftCol.Item().PaddingTop(leftBottomPadding);

                                if (qrBytes != null && qrBytes.Length > 0)
                                {
                                    leftCol.Item().Width(72).Image(qrBytes);
                                    leftCol.Item().PaddingTop(6).Text("Escanear para verificar").FontSize(7).FontColor("#94A3B8");
                                }

                                leftCol.Item().PaddingTop(10).Column(sc =>
                                {
                                    sc.Item().Text("Número de serie:").FontSize(8).FontColor("#64748B");
                                    sc.Item().Text(cert.VerificationCode).FontSize(9).Bold().FontColor("#0F284E");
                                });
                            });

                            // CUERPO PRINCIPAL DERECHO (Ancho restante ~617pt)
                            row.RelativeItem().PaddingHorizontal(44).PaddingVertical(32).Column(mainCol =>
                            {
                                // Encabezado Superior: "CERTIFICADO DE FINALIZACIÓN" a la izq y "A C R E D I T A C I Ó N   V E R I F I C A B L E" a la der
                                mainCol.Item().Row(topRow =>
                                {
                                    topRow.RelativeItem().Column(tc =>
                                    {
                                        tc.Item().Text("CERTIFICADO DE").FontSize(18).Bold().FontColor("#627D98").LetterSpacing(0.5f);
                                        tc.Item().Text("FINALIZACIÓN").FontSize(18).Bold().FontColor("#627D98").LetterSpacing(0.5f);
                                    });

                                    topRow.AutoItem().PaddingTop(6).Text("A C R E D I T A C I Ó N   V E R I F I C A B L E")
                                        .FontSize(8).Bold().FontColor("#10B981");
                                });

                                // Cuerpo del Certificado
                                mainCol.Item().PaddingTop(50).Text("Certificado de finalización de")
                                    .FontSize(11.5f).FontColor("#64748B");

                                mainCol.Item().PaddingTop(4).Text(cert.User.FullName)
                                    .FontSize(28).ExtraBold().FontColor("#0F172A");

                                if (!string.IsNullOrWhiteSpace(cert.User.IdentificationNumber))
                                {
                                    mainCol.Item().PaddingTop(2).Text($"Documento de Identidad: {cert.User.IdentificationNumber}")
                                        .FontSize(9.5f).FontColor("#64748B");
                                }

                                // Línea de acento distintiva roja
                                mainCol.Item().PaddingTop(10).Width(40).LineHorizontal(2.5f).LineColor("#DC2626");

                                mainCol.Item().PaddingTop(14).Text(cert.Course.Title)
                                    .FontSize(20).ExtraBold().FontColor("#0F172A");

                                mainCol.Item().PaddingTop(6).Text($"Curso completado satisfactoriamente el {issueDate}")
                                    .FontSize(10).FontColor("#475569");

                                mainCol.Item().PaddingTop(2).Text($"{cert.Course.EstimatedHours:F1} Horas lectivas{modulesText}")
                                    .FontSize(9.5f).FontColor("#64748B");

                                // Pie de Página anclado al fondo de la hoja
                                mainCol.Item().PaddingTop(footerPadding).Text("Contenido académico desarrollado por")
                                    .FontSize(8).FontColor("#94A3B8");

                                mainCol.Item().PaddingTop(3).Row(cr =>
                                {
                                    cr.AutoItem().Text("Cursos Globales JP").FontSize(11).Bold().FontColor("#0F172A");
                                    cr.AutoItem().PaddingHorizontal(8).Text("•").FontSize(9).FontColor("#CBD5E1");
                                    cr.AutoItem().Text("https://cursos.globalesjp.net").FontSize(10.5f).Bold().FontColor("#2563EB");
                                });

                                mainCol.Item().PaddingTop(16).BorderTop(0.5f).BorderColor("#E2E8F0").PaddingTop(8).Text(
                                    $"Para validar la autenticidad y vigencia de esta credencial académica, ingrese a: {verificationUrl}")
                                    .FontSize(7).FontColor("#94A3B8");
                            });
                        });
                    });
                });
            });

            return document.GeneratePdf();
        }

        private static string GenerateQrCodeBase64(string text)
        {
            using var qrGenerator = new QRCodeGenerator();
            using var qrCodeData = qrGenerator.CreateQrCode(text, QRCodeGenerator.ECCLevel.Q);
            using var pngByteCode = new PngByteQRCode(qrCodeData);
            var qrBytes = pngByteCode.GetGraphic(20);
            return Convert.ToBase64String(qrBytes);
        }
    }
}
