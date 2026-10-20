namespace CursosCertificadosApp.Models.Entities
{
    public class LessonProgress
    {
        public int Id { get; set; }

        public int EnrollmentId { get; set; }
        public CourseEnrollment Enrollment { get; set; } = null!;

        public int LessonId { get; set; }
        public Lesson Lesson { get; set; } = null!;

        public bool IsCompleted { get; set; } = false;

        public DateTime? CompletedAt { get; set; }
    }
}
