using System.ComponentModel.DataAnnotations;

namespace CursosCertificadosApp.Models.ViewModels
{
    public class CvExperienceItem
    {
        public string Company { get; set; } = string.Empty;
        public string Position { get; set; } = string.Empty;
        public string StartDate { get; set; } = string.Empty;
        public string EndDate { get; set; } = string.Empty;
        public bool IsCurrent { get; set; }
        public string Description { get; set; } = string.Empty;
    }

    public class CvEducationItem
    {
        public string Institution { get; set; } = string.Empty;
        public string Degree { get; set; } = string.Empty;
        public string FieldOfStudy { get; set; } = string.Empty;
        public string Year { get; set; } = string.Empty;
    }

    public class CvCertificationItem
    {
        public string Title { get; set; } = string.Empty;
        public string Issuer { get; set; } = string.Empty; // Opcional: puede dejarse en blanco
        public string Year { get; set; } = string.Empty;
        public string? VerificationCode { get; set; }
        public bool IsPlatformCertificate { get; set; }
    }

    public class CvViewModel
    {
        public int Id { get; set; }
        public int UserId { get; set; }

        [Required(ErrorMessage = "El nombre completo es requerido"), MaxLength(150)]
        [Display(Name = "Nombre Completo")]
        public string FullName { get; set; } = string.Empty;

        [MaxLength(50)]
        [Display(Name = "Documento de Identidad (Cédula / DNI / RIF)")]
        public string IdentificationNumber { get; set; } = string.Empty;

        [MaxLength(150)]
        [Display(Name = "Título o Especialidad Profesional")]
        public string JobTitle { get; set; } = string.Empty;

        [EmailAddress, MaxLength(150)]
        [Display(Name = "Correo Electrónico de Contacto")]
        public string Email { get; set; } = string.Empty;

        [MaxLength(50)]
        [Display(Name = "Teléfono / WhatsApp")]
        public string PhoneNumber { get; set; } = string.Empty;

        [MaxLength(120)]
        [Display(Name = "Ubicación (Ciudad, País)")]
        public string Location { get; set; } = string.Empty;

        [MaxLength(250)]
        [Display(Name = "Dirección Completa (Opcional)")]
        public string Address { get; set; } = string.Empty;

        [MaxLength(200)]
        [Display(Name = "Sitio Web / LinkedIn / Portafolio")]
        public string WebsiteOrLinkedIn { get; set; } = string.Empty;

        [Display(Name = "Perfil Profesional / Sobre Mí")]
        public string ProfessionalSummary { get; set; } = string.Empty;

        [Display(Name = "Habilidades Técnicas y Blandas")]
        public string Skills { get; set; } = string.Empty;

        public List<CvExperienceItem> Experiences { get; set; } = new();
        public List<CvEducationItem> Educations { get; set; } = new();
        public List<CvCertificationItem> Certifications { get; set; } = new();

        public string SelectedTemplate { get; set; } = "Corporate"; // "Corporate", "Modern", "Functional"
        public string ColorPalette { get; set; } = "ClassicNavy"; // "ClassicNavy", "EmeraldGreen", "Burgundy", "GraphiteDark", "RoyalPurple"

        // Estados de Pago / Desbloqueo
        public bool IsUnlocked { get; set; }
        public bool HasPendingPayment { get; set; }

        // Datos Financieros para el flujo de $1 USD
        public decimal PriceUsd { get; set; } = 1.00m;
        public decimal BcvRate { get; set; } = 881.07m;
        public string BcvDate { get; set; } = string.Empty;
        public decimal PriceBs => Math.Round(PriceUsd * BcvRate, 2);

        // Foto de Perfil vinculada de la cuenta del usuario
        public string? ProfilePictureUrl { get; set; }

        public string Initials
        {
            get
            {
                if (string.IsNullOrWhiteSpace(FullName)) return "U";
                var parts = FullName.Trim().Split(' ', StringSplitOptions.RemoveEmptyEntries);
                if (parts.Length == 1) return parts[0][0].ToString().ToUpper();
                return $"{parts[0][0]}{parts[1][0]}".ToUpper();
            }
        }

        // Certificados disponibles del usuario en la plataforma para auto-añadir
        public List<CvCertificationItem> AvailablePlatformCertificates { get; set; } = new();
    }

    public class IaSummaryRequest
    {
        public string JobTitle { get; set; } = string.Empty;
        public string ExperienceLevel { get; set; } = "Senior"; // "Junior", "Intermedio", "Senior", "Directivo"
        public string KeySkills { get; set; } = string.Empty;
        public string Tone { get; set; } = "Impacto"; // "Impacto", "Tecnico", "Liderazgo"
    }

    public class IaSummaryResponse
    {
        public bool Success { get; set; }
        public string Summary { get; set; } = string.Empty;
        public string Message { get; set; } = string.Empty;
    }
}
