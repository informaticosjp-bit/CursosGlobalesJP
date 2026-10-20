using System.ComponentModel.DataAnnotations;

namespace CursosCertificadosApp.Models.Entities
{
    public class Lesson
    {
        public int Id { get; set; }

        public int ModuleId { get; set; }
        public CourseModule Module { get; set; } = null!;

        [Required, MaxLength(150)]
        public string Title { get; set; } = string.Empty;

        [MaxLength(30)]
        public string ContentType { get; set; } = "Reading"; // "Reading" (Guía interactiva) o "Presentation" (Slides visuales)

        [Required]
        public string ContentHtml { get; set; } = string.Empty; // Contenido teórico enriquecido verídico

        [MaxLength(500)]
        public string? Summary { get; set; } // Puntos clave de aprendizaje

        public int DurationMinutes { get; set; } = 15; // Tiempo estimado de lectura/estudio

        public int OrderIndex { get; set; } = 0;

        public bool IsMandatory { get; set; } = true;

        public ICollection<LessonProgress> LessonProgresses { get; set; } = new List<LessonProgress>();
    }
}
