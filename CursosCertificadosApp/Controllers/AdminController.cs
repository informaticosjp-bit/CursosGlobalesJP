using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models.Entities;
using CursosCertificadosApp.Models.ViewModels;
using CursosCertificadosApp.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using System.Text.RegularExpressions;

namespace CursosCertificadosApp.Controllers
{
    [Authorize(Roles = "Admin")]
    public class AdminController : Controller
    {
        private readonly AppDbContext _context;
        private readonly IPaymentService _paymentService;
        private readonly IBcvRateService _bcvRateService;
        private readonly IWebHostEnvironment _env;
        private readonly IDatabaseBackupService _backupService;
        private readonly ISiteSettingService _siteSettingService;
        private readonly IUserActivityTracker _activityTracker;

        public AdminController(
            AppDbContext context, 
            IPaymentService paymentService, 
            IBcvRateService bcvRateService,
            IWebHostEnvironment env,
            IDatabaseBackupService backupService,
            ISiteSettingService siteSettingService,
            IUserActivityTracker activityTracker)
        {
            _context = context;
            _paymentService = paymentService;
            _bcvRateService = bcvRateService;
            _env = env;
            _backupService = backupService;
            _siteSettingService = siteSettingService;
            _activityTracker = activityTracker;
        }

        // ==========================================
        // 1. PANEL PRINCIPAL Y CONCILIACIÓN DE PAGOS
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> Index()
        {
            var totalUsers = await _context.Users.CountAsync(u => u.Role == "Student");
            var totalEnrollments = await _context.CourseEnrollments.CountAsync();
            var totalCompleted = await _context.CourseEnrollments.CountAsync(e => e.IsCompleted);
            var issuedCertificates = await _context.Certificates.CountAsync(c => c.Status == CertificateStatus.Issued);
            var pendingPaymentsCount = await _context.Payments.CountAsync(p => p.Status == "Pending");
            var totalRevenue = await _context.Payments.Where(p => p.Status == "Approved").SumAsync(p => p.Amount);
            var totalCourses = await _context.Courses.CountAsync();

            ViewBag.TotalUsers = totalUsers;
            ViewBag.TotalEnrollments = totalEnrollments;
            ViewBag.TotalCompleted = totalCompleted;
            ViewBag.IssuedCertificates = issuedCertificates;
            ViewBag.PendingPaymentsCount = pendingPaymentsCount;
            ViewBag.TotalRevenue = totalRevenue;
            ViewBag.TotalCourses = totalCourses;

            // Tasa BCV Oficial en vivo
            ViewBag.BcvRate = await _bcvRateService.GetCurrentRateAsync();

            var pendingPayments = await _paymentService.GetPendingPaymentsAsync();
            var approvedPayments = await _paymentService.GetApprovedPaymentsAsync();
            ViewBag.ApprovedPaymentsCount = approvedPayments.Count;
            ViewBag.ApprovedPayments = approvedPayments;

            return View(pendingPayments);
        }

        // Historial de Pagos Aprobados y Descarga Directa de Certificados Oficiales
        [HttpGet]
        public async Task<IActionResult> PagosAprobados()
        {
            var approvedPayments = await _paymentService.GetApprovedPaymentsAsync();
            var pendingPaymentsCount = await _context.Payments.CountAsync(p => p.Status == "Pending");
            var totalUsers = await _context.Users.CountAsync(u => u.Role == "Student");
            var totalCourses = await _context.Courses.CountAsync();
            var totalRevenue = await _context.Payments.Where(p => p.Status == "Approved").SumAsync(p => p.Amount);

            ViewBag.ApprovedPaymentsCount = approvedPayments.Count;
            ViewBag.PendingPaymentsCount = pendingPaymentsCount;
            ViewBag.TotalUsers = totalUsers;
            ViewBag.TotalCourses = totalCourses;
            ViewBag.TotalRevenue = totalRevenue;

            return View(approvedPayments);
        }

        // Forzar actualización en vivo de la tasa oficial BCV
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ActualizarTasaBcv()
        {
            var rate = await _bcvRateService.GetCurrentRateAsync(forceRefresh: true);
            TempData["SuccessMessage"] = $"Tasa BCV actualizada exitosamente: Bs. {rate.FormattedRate} ({rate.Source}).";
            return RedirectToAction("Index");
        }

        // Fijar tasa manual de contingencia
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult FijarTasaBcv(decimal manualRate)
        {
            if (manualRate <= 0)
            {
                TempData["ErrorMessage"] = "Ingresa un valor válido para la tasa.";
            }
            else
            {
                _bcvRateService.SetManualRate(manualRate, "Fijada por Administrador");
                TempData["SuccessMessage"] = $"Tasa BCV fijada manualmente en Bs. {manualRate:N2}.";
            }
            return RedirectToAction("Index");
        }

        // Restaurar tasa automática BCV
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult RestaurarTasaAutomatica()
        {
            _bcvRateService.ClearManualOverride();
            TempData["SuccessMessage"] = "Se restableció el cálculo automático directo desde www.bcv.org.ve.";
            return RedirectToAction("Index");
        }

        // Aprobar Pago Manual (1 Clic)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AprobarPago(int paymentId, string? notes)
        {
            var success = await _paymentService.ApprovePaymentAsync(paymentId, notes);
            if (success)
            {
                TempData["SuccessMessage"] = "Pago aprobado satisfactoriamente. El certificado oficial ha sido emitido.";
            }
            else
            {
                TempData["ErrorMessage"] = "No se pudo procesar el pago.";
            }

            return RedirectToAction("Index");
        }

        // Rechazar Pago
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RechazarPago(int paymentId, string reason)
        {
            var success = await _paymentService.RejectPaymentAsync(paymentId, reason);
            if (success)
            {
                TempData["SuccessMessage"] = "Pago rechazado y notificado al estudiante.";
            }
            else
            {
                TempData["ErrorMessage"] = "No se pudo procesar el rechazo.";
            }

            return RedirectToAction("Index");
        }

        // ==========================================
        // 2. GESTIÓN DE USUARIOS
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> Usuarios(string? search, string? role)
        {
            var query = _context.Users
                .Include(u => u.Enrollments)
                    .ThenInclude(e => e.Course)
                .Include(u => u.Certificates)
                .Include(u => u.Payments)
                .AsQueryable();

            if (!string.IsNullOrWhiteSpace(role) && role != "All")
            {
                query = query.Where(u => u.Role == role);
            }

            if (!string.IsNullOrWhiteSpace(search))
            {
                search = search.Trim().ToLower();
                query = query.Where(u => 
                    u.FullName.ToLower().Contains(search) || 
                    u.Email.ToLower().Contains(search) || 
                    u.IdentificationNumber.ToLower().Contains(search) ||
                    (u.PhoneNumber != null && u.PhoneNumber.Contains(search)));
            }

            var totalUsers = await _context.Users.CountAsync();
            var studentCount = await _context.Users.CountAsync(u => u.Role == "Student");
            var creatorCount = await _context.Users.CountAsync(u => u.Role == "Creator");
            var adminCount = await _context.Users.CountAsync(u => u.Role == "Admin");

            ViewBag.TotalUsers = totalUsers;
            ViewBag.StudentCount = studentCount;
            ViewBag.CreatorCount = creatorCount;
            ViewBag.AdminCount = adminCount;
            ViewBag.CurrentRole = role ?? "All";
            ViewBag.SearchTerm = search;

            var users = await query
                .OrderByDescending(u => u.CreatedAt)
                .Select(u => new UserManagementViewModel
                {
                    Id = u.Id,
                    FullName = u.FullName,
                    Email = u.Email,
                    IdentificationNumber = u.IdentificationNumber,
                    Age = u.Age,
                    PhoneNumber = u.PhoneNumber,
                    Role = u.Role,
                    CreatedAt = u.CreatedAt,
                    TotalEnrolledCourses = u.Enrollments.Count,
                    CompletedCoursesCount = u.Enrollments.Count(e => e.IsCompleted),
                    IssuedCertificatesCount = u.Certificates.Count(c => c.Status == CertificateStatus.Issued),
                    TotalPaymentsCount = u.Payments.Count,
                    TotalPaidAmount = u.Payments.Where(p => p.Status == "Approved").Sum(p => p.Amount),
                    Enrollments = u.Enrollments.Select(e => new UserEnrollmentSummary
                    {
                        CourseId = e.CourseId,
                        CourseTitle = e.Course.Title,
                        ProgressPercentage = e.ProgressPercentage,
                        IsCompleted = e.IsCompleted,
                        CompletedAt = e.CompletedAt,
                        CertificateId = u.Certificates.FirstOrDefault(c => c.CourseId == e.CourseId) != null 
                            ? u.Certificates.FirstOrDefault(c => c.CourseId == e.CourseId)!.Id 
                            : null,
                        CertificateCode = u.Certificates.FirstOrDefault(c => c.CourseId == e.CourseId) != null 
                            ? u.Certificates.FirstOrDefault(c => c.CourseId == e.CourseId)!.VerificationCode 
                            : null,
                        CertificateStatus = u.Certificates.FirstOrDefault(c => c.CourseId == e.CourseId) != null 
                            ? u.Certificates.FirstOrDefault(c => c.CourseId == e.CourseId)!.Status.ToString() 
                            : null
                    }).ToList()
                })
                .ToListAsync();

            var currentUserIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            int.TryParse(currentUserIdStr, out int currentUserId);

            foreach (var user in users)
            {
                user.IsOnline = (user.Id == currentUserId) || _activityTracker.IsOnline(user.Id);
            }

            return View(users);
        }

        // Editar Datos del Usuario
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditarUsuario(EditUserViewModel model)
        {
            if (!ModelState.IsValid)
            {
                TempData["ErrorMessage"] = "Por favor completa los campos requeridos correctamente.";
                return RedirectToAction("Usuarios");
            }

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == model.Id);
            if (user == null)
            {
                TempData["ErrorMessage"] = "El usuario seleccionado no existe.";
                return RedirectToAction("Usuarios");
            }

            var cleanEmail = model.Email.Trim().ToLower();
            if (user.Email.ToLower() != cleanEmail)
            {
                var emailExists = await _context.Users.AnyAsync(u => u.Id != model.Id && u.Email.ToLower() == cleanEmail);
                if (emailExists)
                {
                    TempData["ErrorMessage"] = $"El correo '{model.Email}' ya se encuentra registrado por otro usuario.";
                    return RedirectToAction("Usuarios");
                }
            }

            user.FullName = model.FullName.Trim();
            user.IdentificationNumber = model.IdentificationNumber.Trim();
            user.Email = cleanEmail;
            user.PhoneNumber = string.IsNullOrWhiteSpace(model.PhoneNumber) ? null : model.PhoneNumber.Trim();
            user.Age = model.Age;

            if (user.IsMaster)
            {
                user.Role = "Admin";
            }
            else
            {
                var validRoles = new[] { "Student", "Creator", "Admin" };
                if (validRoles.Contains(model.Role))
                {
                    user.Role = model.Role;
                }
            }

            if (!string.IsNullOrWhiteSpace(model.NewPassword))
            {
                if (model.NewPassword.Length < 6)
                {
                    TempData["ErrorMessage"] = "La nueva contraseña debe contener al menos 6 caracteres.";
                    return RedirectToAction("Usuarios");
                }
                user.PasswordHash = DbSeeder.HashPassword(model.NewPassword.Trim());
            }

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Datos de '{user.FullName}' actualizados correctamente.";
            return RedirectToAction("Usuarios");
        }

        // Eliminar Usuario (protección estricta para el Master)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EliminarUsuario(int id)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == id);
            if (user == null)
            {
                TempData["ErrorMessage"] = "El usuario seleccionado no existe.";
                return RedirectToAction("Usuarios");
            }

            // Prohibir terminantemente eliminar al Master
            if (user.Email.Trim().ToLower() == "master@globalesjp.net" || user.Email.Trim().ToLower() == "master")
            {
                TempData["ErrorMessage"] = "El Administrador Master es la cuenta principal protegida del sistema y no puede ser eliminado.";
                return RedirectToAction("Usuarios");
            }

            // Prohibir que el admin se elimine a sí mismo
            var currentUserId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!string.IsNullOrEmpty(currentUserId) && currentUserId == user.Id.ToString())
            {
                TempData["ErrorMessage"] = "No puedes eliminar tu propia cuenta de administrador en sesión activa.";
                return RedirectToAction("Usuarios");
            }

            try
            {
                // 1. Eliminar pagos y certificados asociados
                var payments = await _context.Payments.Where(p => p.UserId == user.Id).ToListAsync();
                _context.Payments.RemoveRange(payments);

                var certs = await _context.Certificates.Where(c => c.UserId == user.Id).ToListAsync();
                _context.Certificates.RemoveRange(certs);

                // 2. Eliminar progresos de lecciones y matrículas
                var enrollments = await _context.CourseEnrollments.Include(e => e.LessonProgresses).Where(e => e.UserId == user.Id).ToListAsync();
                foreach (var en in enrollments)
                {
                    _context.LessonProgresses.RemoveRange(en.LessonProgresses);
                }
                _context.CourseEnrollments.RemoveRange(enrollments);

                // 3. Eliminar intentos de quiz y notificaciones
                var quizAttempts = await _context.QuizAttempts.Where(qa => qa.UserId == user.Id).ToListAsync();
                _context.QuizAttempts.RemoveRange(quizAttempts);

                var notifications = await _context.UserNotifications.Where(n => n.UserId == user.Id).ToListAsync();
                _context.UserNotifications.RemoveRange(notifications);

                // 3.1 Eliminar CVs asociados al usuario
                var userCvs = await _context.UserCvs.Where(cv => cv.UserId == user.Id).ToListAsync();
                _context.UserCvs.RemoveRange(userCvs);

                // 4. Si es creador de cursos, desvincular los cursos (CreatorUserId = null)
                var creatorCourses = await _context.Courses.Where(c => c.CreatorUserId == user.Id).ToListAsync();
                foreach (var cc in creatorCourses)
                {
                    cc.CreatorUserId = null;
                }

                // 5. Eliminar el usuario
                _context.Users.Remove(user);
                await _context.SaveChangesAsync();

                TempData["SuccessMessage"] = $"Usuario '{user.FullName}' ({user.Email}) eliminado correctamente del sistema.";
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"No fue posible eliminar al usuario: {ex.Message}";
            }

            return RedirectToAction("Usuarios");
        }

        // Crear Nuevo Usuario (Alumno, Creador o Administrador)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CrearUsuario(CreateUserViewModel model)
        {
            if (!ModelState.IsValid)
            {
                TempData["ErrorMessage"] = "Por favor completa todos los campos requeridos correctamente.";
                return RedirectToAction("Usuarios");
            }

            var exists = await _context.Users.AnyAsync(u => u.Email.ToLower() == model.Email.Trim().ToLower());
            if (exists)
            {
                TempData["ErrorMessage"] = $"Ya existe un usuario registrado con el correo {model.Email}.";
                return RedirectToAction("Usuarios");
            }

            var validRoles = new[] { "Student", "Creator", "Admin" };
            var role = validRoles.Contains(model.Role) ? model.Role : "Student";

            var user = new User
            {
                FullName = model.FullName.Trim(),
                IdentificationNumber = model.IdentificationNumber.Trim(),
                Email = model.Email.Trim().ToLower(),
                PasswordHash = DbSeeder.HashPassword(model.Password),
                Role = role,
                Age = model.Age,
                PhoneNumber = model.PhoneNumber?.Trim(),
                CreatedAt = DateTime.UtcNow
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            var roleLabel = role switch
            {
                "Admin" => "Administrador",
                "Creator" => "Creador de Cursos",
                _ => "Estudiante"
            };

            TempData["SuccessMessage"] = $"Usuario '{user.FullName}' ({roleLabel}) creado exitosamente en el sistema.";
            return RedirectToAction("Usuarios");
        }

        // ==========================================
        // 3. GESTIÓN Y CREACIÓN DE CURSOS
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> Cursos()
        {
            var courses = await _context.Courses
                .Include(c => c.Category)
                .Include(c => c.CreatorUser)
                .Include(c => c.Modules)
                .Include(c => c.Enrollments)
                .Include(c => c.Certificates)
                .OrderByDescending(c => c.CreatedAt)
                .ToListAsync();

            return View(courses);
        }

        // Crear Curso (GET)
        [HttpGet]
        public async Task<IActionResult> CrearCurso()
        {
            var categories = await _context.Categories.OrderBy(c => c.DisplayOrder).ThenBy(c => c.Name).ToListAsync();
            var model = new CourseFormViewModel
            {
                Categories = categories,
                Level = "Intermedio",
                EstimatedHours = 10,
                PassingScore = 70.00m,
                Price = 1.00m,
                IsPublished = true
            };
            return View(model);
        }

        // Crear Curso (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CrearCurso(CourseFormViewModel model)
        {
            if (!ModelState.IsValid)
            {
                model.Categories = await _context.Categories.OrderBy(c => c.DisplayOrder).ThenBy(c => c.Name).ToListAsync();
                return View(model);
            }

            var slug = string.IsNullOrWhiteSpace(model.Slug)
                ? GenerateSlug(model.Title)
                : GenerateSlug(model.Slug);

            // Verificar si el slug ya existe
            if (await _context.Courses.AnyAsync(c => c.Slug == slug))
            {
                slug += "-" + DateTime.UtcNow.Ticks.ToString()[^4..];
            }

            var course = new Course
            {
                Title = model.Title.Trim(),
                Slug = slug,
                CategoryId = model.CategoryId,
                ShortDescription = model.ShortDescription.Trim(),
                FullDescription = model.FullDescription.Trim(),
                Level = model.Level,
                EstimatedHours = model.EstimatedHours,
                PassingScore = model.PassingScore,
                Price = model.Price,
                BadgeColor = model.BadgeColor,
                IsPublished = model.IsPublished,
                InstructorName = model.InstructorName?.Trim(),
                InstructorTitle = model.InstructorTitle?.Trim(),
                CreatorUserId = null, // Montado por Administrador: 100% ingresos para la empresa
                CreatedAt = DateTime.UtcNow
            };

            // Crear Módulo inicial de fundamentos automáticamente
            var initialModule = new CourseModule
            {
                Title = "Módulo 1: Fundamentos y Contenido Teórico",
                OrderIndex = 1
            };

            var initialLesson = new Lesson
            {
                Title = "1.1 Introducción y Conceptos Clave",
                ContentHtml = $"<h3>{model.Title}</h3><p>Bienvenido a este programa de capacitación interactiva. En esta guía textual estructurada aprenderás los fundamentos esenciales para dominar esta competencia profesional.</p><h4>Objetivos del Programa</h4><p>{model.ShortDescription}</p><p>Revisa detalladamente las lecturas y recursos visuales antes de presentar tu evaluación final para obtener tu certificación oficial.</p>",
                ContentType = "Reading",
                DurationMinutes = 15,
                OrderIndex = 1
            };

            initialModule.Lessons.Add(initialLesson);
            course.Modules.Add(initialModule);

            _context.Courses.Add(course);
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = $"¡Curso '{course.Title}' creado satisfactoriamente con su módulo inicial!";
            return RedirectToAction("ModulosCurso", new { id = course.Id });
        }

        // Editar Curso (GET)
        [HttpGet]
        public async Task<IActionResult> EditarCurso(int id)
        {
            var course = await _context.Courses.FindAsync(id);
            if (course == null) return NotFound();

            var categories = await _context.Categories.OrderBy(c => c.Name).ToListAsync();

            var model = new CourseFormViewModel
            {
                Id = course.Id,
                Title = course.Title,
                Slug = course.Slug,
                CategoryId = course.CategoryId,
                ShortDescription = course.ShortDescription,
                FullDescription = course.FullDescription,
                Level = course.Level,
                EstimatedHours = course.EstimatedHours,
                PassingScore = course.PassingScore,
                Price = course.Price,
                BadgeColor = course.BadgeColor,
                IsPublished = course.IsPublished,
                InstructorName = course.InstructorName,
                InstructorTitle = course.InstructorTitle,
                Categories = categories
            };

            return View(model);
        }

        // Editar Curso (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditarCurso(CourseFormViewModel model)
        {
            if (!ModelState.IsValid)
            {
                model.Categories = await _context.Categories.OrderBy(c => c.Name).ToListAsync();
                return View(model);
            }

            var course = await _context.Courses.FindAsync(model.Id);
            if (course == null) return NotFound();

            course.Title = model.Title.Trim();
            course.CategoryId = model.CategoryId;
            course.ShortDescription = model.ShortDescription.Trim();
            course.FullDescription = model.FullDescription.Trim();
            course.Level = model.Level;
            course.EstimatedHours = model.EstimatedHours;
            course.PassingScore = model.PassingScore;
            course.Price = model.Price;
            course.BadgeColor = model.BadgeColor;
            course.IsPublished = model.IsPublished;
            course.InstructorName = model.InstructorName?.Trim();
            course.InstructorTitle = model.InstructorTitle?.Trim();

            if (!string.IsNullOrWhiteSpace(model.Slug))
            {
                var cleanSlug = GenerateSlug(model.Slug);
                if (cleanSlug != course.Slug && !await _context.Courses.AnyAsync(c => c.Slug == cleanSlug && c.Id != course.Id))
                {
                    course.Slug = cleanSlug;
                }
            }

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Curso '{course.Title}' actualizado correctamente.";
            return RedirectToAction("Cursos");
        }

        // Gestión de Módulos y Lecciones de Lectura de un Curso
        [HttpGet]
        public async Task<IActionResult> ModulosCurso(int id)
        {
            var course = await _context.Courses
                .Include(c => c.Category)
                .Include(c => c.Modules)
                    .ThenInclude(m => m.Lessons)
                .Include(c => c.Quiz)
                    .ThenInclude(q => q!.Questions)
                .FirstOrDefaultAsync(c => c.Id == id);

            if (course == null) return NotFound();

            return View(course);
        }

        // Agregar Módulo
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CrearModulo(int courseId, string title, int orderIndex)
        {
            if (string.IsNullOrWhiteSpace(title))
            {
                TempData["ErrorMessage"] = "El título del módulo es obligatorio.";
                return RedirectToAction("ModulosCurso", new { id = courseId });
            }

            var module = new CourseModule
            {
                CourseId = courseId,
                Title = title.Trim(),
                OrderIndex = orderIndex
            };

            _context.CourseModules.Add(module);
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = $"Módulo '{module.Title}' agregado con éxito.";
            return RedirectToAction("ModulosCurso", new { id = courseId });
        }

        // Agregar Lección de Lectura / Contenido Formativo
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CrearLeccion(int moduleId, int courseId, string title, string content, int estimatedMinutes, int orderIndex)
        {
            if (string.IsNullOrWhiteSpace(title) || string.IsNullOrWhiteSpace(content))
            {
                TempData["ErrorMessage"] = "El título y contenido de la lección son obligatorios.";
                return RedirectToAction("ModulosCurso", new { id = courseId });
            }

            var lesson = new Lesson
            {
                ModuleId = moduleId,
                Title = title.Trim(),
                ContentHtml = content.Trim(),
                ContentType = "Reading",
                DurationMinutes = estimatedMinutes > 0 ? estimatedMinutes : 15,
                OrderIndex = orderIndex
            };

            _context.Lessons.Add(lesson);
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = $"Lectura formativa '{lesson.Title}' agregada con éxito.";
            return RedirectToAction("ModulosCurso", new { id = courseId });
        }

        // Editar Lección Existente
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditarLeccion(int lessonId, int courseId, string title, string content, int durationMinutes, int orderIndex)
        {
            var lesson = await _context.Lessons.FindAsync(lessonId);
            if (lesson == null) return NotFound();

            lesson.Title = title.Trim();
            lesson.ContentHtml = content.Trim();
            lesson.DurationMinutes = durationMinutes > 0 ? durationMinutes : 15;
            lesson.OrderIndex = orderIndex;

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Lectura '{lesson.Title}' actualizada satisfactoriamente.";
            return RedirectToAction("ModulosCurso", new { id = courseId });
        }

        // Eliminar Lección
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EliminarLeccion(int lessonId, int courseId)
        {
            var lesson = await _context.Lessons.FindAsync(lessonId);
            if (lesson != null)
            {
                _context.Lessons.Remove(lesson);
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Lectura eliminada del temario.";
            }
            return RedirectToAction("ModulosCurso", new { id = courseId });
        }

        // Editar Módulo
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditarModulo(int moduleId, int courseId, string title, int orderIndex)
        {
            var module = await _context.CourseModules.FindAsync(moduleId);
            if (module == null) return NotFound();

            module.Title = title.Trim();
            module.OrderIndex = orderIndex;

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Módulo '{module.Title}' actualizado.";
            return RedirectToAction("ModulosCurso", new { id = courseId });
        }

        // Eliminar Módulo
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EliminarModulo(int moduleId, int courseId)
        {
            var module = await _context.CourseModules
                .Include(m => m.Lessons)
                .FirstOrDefaultAsync(m => m.Id == moduleId);

            if (module != null)
            {
                _context.Lessons.RemoveRange(module.Lessons);
                _context.CourseModules.Remove(module);
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Módulo y sus lecciones eliminados correctamente.";
            }
            return RedirectToAction("ModulosCurso", new { id = courseId });
        }

        // Subir Imagen para Contenido / Módulos
        [HttpPost]
        [IgnoreAntiforgeryToken]
        public async Task<IActionResult> SubirImagenContenido(IFormFile? imageFile)
        {
            if (imageFile == null || imageFile.Length == 0)
            {
                return Json(new { success = false, message = "No se seleccionó ningún archivo." });
            }

            var allowedExts = new[] { ".jpg", ".jpeg", ".png", ".webp", ".gif" };
            var ext = Path.GetExtension(imageFile.FileName).ToLowerInvariant();
            if (!allowedExts.Contains(ext))
            {
                return Json(new { success = false, message = "Formato no permitido. Solo imágenes JPG, PNG, WEBP o GIF." });
            }

            var webRoot = _env.WebRootPath ?? Path.Combine(Directory.GetCurrentDirectory(), "wwwroot");
            var uploadsDir = Path.Combine(webRoot, "uploads", "cursos");
            if (!Directory.Exists(uploadsDir))
            {
                Directory.CreateDirectory(uploadsDir);
            }

            var fileName = $"img_{DateTime.UtcNow.Ticks}_{Guid.NewGuid():N}{ext}";
            var filePath = Path.Combine(uploadsDir, fileName);

            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await imageFile.CopyToAsync(stream);
            }

            var publicUrl = $"/uploads/cursos/{fileName}";
            return Json(new { success = true, url = publicUrl });
        }

        // ==========================================
        // 4. CONFIGURACIÓN LEGAL (TÉRMINOS Y CONDICIONES)
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> Terminos()
        {
            var terms = await _context.SystemSettings.FirstOrDefaultAsync(s => s.Key == "TermsAndConditions");
            if (terms == null)
            {
                terms = new SystemSetting
                {
                    Key = "TermsAndConditions",
                    Title = "Términos y Condiciones Generales de Uso, Formación y Certificación",
                    Content = "<p>Contenido de términos y condiciones legales...</p>",
                    UpdatedAt = DateTime.UtcNow
                };
                _context.SystemSettings.Add(terms);
                await _context.SaveChangesAsync();
            }

            return View(terms);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> GuardarTerminos(string title, string content)
        {
            if (string.IsNullOrWhiteSpace(title) || string.IsNullOrWhiteSpace(content))
            {
                TempData["ErrorMessage"] = "El título y el contenido de los términos no pueden estar vacíos.";
                return RedirectToAction("Terminos");
            }

            var terms = await _context.SystemSettings.FirstOrDefaultAsync(s => s.Key == "TermsAndConditions");
            if (terms == null)
            {
                terms = new SystemSetting
                {
                    Key = "TermsAndConditions",
                    Title = title.Trim(),
                    Content = content.Trim(),
                    UpdatedAt = DateTime.UtcNow
                };
                _context.SystemSettings.Add(terms);
            }
            else
            {
                terms.Title = title.Trim();
                terms.Content = content.Trim();
                terms.UpdatedAt = DateTime.UtcNow;
            }

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = "¡Términos y Condiciones actualizados correctamente en toda la plataforma!";
            return RedirectToAction("Terminos");
        }

        // ==========================================
        // 6. ADMINISTRACIÓN DE BASE DE DATOS (RESPALDO / RESTAURACIÓN)
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> BaseDatos()
        {
            var stats = await _backupService.GetDatabaseStatsAsync();
            return View(stats);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DescargarRespaldoJson()
        {
            try
            {
                var userEmail = User.Identity?.Name ?? "Administrador";
                var (fileBytes, fileName) = await _backupService.CreateJsonBackupAsync(userEmail);
                return File(fileBytes, "application/json", fileName);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Error al generar respaldo JSON: {ex.Message}";
                return RedirectToAction("BaseDatos");
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DescargarRespaldoSql()
        {
            try
            {
                var (fileBytes, fileName) = await _backupService.CreateSqlBackupAsync();
                return File(fileBytes, "text/plain", fileName);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Error al generar script SQL: {ex.Message}";
                return RedirectToAction("BaseDatos");
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RestaurarRespaldo(IFormFile backupFile)
        {
            if (backupFile == null || backupFile.Length == 0)
            {
                TempData["ErrorMessage"] = "Debe seleccionar un archivo de respaldo (.sql o .json) válido.";
                return RedirectToAction("BaseDatos");
            }

            var isSql = backupFile.FileName.EndsWith(".sql", StringComparison.OrdinalIgnoreCase);
            var isJson = backupFile.FileName.EndsWith(".json", StringComparison.OrdinalIgnoreCase);

            if (!isSql && !isJson)
            {
                TempData["ErrorMessage"] = "El archivo debe tener formato .sql o .json válido de Cursos Globales JP.";
                return RedirectToAction("BaseDatos");
            }

            try
            {
                using var stream = backupFile.OpenReadStream();
                var result = await _backupService.RestoreFromAnyStreamAsync(stream, backupFile.FileName);
                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Error crítico durante la restauración: {ex.Message}";
            }

            return RedirectToAction("BaseDatos");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RestaurarArchivoLocal(string fileName)
        {
            if (string.IsNullOrWhiteSpace(fileName))
            {
                TempData["ErrorMessage"] = "Nombre de archivo de respaldo no especificado.";
                return RedirectToAction("BaseDatos");
            }

            try
            {
                var result = await _backupService.RestoreFromLocalFileAsync(fileName);
                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Error crítico durante la restauración: {ex.Message}";
            }

            return RedirectToAction("BaseDatos");
        }

        [HttpGet]
        public IActionResult DescargarArchivoLocal(string fileName)
        {
            if (string.IsNullOrWhiteSpace(fileName) || fileName.Contains("..") || Path.IsPathRooted(fileName))
            {
                return BadRequest("Nombre de archivo inválido.");
            }

            var dir = Path.Combine(_env.ContentRootPath, "App_Data", "Backups");
            var filePath = Path.Combine(dir, fileName);

            if (!System.IO.File.Exists(filePath))
            {
                TempData["ErrorMessage"] = "El archivo solicitado no existe en el servidor.";
                return RedirectToAction("BaseDatos");
            }

            var contentType = fileName.EndsWith(".json", StringComparison.OrdinalIgnoreCase) 
                ? "application/json" 
                : "text/plain";

            return PhysicalFile(filePath, contentType, fileName);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult EliminarRespaldoLocal(string fileName)
        {
            if (string.IsNullOrWhiteSpace(fileName) || fileName.Contains("..") || Path.IsPathRooted(fileName))
            {
                TempData["ErrorMessage"] = "Nombre de archivo de respaldo inválido.";
                return RedirectToAction("BaseDatos");
            }

            var dir = Path.Combine(_env.ContentRootPath, "App_Data", "Backups");
            var filePath = Path.Combine(dir, fileName);

            if (System.IO.File.Exists(filePath))
            {
                try
                {
                    System.IO.File.Delete(filePath);
                    TempData["SuccessMessage"] = $"El archivo de respaldo '{fileName}' fue eliminado correctamente del servidor.";
                }
                catch (Exception ex)
                {
                    TempData["ErrorMessage"] = $"No fue posible eliminar el archivo: {ex.Message}";
                }
            }
            else
            {
                TempData["ErrorMessage"] = "El archivo especificado no existe en el servidor.";
            }

            return RedirectToAction("BaseDatos");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult EliminarRespaldosMultiples(List<string>? fileNames)
        {
            var files = fileNames ?? new List<string>();
            if (!files.Any() && Request.Form.ContainsKey("fileNames"))
            {
                files = Request.Form["fileNames"]
                    .Where(s => !string.IsNullOrWhiteSpace(s))
                    .SelectMany(s => s!.Split(',', StringSplitOptions.RemoveEmptyEntries))
                    .Select(s => s.Trim())
                    .ToList();
            }

            if (!files.Any())
            {
                TempData["ErrorMessage"] = "No se seleccionó ningún archivo de respaldo para eliminar.";
                return RedirectToAction("BaseDatos");
            }

            var dir = Path.Combine(_env.ContentRootPath, "App_Data", "Backups");
            int deletedCount = 0;
            int errorCount = 0;

            foreach (var fileName in files)
            {
                if (string.IsNullOrWhiteSpace(fileName) || fileName.Contains("..") || Path.IsPathRooted(fileName))
                {
                    errorCount++;
                    continue;
                }

                var filePath = Path.Combine(dir, fileName);
                if (System.IO.File.Exists(filePath))
                {
                    try
                    {
                        System.IO.File.Delete(filePath);
                        deletedCount++;
                    }
                    catch
                    {
                        errorCount++;
                    }
                }
            }

            if (deletedCount > 0)
            {
                TempData["SuccessMessage"] = $"Se eliminaron exitosamente {deletedCount} archivo(s) de respaldo del servidor.";
            }
            else
            {
                TempData["ErrorMessage"] = "No se pudo eliminar ninguno de los archivos seleccionados.";
            }

            return RedirectToAction("BaseDatos");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RestablecerSistema(string confirmPhrase)
        {
            if (string.IsNullOrWhiteSpace(confirmPhrase) || !confirmPhrase.Trim().Equals("RESTABLECER", StringComparison.OrdinalIgnoreCase))
            {
                TempData["ErrorMessage"] = "Debe escribir la palabra de seguridad 'RESTABLECER' para autorizar el vaciado completo del sistema.";
                return RedirectToAction("BaseDatos");
            }

            try
            {
                var result = await _backupService.ResetSystemAsync("master141990");
                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Error durante el restablecimiento: {ex.Message}";
            }

            return RedirectToAction("BaseDatos");
        }

        // ==========================================
        // 7. PERSONALIZACIÓN DEL SITIO Y PIE DE PÁGINA
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> Personalizacion()
        {
            var settings = await _siteSettingService.GetSettingsAsync();
            return View(settings);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> GuardarPersonalizacion(SiteCustomizationViewModel model)
        {
            if (!ModelState.IsValid)
            {
                TempData["ErrorMessage"] = "Por favor verifica los campos ingresados.";
                return View("Personalizacion", model);
            }

            try
            {
                await _siteSettingService.SaveSettingsAsync(model);
                TempData["SuccessMessage"] = "Identidad del sitio, logo y pie de página actualizados exitosamente.";
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Error al guardar la configuración: {ex.Message}";
            }

            return RedirectToAction("Personalizacion");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RestablecerPersonalizacion()
        {
            try
            {
                await _siteSettingService.ResetToDefaultsAsync();
                TempData["SuccessMessage"] = "Se restablecieron los textos, logo y pie de página a sus valores por defecto.";
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Error al restablecer valores: {ex.Message}";
            }

            return RedirectToAction("Personalizacion");
        }

        // ==========================================
        // 8. GESTIÓN DE ANUNCIOS Y POPUPS (AVISOS / MANTENIMIENTO)
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> Anuncios()
        {
            var settings = await _siteSettingService.GetSettingsAsync();
            var model = new PopupSettingViewModel
            {
                IsEnabled = settings.PopupIsEnabled,
                Title = settings.PopupTitle,
                Message = settings.PopupMessage,
                Type = settings.PopupType,
                ButtonText = settings.PopupButtonText,
                ActionUrl = settings.PopupActionUrl,
                ActionText = settings.PopupActionText,
                ShowOnce = settings.PopupShowOnce,
                Version = settings.PopupVersion
            };
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> GuardarAnuncios(PopupSettingViewModel model)
        {
            if (string.IsNullOrWhiteSpace(model.Title))
            {
                model.Title = "Aviso de Mantenimiento Programado";
            }

            if (string.IsNullOrWhiteSpace(model.Message))
            {
                model.Message = "La plataforma se encuentra en actualización técnica. Agradecemos su comprensión.";
            }

            model.Version = DateTime.UtcNow.ToString("yyyyMMddHHmmss");

            try
            {
                await _siteSettingService.SavePopupSettingsAsync(model);
                TempData["SuccessMessage"] = model.IsEnabled
                    ? "¡Popup/Anuncio ACTIVADO con éxito! Los visitantes verán el comunicado al ingresar a la plataforma."
                    : "El Popup/Anuncio ha sido DESACTIVADO correctamente.";
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Error al guardar el anuncio: {ex.Message}";
            }

            return RedirectToAction("Anuncios");
        }

        // ==========================================
        // 9. GESTIÓN DE CATEGORÍAS
        // ==========================================

        [HttpGet]
        public async Task<IActionResult> Categorias()
        {
            var cats = await _context.Categories
                .OrderBy(c => c.DisplayOrder).ThenBy(c => c.Name)
                .Select(c => new CategoryViewModel
                {
                    Id = c.Id,
                    Name = c.Name,
                    Slug = c.Slug,
                    Description = c.Description,
                    IconClass = c.IconClass,
                    DisplayOrder = c.DisplayOrder,
                    CourseCount = c.Courses.Count()
                }).ToListAsync();
            return View(cats);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CrearCategoria(CategoryViewModel model)
        {
            if (string.IsNullOrWhiteSpace(model.Name))
            {
                TempData["ErrorMessage"] = "El nombre de la categoría es obligatorio.";
                return RedirectToAction("Categorias");
            }
            var slug = string.IsNullOrWhiteSpace(model.Slug)
                ? GenerateSlug(model.Name)
                : GenerateSlug(model.Slug);
            if (await _context.Categories.AnyAsync(c => c.Slug == slug))
                slug += "-" + DateTime.UtcNow.Ticks.ToString()[^4..];

            _context.Categories.Add(new Category
            {
                Name = model.Name.Trim(),
                Slug = slug,
                Description = model.Description?.Trim() ?? "",
                IconClass = string.IsNullOrWhiteSpace(model.IconClass) ? "bi-folder" : model.IconClass.Trim(),
                DisplayOrder = model.DisplayOrder
            });
            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Categoría '{model.Name}' creada exitosamente.";
            return RedirectToAction("Categorias");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditarCategoria(CategoryViewModel model)
        {
            var cat = await _context.Categories.FindAsync(model.Id);
            if (cat == null) return NotFound();

            cat.Name = model.Name.Trim();
            cat.Description = model.Description?.Trim() ?? "";
            cat.IconClass = string.IsNullOrWhiteSpace(model.IconClass) ? "bi-folder" : model.IconClass.Trim();
            cat.DisplayOrder = model.DisplayOrder;

            if (!string.IsNullOrWhiteSpace(model.Slug))
            {
                var cleanSlug = GenerateSlug(model.Slug);
                if (!await _context.Categories.AnyAsync(c => c.Slug == cleanSlug && c.Id != cat.Id))
                    cat.Slug = cleanSlug;
            }

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Categoría '{cat.Name}' actualizada correctamente.";
            return RedirectToAction("Categorias");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EliminarCategoria(int id)
        {
            var cat = await _context.Categories
                .Include(c => c.Courses)
                .FirstOrDefaultAsync(c => c.Id == id);
            if (cat == null) return NotFound();

            if (cat.Courses.Any())
            {
                TempData["ErrorMessage"] = $"No se puede eliminar '{cat.Name}': tiene {cat.Courses.Count} curso(s) asignado(s). Reasigna primero los cursos a otra categoría.";
                return RedirectToAction("Categorias");
            }

            _context.Categories.Remove(cat);
            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Categoría '{cat.Name}' eliminada correctamente.";
            return RedirectToAction("Categorias");
        }

        // ==========================================
        // 9. ELIMINAR CURSO COMPLETO
        // ==========================================

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EliminarCurso(int id)
        {
            try
            {
                var course = await _context.Courses
                    .Include(c => c.Modules).ThenInclude(m => m.Lessons).ThenInclude(l => l.LessonProgresses)
                    .Include(c => c.Quiz!).ThenInclude(q => q.Questions).ThenInclude(q => q.Options)
                    .Include(c => c.Quiz!).ThenInclude(q => q.Attempts)
                    .Include(c => c.Enrollments).ThenInclude(e => e.LessonProgresses)
                    .Include(c => c.Certificates).ThenInclude(cert => cert.Payments)
                    .FirstOrDefaultAsync(c => c.Id == id);

                if (course == null) return NotFound();

                var title = course.Title;

                // Pagos y certificados (restricción manual)
                foreach (var cert in course.Certificates)
                    _context.Payments.RemoveRange(cert.Payments);
                _context.Certificates.RemoveRange(course.Certificates);

                // Matrículas y progreso de lecciones
                foreach (var en in course.Enrollments)
                    _context.LessonProgresses.RemoveRange(en.LessonProgresses);
                _context.CourseEnrollments.RemoveRange(course.Enrollments);

                // Quiz
                if (course.Quiz != null)
                {
                    foreach (var q in course.Quiz.Questions)
                        _context.QuizOptions.RemoveRange(q.Options);
                    _context.QuizQuestions.RemoveRange(course.Quiz.Questions);
                    _context.QuizAttempts.RemoveRange(course.Quiz.Attempts);
                    _context.Quizzes.Remove(course.Quiz);
                }

                // Módulos y lecciones
                foreach (var mod in course.Modules)
                    _context.Lessons.RemoveRange(mod.Lessons);
                _context.CourseModules.RemoveRange(course.Modules);

                _context.Courses.Remove(course);
                await _context.SaveChangesAsync();

                TempData["SuccessMessage"] = $"Curso '{title}' eliminado completamente del sistema.";
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Error al eliminar el curso: {ex.Message}";
            }

            return RedirectToAction("Cursos");
        }

        private static string GenerateSlug(string phrase)
        {
            var str = phrase.ToLowerInvariant().Trim();
            str = Regex.Replace(str, @"\s+", "-");
            str = Regex.Replace(str, @"[^\w\-]+", "");
            str = Regex.Replace(str, @"\-{2,}", "-");
            return str.Trim('-');
        }
    }
}
