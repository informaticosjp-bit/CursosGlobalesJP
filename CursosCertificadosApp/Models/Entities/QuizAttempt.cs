using System.ComponentModel.DataAnnotations.Schema;

namespace CursosCertificadosApp.Models.Entities
{
    public class QuizAttempt
    {
        public int Id { get; set; }

        public int QuizId { get; set; }
        public Quiz Quiz { get; set; } = null!;

        public int UserId { get; set; }
        public User User { get; set; } = null!;

        [Column(TypeName = "decimal(5,2)")]
        public decimal ScorePercentage { get; set; }

        public bool IsPassed { get; set; } = false;

        public string? AnswersJson { get; set; }

        public DateTime AttemptedAt { get; set; } = DateTime.UtcNow;
    }
}
