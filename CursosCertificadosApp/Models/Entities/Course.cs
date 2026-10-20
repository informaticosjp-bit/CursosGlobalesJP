using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CursosCertificadosApp.Models.Entities
{
    public class Course
    {
        public int Id { get; set; }

        public int CategoryId { get; set; }
        public Category Category { get; set; } = null!;

        [Required, MaxLength(150)]
        public string Title { get; set; } = string.Empty;

        [Required, MaxLength(150)]
        public string Slug { get; set; } = string.Empty;

        [MaxLength(300)]
        public string ShortDescription { get; set; } = string.Empty;

        public string FullDescription { get; set; } = string.Empty;

        [MaxLength(50)]
        public string Level { get; set; } = "Intermedio"; // Básico, Intermedio, Avanzado

        public int EstimatedHours { get; set; } = 10;

        [Column(TypeName = "decimal(5,2)")]
        public decimal PassingScore { get; set; } = 70.00m;

        [Column(TypeName = "decimal(10,2)")]
        public decimal Price { get; set; } = 1.00m; // Precio fijado para emisión de certificado (mínimo 1.00 USD)

        [MaxLength(250)]
        public string ImageUrl { get; set; } = "/images/default-course.jpg";

        [MaxLength(30)]
        public string BadgeColor { get; set; } = "primary";

        public bool IsPublished { get; set; } = true;

        [MaxLength(150)]
        public string? InstructorName { get; set; } // Nombre del docente/creador (opcional)

        [MaxLength(150)]
        public string? InstructorTitle { get; set; } // Título profesional o especialidad (opcional)

        public int? CreatorUserId { get; set; } // Usuario creador (si aplica)
        public User? CreatorUser { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Relaciones
        public ICollection<CourseModule> Modules { get; set; } = new List<CourseModule>();
        public Quiz? Quiz { get; set; }
        public ICollection<CourseEnrollment> Enrollments { get; set; } = new List<CourseEnrollment>();
        public ICollection<Certificate> Certificates { get; set; } = new List<Certificate>();
    }
}
