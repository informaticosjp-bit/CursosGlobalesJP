using CursosCertificadosApp.Models.Entities;

namespace CursosCertificadosApp.Services
{
    public class CourseStudySessionViewModel
    {
        public Course Course { get; set; } = null!;
        public CourseEnrollment Enrollment { get; set; } = null!;
        public Lesson? CurrentLesson { get; set; }
        public HashSet<int> CompletedLessonIds { get; set; } = new();
        public Quiz? Quiz { get; set; }
        public bool AllReadingsCompleted { get; set; }
        public QuizAttempt? LatestAttempt { get; set; }
        public Certificate? Certificate { get; set; }
    }

    public class ProgressUpdateResult
    {
        public decimal NewPercentage { get; set; }
        public bool AllReadingsCompleted { get; set; }
        public bool IsCourseCompleted { get; set; }
        public string? CertificateId { get; set; }
    }

    public class QuizEvaluationResult
    {
        public bool IsPassed { get; set; }
        public decimal ScorePercentage { get; set; }
        public int CorrectAnswers { get; set; }
        public int TotalQuestions { get; set; }
        public string? CertificateId { get; set; }
        public List<QuestionFeedback> Feedback { get; set; } = new();
    }

    public class QuestionFeedback
    {
        public int QuestionId { get; set; }
        public string QuestionText { get; set; } = string.Empty;
        public int SelectedOptionId { get; set; }
        public int CorrectOptionId { get; set; }
        public bool IsCorrect { get; set; }
        public string? Explanation { get; set; }
    }

    public interface IProgressService
    {
        Task<CourseEnrollment> EnrollStudentAsync(int userId, int courseId);
        Task<ProgressUpdateResult> CompleteLessonAsync(int userId, int lessonId);
        Task<QuizEvaluationResult> SubmitQuizAsync(int userId, int quizId, Dictionary<int, int> selectedOptions);
        Task<CourseStudySessionViewModel?> GetStudySessionAsync(int userId, string courseSlug, int? requestedLessonId);
        Task<List<CourseEnrollment>> GetStudentEnrollmentsAsync(int userId);
    }
}
