using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;

namespace CursosCertificadosApp.Controllers
{
    public class HomeController : Controller
    {
        private readonly AppDbContext _context;

        public HomeController(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            try
            {
                var categories = await _context.Categories
                    .Include(c => c.Courses.Where(co => co.IsPublished))
                        .ThenInclude(co => co.Modules)
                    .Where(c => c.Courses.Any(co => co.IsPublished))
                    .OrderBy(c => c.DisplayOrder)
                    .ToListAsync();

                var totalCourses = await _context.Courses.CountAsync(c => c.IsPublished);
                var totalHours = await _context.Courses.Where(c => c.IsPublished).SumAsync(c => c.EstimatedHours);

                // Cursos más demandados con Módulos y Categoría incluidos
                var featuredCoursesRaw = await _context.Courses
                    .Include(c => c.Category)
                    .Include(c => c.Modules)
                    .Where(c => c.IsPublished)
                    .OrderBy(c => c.Slug == "office-basico" ? 0 :
                                  c.Slug == "office-intermedio" ? 1 :
                                  c.Slug == "domina-la-ia-con-gemini" ? 2 :
                                  c.Slug == "sap-business-one-b1-gestion-operativa" ? 3 :
                                  c.Slug == "shopify-comercio-electronico-tiendas-online" ? 4 :
                                  c.Slug == "asistente-de-ventas-comercial-supervision" ? 5 :
                                  c.Slug == "mercaderista-trade-merchandising-punto-venta" ? 6 :
                                  c.Slug == "servicio-tecnico-informatico-soporte-sistemas" ? 7 :
                                  c.Slug == "administracion-empresarial-procesos-reportes" ? 8 :
                                  c.Slug == "atencion-al-cliente-presencial-fidelizacion" ? 9 :
                                  c.Slug == "filosofia-empresarial-etica-laboral" ? 10 :
                                  c.Slug == "auxiliar-almacen-inventarios-logistica" ? 11 :
                                  c.Slug == "trabajo-en-equipo-habilidades-blandas-productividad" ? 12 :
                                  c.Slug == "ingles-a1-english-fundamentals" ? 13 :
                                  c.Slug == "introduccion-ciberseguridad" ? 14 :
                                  c.Slug == "gestion-proyectos-agile" ? 15 :
                                  c.Slug == "tacticas-de-negociacion-efectiva" ? 16 :
                                  c.Slug == "ciencia-y-analisis-de-datos" ? 17 : 99)
                    .ThenBy(c => c.Id)
                    .ToListAsync();

                // Garantizar siempre cuadrículas perfectas sin huecos: múltiplo exacto de 3 y de 6
                int totalAvailable = featuredCoursesRaw.Count;
                int perfectCount = (totalAvailable / 6) * 6;
                if (perfectCount < 6 && totalAvailable >= 3)
                {
                    perfectCount = (totalAvailable / 3) * 3;
                }
                else if (perfectCount == 0)
                {
                    perfectCount = totalAvailable;
                }

                // Bloque de 18 cursos (6 filas exactas de 3 cuadros en PC / 9 filas de 2 cuadros en tablet)
                int targetLimit = Math.Min(perfectCount, 18);
                var featuredCourses = featuredCoursesRaw.Take(targetLimit > 0 ? targetLimit : totalAvailable).ToList();

                ViewBag.TotalCourses = totalCourses;
                ViewBag.TotalHours = totalHours;
                ViewBag.FeaturedCourses = featuredCourses;

                return View(categories);
            }
            catch (Exception)
            {
                // Fallback silencioso para no arrojar Error 500 en la página principal si la BD está arrancando
                ViewBag.TotalCourses = 0;
                ViewBag.TotalHours = 0;
                ViewBag.FeaturedCourses = new List<CursosCertificadosApp.Models.Entities.Course>();
                return View(new List<CursosCertificadosApp.Models.Entities.Category>());
            }
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [HttpGet]
        public async Task<IActionResult> Terminos()
        {
            var terms = await _context.SystemSettings.FirstOrDefaultAsync(s => s.Key == "TermsAndConditions");
            if (terms == null)
            {
                terms = new CursosCertificadosApp.Models.Entities.SystemSetting
                {
                    Key = "TermsAndConditions",
                    Title = "Términos y Condiciones Generales de Uso, Formación y Certificación",
                    Content = "<p>Términos y condiciones institucionales en proceso de actualización.</p>",
                    UpdatedAt = DateTime.UtcNow
                };
            }
            return View(terms);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
