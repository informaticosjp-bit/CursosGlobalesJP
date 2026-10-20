using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CursosCertificadosApp.Models.Entities
{
    public class UserCv
    {
        public int Id { get; set; }

        public int UserId { get; set; }
        public User User { get; set; } = null!;

        [Required, MaxLength(150)]
        public string FullName { get; set; } = string.Empty;

        [MaxLength(150)]
        public string? JobTitle { get; set; } = string.Empty;

        [EmailAddress, MaxLength(150)]
        public string? Email { get; set; } = string.Empty;

        [MaxLength(50)]
        public string? PhoneNumber { get; set; } = string.Empty;

        [MaxLength(120)]
        public string? Location { get; set; } = string.Empty;

        [MaxLength(200)]
        public string? WebsiteOrLinkedIn { get; set; } = string.Empty;

        public string? ProfessionalSummary { get; set; } = string.Empty;

        // Estructuras en JSON para flexibilidad total
        public string? ExperienceJson { get; set; } = "[]";
        public string? EducationJson { get; set; } = "[]";
        public string? Skills { get; set; } = string.Empty;
        public string? CertificationsJson { get; set; } = "[]";

        [MaxLength(50)]
        public string? IdentificationNumber { get; set; } = string.Empty;

        [MaxLength(250)]
        public string? Address { get; set; } = string.Empty;

        [MaxLength(50)]
        public string? SelectedTemplate { get; set; } = "Corporate"; // "Corporate", "Modern", "Functional"

        [MaxLength(50)]
        public string? ColorPalette { get; set; } = "ClassicNavy"; // "ClassicNavy", "EmeraldGreen", "Burgundy", "GraphiteDark", "RoyalPurple"

        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
    }
}
