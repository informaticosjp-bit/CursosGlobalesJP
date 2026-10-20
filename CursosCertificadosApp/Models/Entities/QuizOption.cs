using System.ComponentModel.DataAnnotations;

namespace CursosCertificadosApp.Models.Entities
{
    public class QuizOption
    {
        public int Id { get; set; }

        public int QuestionId { get; set; }
        public QuizQuestion Question { get; set; } = null!;

        [Required]
        public string OptionText { get; set; } = string.Empty;

        public bool IsCorrect { get; set; } = false;
    }
}
