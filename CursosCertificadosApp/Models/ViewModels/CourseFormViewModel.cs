using System.ComponentModel.DataAnnotations;
using CursosCertificadosApp.Models.Entities;

namespace CursosCertificadosApp.Models.ViewModels
{
    public class CourseFormViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "El título del curso es obligatorio"), MaxLength(150)]
        [Display(Name = "Título del Curso")]
        public string Title { get; set; } = string.Empty;

        [Display(Name = "Identificador Web (Slug)")]
        public string? Slug { get; set; }

        [Required(ErrorMessage = "Debes seleccionar una categoría")]
        [Display(Name = "Categoría")]
        public int CategoryId { get; set; }

        [Required(ErrorMessage = "La descripción corta es obligatoria"), MaxLength(300)]
        [Display(Name = "Descripción Corta (Resumen para catálogo)")]
        public string ShortDescription { get; set; } = string.Empty;

        [Required(ErrorMessage = "La descripción completa es obligatoria")]
        [Display(Name = "Descripción Completa y Objetivos")]
        public string FullDescription { get; set; } = string.Empty;

        [Required]
        [Display(Name = "Nivel de Dificultad")]
        public string Level { get; set; } = "Intermedio"; // Básico, Intermedio, Avanzado

        [Required, Range(1, 200, ErrorMessage = "Las horas estimadas deben estar entre 1 y 200")]
        [Display(Name = "Horas Académicas Estimadas")]
        public int EstimatedHours { get; set; } = 10;

        [Required, Range(50, 100, ErrorMessage = "El puntaje mínimo debe estar entre 50% y 100%")]
        [Display(Name = "Calificación Mínima Aprobatoria (%)")]
        public decimal PassingScore { get; set; } = 70.00m;

        [Required(ErrorMessage = "El precio de emisión del certificado es obligatorio")]
        [Range(1.00, 1000.00, ErrorMessage = "El precio mínimo de certificación es de $1.00 USD")]
        [Display(Name = "Precio de Certificación Oficial ($ USD)")]
        public decimal Price { get; set; } = 1.00m;

        [Display(Name = "Color Distintivo")]
        public string BadgeColor { get; set; } = "primary";

        [Display(Name = "¿Publicar Curso Inmediatamente?")]
        public bool IsPublished { get; set; } = true;

        [Display(Name = "Nombre del Docente / Creador (Opcional)")]
        [MaxLength(150)]
        public string? InstructorName { get; set; }

        [Display(Name = "Título / Especialidad del Docente (Opcional)")]
        [MaxLength(150)]
        public string? InstructorTitle { get; set; }

        public List<Category> Categories { get; set; } = new();
    }

    public class CreateModuleViewModel
    {
        public int CourseId { get; set; }

        [Required(ErrorMessage = "El título del módulo es obligatorio"), MaxLength(150)]
        public string Title { get; set; } = string.Empty;

        public int OrderIndex { get; set; } = 1;
    }

    public class CreateLessonViewModel
    {
        public int ModuleId { get; set; }
        public int CourseId { get; set; }

        [Required(ErrorMessage = "El título de la lectura es obligatorio"), MaxLength(150)]
        public string Title { get; set; } = string.Empty;

        [Required(ErrorMessage = "El contenido formativo interactivo es obligatorio")]
        public string Content { get; set; } = string.Empty;

        public int EstimatedMinutes { get; set; } = 15;
        public int OrderIndex { get; set; } = 1;
    }
}
