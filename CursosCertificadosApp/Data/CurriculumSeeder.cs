using CursosCertificadosApp.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace CursosCertificadosApp.Data
{
    public static partial class CurriculumSeeder
    {
        public class CourseSeedData
        {
            public string CategorySlug { get; set; } = string.Empty;
            public string Title { get; set; } = string.Empty;
            public string Slug { get; set; } = string.Empty;
            public string ShortDescription { get; set; } = string.Empty;
            public string Level { get; set; } = "Intermedio";
            public int EstimatedHours { get; set; } = 16;
            public string BadgeColor { get; set; } = "primary";
            public List<ModuleSeedData> Modules { get; set; } = new();
            public QuizSeedData Quiz { get; set; } = new();
        }

        public class ModuleSeedData
        {
            public string Title { get; set; } = string.Empty;
            public string LessonTitle { get; set; } = string.Empty;
            public string ContentHtml { get; set; } = string.Empty;
            public string Summary { get; set; } = string.Empty;
            public int DurationMinutes { get; set; } = 25;
        }

        public class QuizSeedData
        {
            public string Title { get; set; } = string.Empty;
            public List<QuestionSeedData> Questions { get; set; } = new();
        }

        public class QuestionSeedData
        {
            public string QuestionText { get; set; } = string.Empty;
            public string[] Options { get; set; } = Array.Empty<string>();
            public int CorrectIndex { get; set; }
            public string Explanation { get; set; } = string.Empty;
        }

        public static List<CourseSeedData> GetAllCurricula()
        {
            var list = new List<CourseSeedData>();
            list.AddRange(GetTechCourses());
            list.AddRange(GetEmployabilityCourses());
            return list;
        }

        public static async Task SeedOrUpdateAllCoursesAsync(AppDbContext context)
        {
            // 1. Asegurar las dos categorías oficiales de la plataforma
            var categories = await EnsureCategoriesAsync(context);

            // 2. Catálogo consolidado de los 10 cursos oficiales
            var allCourses = GetAllCurricula();
            var officialSlugs = allCourses.Select(c => c.Slug).ToHashSet(StringComparer.OrdinalIgnoreCase);

            // 3. Crear o actualizar los 10 cursos oficiales primero
            var targetCourseMap = new Dictionary<string, Course>(StringComparer.OrdinalIgnoreCase);

            foreach (var courseData in allCourses)
            {
                if (!categories.TryGetValue(courseData.CategorySlug, out var catId))
                    continue;

                var course = await context.Courses
                    .Include(c => c.Modules)
                        .ThenInclude(m => m.Lessons)
                    .FirstOrDefaultAsync(c => c.Slug == courseData.Slug);

                if (course == null)
                {
                    course = new Course
                    {
                        CategoryId = catId,
                        Title = courseData.Title,
                        Slug = courseData.Slug,
                        ShortDescription = courseData.ShortDescription,
                        FullDescription = $"{courseData.ShortDescription} Programa formativo profesional estructurado en lecturas especializadas, casos prácticos del entorno laboral y evaluación sumativa final para acreditación oficial.",
                        Level = courseData.Level,
                        EstimatedHours = courseData.EstimatedHours,
                        PassingScore = 70.00m,
                        BadgeColor = courseData.BadgeColor,
                        IsPublished = true,
                        CreatedAt = DateTime.UtcNow
                    };
                    context.Courses.Add(course);
                    await context.SaveChangesAsync();
                }
                else
                {
                    course.Title = courseData.Title;
                    course.ShortDescription = courseData.ShortDescription;
                    course.FullDescription = $"{courseData.ShortDescription} Programa formativo profesional estructurado en lecturas especializadas, casos prácticos del entorno laboral y evaluación sumativa final para acreditación oficial.";
                    course.Level = courseData.Level;
                    course.EstimatedHours = courseData.EstimatedHours;
                    course.BadgeColor = courseData.BadgeColor;
                    course.CategoryId = catId;
                    course.IsPublished = true;
                }

                // Sincronizar Módulos y Lecciones (Ajustar a las 4 lecciones requeridas)
                var existingMods = await context.CourseModules
                    .Include(m => m.Lessons)
                    .Where(m => m.CourseId == course.Id)
                    .OrderBy(m => m.OrderIndex)
                    .ToListAsync();

                // Eliminar módulos excedentes si un curso previo tenía más de los requeridos
                if (existingMods.Count > courseData.Modules.Count)
                {
                    var excessMods = existingMods.Skip(courseData.Modules.Count).ToList();
                    var excessModIds = excessMods.Select(m => m.Id).ToList();
                    var excessLessons = excessMods.SelectMany(m => m.Lessons).ToList();
                    var excessLessonIds = excessLessons.Select(l => l.Id).ToList();

                    var excessProgresses = await context.LessonProgresses.Where(lp => excessLessonIds.Contains(lp.LessonId)).ToListAsync();
                    if (excessProgresses.Count > 0) context.LessonProgresses.RemoveRange(excessProgresses);

                    context.Lessons.RemoveRange(excessLessons);
                    context.CourseModules.RemoveRange(excessMods);
                    await context.SaveChangesAsync();

                    existingMods = existingMods.Take(courseData.Modules.Count).ToList();
                }

                for (int i = 0; i < courseData.Modules.Count; i++)
                {
                    var modData = courseData.Modules[i];
                    CourseModule targetMod;

                    if (i < existingMods.Count)
                    {
                        targetMod = existingMods[i];
                        targetMod.Title = modData.Title;
                        targetMod.OrderIndex = i + 1;
                    }
                    else
                    {
                        targetMod = new CourseModule
                        {
                            CourseId = course.Id,
                            Title = modData.Title,
                            OrderIndex = i + 1
                        };
                        context.CourseModules.Add(targetMod);
                        await context.SaveChangesAsync();
                    }

                    var targetLesson = targetMod.Lessons.FirstOrDefault();
                    var isPresentation = modData.LessonTitle.Contains("Presentación") || modData.LessonTitle.Contains("Visual");

                    if (targetLesson != null)
                    {
                        targetLesson.Title = modData.LessonTitle;
                        targetLesson.ContentType = isPresentation ? "Presentation" : "Reading";
                        targetLesson.ContentHtml = modData.ContentHtml;
                        targetLesson.Summary = modData.Summary;
                        targetLesson.DurationMinutes = modData.DurationMinutes;
                        targetLesson.OrderIndex = 1;
                        targetLesson.IsMandatory = true;
                    }
                    else
                    {
                        var newLesson = new Lesson
                        {
                            ModuleId = targetMod.Id,
                            Title = modData.LessonTitle,
                            ContentType = isPresentation ? "Presentation" : "Reading",
                            ContentHtml = modData.ContentHtml,
                            Summary = modData.Summary,
                            DurationMinutes = modData.DurationMinutes,
                            OrderIndex = 1,
                            IsMandatory = true
                        };
                        context.Lessons.Add(newLesson);
                    }
                }
                await context.SaveChangesAsync();

                // Sincronizar o recrear Quiz
                var existingQuiz = await context.Quizzes
                    .Include(q => q.Questions)
                        .ThenInclude(qu => qu.Options)
                    .FirstOrDefaultAsync(q => q.CourseId == course.Id);

                if (existingQuiz != null)
                {
                    // Actualizar preguntas u opciones existentes limpiamente
                    foreach (var q in existingQuiz.Questions)
                    {
                        context.QuizOptions.RemoveRange(q.Options);
                    }
                    context.QuizQuestions.RemoveRange(existingQuiz.Questions);
                    await context.SaveChangesAsync();
                }
                else
                {
                    existingQuiz = new Quiz
                    {
                        CourseId = course.Id,
                        Title = courseData.Quiz.Title,
                        Description = "Evaluación sumativa corta para validar los conocimientos adquiridos. Calificación aprobatoria mínima: 70%.",
                        PassingPercentage = 70.00m,
                        TimeLimitMinutes = 20
                    };
                    context.Quizzes.Add(existingQuiz);
                    await context.SaveChangesAsync();
                }

                existingQuiz.Title = courseData.Quiz.Title;

                int qOrder = 1;
                foreach (var q in courseData.Quiz.Questions)
                {
                    var question = new QuizQuestion
                    {
                        QuizId = existingQuiz.Id,
                        QuestionText = q.QuestionText,
                        Explanation = q.Explanation,
                        OrderIndex = qOrder
                    };
                    context.QuizQuestions.Add(question);
                    await context.SaveChangesAsync();

                    for (int optIdx = 0; optIdx < q.Options.Length; optIdx++)
                    {
                        var option = new QuizOption
                        {
                            QuestionId = question.Id,
                            OptionText = q.Options[optIdx],
                            IsCorrect = (optIdx == q.CorrectIndex)
                        };
                        context.QuizOptions.Add(option);
                    }
                    await context.SaveChangesAsync();
                    qOrder++;
                }

                targetCourseMap[course.Slug] = course;
            }

            // 4. Migración de certificados e inscripciones de cursos antiguos a los nuevos equivalentes
            var migrationMap = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
            {
                { "domina-la-ia-con-gemini", "alfabetizacion-ia-gemini-chatgpt" },
                { "power-bi", "gestion-datos-analisis-excel" },
                { "excel-avanzado", "gestion-datos-analisis-excel" },
                { "ciencia-y-analisis-de-datos", "gestion-datos-analisis-excel" },
                { "office-basico", "ofimatica-nube-google-workspace" },
                { "office-intermedio", "ofimatica-nube-google-workspace" },
                { "office-intermedio-y-basico", "ofimatica-nube-google-workspace" },
                { "ti-para-el-exito-empresarial", "ofimatica-nube-google-workspace" },
                { "introduccion-ciberseguridad", "ciberseguridad-y-redes-pymes" },
                { "gestion-proyectos-agile", "transformacion-digital-empresas" },
                { "administracion-de-inventario", "transformacion-digital-empresas" },
                { "ventas-en-linea", "transformacion-digital-empresas" },
                { "planificacion-estrategica", "transformacion-digital-empresas" },
                { "ingles-a1-english-fundamentals", "ingles-profesional-entrevistas-networking" },
                { "liderazgo-efectivo", "networking-crecimiento-liderazgo" },
                { "gestion-del-tiempo", "gestion-tiempo-productividad-pensamiento-critico" },
                { "tacticas-de-negociacion-efectiva", "entrevistas-trabajo-exitosas" },
                { "atencion-al-cliente", "entrevistas-trabajo-exitosas" },
                { "primeros-auxilios", "gestion-tiempo-productividad-pensamiento-critico" },
                { "prueba-1", "alfabetizacion-ia-gemini-chatgpt" }
            };

            var obsoleteCourses = await context.Courses
                .Where(c => !officialSlugs.Contains(c.Slug))
                .ToListAsync();

            foreach (var obsCourse in obsoleteCourses)
            {
                var targetSlug = migrationMap.TryGetValue(obsCourse.Slug, out var mapped) ? mapped : "alfabetizacion-ia-gemini-chatgpt";
                if (targetCourseMap.TryGetValue(targetSlug, out var targetCourse))
                {
                    // Migrar certificados
                    var certs = await context.Certificates.Where(ce => ce.CourseId == obsCourse.Id).ToListAsync();
                    foreach (var cert in certs)
                    {
                        cert.CourseId = targetCourse.Id;
                    }

                    // Migrar inscripciones
                    var enrollments = await context.CourseEnrollments.Where(e => e.CourseId == obsCourse.Id).ToListAsync();
                    foreach (var en in enrollments)
                    {
                        var alreadyEnrolled = await context.CourseEnrollments.AnyAsync(e => e.CourseId == targetCourse.Id && e.UserId == en.UserId);
                        if (!alreadyEnrolled)
                        {
                            en.CourseId = targetCourse.Id;
                        }
                        else
                        {
                            // Si ya está inscrito en el nuevo, eliminar progreso duplicado
                            var prog = await context.LessonProgresses.Where(lp => lp.EnrollmentId == en.Id).ToListAsync();
                            if (prog.Count > 0) context.LessonProgresses.RemoveRange(prog);
                            context.CourseEnrollments.Remove(en);
                        }
                    }
                    await context.SaveChangesAsync();
                }

                // Eliminar módulos, lecciones, quizzes del curso obsoleto
                var oldModules = await context.CourseModules.Include(m => m.Lessons).Where(m => m.CourseId == obsCourse.Id).ToListAsync();
                var oldLessonIds = oldModules.SelectMany(m => m.Lessons.Select(l => l.Id)).ToList();
                var oldProgresses = await context.LessonProgresses.Where(lp => oldLessonIds.Contains(lp.LessonId)).ToListAsync();
                if (oldProgresses.Count > 0) context.LessonProgresses.RemoveRange(oldProgresses);

                foreach (var m in oldModules)
                {
                    context.Lessons.RemoveRange(m.Lessons);
                }
                context.CourseModules.RemoveRange(oldModules);

                var oldQuizzes = await context.Quizzes
                    .Include(q => q.Questions).ThenInclude(qu => qu.Options)
                    .Include(q => q.Attempts)
                    .Where(q => q.CourseId == obsCourse.Id)
                    .ToListAsync();

                foreach (var q in oldQuizzes)
                {
                    if (q.Attempts.Count > 0) context.QuizAttempts.RemoveRange(q.Attempts);
                    foreach (var qu in q.Questions)
                    {
                        context.QuizOptions.RemoveRange(qu.Options);
                    }
                    context.QuizQuestions.RemoveRange(q.Questions);
                }
                context.Quizzes.RemoveRange(oldQuizzes);

                context.Courses.Remove(obsCourse);
                await context.SaveChangesAsync();
            }

            // 5. Limpiar categorías obsoletas sin cursos asociados
            var activeCategorySlugs = new[] { "tecnologia-ia-ofimatica", "empleabilidad-desarrollo-idiomas" };
            var obsoleteCategories = await context.Categories
                .Where(c => !activeCategorySlugs.Contains(c.Slug))
                .ToListAsync();

            foreach (var cat in obsoleteCategories)
            {
                var hasCourses = await context.Courses.AnyAsync(c => c.CategoryId == cat.Id);
                if (!hasCourses)
                {
                    context.Categories.Remove(cat);
                }
            }
            await context.SaveChangesAsync();
        }

        private static async Task<Dictionary<string, int>> EnsureCategoriesAsync(AppDbContext context)
        {
            var catTech = await context.Categories.FirstOrDefaultAsync(c => c.Slug == "tecnologia-ia-ofimatica");
            if (catTech == null)
            {
                catTech = new Category
                {
                    Name = "Tecnología, IA y Ofimática",
                    Slug = "tecnologia-ia-ofimatica",
                    Description = "Competencias digitales avanzadas, inteligencia artificial generativa aplicada, ofimática en la nube, ciberseguridad y análisis de datos.",
                    IconClass = "bi-cpu",
                    DisplayOrder = 1
                };
                context.Categories.Add(catTech);
            }
            else
            {
                catTech.Name = "Tecnología, IA y Ofimática";
                catTech.Description = "Competencias digitales avanzadas, inteligencia artificial generativa aplicada, ofimática en la nube, ciberseguridad y análisis de datos.";
                catTech.IconClass = "bi-cpu";
                catTech.DisplayOrder = 1;
            }

            var catEmploy = await context.Categories.FirstOrDefaultAsync(c => c.Slug == "empleabilidad-desarrollo-idiomas");
            if (catEmploy == null)
            {
                catEmploy = new Category
                {
                    Name = "Empleabilidad, Desarrollo Humano e Idiomas",
                    Slug = "empleabilidad-desarrollo-idiomas",
                    Description = "Habilidades profesionales, liderazgo, entrevistas de impacto, comunicación corporativa e inglés para los negocios.",
                    IconClass = "bi-person-badge",
                    DisplayOrder = 2
                };
                context.Categories.Add(catEmploy);
            }
            else
            {
                catEmploy.Name = "Empleabilidad, Desarrollo Humano e Idiomas";
                catEmploy.Description = "Habilidades profesionales, liderazgo, entrevistas de impacto, comunicación corporativa e inglés para los negocios.";
                catEmploy.IconClass = "bi-person-badge";
                catEmploy.DisplayOrder = 2;
            }

            await context.SaveChangesAsync();

            return await context.Categories
                .Where(c => activeCategorySlugs.Contains(c.Slug))
                .ToDictionaryAsync(c => c.Slug, c => c.Id);
        }

        private static readonly string[] activeCategorySlugs = new[] { "tecnologia-ia-ofimatica", "empleabilidad-desarrollo-idiomas" };
    }
}
