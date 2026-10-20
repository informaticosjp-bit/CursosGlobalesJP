using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models.Entities;
using CursosCertificadosApp.Models.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using System.Text.RegularExpressions;

namespace CursosCertificadosApp.Controllers
{
    [Authorize(Roles = "Creator,Admin")]
    public class CreadorController : Controller
    {
        private readonly AppDbContext _context;
        private readonly IWebHostEnvironment _env;

        public CreadorController(AppDbContext context, IWebHostEnvironment env)
        {
            _context = context;
            _env = env;
        }

        private int GetCurrentUserId()
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            int.TryParse(userIdStr, out int userId);
            return userId;
        }

        // ==========================================
        // 1. MIS CURSOS COMO CREADOR
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> Cursos()
        {
            var userId = GetCurrentUserId();
            bool isAdmin = User.IsInRole("Admin");

            var query = _context.Courses
                .Include(c => c.Category)
                .Include(c => c.Modules)
                .Include(c => c.Enrollments)
                .Include(c => c.Certificates)
                .AsQueryable();

            if (!isAdmin)
            {
                query = query.Where(c => c.CreatorUserId == userId);
            }

            var courses = await query.OrderByDescending(c => c.CreatedAt).ToListAsync();
            
            // Estadísticas de ganancias del creador (80% del valor del certificado emitido)
            var totalCertificados = courses.Sum(c => c.Certificates.Count(cert => cert.Status == CertificateStatus.Issued));
            var gananciasEstimadas = courses.Sum(c => c.Price * 0.80m * c.Certificates.Count(cert => cert.Status == CertificateStatus.Issued));
            ViewBag.TotalCertificados = totalCertificados;
            ViewBag.GananciasEstimadas = gananciasEstimadas;

            return View(courses);
        }

        // ==========================================
        // 2. CREAR CURSO
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> CrearCurso()
        {
            var categories = await _context.Categories.OrderBy(c => c.Name).ToListAsync();
            var userName = User.Identity?.Name;

            var model = new CourseFormViewModel
            {
                Categories = categories,
                Level = "Intermedio",
                EstimatedHours = 10,
                PassingScore = 70.00m,
                Price = 1.00m,
                IsPublished = true,
                InstructorName = userName
            };
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CrearCurso(CourseFormViewModel model)
        {
            var userId = GetCurrentUserId();

            if (!ModelState.IsValid)
            {
                model.Categories = await _context.Categories.OrderBy(c => c.Name).ToListAsync();
                return View(model);
            }

            var slug = string.IsNullOrWhiteSpace(model.Slug)
                ? GenerateSlug(model.Title)
                : GenerateSlug(model.Slug);

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
                InstructorName = string.IsNullOrWhiteSpace(model.InstructorName) ? User.Identity?.Name : model.InstructorName.Trim(),
                InstructorTitle = model.InstructorTitle?.Trim(),
                CreatorUserId = userId,
                CreatedAt = DateTime.UtcNow
            };

            // Módulo inicial
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

            TempData["SuccessMessage"] = $"¡Curso '{course.Title}' creado satisfactoriamente!";
            return RedirectToAction("ModulosCurso", new { id = course.Id });
        }

        // ==========================================
        // 3. EDITAR CURSO
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> EditarCurso(int id)
        {
            var userId = GetCurrentUserId();
            bool isAdmin = User.IsInRole("Admin");

            var course = await _context.Courses.FindAsync(id);
            if (course == null) return NotFound();

            if (!isAdmin && course.CreatorUserId != userId)
            {
                return Forbid();
            }

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

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditarCurso(CourseFormViewModel model)
        {
            var userId = GetCurrentUserId();
            bool isAdmin = User.IsInRole("Admin");

            if (!ModelState.IsValid)
            {
                model.Categories = await _context.Categories.OrderBy(c => c.Name).ToListAsync();
                return View(model);
            }

            var course = await _context.Courses.FindAsync(model.Id);
            if (course == null) return NotFound();

            if (!isAdmin && course.CreatorUserId != userId)
            {
                return Forbid();
            }

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

        // ==========================================
        // 4. GESTIÓN DE MÓDULOS Y LECCIONES
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> ModulosCurso(int id)
        {
            var userId = GetCurrentUserId();
            bool isAdmin = User.IsInRole("Admin");

            var course = await _context.Courses
                .Include(c => c.Category)
                .Include(c => c.Modules)
                    .ThenInclude(m => m.Lessons)
                .Include(c => c.Quiz)
                    .ThenInclude(q => q!.Questions)
                .FirstOrDefaultAsync(c => c.Id == id);

            if (course == null) return NotFound();

            if (!isAdmin && course.CreatorUserId != userId)
            {
                return Forbid();
            }

            return View(course);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CrearModulo(int courseId, string title, int orderIndex)
        {
            var userId = GetCurrentUserId();
            bool isAdmin = User.IsInRole("Admin");

            var course = await _context.Courses.FindAsync(courseId);
            if (course == null || (!isAdmin && course.CreatorUserId != userId)) return Forbid();

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

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditarModulo(int moduleId, int courseId, string title, int orderIndex)
        {
            var userId = GetCurrentUserId();
            bool isAdmin = User.IsInRole("Admin");

            var course = await _context.Courses.FindAsync(courseId);
            if (course == null || (!isAdmin && course.CreatorUserId != userId)) return Forbid();

            var module = await _context.CourseModules.FindAsync(moduleId);
            if (module == null) return NotFound();

            module.Title = title.Trim();
            module.OrderIndex = orderIndex;

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Módulo '{module.Title}' actualizado.";
            return RedirectToAction("ModulosCurso", new { id = courseId });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EliminarModulo(int moduleId, int courseId)
        {
            var userId = GetCurrentUserId();
            bool isAdmin = User.IsInRole("Admin");

            var course = await _context.Courses.FindAsync(courseId);
            if (course == null || (!isAdmin && course.CreatorUserId != userId)) return Forbid();

            var module = await _context.CourseModules
                .Include(m => m.Lessons)
                .FirstOrDefaultAsync(m => m.Id == moduleId);

            if (module != null)
            {
                _context.Lessons.RemoveRange(module.Lessons);
                _context.CourseModules.Remove(module);
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Módulo y sus lecturas eliminados.";
            }

            return RedirectToAction("ModulosCurso", new { id = courseId });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CrearLeccion(int moduleId, int courseId, string title, string content, int estimatedMinutes, int orderIndex)
        {
            var userId = GetCurrentUserId();
            bool isAdmin = User.IsInRole("Admin");

            var course = await _context.Courses.FindAsync(courseId);
            if (course == null || (!isAdmin && course.CreatorUserId != userId)) return Forbid();

            if (string.IsNullOrWhiteSpace(title) || string.IsNullOrWhiteSpace(content))
            {
                TempData["ErrorMessage"] = "El título y contenido son obligatorios.";
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

            TempData["SuccessMessage"] = $"Lectura '{lesson.Title}' agregada con éxito.";
            return RedirectToAction("ModulosCurso", new { id = courseId });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditarLeccion(int lessonId, int courseId, string title, string content, int durationMinutes, int orderIndex)
        {
            var userId = GetCurrentUserId();
            bool isAdmin = User.IsInRole("Admin");

            var course = await _context.Courses.FindAsync(courseId);
            if (course == null || (!isAdmin && course.CreatorUserId != userId)) return Forbid();

            var lesson = await _context.Lessons.FindAsync(lessonId);
            if (lesson == null) return NotFound();

            lesson.Title = title.Trim();
            lesson.ContentHtml = content.Trim();
            lesson.DurationMinutes = durationMinutes > 0 ? durationMinutes : 15;
            lesson.OrderIndex = orderIndex;

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Lectura '{lesson.Title}' actualizada con éxito.";
            return RedirectToAction("ModulosCurso", new { id = courseId });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EliminarLeccion(int lessonId, int courseId)
        {
            var userId = GetCurrentUserId();
            bool isAdmin = User.IsInRole("Admin");

            var course = await _context.Courses.FindAsync(courseId);
            if (course == null || (!isAdmin && course.CreatorUserId != userId)) return Forbid();

            var lesson = await _context.Lessons.FindAsync(lessonId);
            if (lesson != null)
            {
                _context.Lessons.Remove(lesson);
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Lectura eliminada.";
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
        // 9. CREAR CATEGORÍA (ACCESO PARA CREADORES)
        // ==========================================
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CrearCategoria(CategoryViewModel model, string? returnUrl = null)
        {
            if (string.IsNullOrWhiteSpace(model.Name))
            {
                TempData["ErrorMessage"] = "El nombre de la categoría es obligatorio.";
                if (!string.IsNullOrEmpty(returnUrl)) return LocalRedirect(returnUrl);
                return RedirectToAction(nameof(Cursos));
            }

            var slug = string.IsNullOrWhiteSpace(model.Slug)
                ? GenerateSlug(model.Name)
                : GenerateSlug(model.Slug);

            if (await _context.Categories.AnyAsync(c => c.Slug == slug))
                slug += "-" + DateTime.UtcNow.Ticks.ToString()[^4..];

            var maxOrder = await _context.Categories.AnyAsync()
                ? await _context.Categories.MaxAsync(c => c.DisplayOrder)
                : 0;

            var newCategory = new Category
            {
                Name = model.Name.Trim(),
                Slug = slug,
                Description = model.Description?.Trim() ?? "",
                IconClass = string.IsNullOrWhiteSpace(model.IconClass) ? "bi-folder" : model.IconClass.Trim(),
                DisplayOrder = model.DisplayOrder > 0 ? model.DisplayOrder : maxOrder + 1
            };

            _context.Categories.Add(newCategory);
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = $"Categoría '{newCategory.Name}' agregada exitosamente.";

            if (!string.IsNullOrEmpty(returnUrl))
            {
                return LocalRedirect(returnUrl);
            }
            return RedirectToAction(nameof(Cursos));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CrearCategoriaAjax([FromBody] CategoryViewModel model)
        {
            if (string.IsNullOrWhiteSpace(model.Name))
            {
                return Json(new { success = false, message = "El nombre de la categoría es obligatorio." });
            }

            var slug = string.IsNullOrWhiteSpace(model.Slug)
                ? GenerateSlug(model.Name)
                : GenerateSlug(model.Slug);

            if (await _context.Categories.AnyAsync(c => c.Slug == slug))
                slug += "-" + DateTime.UtcNow.Ticks.ToString()[^4..];

            var maxOrder = await _context.Categories.AnyAsync()
                ? await _context.Categories.MaxAsync(c => c.DisplayOrder)
                : 0;

            var newCategory = new Category
            {
                Name = model.Name.Trim(),
                Slug = slug,
                Description = model.Description?.Trim() ?? "",
                IconClass = string.IsNullOrWhiteSpace(model.IconClass) ? "bi-folder" : model.IconClass.Trim(),
                DisplayOrder = model.DisplayOrder > 0 ? model.DisplayOrder : maxOrder + 1
            };

            _context.Categories.Add(newCategory);
            await _context.SaveChangesAsync();

            return Json(new
            {
                success = true,
                id = newCategory.Id,
                name = newCategory.Name,
                slug = newCategory.Slug,
                message = $"Categoría '{newCategory.Name}' creada con éxito."
            });
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
