using System.ComponentModel.DataAnnotations;

namespace CursosCertificadosApp.Models.Entities
{
    public class Category
    {
        public int Id { get; set; }

        [Required, MaxLength(100)]
        public string Name { get; set; } = string.Empty;

        [Required, MaxLength(100)]
        public string Slug { get; set; } = string.Empty;

        [MaxLength(250)]
        public string Description { get; set; } = string.Empty;

        [MaxLength(50)]
        public string IconClass { get; set; } = "bi-folder";

        public int DisplayOrder { get; set; } = 0;

        public ICollection<Course> Courses { get; set; } = new List<Course>();
    }
}
