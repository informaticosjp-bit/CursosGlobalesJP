using System.Text.Json;
using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models.Entities;
using CursosCertificadosApp.Models.ViewModels;
using Microsoft.EntityFrameworkCore;

namespace CursosCertificadosApp.Services
{
    public class CvService : ICvService
    {
        private readonly AppDbContext _context;
        private readonly IBcvRateService _bcvRateService;

        public CvService(AppDbContext context, IBcvRateService bcvRateService)
        {
            _context = context;
            _bcvRateService = bcvRateService;
        }

        public async Task<bool> IsCvUnlockedForUserAsync(int userId)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user != null && user.Role == "Admin") return true;

            return await _context.Payments
                .AnyAsync(p => p.UserId == userId && p.PaymentType == "CvGenerator" && p.Status == "Approved");
        }

        public async Task<bool> HasPendingCvPaymentAsync(int userId)
        {
            return await _context.Payments
                .AnyAsync(p => p.UserId == userId && p.PaymentType == "CvGenerator" && p.Status == "Pending");
        }

        public async Task<List<CvCertificationItem>> GetUserPlatformCertificatesAsync(int userId)
        {
            var certs = await _context.Certificates
                .Include(c => c.Course)
                .Where(c => c.UserId == userId && (c.Status == CertificateStatus.Issued || c.Status == CertificateStatus.Locked))
                .OrderByDescending(c => c.IssuedAt ?? c.CreatedAt)
                .ToListAsync();

            return certs.Select(c => new CvCertificationItem
            {
                Title = c.Course?.Title ?? "Certificación de Competencias",
                Issuer = "Cursos Globales JP",
                Year = (c.IssuedAt ?? c.CreatedAt).Year.ToString(),
                VerificationCode = c.VerificationCode,
                IsPlatformCertificate = true
            }).ToList();
        }

        public async Task<CvViewModel> GetOrCreateUserCvAsync(int userId)
        {
            var user = await _context.Users.FindAsync(userId);
            var isUnlocked = await IsCvUnlockedForUserAsync(userId);
            var hasPending = await HasPendingCvPaymentAsync(userId);
            var bcv = await _bcvRateService.GetCurrentRateAsync();
            var platformCerts = await GetUserPlatformCertificatesAsync(userId);

            var cv = await _context.UserCvs.FirstOrDefaultAsync(c => c.UserId == userId);

            if (cv == null)
            {
                // Crear perfil inicial exclusivamente con datos reales registrados por el usuario en la web
                cv = new UserCv
                {
                    UserId = userId,
                    FullName = user?.FullName ?? "",
                    IdentificationNumber = user?.IdentificationNumber ?? "",
                    JobTitle = "",
                    Email = user?.Email ?? "",
                    PhoneNumber = user?.PhoneNumber ?? "",
                    Location = "",
                    Address = user?.Address ?? "",
                    WebsiteOrLinkedIn = "",
                    ProfessionalSummary = "",
                    Skills = "",
                    SelectedTemplate = "Corporate",
                    ColorPalette = "ClassicNavy",
                    ExperienceJson = "[]",
                    EducationJson = "[]",
                    CertificationsJson = JsonSerializer.Serialize(platformCerts),
                    UpdatedAt = DateTime.UtcNow
                };

                _context.UserCvs.Add(cv);
                await _context.SaveChangesAsync();
            }
            else
            {
                // Limpiar cualquier dato simulado de pruebas anteriores para que queden en blanco
                if (cv.JobTitle == "Profesional Especialista") cv.JobTitle = "";
                if (cv.Location == "Caracas, Venezuela") cv.Location = "";
                if (!string.IsNullOrWhiteSpace(cv.ProfessionalSummary) && cv.ProfessionalSummary.StartsWith("Profesional orientador a resultados")) cv.ProfessionalSummary = "";
                if (!string.IsNullOrWhiteSpace(cv.Skills) && cv.Skills.StartsWith("Liderazgo de Equipos")) cv.Skills = "";
                if (!string.IsNullOrWhiteSpace(cv.ExperienceJson) && cv.ExperienceJson.Contains("Empresa / Organización Principal")) cv.ExperienceJson = "[]";
                if (!string.IsNullOrWhiteSpace(cv.EducationJson) && cv.EducationJson.Contains("Universidad / Instituto Superior")) cv.EducationJson = "[]";

                // Sincronizar datos reales de la web si están vacíos
                if (string.IsNullOrWhiteSpace(cv.IdentificationNumber) && !string.IsNullOrWhiteSpace(user?.IdentificationNumber))
                {
                    cv.IdentificationNumber = user.IdentificationNumber;
                }
                if (string.IsNullOrWhiteSpace(cv.Address) && !string.IsNullOrWhiteSpace(user?.Address))
                {
                    cv.Address = user.Address;
                }
                if (string.IsNullOrWhiteSpace(cv.FullName) && !string.IsNullOrWhiteSpace(user?.FullName))
                {
                    cv.FullName = user.FullName;
                }
                if (string.IsNullOrWhiteSpace(cv.Email) && !string.IsNullOrWhiteSpace(user?.Email))
                {
                    cv.Email = user.Email;
                }
                if (string.IsNullOrWhiteSpace(cv.PhoneNumber) && !string.IsNullOrWhiteSpace(user?.PhoneNumber))
                {
                    cv.PhoneNumber = user.PhoneNumber;
                }
                if (string.IsNullOrWhiteSpace(cv.ColorPalette))
                {
                    cv.ColorPalette = "ClassicNavy";
                }
                await _context.SaveChangesAsync();
            }

            var experiences = string.IsNullOrWhiteSpace(cv.ExperienceJson)
                ? new List<CvExperienceItem>()
                : JsonSerializer.Deserialize<List<CvExperienceItem>>(cv.ExperienceJson) ?? new();

            var educations = string.IsNullOrWhiteSpace(cv.EducationJson)
                ? new List<CvEducationItem>()
                : JsonSerializer.Deserialize<List<CvEducationItem>>(cv.EducationJson) ?? new();

            var certifications = string.IsNullOrWhiteSpace(cv.CertificationsJson)
                ? new List<CvCertificationItem>()
                : JsonSerializer.Deserialize<List<CvCertificationItem>>(cv.CertificationsJson) ?? new();

            // Si las certificaciones en el CV están vacías pero tiene en la plataforma, incorporarlas automáticamente
            if (!certifications.Any() && platformCerts.Any())
            {
                certifications.AddRange(platformCerts);
                cv.CertificationsJson = JsonSerializer.Serialize(certifications);
                await _context.SaveChangesAsync();
            }

            return new CvViewModel
            {
                Id = cv.Id,
                UserId = cv.UserId,
                FullName = cv.FullName ?? "",
                IdentificationNumber = cv.IdentificationNumber ?? "",
                JobTitle = cv.JobTitle ?? "",
                Email = cv.Email ?? "",
                PhoneNumber = cv.PhoneNumber ?? "",
                Location = cv.Location ?? "",
                Address = cv.Address ?? "",
                WebsiteOrLinkedIn = cv.WebsiteOrLinkedIn ?? "",
                ProfessionalSummary = cv.ProfessionalSummary ?? "",
                Skills = cv.Skills ?? "",
                Experiences = experiences,
                Educations = educations,
                Certifications = certifications,
                SelectedTemplate = string.IsNullOrEmpty(cv.SelectedTemplate) ? "Corporate" : cv.SelectedTemplate,
                ColorPalette = string.IsNullOrEmpty(cv.ColorPalette) ? "ClassicNavy" : cv.ColorPalette,
                IsUnlocked = isUnlocked,
                HasPendingPayment = hasPending,
                PriceUsd = 1.00m,
                BcvRate = bcv.UsdRate,
                BcvDate = bcv.ValueDate,
                AvailablePlatformCertificates = platformCerts,
                ProfilePictureUrl = user?.ProfilePictureUrl
            };
        }

        public async Task<bool> SaveUserCvAsync(int userId, CvViewModel model)
        {
            var cv = await _context.UserCvs.FirstOrDefaultAsync(c => c.UserId == userId);
            if (cv == null)
            {
                cv = new UserCv { UserId = userId };
                _context.UserCvs.Add(cv);
            }

            cv.FullName = model.FullName?.Trim() ?? "";
            cv.IdentificationNumber = model.IdentificationNumber?.Trim() ?? "";
            cv.JobTitle = model.JobTitle?.Trim() ?? "";
            cv.Email = model.Email?.Trim() ?? "";
            cv.PhoneNumber = model.PhoneNumber?.Trim() ?? "";
            cv.Location = model.Location?.Trim() ?? "";
            cv.Address = model.Address?.Trim() ?? "";
            cv.WebsiteOrLinkedIn = model.WebsiteOrLinkedIn?.Trim() ?? "";
            cv.ProfessionalSummary = model.ProfessionalSummary?.Trim() ?? "";
            cv.Skills = model.Skills?.Trim() ?? "";
            cv.SelectedTemplate = string.IsNullOrWhiteSpace(model.SelectedTemplate) ? "Corporate" : model.SelectedTemplate;
            cv.ColorPalette = string.IsNullOrWhiteSpace(model.ColorPalette) ? "ClassicNavy" : model.ColorPalette;
            cv.ExperienceJson = JsonSerializer.Serialize(model.Experiences ?? new());
            cv.EducationJson = JsonSerializer.Serialize(model.Educations ?? new());
            cv.CertificationsJson = JsonSerializer.Serialize(model.Certifications ?? new());
            cv.UpdatedAt = DateTime.UtcNow;

            await _context.SaveChangesAsync();
            return true;
        }

        public string GenerateProfessionalSummaryAi(IaSummaryRequest request)
        {
            var title = string.IsNullOrWhiteSpace(request.JobTitle) ? "Profesional Multidisciplinario" : request.JobTitle.Trim();
            var skills = string.IsNullOrWhiteSpace(request.KeySkills) ? "resolución de problemas, liderazgo y metodologías ágiles" : request.KeySkills.Trim();
            var level = request.ExperienceLevel?.Trim() ?? "Senior";
            var tone = request.Tone?.Trim() ?? "Impacto";

            var random = new Random();

            if (tone == "Liderazgo")
            {
                var intros = new[]
                {
                    $"{title} con comprobada capacidad de liderazgo y dirección estratégica de proyectos multidisciplinarios.",
                    $"Líder y especialista en el rol de {title}, caracterizado por transformar desafíos organizacionales en oportunidades de alto rendimiento.",
                    $"{title} con enfoque directivo y visión integral de negocio, experto en potenciar el talento de sus equipos de trabajo."
                };

                var bodies = new[]
                {
                    $"Experiencia destacada en la toma de decisiones, optimización de recursos y aplicación de estándares modernos de calidad y cumplimiento. Competente en áreas clave como {skills}.",
                    $"Trayectoria guiando procesos de transformación y eficiencia operativa, integrando herramientas tecnológicas como {skills} con sólidas habilidades de comunicación asertiva y negociación.",
                    $"Habilidad demostrada para liderar iniciativas de alto impacto, garantizando la continuidad de procesos críticos e implementando soluciones fundamentadas en {skills}."
                };

                var closings = new[]
                {
                    "Orientado a superar metas corporativas y consolidar ventajas competitivas sostenibles para la organización.",
                    "Comprometido con la excelencia directiva, la innovación constante y el logro medible de los objetivos institucionales.",
                    "Preparado para asumir roles de alta responsabilidad aportando madurez profesional, resiliencia y resultados tangibles."
                };

                return $"{intros[random.Next(intros.Length)]} {bodies[random.Next(bodies.Length)]} {closings[random.Next(closings.Length)]}";
            }
            else if (tone == "Tecnico")
            {
                var intros = new[]
                {
                    $"{title} con sólida formación técnica y rigurosidad metodológica en el diseño e implementación de soluciones especializadas.",
                    $"Especialista técnico desempeñándose como {title}, enfocado en la arquitectura, ejecución y mejora continua de sistemas y procesos.",
                    $"{title} con amplio dominio analítico y capacidad para abordar problemas complejos mediante enfoques sistemáticos y estructurados."
                };

                var bodies = new[]
                {
                    $"Dominio práctico y teórico en tecnologías y herramientas fundamentales, destacando en {skills}. Experiencia en documentación técnica, mitigación de riesgos y aseguramiento de operatividad.",
                    $"Capacidad contrastada para evaluar requerimientos funcionales, diagnosticar incidencias y desarrollar flujos eficientes respaldados en competencias como {skills}.",
                    $"Enfoque disciplinado en mejores prácticas de la industria, automatización de tareas y escalabilidad operativa apoyado en el dominio de {skills}."
                };

                var closings = new[]
                {
                    "Enfocado en entregar soluciones sólidas, escalables y con los más altos estándares de desempeño profesional.",
                    "Motivado por el aprendizaje continuo y la aplicación de tecnología de vanguardia para optimizar la productividad empresarial.",
                    "Listo para aportar valor técnico inmediato y solvencia operativa en entornos dinámicos y de alta exigencia."
                };

                return $"{intros[random.Next(intros.Length)]} {bodies[random.Next(bodies.Length)]} {closings[random.Next(closings.Length)]}";
            }
            else // "Impacto" (Por defecto / Estándar ATS de Talento Humano)
            {
                var intros = new[]
                {
                    $"{title} de nivel {level}, con trayectoria destacada en la consecución de objetivos estratégicos y optimización de rendimiento.",
                    $"Profesional proactivo en el rol de {title}, caracterizado por su pensamiento crítico, adaptabilidad y compromiso con la excelencia operativa.",
                    $"{title} con amplia experiencia práctica y sólida base conceptual en gestión eficiente y resolución de problemas corporativos."
                };

                var bodies = new[]
                {
                    $"Cuenta con un perfil versátil y orientado a resultados, respaldado por competencias clave en {skills}. Habilidad demostrada para integrarse ágilmente a dinámicas de trabajo exigentes y colaborar con equipos multidisciplinarios.",
                    $"Amplia destreza en optimización de flujos de trabajo, gestión del tiempo y cumplimiento de estándares de alto impacto, combinando conocimientos aplicados en {skills}.",
                    $"Capacidad analítica para identificar oportunidades de mejora, ejecutar planes de acción y mantener estándares rigurosos de calidad mediante la aplicación efectiva de {skills}."
                };

                var closings = new[]
                {
                    "En búsqueda de aportar experiencia, visión innovadora y valor medible a equipos que priorizan la calidad y el crecimiento sostenible.",
                    "Orientado al desarrollo profesional continuo y a generar un impacto positivo y cuantificable en los resultados de la empresa.",
                    "Dedicado a elevar la productividad organizacional a través de una sólida ética de trabajo, iniciativa y búsqueda de la excelencia."
                };

                return $"{intros[random.Next(intros.Length)]} {bodies[random.Next(bodies.Length)]} {closings[random.Next(closings.Length)]}";
            }
        }
    }
}
