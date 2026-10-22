namespace CursosCertificadosApp.Models.ViewModels
{
    public class UserManagementViewModel
    {
        public int Id { get; set; }
        public string FullName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string IdentificationNumber { get; set; } = string.Empty;
        public int? Age { get; set; }
        public string? PhoneNumber { get; set; }
        public string Role { get; set; } = "Student";
        public DateTime CreatedAt { get; set; }
        public bool IsOnline { get; set; }
        public DateTime? LastActiveAt { get; set; }

        public bool IsMaster => Email.Trim().ToLower() == "master@globalesjp.net" || Email.Trim().ToLower() == "master";

        public int TotalEnrolledCourses { get; set; }
        public int CompletedCoursesCount { get; set; }
        public int IssuedCertificatesCount { get; set; }
        public int TotalPaymentsCount { get; set; }
        public decimal TotalPaidAmount { get; set; }

        public List<UserEnrollmentSummary> Enrollments { get; set; } = new();
    }

    public class UserEnrollmentSummary
    {
        public int CourseId { get; set; }
        public string CourseTitle { get; set; } = string.Empty;
        public decimal ProgressPercentage { get; set; }
        public bool IsCompleted { get; set; }
        public DateTime? CompletedAt { get; set; }
        public string? CertificateId { get; set; }
        public string? CertificateCode { get; set; }
        public string? CertificateStatus { get; set; }
    }

    public class CreateUserViewModel
    {
        [System.ComponentModel.DataAnnotations.Required(ErrorMessage = "El nombre completo es obligatorio"), System.ComponentModel.DataAnnotations.MaxLength(150)]
        public string FullName { get; set; } = string.Empty;

        [System.ComponentModel.DataAnnotations.Required(ErrorMessage = "La cédula / identificación es obligatoria"), System.ComponentModel.DataAnnotations.MaxLength(50)]
        public string IdentificationNumber { get; set; } = string.Empty;

        [System.ComponentModel.DataAnnotations.Required(ErrorMessage = "El correo es obligatorio"), System.ComponentModel.DataAnnotations.EmailAddress]
        public string Email { get; set; } = string.Empty;

        [System.ComponentModel.DataAnnotations.Required(ErrorMessage = "La contraseña es obligatoria"), System.ComponentModel.DataAnnotations.MinLength(6, ErrorMessage = "Mínimo 6 caracteres")]
        public string Password { get; set; } = string.Empty;

        [System.ComponentModel.DataAnnotations.Required]
        public string Role { get; set; } = "Student"; // Student, Creator, Admin

        [System.ComponentModel.DataAnnotations.Range(10, 120, ErrorMessage = "Edad inválida")]
        public int? Age { get; set; }

        [System.ComponentModel.DataAnnotations.MaxLength(30)]
        public string? PhoneNumber { get; set; }
    }

    public class EditUserViewModel
    {
        public int Id { get; set; }

        [System.ComponentModel.DataAnnotations.Required(ErrorMessage = "El nombre completo es obligatorio"), System.ComponentModel.DataAnnotations.MaxLength(150)]
        public string FullName { get; set; } = string.Empty;

        [System.ComponentModel.DataAnnotations.Required(ErrorMessage = "La cédula / identificación es obligatoria"), System.ComponentModel.DataAnnotations.MaxLength(50)]
        public string IdentificationNumber { get; set; } = string.Empty;

        [System.ComponentModel.DataAnnotations.Required(ErrorMessage = "El correo es obligatorio"), System.ComponentModel.DataAnnotations.EmailAddress]
        public string Email { get; set; } = string.Empty;

        [System.ComponentModel.DataAnnotations.MaxLength(30)]
        public string? PhoneNumber { get; set; }

        [System.ComponentModel.DataAnnotations.Range(10, 120, ErrorMessage = "Edad inválida")]
        public int? Age { get; set; }

        [System.ComponentModel.DataAnnotations.Required]
        public string Role { get; set; } = "Student";

        public string? NewPassword { get; set; }
    }
}
