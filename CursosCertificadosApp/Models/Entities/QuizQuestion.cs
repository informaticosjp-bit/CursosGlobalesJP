using System.ComponentModel.DataAnnotations;

namespace CursosCertificadosApp.Models.Entities
{
    public class QuizQuestion
    {
        public int Id { get; set; }

        public int QuizId { get; set; }
        public Quiz Quiz { get; set; } = null!;

        [Required]
        public string QuestionText { get; set; } = string.Empty;

        public string? Explanation { get; set; }

        public int OrderIndex { get; set; } = 0;

        public ICollection<QuizOption> Options { get; set; } = new List<QuizOption>();
    }
}
