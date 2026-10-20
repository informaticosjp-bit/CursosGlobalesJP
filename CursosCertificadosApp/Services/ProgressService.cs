using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models.Entities;
using Microsoft.EntityFrameworkCore;
using System.Text.Json;

namespace CursosCertificadosApp.Services
{
    public class ProgressService : IProgressService
    {
        private readonly AppDbContext _context;
        private readonly ICertificateService _certificateService;

        public ProgressService(AppDbContext context, ICertificateService certificateService)
        {
            _context = context;
            _certificateService = certificateService;
        }

        public async Task<CourseEnrollment> EnrollStudentAsync(int userId, int courseId)
        {
            var enrollment = await _context.CourseEnrollments
                .Include(e => e.LessonProgresses)
                .FirstOrDefaultAsync(e => e.UserId == userId && e.CourseId == courseId);

            if (enrollment != null)
            {
                return enrollment;
            }

            enrollment = new CourseEnrollment
            {
                UserId = userId,
                CourseId = courseId,
                EnrolledAt = DateTime.UtcNow,
                ProgressPercentage = 0,
                IsCompleted = false,
                QuizPassed = false,
                QuizScore = 0
            };

            _context.CourseEnrollments.Add(enrollment);
            await _context.SaveChangesAsync();

            return enrollment;
        }

        public async Task<ProgressUpdateResult> CompleteLessonAsync(int userId, int lessonId)
        {
            var lesson = await _context.Lessons
                .Include(l => l.Module)
                .FirstOrDefaultAsync(l => l.Id == lessonId);

            if (lesson == null) throw new ArgumentException("Lección no encontrada.");

            var courseId = lesson.Module.CourseId;
            var enrollment = await EnrollStudentAsync(userId, courseId);

            var progress = await _context.LessonProgresses
                .FirstOrDefaultAsync(lp => lp.EnrollmentId == enrollment.Id && lp.LessonId == lessonId);

            if (progress == null)
            {
                progress = new LessonProgress
                {
                    EnrollmentId = enrollment.Id,
                    LessonId = lessonId,
                    IsCompleted = true,
                    CompletedAt = DateTime.UtcNow
                };
                _context.LessonProgresses.Add(progress);
                await _context.SaveChangesAsync();
            }
            else if (!progress.IsCompleted)
            {
                progress.IsCompleted = true;
                progress.CompletedAt = DateTime.UtcNow;
                await _context.SaveChangesAsync();
            }

            // Conteo de lecciones de lectura obligatorias
            var totalLessons = await _context.Lessons
                .Where(l => l.Module.CourseId == courseId && l.IsMandatory)
                .CountAsync();

            var completedCount = await _context.LessonProgresses
                .Where(lp => lp.EnrollmentId == enrollment.Id && lp.IsCompleted && lp.Lesson.IsMandatory)
                .CountAsync();

            bool allReadingsDone = (totalLessons > 0 && completedCount >= totalLessons);

            // Si aún no ha aprobado la prueba, el avance de lecturas pondera hasta el 90%
            decimal readingWeight = allReadingsDone ? 90m : Math.Round(((decimal)completedCount / totalLessons) * 90m, 2);

            if (enrollment.QuizPassed)
            {
                enrollment.ProgressPercentage = 100m;
                enrollment.IsCompleted = true;
            }
            else
            {
                enrollment.ProgressPercentage = readingWeight;
            }

            await _context.SaveChangesAsync();

            var cert = await _context.Certificates
                .FirstOrDefaultAsync(c => c.UserId == userId && c.CourseId == courseId);

            return new ProgressUpdateResult
            {
                NewPercentage = enrollment.ProgressPercentage,
                AllReadingsCompleted = allReadingsDone,
                IsCourseCompleted = enrollment.IsCompleted,
                CertificateId = cert?.Id
            };
        }

        public async Task<QuizEvaluationResult> SubmitQuizAsync(int userId, int quizId, Dictionary<int, int> selectedOptions)
        {
            var quiz = await _context.Quizzes
                .Include(q => q.Course)
                .Include(q => q.Questions.OrderBy(qu => qu.OrderIndex))
                    .ThenInclude(qu => qu.Options)
                .FirstOrDefaultAsync(q => q.Id == quizId);

            if (quiz == null) throw new ArgumentException("Cuestionario no encontrado.");

            var enrollment = await EnrollStudentAsync(userId, quiz.CourseId);

            int correctCount = 0;
            var feedbackList = new List<QuestionFeedback>();

            foreach (var question in quiz.Questions)
            {
                var correctOption = question.Options.FirstOrDefault(o => o.IsCorrect);
                selectedOptions.TryGetValue(question.Id, out int chosenOptionId);

                bool isCorrect = (correctOption != null && chosenOptionId == correctOption.Id);
                if (isCorrect) correctCount++;

                feedbackList.Add(new QuestionFeedback
                {
                    QuestionId = question.Id,
                    QuestionText = question.QuestionText,
                    SelectedOptionId = chosenOptionId,
                    CorrectOptionId = correctOption?.Id ?? 0,
                    IsCorrect = isCorrect,
                    Explanation = question.Explanation
                });
            }

            decimal score = quiz.Questions.Count > 0 
                ? Math.Round(((decimal)correctCount / quiz.Questions.Count) * 100m, 2) 
                : 0m;

            bool isPassed = score >= quiz.PassingPercentage;

            // Registrar intento
            var attempt = new QuizAttempt
            {
                QuizId = quiz.Id,
                UserId = userId,
                ScorePercentage = score,
                IsPassed = isPassed,
                AnswersJson = JsonSerializer.Serialize(selectedOptions),
                AttemptedAt = DateTime.UtcNow
            };
            _context.QuizAttempts.Add(attempt);

            string? certId = null;

            if (isPassed)
            {
                enrollment.QuizPassed = true;
                enrollment.QuizScore = score;
                enrollment.ProgressPercentage = 100.00m;
                enrollment.IsCompleted = true;
                enrollment.CompletedAt = DateTime.UtcNow;

                await _context.SaveChangesAsync();

                // Trigger del certificado al aprobar el examen
                var cert = await _certificateService.GenerateLockedCertificateAsync(enrollment.Id, score);
                certId = cert.Id;
            }
            else
            {
                await _context.SaveChangesAsync();
            }

            return new QuizEvaluationResult
            {
                IsPassed = isPassed,
                ScorePercentage = score,
                CorrectAnswers = correctCount,
                TotalQuestions = quiz.Questions.Count,
                CertificateId = certId,
                Feedback = feedbackList
            };
        }

        public async Task<CourseStudySessionViewModel?> GetStudySessionAsync(int userId, string courseSlug, int? requestedLessonId)
        {
            var course = await _context.Courses
                .Include(c => c.Category)
                .Include(c => c.Quiz)
                    .ThenInclude(q => q!.Questions.OrderBy(qu => qu.OrderIndex))
                        .ThenInclude(qu => qu.Options)
                .Include(c => c.Modules.OrderBy(m => m.OrderIndex))
                    .ThenInclude(m => m.Lessons.OrderBy(l => l.OrderIndex))
                .FirstOrDefaultAsync(c => c.Slug == courseSlug);

            if (course == null) return null;

            var enrollment = await EnrollStudentAsync(userId, course.Id);

            var completedLessonIds = await _context.LessonProgresses
                .Where(lp => lp.EnrollmentId == enrollment.Id && lp.IsCompleted)
                .Select(lp => lp.LessonId)
                .ToHashSetAsync();

            var allLessons = course.Modules
                .OrderBy(m => m.OrderIndex)
                .SelectMany(m => m.Lessons.OrderBy(l => l.OrderIndex))
                .ToList();

            bool allReadingsDone = allLessons.All(l => completedLessonIds.Contains(l.Id));

            Lesson? current = null;
            if (requestedLessonId.HasValue)
            {
                current = allLessons.FirstOrDefault(l => l.Id == requestedLessonId.Value);
            }

            if (current == null && allLessons.Any())
            {
                current = allLessons.FirstOrDefault(l => !completedLessonIds.Contains(l.Id)) ?? allLessons.FirstOrDefault();
            }

            var latestAttempt = course.Quiz != null
                ? await _context.QuizAttempts
                    .Where(a => a.QuizId == course.Quiz.Id && a.UserId == userId)
                    .OrderByDescending(a => a.AttemptedAt)
                    .FirstOrDefaultAsync()
                : null;

            var certificate = await _context.Certificates
                .FirstOrDefaultAsync(c => c.UserId == userId && c.CourseId == course.Id);

            return new CourseStudySessionViewModel
            {
                Course = course,
                Enrollment = enrollment,
                CurrentLesson = current,
                CompletedLessonIds = completedLessonIds,
                Quiz = course.Quiz,
                AllReadingsCompleted = allReadingsDone,
                LatestAttempt = latestAttempt,
                Certificate = certificate
            };
        }

        public async Task<List<CourseEnrollment>> GetStudentEnrollmentsAsync(int userId)
        {
            return await _context.CourseEnrollments
                .Include(e => e.Course)
                    .ThenInclude(c => c.Category)
                .Include(e => e.Course)
                    .ThenInclude(c => c.Certificates.Where(cert => cert.UserId == userId))
                .Where(e => e.UserId == userId)
                .OrderByDescending(e => e.EnrolledAt)
                .ToListAsync();
        }
    }
}
