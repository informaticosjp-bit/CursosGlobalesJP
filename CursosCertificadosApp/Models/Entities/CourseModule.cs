using System.ComponentModel.DataAnnotations;

namespace CursosCertificadosApp.Models.Entities
{
    public class CourseModule
    {
        public int Id { get; set; }

        public int CourseId { get; set; }
        public Course Course { get; set; } = null!;

        [Required, MaxLength(150)]
        public string Title { get; set; } = string.Empty;

        public int OrderIndex { get; set; } = 0;

        public ICollection<Lesson> Lessons { get; set; } = new List<Lesson>();
    }
}
