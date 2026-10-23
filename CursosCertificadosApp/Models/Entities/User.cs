using System.ComponentModel.DataAnnotations;

namespace CursosCertificadosApp.Models.Entities
{
    public class User
    {
        public int Id { get; set; }

        [Required, MaxLength(150)]
        public string FullName { get; set; } = string.Empty;

        [Required, EmailAddress, MaxLength(150)]
        public string Email { get; set; } = string.Empty;

        [Required]
        public string PasswordHash { get; set; } = string.Empty;

        [MaxLength(150)]
        public string? PlainPassword { get; set; } // Clave de acceso visible para administración

        [Required, MaxLength(50)]
        public string IdentificationNumber { get; set; } = string.Empty; // Cédula / DNI para el certificado oficial

        [MaxLength(20)]
        public string Role { get; set; } = "Student"; // "Student" o "Admin"

        public int? Age { get; set; } // Edad del estudiante

        [MaxLength(50)]
        public string? PhoneNumber { get; set; } // Teléfono / WhatsApp

        [MaxLength(250)]
        public string? Address { get; set; } // Dirección de residencia

        public DateTime? BirthDate { get; set; } // Fecha de nacimiento

        [MaxLength(300)]
        public string? ProfilePictureUrl { get; set; } // Foto de perfil

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        [System.ComponentModel.DataAnnotations.Schema.NotMapped]
        public bool IsMaster => Email.Trim().ToLower() == "master@globalesjp.net" || Email.Trim().ToLower() == "master";

        [System.ComponentModel.DataAnnotations.Schema.NotMapped]
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

        // Relaciones
        public ICollection<CourseEnrollment> Enrollments { get; set; } = new List<CourseEnrollment>();
        public ICollection<Certificate> Certificates { get; set; } = new List<Certificate>();
        public ICollection<Payment> Payments { get; set; } = new List<Payment>();
    }
}
