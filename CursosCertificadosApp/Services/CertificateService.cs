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
        private readonly ISiteSettingService _siteSettingService;

        public CertificateService(AppDbContext context, IWebHostEnvironment env, ISiteSettingService siteSettingService)
        {
            _context = context;
            _env = env;
            _siteSettingService = siteSettingService;
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
            var certConfig = _siteSettingService.GetCertificateTemplateSync();
            var webRoot = _env.WebRootPath ?? Path.Combine(_env.ContentRootPath, "wwwroot");

            string logoPath;
            if (!string.IsNullOrWhiteSpace(certConfig.LogoUrl) && certConfig.LogoUrl.StartsWith("/"))
            {
                logoPath = Path.Combine(webRoot, certConfig.LogoUrl.TrimStart('/').Replace('/', Path.DirectorySeparatorChar));
            }
            else
            {
                logoPath = Path.Combine(webRoot, "images", "logo-jp.png");
            }

            byte[]? logoBytes = File.Exists(logoPath) ? File.ReadAllBytes(logoPath) : null;
            if (logoBytes == null)
            {
                var fallbackPath = Path.Combine(webRoot, "images", "logo-jp.png");
                if (File.Exists(fallbackPath)) logoBytes = File.ReadAllBytes(fallbackPath);
            }

            var isLocked = cert.Status != CertificateStatus.Issued;
            var domain = !string.IsNullOrWhiteSpace(certConfig.VerificationDomain) ? certConfig.VerificationDomain.TrimEnd('/') : "https://cursos.globalesjp.net";
            var verificationUrl = $"{domain}/Certificados/Verificar/{cert.VerificationCode}";
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
                                // Logo + Institución / Aprendizaje Online
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
                                            nr.AutoItem().Text(certConfig.InstitutionName).FontSize(11).Bold().FontColor("#0F172A");
                                            if (!string.IsNullOrWhiteSpace(certConfig.InstitutionHighlight))
                                            {
                                                nr.AutoItem().PaddingLeft(3).Text(certConfig.InstitutionHighlight).FontSize(11).ExtraBold().FontColor("#DC2626");
                                            }
                                        });
                                        bc.Item().Text(certConfig.HeaderSubtitle).FontSize(9.5f).FontColor("#64748B");
                                    });
                                });

                                // Texto medio descriptivo
                                if (!string.IsNullOrWhiteSpace(certConfig.SideDescription))
                                {
                                    leftCol.Item().PaddingTop(120).Text(certConfig.SideDescription)
                                        .FontSize(7).FontColor("#94A3B8").LineHeight(1.35f);
                                }

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
                                // Encabezado Superior: Título de Diploma a la izq y Acreditación a la der
                                mainCol.Item().Row(topRow =>
                                {
                                    topRow.RelativeItem().Column(tc =>
                                    {
                                        var rawTitle = certConfig.CertificateTitle ?? "CERTIFICADO DE FINALIZACIÓN";
                                        var titleWords = rawTitle.Split(' ', StringSplitOptions.RemoveEmptyEntries);
                                        if (titleWords.Length >= 2)
                                        {
                                            var half = (int)Math.Ceiling(titleWords.Length / 2.0);
                                            var line1 = string.Join(" ", titleWords.Take(half));
                                            var line2 = string.Join(" ", titleWords.Skip(half));
                                            tc.Item().Text(line1).FontSize(18).Bold().FontColor("#627D98").LetterSpacing(0.5f);
                                            tc.Item().Text(line2).FontSize(18).Bold().FontColor("#627D98").LetterSpacing(0.5f);
                                        }
                                        else
                                        {
                                            tc.Item().Text(rawTitle).FontSize(18).Bold().FontColor("#627D98").LetterSpacing(0.5f);
                                        }
                                    });

                                    if (!string.IsNullOrWhiteSpace(certConfig.AccreditationBadgeText))
                                    {
                                        topRow.AutoItem().PaddingTop(6).Text(certConfig.AccreditationBadgeText)
                                            .FontSize(8).Bold().FontColor("#10B981");
                                    }
                                });

                                // Cuerpo del Certificado
                                mainCol.Item().PaddingTop(50).Text(certConfig.GrantingIntroText)
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
                                    cr.AutoItem().Text(certConfig.DeveloperOrgName).FontSize(11).Bold().FontColor("#0F172A");
                                    cr.AutoItem().PaddingHorizontal(8).Text("•").FontSize(9).FontColor("#CBD5E1");
                                    cr.AutoItem().Text(domain).FontSize(10.5f).Bold().FontColor("#2563EB");
                                });

                                var disclaimer = !string.IsNullOrWhiteSpace(certConfig.VerificationDisclaimer)
                                    ? $"{certConfig.VerificationDisclaimer} {verificationUrl}"
                                    : $"Para validar la autenticidad y vigencia de esta credencial académica, ingrese a: {verificationUrl}";

                                mainCol.Item().PaddingTop(16).BorderTop(0.5f).BorderColor("#E2E8F0").PaddingTop(8).Text(disclaimer)
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
