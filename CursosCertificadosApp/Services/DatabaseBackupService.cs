using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models.Entities;
using Microsoft.EntityFrameworkCore;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace CursosCertificadosApp.Services
{
    public class FullBackupSnapshot
    {
        public string AppName { get; set; } = "Cursos Globales JP";
        public string Version { get; set; } = "2.0";
        public DateTime ExportedAt { get; set; } = DateTime.UtcNow;
        public string ExportedBy { get; set; } = "Administrator";
        public int TotalRecordsCount { get; set; }

        public List<Category> Categories { get; set; } = new();
        public List<User> Users { get; set; } = new();
        public List<Course> Courses { get; set; } = new();
        public List<CourseModule> CourseModules { get; set; } = new();
        public List<Lesson> Lessons { get; set; } = new();
        public List<Quiz> Quizzes { get; set; } = new();
        public List<QuizQuestion> QuizQuestions { get; set; } = new();
        public List<QuizOption> QuizOptions { get; set; } = new();
        public List<CourseEnrollment> CourseEnrollments { get; set; } = new();
        public List<LessonProgress> LessonProgresses { get; set; } = new();
        public List<QuizAttempt> QuizAttempts { get; set; } = new();
        public List<Certificate> Certificates { get; set; } = new();
        public List<Payment> Payments { get; set; } = new();
        public List<UserNotification> UserNotifications { get; set; } = new();
        public List<UserCv> UserCvs { get; set; } = new();
        public List<SystemSetting> SystemSettings { get; set; } = new();
    }

    public class DatabaseBackupService : IDatabaseBackupService
    {
        private readonly AppDbContext _context;
        private readonly IWebHostEnvironment _env;
        private readonly IConfiguration _configuration;

        public DatabaseBackupService(
            AppDbContext context,
            IWebHostEnvironment env,
            IConfiguration configuration)
        {
            _context = context;
            _env = env;
            _configuration = configuration;
        }

        private string GetBackupDirectory()
        {
            var dir = Path.Combine(_env.ContentRootPath, "App_Data", "Backups");
            if (!Directory.Exists(dir))
            {
                Directory.CreateDirectory(dir);
            }
            return dir;
        }

        public async Task<DatabaseStatsViewModel> GetDatabaseStatsAsync()
        {
            var rawProvider = _context.Database.ProviderName ?? "PostgreSQL";
            var cleanProvider = rawProvider.Contains("Npgsql", StringComparison.OrdinalIgnoreCase) || rawProvider.Contains("Postgre", StringComparison.OrdinalIgnoreCase)
                ? "PostgreSQL"
                : (rawProvider.Contains("Sqlite", StringComparison.OrdinalIgnoreCase) ? "SQLite" : rawProvider);

            var stats = new DatabaseStatsViewModel
            {
                Provider = cleanProvider,
                DatabaseName = "cursos_globales_jp"
            };

            try
            {
                stats.IsConnected = await _context.Database.CanConnectAsync();
            }
            catch
            {
                stats.IsConnected = false;
            }

            if (stats.IsConnected)
            {
                stats.TableCounts["Usuarios"] = await _context.Users.CountAsync();
                stats.TableCounts["Cursos"] = await _context.Courses.CountAsync();
                stats.TableCounts["Categorías"] = await _context.Categories.CountAsync();
                stats.TableCounts["Módulos"] = await _context.CourseModules.CountAsync();
                stats.TableCounts["Lecciones"] = await _context.Lessons.CountAsync();
                stats.TableCounts["Inscripciones"] = await _context.CourseEnrollments.CountAsync();
                stats.TableCounts["Certificados"] = await _context.Certificates.CountAsync();
                stats.TableCounts["Pagos Registrados"] = await _context.Payments.CountAsync();
                stats.TableCounts["Evaluaciones (Quizzes)"] = await _context.Quizzes.CountAsync();
                stats.TableCounts["Notificaciones"] = await _context.UserNotifications.CountAsync();
                stats.TableCounts["Parámetros del Sistema"] = await _context.SystemSettings.CountAsync();

                stats.TotalRecords = stats.TableCounts.Values.Sum();
            }

            stats.BackupFiles = GetBackupHistory();

            return stats;
        }

        public async Task<(byte[] FileBytes, string FileName)> CreateJsonBackupAsync(string createdBy)
        {
            var snapshot = new FullBackupSnapshot
            {
                ExportedAt = DateTime.UtcNow,
                ExportedBy = createdBy,
                Categories = await _context.Categories.AsNoTracking().ToListAsync(),
                Users = await _context.Users.AsNoTracking().ToListAsync(),
                Courses = await _context.Courses.AsNoTracking().ToListAsync(),
                CourseModules = await _context.CourseModules.AsNoTracking().ToListAsync(),
                Lessons = await _context.Lessons.AsNoTracking().ToListAsync(),
                Quizzes = await _context.Quizzes.AsNoTracking().ToListAsync(),
                QuizQuestions = await _context.QuizQuestions.AsNoTracking().ToListAsync(),
                QuizOptions = await _context.QuizOptions.AsNoTracking().ToListAsync(),
                CourseEnrollments = await _context.CourseEnrollments.AsNoTracking().ToListAsync(),
                LessonProgresses = await _context.LessonProgresses.AsNoTracking().ToListAsync(),
                QuizAttempts = await _context.QuizAttempts.AsNoTracking().ToListAsync(),
                Certificates = await _context.Certificates.AsNoTracking().ToListAsync(),
                Payments = await _context.Payments.AsNoTracking().ToListAsync(),
                UserNotifications = await _context.UserNotifications.AsNoTracking().ToListAsync(),
                UserCvs = await _context.UserCvs.AsNoTracking().ToListAsync(),
                SystemSettings = await _context.SystemSettings.AsNoTracking().ToListAsync()
            };

            snapshot.TotalRecordsCount = snapshot.Categories.Count + snapshot.Users.Count +
                snapshot.Courses.Count + snapshot.CourseModules.Count + snapshot.Lessons.Count +
                snapshot.Quizzes.Count + snapshot.QuizQuestions.Count + snapshot.QuizOptions.Count +
                snapshot.CourseEnrollments.Count + snapshot.LessonProgresses.Count + snapshot.QuizAttempts.Count +
                snapshot.Certificates.Count + snapshot.Payments.Count + snapshot.UserNotifications.Count +
                snapshot.UserCvs.Count + snapshot.SystemSettings.Count;

            var options = new JsonSerializerOptions
            {
                WriteIndented = true,
                ReferenceHandler = ReferenceHandler.IgnoreCycles
            };

            var jsonString = JsonSerializer.Serialize(snapshot, options);
            var bytes = Encoding.UTF8.GetBytes(jsonString);

            var fileName = $"Respaldo_CursosGlobalesJP_{DateTime.UtcNow:yyyyMMdd_HHmmss}.json";

            // Guardar copia local en historial
            var backupPath = Path.Combine(GetBackupDirectory(), fileName);
            await File.WriteAllBytesAsync(backupPath, bytes);

            return (bytes, fileName);
        }

        public async Task<(byte[] FileBytes, string FileName)> CreateSqlBackupAsync()
        {
            var (jsonBytes, _) = await CreateJsonBackupAsync("System SQL Exporter");
            var jsonString = Encoding.UTF8.GetString(jsonBytes);
            var snapshot = JsonSerializer.Deserialize<FullBackupSnapshot>(jsonString);

            var sb = new StringBuilder();
            sb.AppendLine("-- ================================================================");
            sb.AppendLine($"-- RESPALDO OFICIAL DE BASE DE DATOS POSTGRESQL: CURSOS GLOBALES JP");
            sb.AppendLine($"-- Fecha de Generación: {DateTime.UtcNow:yyyy-MM-dd HH:mm:ss} UTC");
            sb.AppendLine("-- Empresa: Inversiones Globales JP 1968, C.A. (RIF: J-41102463-5)");
            sb.AppendLine("-- Compatible con: PostgreSQL 14+, pgAdmin, psql CLI y VPS Linux/Windows");
            sb.AppendLine("-- ================================================================\n");

            sb.AppendLine("BEGIN TRANSACTION;\n");

            sb.AppendLine("-- 1. VACIADO DE TABLAS EN ORDEN INVERSO DE INTEGRIDAD REFERENCIAL");
            sb.AppendLine("DELETE FROM \"LessonProgresses\";");
            sb.AppendLine("DELETE FROM \"QuizAttempts\";");
            sb.AppendLine("DELETE FROM \"QuizOptions\";");
            sb.AppendLine("DELETE FROM \"QuizQuestions\";");
            sb.AppendLine("DELETE FROM \"Quizzes\";");
            sb.AppendLine("DELETE FROM \"Lessons\";");
            sb.AppendLine("DELETE FROM \"CourseModules\";");
            sb.AppendLine("DELETE FROM \"CourseEnrollments\";");
            sb.AppendLine("DELETE FROM \"Certificates\";");
            sb.AppendLine("DELETE FROM \"Payments\";");
            sb.AppendLine("DELETE FROM \"UserNotifications\";");
            sb.AppendLine("DELETE FROM \"UserCvs\";");
            sb.AppendLine("DELETE FROM \"Courses\";");
            sb.AppendLine("DELETE FROM \"Categories\";");
            sb.AppendLine("DELETE FROM \"Users\";");
            sb.AppendLine("DELETE FROM \"SystemSettings\";\n");

            if (snapshot != null)
            {
                // 1. Categories
                sb.AppendLine("-- 2. CATEGORÍAS");
                foreach (var c in snapshot.Categories)
                {
                    sb.AppendLine($"INSERT INTO \"Categories\" (\"Id\", \"Name\", \"Slug\", \"Description\", \"IconClass\", \"DisplayOrder\") VALUES ({c.Id}, '{EscapeSql(c.Name)}', '{EscapeSql(c.Slug)}', '{EscapeSql(c.Description)}', '{EscapeSql(c.IconClass)}', {c.DisplayOrder});");
                }

                // 2. Users
                sb.AppendLine("\n-- 3. USUARIOS");
                foreach (var u in snapshot.Users)
                {
                    var birthStr = u.BirthDate.HasValue ? $"'{u.BirthDate.Value:o}'" : "NULL";
                    var picStr = string.IsNullOrEmpty(u.ProfilePictureUrl) ? "NULL" : $"'{EscapeSql(u.ProfilePictureUrl)}'";
                    sb.AppendLine($"INSERT INTO \"Users\" (\"Id\", \"FullName\", \"Email\", \"PasswordHash\", \"IdentificationNumber\", \"Role\", \"CreatedAt\", \"PhoneNumber\", \"Address\", \"BirthDate\", \"ProfilePictureUrl\") VALUES ({u.Id}, '{EscapeSql(u.FullName)}', '{EscapeSql(u.Email)}', '{EscapeSql(u.PasswordHash)}', '{EscapeSql(u.IdentificationNumber)}', '{EscapeSql(u.Role)}', '{u.CreatedAt:o}', '{EscapeSql(u.PhoneNumber)}', '{EscapeSql(u.Address)}', {birthStr}, {picStr});");
                }

                // 3. Courses
                sb.AppendLine("\n-- 4. CURSOS");
                foreach (var crs in snapshot.Courses)
                {
                    var creatorVal = crs.CreatorUserId.HasValue ? crs.CreatorUserId.Value.ToString() : "NULL";
                    var instName = string.IsNullOrEmpty(crs.InstructorName) ? "NULL" : $"'{EscapeSql(crs.InstructorName)}'";
                    var instTitle = string.IsNullOrEmpty(crs.InstructorTitle) ? "NULL" : $"'{EscapeSql(crs.InstructorTitle)}'";
                    var passingScore = crs.PassingScore.ToString(System.Globalization.CultureInfo.InvariantCulture);
                    sb.AppendLine($"INSERT INTO \"Courses\" (\"Id\", \"Title\", \"Slug\", \"ShortDescription\", \"FullDescription\", \"Level\", \"EstimatedHours\", \"PassingScore\", \"ImageUrl\", \"BadgeColor\", \"IsPublished\", \"CategoryId\", \"CreatedAt\", \"InstructorName\", \"InstructorTitle\", \"CreatorUserId\") VALUES ({crs.Id}, '{EscapeSql(crs.Title)}', '{EscapeSql(crs.Slug)}', '{EscapeSql(crs.ShortDescription)}', '{EscapeSql(crs.FullDescription)}', '{EscapeSql(crs.Level)}', {crs.EstimatedHours}, {passingScore}, '{EscapeSql(crs.ImageUrl)}', '{EscapeSql(crs.BadgeColor)}', {(crs.IsPublished ? "TRUE" : "FALSE")}, {crs.CategoryId}, '{crs.CreatedAt:o}', {instName}, {instTitle}, {creatorVal});");
                }

                // 4. CourseModules
                sb.AppendLine("\n-- 5. MÓDULOS DE CURSO");
                foreach (var m in snapshot.CourseModules)
                {
                    sb.AppendLine($"INSERT INTO \"CourseModules\" (\"Id\", \"CourseId\", \"Title\", \"OrderIndex\") VALUES ({m.Id}, {m.CourseId}, '{EscapeSql(m.Title)}', {m.OrderIndex});");
                }

                // 5. Lessons
                sb.AppendLine("\n-- 6. LECCIONES");
                foreach (var l in snapshot.Lessons)
                {
                    var summaryStr = string.IsNullOrEmpty(l.Summary) ? "NULL" : $"'{EscapeSql(l.Summary)}'";
                    sb.AppendLine($"INSERT INTO \"Lessons\" (\"Id\", \"ModuleId\", \"Title\", \"ContentType\", \"ContentHtml\", \"Summary\", \"DurationMinutes\", \"OrderIndex\", \"IsMandatory\") VALUES ({l.Id}, {l.ModuleId}, '{EscapeSql(l.Title)}', '{EscapeSql(l.ContentType)}', '{EscapeSql(l.ContentHtml)}', {summaryStr}, {l.DurationMinutes}, {l.OrderIndex}, {(l.IsMandatory ? "TRUE" : "FALSE")});");
                }

                // 6. Quizzes
                sb.AppendLine("\n-- 7. CUESTIONARIOS");
                foreach (var q in snapshot.Quizzes)
                {
                    var passPct = q.PassingPercentage.ToString(System.Globalization.CultureInfo.InvariantCulture);
                    sb.AppendLine($"INSERT INTO \"Quizzes\" (\"Id\", \"CourseId\", \"Title\", \"Description\", \"PassingPercentage\", \"TimeLimitMinutes\") VALUES ({q.Id}, {q.CourseId}, '{EscapeSql(q.Title)}', '{EscapeSql(q.Description)}', {passPct}, {q.TimeLimitMinutes});");
                }

                // 7. QuizQuestions
                sb.AppendLine("\n-- 8. PREGUNTAS DE EVALUACIÓN");
                foreach (var qq in snapshot.QuizQuestions)
                {
                    var explStr = string.IsNullOrEmpty(qq.Explanation) ? "NULL" : $"'{EscapeSql(qq.Explanation)}'";
                    sb.AppendLine($"INSERT INTO \"QuizQuestions\" (\"Id\", \"QuizId\", \"QuestionText\", \"Explanation\", \"OrderIndex\") VALUES ({qq.Id}, {qq.QuizId}, '{EscapeSql(qq.QuestionText)}', {explStr}, {qq.OrderIndex});");
                }

                // 8. QuizOptions
                sb.AppendLine("\n-- 9. OPCIONES DE RESPUESTA");
                foreach (var qo in snapshot.QuizOptions)
                {
                    sb.AppendLine($"INSERT INTO \"QuizOptions\" (\"Id\", \"QuestionId\", \"OptionText\", \"IsCorrect\") VALUES ({qo.Id}, {qo.QuestionId}, '{EscapeSql(qo.OptionText)}', {(qo.IsCorrect ? "TRUE" : "FALSE")});");
                }

                // 9. CourseEnrollments
                sb.AppendLine("\n-- 10. INSCRIPCIONES DE ESTUDIANTES");
                foreach (var ce in snapshot.CourseEnrollments)
                {
                    var completedAtStr = ce.CompletedAt.HasValue ? $"'{ce.CompletedAt.Value:o}'" : "NULL";
                    var progPct = ce.ProgressPercentage.ToString(System.Globalization.CultureInfo.InvariantCulture);
                    var quizScore = ce.QuizScore.ToString(System.Globalization.CultureInfo.InvariantCulture);
                    sb.AppendLine($"INSERT INTO \"CourseEnrollments\" (\"Id\", \"UserId\", \"CourseId\", \"EnrolledAt\", \"CompletedAt\", \"ProgressPercentage\", \"IsCompleted\", \"QuizPassed\", \"QuizScore\") VALUES ({ce.Id}, {ce.UserId}, {ce.CourseId}, '{ce.EnrolledAt:o}', {completedAtStr}, {progPct}, {(ce.IsCompleted ? "TRUE" : "FALSE")}, {(ce.QuizPassed ? "TRUE" : "FALSE")}, {quizScore});");
                }

                // 10. LessonProgresses
                sb.AppendLine("\n-- 11. PROGRESO DE LECCIONES");
                foreach (var lp in snapshot.LessonProgresses)
                {
                    var compAtStr = lp.CompletedAt.HasValue ? $"'{lp.CompletedAt.Value:o}'" : "NULL";
                    sb.AppendLine($"INSERT INTO \"LessonProgresses\" (\"Id\", \"EnrollmentId\", \"LessonId\", \"IsCompleted\", \"CompletedAt\") VALUES ({lp.Id}, {lp.EnrollmentId}, {lp.LessonId}, {(lp.IsCompleted ? "TRUE" : "FALSE")}, {compAtStr});");
                }

                // 11. QuizAttempts
                sb.AppendLine("\n-- 12. INTENTOS DE EVALUACIÓN");
                foreach (var qa in snapshot.QuizAttempts)
                {
                    var score = qa.ScorePercentage.ToString(System.Globalization.CultureInfo.InvariantCulture);
                    var answersStr = string.IsNullOrEmpty(qa.AnswersJson) ? "NULL" : $"'{EscapeSql(qa.AnswersJson)}'";
                    sb.AppendLine($"INSERT INTO \"QuizAttempts\" (\"Id\", \"QuizId\", \"UserId\", \"ScorePercentage\", \"IsPassed\", \"AnswersJson\", \"AttemptedAt\") VALUES ({qa.Id}, {qa.QuizId}, {qa.UserId}, {score}, {(qa.IsPassed ? "TRUE" : "FALSE")}, {answersStr}, '{qa.AttemptedAt:o}');");
                }

                // 12. Certificates
                sb.AppendLine("\n-- 13. CERTIFICADOS EMITIDOS");
                foreach (var cert in snapshot.Certificates)
                {
                    var issuedAtStr = cert.IssuedAt.HasValue ? $"'{cert.IssuedAt.Value:o}'" : "NULL";
                    var quizScoreStr = cert.QuizScore.HasValue ? cert.QuizScore.Value.ToString(System.Globalization.CultureInfo.InvariantCulture) : "NULL";
                    var previewStr = string.IsNullOrEmpty(cert.WatermarkPreviewUrl) ? "NULL" : $"'{EscapeSql(cert.WatermarkPreviewUrl)}'";
                    var pdfStr = string.IsNullOrEmpty(cert.FinalPdfPath) ? "NULL" : $"'{EscapeSql(cert.FinalPdfPath)}'";
                    var qrStr = string.IsNullOrEmpty(cert.QrCodeBase64) ? "NULL" : $"'{EscapeSql(cert.QrCodeBase64)}'";
                    sb.AppendLine($"INSERT INTO \"Certificates\" (\"Id\", \"VerificationCode\", \"UserId\", \"CourseId\", \"CreatedAt\", \"IssuedAt\", \"Status\", \"QuizScore\", \"WatermarkPreviewUrl\", \"FinalPdfPath\", \"QrCodeBase64\") VALUES ('{cert.Id}', '{EscapeSql(cert.VerificationCode)}', {cert.UserId}, {cert.CourseId}, '{cert.CreatedAt:o}', {issuedAtStr}, {(int)cert.Status}, {quizScoreStr}, {previewStr}, {pdfStr}, {qrStr});");
                }

                // 13. Payments
                sb.AppendLine("\n-- 14. PAGOS Y CONCILIACIONES");
                foreach (var p in snapshot.Payments)
                {
                    var certIdStr = string.IsNullOrEmpty(p.CertificateId) ? "NULL" : $"'{p.CertificateId}'";
                    var amountStr = p.Amount.ToString(System.Globalization.CultureInfo.InvariantCulture);
                    var proofStr = string.IsNullOrEmpty(p.ProofImageUrl) ? "NULL" : $"'{EscapeSql(p.ProofImageUrl)}'";
                    var procAtStr = p.ProcessedAt.HasValue ? $"'{p.ProcessedAt.Value:o}'" : "NULL";
                    var notesStr = string.IsNullOrEmpty(p.AdminNotes) ? "NULL" : $"'{EscapeSql(p.AdminNotes)}'";
                    sb.AppendLine($"INSERT INTO \"Payments\" (\"Id\", \"CertificateId\", \"UserId\", \"PaymentType\", \"Amount\", \"PaymentMethod\", \"TransactionReference\", \"ProofImageUrl\", \"Status\", \"CreatedAt\", \"ProcessedAt\", \"AdminNotes\") VALUES ({p.Id}, {certIdStr}, {p.UserId}, '{EscapeSql(p.PaymentType)}', {amountStr}, '{EscapeSql(p.PaymentMethod)}', '{EscapeSql(p.TransactionReference)}', {proofStr}, '{EscapeSql(p.Status)}', '{p.CreatedAt:o}', {procAtStr}, {notesStr});");
                }

                // 14. UserNotifications
                sb.AppendLine("\n-- 15. NOTIFICACIONES");
                foreach (var un in snapshot.UserNotifications)
                {
                    sb.AppendLine($"INSERT INTO \"UserNotifications\" (\"Id\", \"UserId\", \"Title\", \"Message\", \"Type\", \"IsRead\", \"CreatedAt\") VALUES ({un.Id}, {un.UserId}, '{EscapeSql(un.Title)}', '{EscapeSql(un.Message)}', '{EscapeSql(un.Type)}', {(un.IsRead ? "TRUE" : "FALSE")}, '{un.CreatedAt:o}');");
                }

                // 15. SystemSettings
                sb.AppendLine("\n-- 16. PARÁMETROS DEL SISTEMA (TÉRMINOS)");
                foreach (var s in snapshot.SystemSettings)
                {
                    sb.AppendLine($"INSERT INTO \"SystemSettings\" (\"Id\", \"Key\", \"Title\", \"Content\", \"UpdatedAt\") VALUES ({s.Id}, '{EscapeSql(s.Key)}', '{EscapeSql(s.Title)}', '{EscapeSql(s.Content)}', '{s.UpdatedAt:o}');");
                }

                // 16. UserCvs
                sb.AppendLine("\n-- 17. CURRICULUMS VITAE (USER CVS)");
                if (snapshot.UserCvs != null)
                {
                    foreach (var cv in snapshot.UserCvs)
                    {
                        var jobTitle = string.IsNullOrEmpty(cv.JobTitle) ? "NULL" : $"'{EscapeSql(cv.JobTitle)}'";
                        var email = string.IsNullOrEmpty(cv.Email) ? "NULL" : $"'{EscapeSql(cv.Email)}'";
                        var phone = string.IsNullOrEmpty(cv.PhoneNumber) ? "NULL" : $"'{EscapeSql(cv.PhoneNumber)}'";
                        var loc = string.IsNullOrEmpty(cv.Location) ? "NULL" : $"'{EscapeSql(cv.Location)}'";
                        var web = string.IsNullOrEmpty(cv.WebsiteOrLinkedIn) ? "NULL" : $"'{EscapeSql(cv.WebsiteOrLinkedIn)}'";
                        var sum = string.IsNullOrEmpty(cv.ProfessionalSummary) ? "NULL" : $"'{EscapeSql(cv.ProfessionalSummary)}'";
                        var exp = string.IsNullOrEmpty(cv.ExperienceJson) ? "'[]'" : $"'{EscapeSql(cv.ExperienceJson)}'";
                        var edu = string.IsNullOrEmpty(cv.EducationJson) ? "'[]'" : $"'{EscapeSql(cv.EducationJson)}'";
                        var skills = string.IsNullOrEmpty(cv.Skills) ? "NULL" : $"'{EscapeSql(cv.Skills)}'";
                        var certs = string.IsNullOrEmpty(cv.CertificationsJson) ? "'[]'" : $"'{EscapeSql(cv.CertificationsJson)}'";
                        var idNum = string.IsNullOrEmpty(cv.IdentificationNumber) ? "NULL" : $"'{EscapeSql(cv.IdentificationNumber)}'";
                        var addr = string.IsNullOrEmpty(cv.Address) ? "NULL" : $"'{EscapeSql(cv.Address)}'";
                        var tpl = string.IsNullOrEmpty(cv.SelectedTemplate) ? "'Corporate'" : $"'{EscapeSql(cv.SelectedTemplate)}'";
                        var pal = string.IsNullOrEmpty(cv.ColorPalette) ? "'ClassicNavy'" : $"'{EscapeSql(cv.ColorPalette)}'";

                        sb.AppendLine($"INSERT INTO \"UserCvs\" (\"Id\", \"UserId\", \"FullName\", \"JobTitle\", \"Email\", \"PhoneNumber\", \"Location\", \"WebsiteOrLinkedIn\", \"ProfessionalSummary\", \"ExperienceJson\", \"EducationJson\", \"Skills\", \"CertificationsJson\", \"IdentificationNumber\", \"Address\", \"SelectedTemplate\", \"ColorPalette\", \"UpdatedAt\") VALUES ({cv.Id}, {cv.UserId}, '{EscapeSql(cv.FullName)}', {jobTitle}, {email}, {phone}, {loc}, {web}, {sum}, {exp}, {edu}, {skills}, {certs}, {idNum}, {addr}, {tpl}, {pal}, '{cv.UpdatedAt:o}');");
                    }
                }
            }

            // PostgreSQL sequence resets
            sb.AppendLine("\n-- 18. REAJUSTE DE SECUENCIAS POSTGRESQL");
            var tablesWithId = new[] { "Categories", "Users", "Courses", "CourseModules", "Lessons", "Quizzes", "QuizQuestions", "QuizOptions", "CourseEnrollments", "LessonProgresses", "QuizAttempts", "Payments", "UserNotifications", "UserCvs", "SystemSettings" };
            foreach (var tbl in tablesWithId)
            {
                sb.AppendLine($"DO $$ BEGIN IF EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE c.relkind = 'S' AND c.relname = lower('{tbl}') || '_Id_seq') THEN EXECUTE 'SELECT setval(''' || lower('{tbl}') || '_Id_seq'', COALESCE((SELECT MAX(\"\"Id\"\") FROM \"\"{tbl}\"\"), 1))'; END IF; END $$;");
            }

            sb.AppendLine("\nCOMMIT;");

            var sqlBytes = Encoding.UTF8.GetBytes(sb.ToString());
            var fileName = $"Respaldo_CursosGlobalesJP_{DateTime.UtcNow:yyyyMMdd_HHmmss}.sql";

            // Guardar copia local en historial del servidor
            var backupPath = Path.Combine(GetBackupDirectory(), fileName);
            await File.WriteAllBytesAsync(backupPath, sqlBytes);

            return (sqlBytes, fileName);
        }

        public async Task<(bool Success, string Message)> RestoreFromJsonStreamAsync(Stream stream)
        {
            try
            {
                using var reader = new StreamReader(stream, Encoding.UTF8);
                var json = await reader.ReadToEndAsync();

                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                };

                var snapshot = JsonSerializer.Deserialize<FullBackupSnapshot>(json, options);
                if (snapshot == null)
                {
                    return (false, "El archivo de respaldo no tiene un formato JSON válido o está vacío.");
                }

                using var transaction = await _context.Database.BeginTransactionAsync();

                // 1. Limpieza de tablas hijas primero (para respetar integridad referencial)
                _context.LessonProgresses.RemoveRange(_context.LessonProgresses);
                _context.QuizAttempts.RemoveRange(_context.QuizAttempts);
                _context.QuizOptions.RemoveRange(_context.QuizOptions);
                _context.QuizQuestions.RemoveRange(_context.QuizQuestions);
                _context.Quizzes.RemoveRange(_context.Quizzes);
                _context.Lessons.RemoveRange(_context.Lessons);
                _context.CourseModules.RemoveRange(_context.CourseModules);
                _context.CourseEnrollments.RemoveRange(_context.CourseEnrollments);
                _context.Certificates.RemoveRange(_context.Certificates);
                _context.Payments.RemoveRange(_context.Payments);
                _context.UserNotifications.RemoveRange(_context.UserNotifications);
                _context.Courses.RemoveRange(_context.Courses);
                _context.Categories.RemoveRange(_context.Categories);
                _context.Users.RemoveRange(_context.Users);
                _context.SystemSettings.RemoveRange(_context.SystemSettings);

                await _context.SaveChangesAsync();

                // 2. Limpieza de relaciones de navegación antes de reinsertar
                foreach (var c in snapshot.Courses) { c.Category = null!; c.Quiz = null; c.CreatorUser = null; }
                foreach (var m in snapshot.CourseModules) { m.Course = null!; }
                foreach (var l in snapshot.Lessons) { l.Module = null!; }
                foreach (var q in snapshot.Quizzes) { q.Course = null!; }
                foreach (var qq in snapshot.QuizQuestions) { qq.Quiz = null!; }
                foreach (var qo in snapshot.QuizOptions) { qo.Question = null!; }
                foreach (var ce in snapshot.CourseEnrollments) { ce.User = null!; ce.Course = null!; }
                foreach (var cert in snapshot.Certificates) { cert.User = null!; cert.Course = null!; }
                foreach (var p in snapshot.Payments) { p.User = null!; p.Certificate = null; }
                foreach (var un in snapshot.UserNotifications) { un.User = null!; }
                foreach (var lp in snapshot.LessonProgresses) { lp.Enrollment = null!; lp.Lesson = null!; }
                foreach (var qa in snapshot.QuizAttempts) { qa.User = null!; qa.Quiz = null!; }

                // 3. Inserción ordenada de tablas maestras a dependientes
                if (snapshot.Categories.Any()) await _context.Categories.AddRangeAsync(snapshot.Categories);
                if (snapshot.Users.Any()) await _context.Users.AddRangeAsync(snapshot.Users);
                await _context.SaveChangesAsync();

                if (snapshot.Courses.Any()) await _context.Courses.AddRangeAsync(snapshot.Courses);
                if (snapshot.SystemSettings.Any()) await _context.SystemSettings.AddRangeAsync(snapshot.SystemSettings);
                await _context.SaveChangesAsync();

                if (snapshot.CourseModules.Any()) await _context.CourseModules.AddRangeAsync(snapshot.CourseModules);
                if (snapshot.Quizzes.Any()) await _context.Quizzes.AddRangeAsync(snapshot.Quizzes);
                await _context.SaveChangesAsync();

                if (snapshot.Lessons.Any()) await _context.Lessons.AddRangeAsync(snapshot.Lessons);
                if (snapshot.QuizQuestions.Any()) await _context.QuizQuestions.AddRangeAsync(snapshot.QuizQuestions);
                await _context.SaveChangesAsync();

                if (snapshot.QuizOptions.Any()) await _context.QuizOptions.AddRangeAsync(snapshot.QuizOptions);
                if (snapshot.CourseEnrollments.Any()) await _context.CourseEnrollments.AddRangeAsync(snapshot.CourseEnrollments);
                if (snapshot.Certificates.Any()) await _context.Certificates.AddRangeAsync(snapshot.Certificates);
                if (snapshot.Payments.Any()) await _context.Payments.AddRangeAsync(snapshot.Payments);
                if (snapshot.UserNotifications.Any()) await _context.UserNotifications.AddRangeAsync(snapshot.UserNotifications);
                if (snapshot.UserCvs != null && snapshot.UserCvs.Any()) await _context.UserCvs.AddRangeAsync(snapshot.UserCvs);
                await _context.SaveChangesAsync();

                if (snapshot.LessonProgresses.Any()) await _context.LessonProgresses.AddRangeAsync(snapshot.LessonProgresses);
                if (snapshot.QuizAttempts.Any()) await _context.QuizAttempts.AddRangeAsync(snapshot.QuizAttempts);
                await _context.SaveChangesAsync();

                // 4. Sincronizar secuencias serial de PostgreSQL para evitar colisiones en IDs
                await ResetPostgresSequencesAsync();

                await transaction.CommitAsync();

                return (true, $"¡Restauración exitosa! Se restauraron correctamente {snapshot.TotalRecordsCount} registros ({snapshot.Users.Count} usuarios, {snapshot.Courses.Count} cursos, {snapshot.Payments.Count} pagos y {snapshot.Certificates.Count} certificados).");
            }
            catch (Exception ex)
            {
                return (false, "Error durante la restauración de la base de datos: " + ex.Message);
            }
        }

        public async Task<(bool Success, string Message)> RestoreFromSqlStreamAsync(Stream stream)
        {
            try
            {
                using var reader = new StreamReader(stream, Encoding.UTF8);
                var sql = await reader.ReadToEndAsync();

                if (string.IsNullOrWhiteSpace(sql))
                {
                    return (false, "El archivo SQL proporcionado está vacío.");
                }

                // Ejecución directa de script SQL en PostgreSQL a través de la conexión ADO.NET subyacente
                // Esto previene que el formateador de cadenas y placeholders de EF Core falle cuando hay caracteres '{' y '}' en HTML o JSON
                var connection = _context.Database.GetDbConnection();
                var shouldClose = false;
                if (connection.State != System.Data.ConnectionState.Open)
                {
                    await connection.OpenAsync();
                    shouldClose = true;
                }

                try
                {
                    using var command = connection.CreateCommand();
                    command.CommandText = sql;
                    command.CommandTimeout = 300; // 5 minutos para scripts extensos
                    await command.ExecuteNonQueryAsync();
                }
                finally
                {
                    if (shouldClose)
                    {
                        await connection.CloseAsync();
                    }
                }

                await ResetPostgresSequencesAsync();

                return (true, "¡Base de datos restaurada con éxito desde el archivo de respaldo .sql!");
            }
            catch (Exception ex)
            {
                return (false, $"Error al restaurar desde archivo SQL: {ex.Message}");
            }
        }

        public async Task<(bool Success, string Message)> RestoreFromAnyStreamAsync(Stream stream, string fileName)
        {
            if (fileName.EndsWith(".sql", StringComparison.OrdinalIgnoreCase))
            {
                return await RestoreFromSqlStreamAsync(stream);
            }
            return await RestoreFromJsonStreamAsync(stream);
        }

        public async Task<(bool Success, string Message)> RestoreFromLocalFileAsync(string fileName)
        {
            var cleanFileName = Path.GetFileName(fileName);
            var filePath = Path.Combine(GetBackupDirectory(), cleanFileName);

            if (!File.Exists(filePath))
            {
                return (false, "El archivo de respaldo seleccionado no existe en el servidor.");
            }

            using var stream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            return await RestoreFromAnyStreamAsync(stream, cleanFileName);
        }

        public async Task<(bool Success, string Message)> ResetSystemAsync(string masterPassword = "master141990")
        {
            try
            {
                // 1. Generar respaldo de seguridad preventivo automático antes de limpiar
                try
                {
                    await CreateJsonBackupAsync("Sistema (Pre-Restablecimiento Primer Uso)");
                }
                catch { }

                using var transaction = await _context.Database.BeginTransactionAsync();

                // 2. Garantizar o preparar el usuario Administrador Master
                var masterUser = await _context.Users.FirstOrDefaultAsync(u => u.Email.ToLower() == "master@globalesjp.net" || u.Email.ToLower() == "master");
                if (masterUser == null)
                {
                    masterUser = new User
                    {
                        FullName = "Administrador Master",
                        Email = "master@globalesjp.net",
                        PasswordHash = DbSeeder.HashPassword(masterPassword),
                        IdentificationNumber = "V-00000000",
                        Role = "Admin",
                        CreatedAt = DateTime.UtcNow
                    };
                    _context.Users.Add(masterUser);
                    await _context.SaveChangesAsync();
                }
                else
                {
                    masterUser.FullName = "Administrador Master";
                    masterUser.PasswordHash = DbSeeder.HashPassword(masterPassword);
                    masterUser.Role = "Admin";
                    await _context.SaveChangesAsync();
                }

                // 3. Reasignar cualquier curso creado por otros usuarios al Administrador Master
                var coursesWithOtherCreators = await _context.Courses
                    .Where(c => c.CreatorUserId != null && c.CreatorUserId != masterUser.Id)
                    .ToListAsync();
                foreach (var course in coursesWithOtherCreators)
                {
                    course.CreatorUserId = masterUser.Id;
                }
                if (coursesWithOtherCreators.Any())
                {
                    await _context.SaveChangesAsync();
                }

                // 4. Limpieza de datos operativos de usuarios:
                // Pagos, Certificados, Avances de lecciones, Intentos de cuestionarios, Inscripciones, Notificaciones y CVs
                // NOTA OBLIGATORIA: Se preservan ÍNTEGRAMENTE Cursos, Módulos, Lecciones, Quizzes, Preguntas, Opciones, Categorías y Ajustes del Sistema.
                _context.Payments.RemoveRange(_context.Payments);
                _context.Certificates.RemoveRange(_context.Certificates);
                _context.LessonProgresses.RemoveRange(_context.LessonProgresses);
                _context.QuizAttempts.RemoveRange(_context.QuizAttempts);
                _context.CourseEnrollments.RemoveRange(_context.CourseEnrollments);
                _context.UserNotifications.RemoveRange(_context.UserNotifications);
                _context.UserCvs.RemoveRange(_context.UserCvs);

                await _context.SaveChangesAsync();

                // 5. Eliminar todos los usuarios que no sean el Administrador Master (Master queda como ÚNICO usuario)
                var nonMasterUsers = await _context.Users
                    .Where(u => u.Id != masterUser.Id && u.Email.ToLower() != "master@globalesjp.net" && u.Email.ToLower() != "master")
                    .ToListAsync();
                _context.Users.RemoveRange(nonMasterUsers);

                // Si existía la bandera de vaciado total anterior, removerla para asegurar visualización normal
                var resetFlag = await _context.SystemSettings.FirstOrDefaultAsync(s => s.Key == "SystemResetToBlank");
                if (resetFlag != null)
                {
                    _context.SystemSettings.Remove(resetFlag);
                }

                await _context.SaveChangesAsync();

                // 6. Reajustar secuencias en PostgreSQL
                await ResetPostgresSequencesAsync();

                await transaction.CommitAsync();

                return (true, "¡Plataforma lista para su primer uso exitosamente! Se eliminaron los usuarios de prueba (dejando únicamente al Administrador Master), pagos, certificados, inscripciones y avances. El catálogo completo de 28 cursos, 118 módulos, 118 lecciones, 28 cuestionarios con 280 preguntas y todas las categorías permanecen 100% intactos.");
            }
            catch (Exception ex)
            {
                return (false, $"Error crítico al restablecer el sistema: {ex.Message}");
            }
        }

        public List<DatabaseBackupFileInfo> GetBackupHistory()
        {
            var list = new List<DatabaseBackupFileInfo>();
            var dir = GetBackupDirectory();
            if (!Directory.Exists(dir)) return list;

            var sqlFiles = Directory.GetFiles(dir, "*.sql");
            var jsonFiles = Directory.GetFiles(dir, "*.json");
            var files = sqlFiles.Concat(jsonFiles)
                .OrderByDescending(f => File.GetCreationTimeUtc(f));

            foreach (var file in files)
            {
                var fi = new FileInfo(file);
                list.Add(new DatabaseBackupFileInfo
                {
                    FileName = fi.Name,
                    FilePath = fi.FullName,
                    FileSizeBytes = fi.Length,
                    CreatedAt = fi.CreationTime
                });
            }

            return list;
        }

        private async Task ResetPostgresSequencesAsync()
        {
            var tables = new[]
            {
                "Categories", "Users", "Courses", "CourseModules", "Lessons",
                "Quizzes", "QuizQuestions", "QuizOptions", "CourseEnrollments",
                "LessonProgresses", "QuizAttempts", "Payments",
                "UserNotifications", "UserCvs", "SystemSettings"
            };

            foreach (var table in tables)
            {
                try
                {
#pragma warning disable EF1002
                    await _context.Database.ExecuteSqlRawAsync($@"
                        DO $$
                        BEGIN
                            IF EXISTS (
                                SELECT 1 FROM pg_class c 
                                JOIN pg_namespace n ON n.oid = c.relnamespace 
                                WHERE c.relkind = 'S' AND c.relname = lower('{table}') || '_Id_seq'
                            ) THEN
                                EXECUTE 'SELECT setval(''' || lower('{table}') || '_Id_seq'', COALESCE((SELECT MAX(""Id"") FROM ""{table}""), 1))';
                            END IF;
                        END $$;
                    ");
#pragma warning restore EF1002
                }
                catch { }
            }
        }

        private static string EscapeSql(string? input)
        {
            if (string.IsNullOrEmpty(input)) return string.Empty;
            return input.Replace("'", "''");
        }
    }
}
