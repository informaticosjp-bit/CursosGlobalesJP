using CursosCertificadosApp.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace CursosCertificadosApp.Data
{
    public class UpgradeCourseData
    {
        public string Slug { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;
        public string CategorySlug { get; set; } = string.Empty;
        public string ShortDescription { get; set; } = string.Empty;
        public string FullDescription { get; set; } = string.Empty;
        public string Level { get; set; } = "Básico";
        public int EstimatedHours { get; set; } = 20;
        public string BadgeColor { get; set; } = "primary";
        public List<UpgradeModuleData> Modules { get; set; } = new();
        public List<UpgradeQuestionData> Questions { get; set; } = new();
        public List<UpgradeQuizQuestionData> QuizQuestions { get; set; } = new();
    }

    public class UpgradeQuizQuestionData
    {
        public string Question { get; set; } = string.Empty;
        public string OptionA { get; set; } = string.Empty;
        public string OptionB { get; set; } = string.Empty;
        public string OptionC { get; set; } = string.Empty;
        public string OptionD { get; set; } = string.Empty;
        public string CorrectAnswer { get; set; } = "A";
        public string Explanation { get; set; } = string.Empty;
    }

    public class UpgradeModuleData
    {
        public string Title { get; set; } = string.Empty;
        public string LessonTitle { get; set; } = string.Empty;
        public string Summary { get; set; } = string.Empty;
        public string ContentHtml { get; set; } = string.Empty;
        public int DurationMinutes { get; set; } = 30;
    }

    public class UpgradeQuestionData
    {
        public string QuestionText { get; set; } = string.Empty;
        public string[] Options { get; set; } = Array.Empty<string>();
        public int CorrectIndex { get; set; }
        public string Explanation { get; set; } = string.Empty;
    }

    public static class CurriculumUpgradeHelper
    {
        public static async Task ApplyCourseUpgradeAsync(AppDbContext context, UpgradeCourseData data)
        {
            if (!data.Questions.Any() && data.QuizQuestions != null && data.QuizQuestions.Any())
            {
                foreach (var qq in data.QuizQuestions)
                {
                    int corrIdx = qq.CorrectAnswer?.Trim().ToUpperInvariant() switch
                    {
                        "B" => 1,
                        "C" => 2,
                        "D" => 3,
                        _ => 0
                    };

                    data.Questions.Add(new UpgradeQuestionData
                    {
                        QuestionText = qq.Question,
                        Options = new[] { qq.OptionA, qq.OptionB, qq.OptionC, qq.OptionD },
                        CorrectIndex = corrIdx,
                        Explanation = qq.Explanation
                    });
                }
            }

            var category = await context.Categories.FirstOrDefaultAsync(c => c.Slug == data.CategorySlug);
            if (category == null)
            {
                category = await context.Categories.FirstOrDefaultAsync();
            }

            var course = await context.Courses
                .Include(c => c.Modules)
                    .ThenInclude(m => m.Lessons)
                .FirstOrDefaultAsync(c => c.Slug == data.Slug);

            if (course == null)
            {
                course = new Course
                {
                    CategoryId = category?.Id ?? 1,
                    Title = data.Title,
                    Slug = data.Slug,
                    ShortDescription = data.ShortDescription,
                    FullDescription = data.FullDescription,
                    Level = data.Level,
                    EstimatedHours = data.EstimatedHours,
                    PassingScore = 70.00m,
                    Price = 1.00m,
                    BadgeColor = data.BadgeColor,
                    IsPublished = true,
                    CreatedAt = DateTime.UtcNow
                };
                context.Courses.Add(course);
                await context.SaveChangesAsync();
            }
            else
            {
                course.Title = data.Title;
                course.ShortDescription = data.ShortDescription;
                course.FullDescription = data.FullDescription;
                course.Level = data.Level;
                course.EstimatedHours = data.EstimatedHours;
                course.BadgeColor = data.BadgeColor;
                course.IsPublished = true;
                if (category != null)
                {
                    course.CategoryId = category.Id;
                }
                await context.SaveChangesAsync();
            }

            // 1. Sincronizar Módulos y Lecciones
            var existingModules = await context.CourseModules
                .Include(m => m.Lessons)
                .Where(m => m.CourseId == course.Id)
                .OrderBy(m => m.OrderIndex)
                .ToListAsync();

            // Actualizar o crear módulos requeridos
            for (int i = 0; i < data.Modules.Count; i++)
            {
                var modData = data.Modules[i];
                CourseModule mod;

                if (i < existingModules.Count)
                {
                    mod = existingModules[i];
                    mod.Title = modData.Title;
                    mod.OrderIndex = i + 1;
                }
                else
                {
                    mod = new CourseModule
                    {
                        CourseId = course.Id,
                        Title = modData.Title,
                        OrderIndex = i + 1
                    };
                    context.CourseModules.Add(mod);
                    await context.SaveChangesAsync();
                }

                var lesson = mod.Lessons.FirstOrDefault();
                if (lesson != null)
                {
                    lesson.Title = modData.LessonTitle;
                    lesson.ContentType = "Reading";
                    lesson.ContentHtml = modData.ContentHtml;
                    lesson.Summary = modData.Summary;
                    lesson.DurationMinutes = modData.DurationMinutes;
                    lesson.OrderIndex = 1;
                    lesson.IsMandatory = true;
                }
                else
                {
                    lesson = new Lesson
                    {
                        ModuleId = mod.Id,
                        Title = modData.LessonTitle,
                        ContentType = "Reading",
                        ContentHtml = modData.ContentHtml,
                        Summary = modData.Summary,
                        DurationMinutes = modData.DurationMinutes,
                        OrderIndex = 1,
                        IsMandatory = true
                    };
                    context.Lessons.Add(lesson);
                }
            }

            // Si habían más módulos antiguos con lecciones vacías, remover los sobrantes
            if (existingModules.Count > data.Modules.Count)
            {
                for (int i = data.Modules.Count; i < existingModules.Count; i++)
                {
                    var extraMod = existingModules[i];
                    // Verificar si algún alumno tiene progreso en estas lecciones extra
                    var lessonIds = extraMod.Lessons.Select(l => l.Id).ToList();
                    var hasProgress = await context.LessonProgresses.AnyAsync(lp => lessonIds.Contains(lp.LessonId));
                    if (!hasProgress)
                    {
                        context.Lessons.RemoveRange(extraMod.Lessons);
                        context.CourseModules.Remove(extraMod);
                    }
                }
            }

            await context.SaveChangesAsync();

            // 2. Sincronizar Cuestionario Exigente (10 Preguntas Obligatorias)
            var quiz = await context.Quizzes
                .Include(q => q.Questions)
                    .ThenInclude(qu => qu.Options)
                .FirstOrDefaultAsync(q => q.CourseId == course.Id);

            if (quiz == null)
            {
                quiz = new Quiz
                {
                    CourseId = course.Id,
                    Title = $"{data.Title} - Evaluación Sumativa de Validación",
                    Description = "Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.",
                    PassingPercentage = 70.00m,
                    TimeLimitMinutes = 25
                };
                context.Quizzes.Add(quiz);
                await context.SaveChangesAsync();
            }
            else
            {
                quiz.Title = $"{data.Title} - Evaluación Sumativa de Validación";
                quiz.Description = "Evaluación técnica de 10 preguntas para constatar el dominio de los conceptos y aplicaciones prácticas del curso. Requiere un mínimo de 70% de aprobación para certificar.";
                quiz.PassingPercentage = 70.00m;
                quiz.TimeLimitMinutes = 25;

                // Limpiar preguntas anteriores para reconstruir el banco de 10 preguntas
                foreach (var q in quiz.Questions)
                {
                    context.QuizOptions.RemoveRange(q.Options);
                }
                context.QuizQuestions.RemoveRange(quiz.Questions);
                await context.SaveChangesAsync();
            }

            // Insertar exactamente las 10 preguntas
            int qIndex = 1;
            foreach (var qData in data.Questions)
            {
                var question = new QuizQuestion
                {
                    QuizId = quiz.Id,
                    QuestionText = qData.QuestionText,
                    Explanation = qData.Explanation,
                    OrderIndex = qIndex
                };
                context.QuizQuestions.Add(question);
                await context.SaveChangesAsync();

                for (int optIdx = 0; optIdx < qData.Options.Length; optIdx++)
                {
                    var option = new QuizOption
                    {
                        QuestionId = question.Id,
                        OptionText = qData.Options[optIdx],
                        IsCorrect = (optIdx == qData.CorrectIndex)
                    };
                    context.QuizOptions.Add(option);
                }
                await context.SaveChangesAsync();
                qIndex++;
            }
        }
    }
}
