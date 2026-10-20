using System.ComponentModel.DataAnnotations;

namespace CursosCertificadosApp.Models.ViewModels
{
    public class CategoryViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "El nombre de la categoría es obligatorio"), MaxLength(100)]
        [Display(Name = "Nombre de la Categoría")]
        public string Name { get; set; } = string.Empty;

        [MaxLength(100)]
        [Display(Name = "Identificador Web (Slug)")]
        public string? Slug { get; set; }

        [MaxLength(250)]
        [Display(Name = "Descripción")]
        public string Description { get; set; } = string.Empty;

        [MaxLength(50)]
        [Display(Name = "Icono Bootstrap (ej: bi-code-slash)")]
        public string IconClass { get; set; } = "bi-folder";

        [Display(Name = "Orden de Visualización")]
        public int DisplayOrder { get; set; } = 0;

        public int CourseCount { get; set; }
    }
}
