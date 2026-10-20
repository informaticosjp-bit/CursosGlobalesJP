using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;

namespace CursosCertificadosApp.Models.ViewModels
{
    public class UserProfileViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "El nombre completo es obligatorio")]
        [MaxLength(150, ErrorMessage = "El nombre no puede exceder 150 caracteres")]
        [Display(Name = "Nombre Completo")]
        public string FullName { get; set; } = string.Empty;

        [Required(ErrorMessage = "El documento de identidad es obligatorio para tus certificados")]
        [MaxLength(50, ErrorMessage = "La cédula no puede exceder 50 caracteres")]
        [Display(Name = "Cédula / Documento de Identidad")]
        public string IdentificationNumber { get; set; } = string.Empty;

        [Required(ErrorMessage = "El correo electrónico es obligatorio")]
        [EmailAddress(ErrorMessage = "Ingresa un correo electrónico válido")]
        [MaxLength(150)]
        [Display(Name = "Correo Electrónico")]
        public string Email { get; set; } = string.Empty;

        [MaxLength(250, ErrorMessage = "La dirección no puede exceder 250 caracteres")]
        [Display(Name = "Dirección de Residencia")]
        public string? Address { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Fecha de Nacimiento")]
        public DateTime? BirthDate { get; set; }

        [MaxLength(50)]
        [Display(Name = "Teléfono / WhatsApp")]
        public string? PhoneNumber { get; set; }

        public int? Age { get; set; }

        public string? CurrentProfilePictureUrl { get; set; }

        public bool RemovePicture { get; set; }

        [Display(Name = "Subir Foto de Perfil (opcional)")]
        public IFormFile? ProfilePicture { get; set; }

        public string Role { get; set; } = "Student";

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
    }
}
