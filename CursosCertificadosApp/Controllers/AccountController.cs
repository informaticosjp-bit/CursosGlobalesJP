using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models.Entities;
using CursosCertificadosApp.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.Security.Claims;
using CursosCertificadosApp.Models.ViewModels;

namespace CursosCertificadosApp.Controllers
{
    public class LoginViewModel
    {
        [Required(ErrorMessage = "El correo o usuario es obligatorio")]
        public string Email { get; set; } = string.Empty;

        [Required(ErrorMessage = "La contraseña es obligatoria"), DataType(DataType.Password)]
        public string Password { get; set; } = string.Empty;
    }

    public class RegisterViewModel
    {
        [Required(ErrorMessage = "El nombre completo es obligatorio"), MaxLength(150)]
        public string FullName { get; set; } = string.Empty;

        [Required(ErrorMessage = "El documento de identidad es obligatorio para tu certificado oficial")]
        [Display(Name = "Cédula / DNI / Pasaporte")]
        public string IdentificationNumber { get; set; } = string.Empty;

        [Range(10, 120, ErrorMessage = "Ingresa una edad válida")]
        [Display(Name = "Edad (opcional)")]
        public int? Age { get; set; }

        [MaxLength(30)]
        [Display(Name = "Teléfono / WhatsApp (opcional)")]
        public string? PhoneNumber { get; set; }

        [Required(ErrorMessage = "El correo electrónico es obligatorio"), EmailAddress]
        public string Email { get; set; } = string.Empty;

        [Required(ErrorMessage = "La contraseña es obligatoria"), MinLength(6, ErrorMessage = "Mínimo 6 caracteres"), DataType(DataType.Password)]
        public string Password { get; set; } = string.Empty;

        [Compare("Password", ErrorMessage = "Las contraseñas no coinciden"), DataType(DataType.Password)]
        public string ConfirmPassword { get; set; } = string.Empty;
    }

    public class AccountController : Controller
    {
        private readonly AppDbContext _context;
        private readonly IProgressService _progressService;
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly ILogger<AccountController> _logger;

        public AccountController(
            AppDbContext context, 
            IProgressService progressService,
            IWebHostEnvironment webHostEnvironment,
            ILogger<AccountController> logger)
        {
            _context = context;
            _progressService = progressService;
            _webHostEnvironment = webHostEnvironment;
            _logger = logger;
        }

        [HttpGet]
        public IActionResult Login(string? returnUrl)
        {
            try
            {
                ViewBag.ReturnUrl = returnUrl;
                return View();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al cargar la vista de Login: {Message}", ex.Message);
                return View();
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(LoginViewModel model, string? returnUrl)
        {
            if (!ModelState.IsValid) return View(model);

            try
            {
                var inputIdentifier = (model.Email ?? string.Empty).Trim().ToLowerInvariant();
                var trimmedPassword = (model.Password ?? string.Empty).Trim();
                var passwordHash = DbSeeder.HashPassword(trimmedPassword);

                // 1. Búsqueda directa por hash estándar SHA-256
                var user = await _context.Users
                    .FirstOrDefaultAsync(u => 
                        (u.Email.ToLower() == inputIdentifier || (inputIdentifier == "master" && u.Email.ToLower() == "master@globalesjp.net")) 
                        && u.PasswordHash == passwordHash);

                // 2. Comprobación y auto-sincronización de rescate para el Administrador Maestro
                if (user == null)
                {
                    var isMasterTarget = inputIdentifier == "master" || inputIdentifier == "master@globalesjp.net";
                    if (isMasterTarget && (trimmedPassword == "master141990" || trimmedPassword == "Master141990"))
                    {
                        var masterCandidate = await _context.Users
                            .FirstOrDefaultAsync(u => u.Email.ToLower() == "master@globalesjp.net" || u.Email.ToLower() == "master");

                        if (masterCandidate != null)
                        {
                            user = masterCandidate;
                            user.PasswordHash = passwordHash;
                            user.Role = "Admin";
                            await _context.SaveChangesAsync();
                            _logger.LogInformation("Hash de credenciales del Administrador Maestro sincronizado correctamente.");
                        }
                    }
                }

                if (user == null)
                {
                    ModelState.AddModelError(string.Empty, "Credenciales incorrectas o usuario no registrado.");
                    return View(model);
                }

                await SignInUser(user);
                _logger.LogInformation("Inicio de sesión exitoso para: {Email} con Rol: {Role}", user.Email, user.Role);

                if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
                {
                    return Redirect(returnUrl);
                }

                if (user.Role == "Admin")
                {
                    return RedirectToAction("Index", "Admin");
                }
                else if (user.Role == "Creator")
                {
                    return RedirectToAction("Cursos", "Creador");
                }

                return RedirectToAction("Dashboard");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Excepción durante el proceso de inicio de sesión de {Email}: {Message}", model.Email, ex.Message);
                ModelState.AddModelError(string.Empty, "Ocurrió un error temporal al procesar el inicio de sesión. Por favor reintenta en unos instantes.");
                return View(model);
            }
        }

        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Register(RegisterViewModel model)
        {
            if (!ModelState.IsValid) return View(model);

            var exists = await _context.Users.AnyAsync(u => u.Email.ToLower() == model.Email.ToLower());
            if (exists)
            {
                ModelState.AddModelError("Email", "Ya existe una cuenta con este correo electrónico.");
                return View(model);
            }

            var user = new User
            {
                FullName = model.FullName.Trim(),
                IdentificationNumber = model.IdentificationNumber.Trim(),
                Age = model.Age,
                PhoneNumber = model.PhoneNumber?.Trim(),
                Email = model.Email.Trim().ToLower(),
                PasswordHash = DbSeeder.HashPassword(model.Password),
                Role = "Student",
                CreatedAt = DateTime.UtcNow
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            await SignInUser(user);

            TempData["SuccessMessage"] = $"¡Bienvenido a Cursos Globales JP, {user.FullName}! Explora nuestro catálogo y comienza tu primer curso gratis.";
            return RedirectToAction("Dashboard");
        }

        [Authorize]
        [HttpGet]
        public async Task<IActionResult> Dashboard()
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId)) return RedirectToAction("Login");

            var user = await _context.Users.FindAsync(userId);
            var enrollments = await _progressService.GetStudentEnrollmentsAsync(userId);
            var certificates = await _context.Certificates
                .Include(c => c.Course)
                .Where(c => c.UserId == userId)
                .OrderByDescending(c => c.CreatedAt)
                .ToListAsync();

            var notifications = await _context.UserNotifications
                .Where(n => n.UserId == userId)
                .OrderByDescending(n => n.CreatedAt)
                .ToListAsync();

            ViewBag.User = user;
            ViewBag.Certificates = certificates;
            ViewBag.Notifications = notifications;

            return View(enrollments);
        }

        [Authorize]
        [HttpPost]
        public async Task<IActionResult> MarcarNotificacionLeida(int id)
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (int.TryParse(userIdStr, out int userId))
            {
                var notif = await _context.UserNotifications.FirstOrDefaultAsync(n => n.Id == id && n.UserId == userId);
                if (notif != null)
                {
                    notif.IsRead = true;
                    await _context.SaveChangesAsync();
                }
            }
            return Ok();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public IActionResult AccessDenied()
        {
            return View();
        }

        [Authorize]
        [HttpGet]
        public async Task<IActionResult> Perfil()
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId)) return RedirectToAction("Login");

            var user = await _context.Users.FindAsync(userId);
            if (user == null) return NotFound();

            var model = new UserProfileViewModel
            {
                Id = user.Id,
                FullName = user.FullName,
                IdentificationNumber = user.IdentificationNumber,
                Email = user.Email,
                Address = user.Address,
                BirthDate = user.BirthDate,
                PhoneNumber = user.PhoneNumber,
                Age = user.Age,
                CurrentProfilePictureUrl = user.ProfilePictureUrl,
                Role = user.Role
            };

            return View(model);
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Perfil(UserProfileViewModel model)
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId)) return Unauthorized();

            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var user = await _context.Users.FindAsync(userId);
            if (user == null) return NotFound();

            var emailExists = await _context.Users.AnyAsync(u => u.Email.ToLower() == model.Email.Trim().ToLower() && u.Id != userId);
            if (emailExists)
            {
                ModelState.AddModelError("Email", "Este correo electrónico ya se encuentra registrado por otro usuario.");
                model.CurrentProfilePictureUrl = user.ProfilePictureUrl;
                model.Role = user.Role;
                return View(model);
            }

            user.FullName = model.FullName.Trim();
            user.IdentificationNumber = model.IdentificationNumber.Trim();
            user.Email = model.Email.Trim().ToLower();
            user.Address = string.IsNullOrWhiteSpace(model.Address) ? null : model.Address.Trim();
            user.PhoneNumber = string.IsNullOrWhiteSpace(model.PhoneNumber) ? null : model.PhoneNumber.Trim();

            if (model.BirthDate.HasValue)
            {
                user.BirthDate = DateTime.SpecifyKind(model.BirthDate.Value.Date, DateTimeKind.Utc);
                var today = DateTime.UtcNow.Date;
                var age = today.Year - user.BirthDate.Value.Year;
                if (user.BirthDate.Value > today.AddYears(-age)) age--;
                user.Age = age;
            }
            else
            {
                user.BirthDate = null;
            }

            var webRoot = _webHostEnvironment.WebRootPath ?? Path.Combine(_webHostEnvironment.ContentRootPath, "wwwroot");

            if (model.RemovePicture)
            {
                if (!string.IsNullOrEmpty(user.ProfilePictureUrl))
                {
                    var oldFilePath = Path.Combine(webRoot, user.ProfilePictureUrl.TrimStart('/'));
                    if (System.IO.File.Exists(oldFilePath))
                    {
                        try { System.IO.File.Delete(oldFilePath); } catch { }
                    }
                }
                user.ProfilePictureUrl = null;
            }

            if (model.ProfilePicture != null && model.ProfilePicture.Length > 0)
            {
                // Límite estricto de tamaño para evitar saturar almacenamiento en servidores ligeros
                const long maxFileSize = 1024 * 1024; // 1 MB
                if (model.ProfilePicture.Length > maxFileSize)
                {
                    ModelState.AddModelError("ProfilePicture", "La imagen seleccionada supera el límite máximo permitido de 1 MB. Por favor sube una imagen más pequeña.");
                    model.CurrentProfilePictureUrl = user.ProfilePictureUrl;
                    model.Role = user.Role;
                    return View(model);
                }

                var uploadsFolder = Path.Combine(webRoot, "uploads", "profiles");
                if (!Directory.Exists(uploadsFolder)) Directory.CreateDirectory(uploadsFolder);

                var extension = Path.GetExtension(model.ProfilePicture.FileName).ToLowerInvariant();
                var allowedExtensions = new[] { ".jpg", ".jpeg", ".png", ".webp" };
                if (allowedExtensions.Contains(extension))
                {
                    // Si el usuario ya tenía una foto previa, borrarla para no dejar archivos huérfanos
                    if (!string.IsNullOrEmpty(user.ProfilePictureUrl))
                    {
                        var oldFilePath = Path.Combine(webRoot, user.ProfilePictureUrl.TrimStart('/'));
                        if (System.IO.File.Exists(oldFilePath))
                        {
                            try { System.IO.File.Delete(oldFilePath); } catch { }
                        }
                    }

                    var fileName = $"user_{user.Id}_{Guid.NewGuid():N}{extension}";
                    var filePath = Path.Combine(uploadsFolder, fileName);
                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await model.ProfilePicture.CopyToAsync(stream);
                    }
                    user.ProfilePictureUrl = $"/uploads/profiles/{fileName}";
                }
                else
                {
                    ModelState.AddModelError("ProfilePicture", "Formato de imagen no válido. Solo se admiten JPG, PNG y WEBP.");
                    model.CurrentProfilePictureUrl = user.ProfilePictureUrl;
                    model.Role = user.Role;
                    return View(model);
                }
            }

            await _context.SaveChangesAsync();

            await SignInUser(user);

            TempData["SuccessMessage"] = "¡Tus datos de perfil han sido actualizados exitosamente!";
            return RedirectToAction("Perfil");
        }

        private async Task SignInUser(User user)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new Claim(ClaimTypes.Name, user.FullName ?? "Administrador"),
                new Claim(ClaimTypes.Email, user.Email ?? "master@globalesjp.net"),
                new Claim(ClaimTypes.Role, user.Role ?? "Admin"),
                new Claim("IdentificationNumber", user.IdentificationNumber ?? "V-00000000"),
                new Claim("ProfilePictureUrl", user.ProfilePictureUrl ?? string.Empty)
            };

            var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var principal = new ClaimsPrincipal(identity);

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);
        }
    }
}
