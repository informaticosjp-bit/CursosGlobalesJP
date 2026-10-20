using System.ComponentModel.DataAnnotations;

namespace CursosCertificadosApp.Models.Entities
{
    public class UserNotification
    {
        public int Id { get; set; }

        public int UserId { get; set; }
        public User User { get; set; } = null!;

        [Required, MaxLength(150)]
        public string Title { get; set; } = string.Empty;

        [Required]
        public string Message { get; set; } = string.Empty;

        [Required, MaxLength(30)]
        public string Type { get; set; } = "Info"; // "Success", "Info", "Warning"

        public bool IsRead { get; set; } = false;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}
