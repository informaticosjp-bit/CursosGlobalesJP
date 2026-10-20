using CursosCertificadosApp.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace CursosCertificadosApp.Data
{
    public static class BusinessFundamentalsSeeder
    {
        public class CourseData
        {
            public string CategorySlug { get; set; } = string.Empty;
            public string Title { get; set; } = string.Empty;
            public string Slug { get; set; } = string.Empty;
            public string ShortDescription { get; set; } = string.Empty;
            public string Level { get; set; } = "Básico";
            public int EstimatedHours { get; set; } = 16;
            public string BadgeColor { get; set; } = "primary";
            public List<ModuleData> Modules { get; set; } = new();
            public QuizData Quiz { get; set; } = new();
        }

        public class ModuleData
        {
            public string Title { get; set; } = string.Empty;
            public string LessonTitle { get; set; } = string.Empty;
            public string Summary { get; set; } = string.Empty;
            public string ContentHtml { get; set; } = string.Empty;
            public int DurationMinutes { get; set; } = 25;
        }

        public class QuizData
        {
            public string Title { get; set; } = string.Empty;
            public List<QuestionData> Questions { get; set; } = new();
        }

        public class QuestionData
        {
            public string QuestionText { get; set; } = string.Empty;
            public string[] Options { get; set; } = Array.Empty<string>();
            public int CorrectIndex { get; set; }
            public string Explanation { get; set; } = string.Empty;
        }

        public static async Task SeedOrUpdateCoursesAsync(AppDbContext context)
        {
            // 1. Asegurar categoría de Empleabilidad y Gestión Comercial
            var catEmploy = await context.Categories.FirstOrDefaultAsync(c => c.Slug == "empleabilidad-desarrollo-idiomas");
            if (catEmploy == null)
            {
                catEmploy = new Category
                {
                    Name = "Empleabilidad, Ventas y Gestión Comercial",
                    Slug = "empleabilidad-desarrollo-idiomas",
                    Description = "Formación en administración empresarial, ventas, servicio al cliente, valores y competencias laborales.",
                    IconClass = "bi-briefcase",
                    DisplayOrder = 2
                };
                context.Categories.Add(catEmploy);
                await context.SaveChangesAsync();
            }

            var courses = GetCoursesData();

            foreach (var courseData in courses)
            {
                var course = await context.Courses
                    .Include(c => c.Modules)
                        .ThenInclude(m => m.Lessons)
                    .FirstOrDefaultAsync(c => c.Slug == courseData.Slug);

                if (course == null)
                {
                    course = new Course
                    {
                        CategoryId = catEmploy.Id,
                        Title = courseData.Title,
                        Slug = courseData.Slug,
                        ShortDescription = courseData.ShortDescription,
                        FullDescription = $"{courseData.ShortDescription} Programa formativo con lecciones estructuradas, casos reales del entorno laboral y evaluación sumativa final para acreditación oficial.",
                        Level = courseData.Level,
                        EstimatedHours = courseData.EstimatedHours,
                        PassingScore = 70.00m,
                        Price = 1.00m,
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
                    course.FullDescription = $"{courseData.ShortDescription} Programa formativo con lecciones estructuradas, casos reales del entorno laboral y evaluación sumativa final para acreditación oficial.";
                    course.Level = courseData.Level;
                    course.EstimatedHours = courseData.EstimatedHours;
                    course.BadgeColor = courseData.BadgeColor;
                    course.CategoryId = catEmploy.Id;
                    course.IsPublished = true;
                    await context.SaveChangesAsync();
                }

                // Sincronizar Módulos y Lecciones
                var existingMods = await context.CourseModules
                    .Include(m => m.Lessons)
                    .Where(m => m.CourseId == course.Id)
                    .OrderBy(m => m.OrderIndex)
                    .ToListAsync();

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
                    if (targetLesson != null)
                    {
                        targetLesson.Title = modData.LessonTitle;
                        targetLesson.ContentType = "Reading";
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
                            ContentType = "Reading",
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

                // Sincronizar Quiz
                var existingQuiz = await context.Quizzes
                    .Include(q => q.Questions)
                        .ThenInclude(qu => qu.Options)
                    .FirstOrDefaultAsync(q => q.CourseId == course.Id);

                if (existingQuiz != null)
                {
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
            }
        }

        public static List<CourseData> GetCoursesData()
        {
            return new List<CourseData>
            {
                // =========================================================================
                // CURSO 1: ADMINISTRACIÓN EMPRESARIAL BÁSICA
                // =========================================================================
                new CourseData
                {
                    CategorySlug = "empleabilidad-desarrollo-idiomas",
                    Title = "Administración Empresarial Básica: Estructura, Compras, Ventas y Reportes",
                    Slug = "administracion-empresarial-procesos-reportes",
                    ShortDescription = "Domina el engranaje básico de una empresa: organigrama, compras, ventas, facturación, sistemas ERP y reportes de control operativo.",
                    Level = "Básico",
                    EstimatedHours = 18,
                    BadgeColor = "primary",
                    Modules = new List<ModuleData>
                    {
                        new ModuleData
                        {
                            Title = "Módulo 1: Estructura Organizacional, Departamentos y Organigrama de la Empresa",
                            LessonTitle = "La Empresa como Sistema: Áreas Funcionales y Jerarquías",
                            Summary = "Comprende qué es una organización mercantil, los departamentos fundamentales (Dirección, Compras, Ventas, Almacén, Contabilidad y RRHH) y cómo se lee un organigrama.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-building fs-3 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">¿Qué es una Empresa y Cómo se Organiza?</h5>
            <p class=""mb-0 small"">Toda empresa, sin importar su tamaño, es un sistema coordinado de personas, recursos y procesos que buscan satisfacer necesidades del mercado de manera rentable.</p>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-diagram-3-fill text-primary me-2""></i>1. Las Áreas Funcionales Clave</h4>
    <p>Para operar eficazmente, las actividades se dividen en departamentos interconectados:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""card h-100 border-0 shadow-xs bg-light"">
                <div class=""card-body"">
                    <h6 class=""fw-bold text-dark""><i class=""bi bi-cart-check text-success me-1""></i> Compras y Aprovisionamiento</h6>
                    <p class=""small text-secondary mb-0"">Adquiere materia prima, insumos y mercancía para la venta, negociando con proveedores las mejores condiciones de precio, plazo y calidad.</p>
                </div>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""card h-100 border-0 shadow-xs bg-light"">
                <div class=""card-body"">
                    <h6 class=""fw-bold text-dark""><i class=""bi bi-shop text-primary me-1""></i> Ventas y Comercial</h6>
                    <p class=""small text-secondary mb-0"">Genera los ingresos de la empresa. Atiende clientes, cotiza, emite pedidos, gestiona el piso de venta y cuida las relaciones comerciales.</p>
                </div>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""card h-100 border-0 shadow-xs bg-light"">
                <div class=""card-body"">
                    <h6 class=""fw-bold text-dark""><i class=""bi bi-boxes text-warning me-1""></i> Almacén y Logística</h6>
                    <p class=""small text-secondary mb-0"">Custodia el inventario físico, recibe mercancía entrante, prepara despachos (*picking*) y resguarda los activos contra pérdidas o daños.</p>
                </div>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""card h-100 border-0 shadow-xs bg-light"">
                <div class=""card-body"">
                    <h6 class=""fw-bold text-dark""><i class=""bi bi-calculator text-danger me-1""></i> Administración y Finanzas</h6>
                    <p class=""small text-secondary mb-0"">Facturación legal, cobro de facturas, pago a proveedores, conciliaciones bancarias, nómina y cumplimiento tributario.</p>
                </div>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-diagram-2 text-primary me-2""></i>2. Tipos de Organigramas y Flujo Jerárquico</h4>
    <p>El organigrama es la representación gráfica de la estructura formal de la empresa. En él se aprecian:</p>
    <ul>
        <li><strong>Nivel Directivo / Gerencial:</strong> Toma decisiones estratégicas, aprueba presupuestos y marca el rumbo del negocio (Director General, Gerente General).</li>
        <li><strong>Nivel Táctico / Supervisorio:</strong> Coordina a los equipos operativos y asegura que las directrices se cumplan (Jefes de Departamento, Supervisores de Piso).</li>
        <li><strong>Nivel Operativo:</strong> Ejecuta directamente las tareas del día a día (Asistentes de ventas, cajeros, mercaderistas, auxiliares de almacén, soporte técnico).</li>
    </ul>

    <div class=""alert alert-info border-0 rounded-3 mt-4"">
        <h6 class=""fw-bold""><i class=""bi bi-lightbulb-fill me-1""></i> Principio de Cadena de Mando:</h6>
        <p class=""small mb-0"">Cada colaborador debe tener claridad de quién es su supervisor directo a quien reportar incidencias y de quién recibe instrucciones, evitando la duplicidad de órdenes contradictorias.</p>
    </div>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 2: El Proceso de Compras: De la Requisición al Control de Proveedores",
                            LessonTitle = "El Ciclo Operativo de Adquisiciones y Cuentas por Pagar",
                            Summary = "Aprende el ciclo formal de compras en una empresa: requisición, solicitud de cotizaciones, emisión de la Orden de Compra (OC), recepción de mercancía y conciliación fiscal.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-arrow-repeat me-1""></i> El Ciclo de Compras Empresarial (Procure to Pay)</h5>
        <p class=""mb-0 small"">Comprar en una empresa no es simplemente pagar en caja; requiere un proceso formal con documentos de respaldo para garantizar transparencia y evitar fraudes o sobrecostos.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-list-ol text-primary me-2""></i>Las 5 Etapas del Proceso de Compras</h4>
    <ol class=""list-group list-group-numbered mb-4"">
        <li class=""list-group-item d-flex justify-content-between align-items-start"">
            <div class=""ms-2 me-auto"">
                <div class=""fw-bold"">1. Requisición o Solicitud de Compra Interna</div>
                El departamento que necesita insumos o el almacén que detecta stock mínimo emite un formulario solicitando el producto debidamente justificado.
            </div>
            <span class=""badge bg-secondary rounded-pill"">Paso 1</span>
        </li>
        <li class=""list-group-item d-flex justify-content-between align-items-start"">
            <div class=""ms-2 me-auto"">
                <div class=""fw-bold"">2. Cotización y Cuadro Comparativo</div>
                El comprador solicita cotizaciones a por lo menos 3 proveedores para comparar precios, tiempos de entrega, formas de pago (crédito/contado) y garantías.
            </div>
            <span class=""badge bg-secondary rounded-pill"">Paso 2</span>
        </li>
        <li class=""list-group-item d-flex justify-content-between align-items-start"">
            <div class=""ms-2 me-auto"">
                <div class=""fw-bold"">3. Emisión de la Orden de Compra (OC / Purchase Order)</div>
                Es el contrato formal que autoriza al proveedor a despachar las cantidades acordadas a los precios y plazos negociados.
            </div>
            <span class=""badge bg-primary rounded-pill"">Oficial</span>
        </li>
        <li class=""list-group-item d-flex justify-content-between align-items-start"">
            <div class=""ms-2 me-auto"">
                <div class=""fw-bold"">4. Recepción e Inspección en Almacén</div>
                Al llegar el transporte, el auxiliar de almacén coteja el bulto contra la Orden de Compra y la Guía de Despacho del proveedor, verificando estado físico y fechas.
            </div>
            <span class=""badge bg-secondary rounded-pill"">Físico</span>
        </li>
        <li class=""list-group-item d-flex justify-content-between align-items-start"">
            <div class=""ms-2 me-auto"">
                <div class=""fw-bold"">5. Conciliación y Registro en Cuentas por Pagar (3-Way Matching)</div>
                Administración verifica que coincidan: (a) la Orden de Compra, (b) la Nota de Entrada de Almacén y (c) la Factura del Proveedor antes de liberar el pago.
            </div>
            <span class=""badge bg-success rounded-pill"">Pago</span>
        </li>
    </ol>

    <div class=""card border-0 bg-light p-3"">
        <h6 class=""fw-bold text-dark""><i class=""bi bi-exclamation-octagon text-danger me-1""></i> Error Grave a Evitar:</h6>
        <p class=""small text-secondary mb-0"">Nunca se debe pagar una factura de proveedor sin tener el comprobante de entrada firmado y sellado por el encargado del almacén que certifique que la mercancía ingresó completa.</p>
    </div>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 3: El Ciclo de Ventas: Cotización, Facturación, Entrega y Cobranza",
                            LessonTitle = "Del Contacto con el Cliente al Ingreso en Caja (Order to Cash)",
                            Summary = "Domina el flujo de ventas: prospección, cotización formal, pedido de venta, emisión de factura legal, guía de despacho y seguimiento de cobranza.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-cash-coin me-1""></i> La Venta no Termina al Vender, Termina al Cobrar</h5>
        <p class=""mb-0 small"">El ciclo de ventas es el motor financiero de la empresa. Comprender su flujo evita pérdidas de inventario, errores de facturación e impagos de clientes.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-arrow-right-circle-fill text-primary me-2""></i>Flujo Cronológico de una Venta</h4>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm align-middle"">
            <thead class=""table-primary"">
                <tr>
                    <th>Etapa</th>
                    <th>Documento Clave</th>
                    <th>Responsable</th>
                    <th>Objetivo Operativo</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold"">1. Cotización / Presupuesto</td>
                    <td>Cotización Formal</td>
                    <td>Asesor / Ventas</td>
                    <td>Indica precio unitario, vigencia de la oferta, impuestos y condiciones de pago.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">2. Pedido de Venta</td>
                    <td>Orden de Pedido</td>
                    <td>Ventas / Facturación</td>
                    <td>Reserva el inventario en el sistema y autoriza el despacho.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">3. Despacho / Entrega</td>
                    <td>Nota de Entrega / Guía</td>
                    <td>Almacén / Logística</td>
                    <td>El cliente o transportista firma conforme la recepción física de las unidades.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">4. Facturación Legal</td>
                    <td>Factura Fiscal / Electrónica</td>
                    <td>Administración / Caja</td>
                    <td>Documento tributario vinculante con desglose de IVA y datos fiscales.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">5. Cobranza y Cierre</td>
                    <td>Recibo de Pago / Depósito</td>
                    <td>Caja / Tesorería</td>
                    <td>Conciliación del pago (Efectivo, Pago Móvil, Transferencia, Tarjeta o Divisas).</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h5 class=""fw-bold text-dark""><i class=""bi bi-receipt text-warning me-1""></i> Importancia del Control de Cuentas por Cobrar (CxC)</h5>
    <p class=""small text-secondary"">Cuando una empresa vende a crédito (a 15 o 30 días), la gestión de cobranza preventiva es crucial. Un retraso en el cobro compromete el flujo de caja necesario para pagar sueldos, alquileres y proveedores.</p>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 4: Sistemas de Gestión (ERP/CRM) y Reportes de Control Operativo",
                            LessonTitle = "Sistemas Administrativos y Generación de Reportes Diarios",
                            Summary = "Conoce qué es un sistema ERP (como SAP o Profit Plus), qué es un CRM, cómo se generan reportes de cuadre de caja, ventas diarias e inventario para la toma de decisiones.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-display me-1""></i> Sistemas de Información Empresarial</h5>
        <p class=""mb-0 small"">Hoy en día, ninguna empresa competitiva opera con cuadernos a mano. El dominio de sistemas informáticos y reportes cuantitativos es el requisito básico para cualquier empleo de oficina o tienda.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-hdd-network text-primary me-2""></i>1. ¿Qué es un ERP y un CRM?</h4>
    <ul>
        <li><strong>ERP (Enterprise Resource Planning):</strong> Software centralizado donde se cruza toda la información del negocio: cuando se vende un producto en caja, automáticamente se descuenta del inventario en almacén y se crea el asiento contable en finanzas (Ej. SAP Business One, Odoo, Saint, Profit Plus).</li>
        <li><strong>CRM (Customer Relationship Management):</strong> Sistema para registrar clientes, historiales de llamadas, presupuestos enviados y seguimiento comercial.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-file-earmark-bar-graph text-primary me-2""></i>2. Los 3 Reportes Diarios Indispensables</h4>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-4"">
            <div class=""border rounded-3 p-3 bg-white shadow-xs"">
                <span class=""badge bg-primary mb-2"">Reporte 1</span>
                <h6 class=""fw-bold text-dark"">Cuadre y Cierre de Caja</h6>
                <p class=""small text-secondary mb-0"">Total recaudado al final del turno dividido por formas de pago (Efectivo Bs, Divisas en efectivo, Pago Móvil, Puntos de Venta). La suma física debe coincidir con el sistema (Cero faltantes/sobrantes).</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""border rounded-3 p-3 bg-white shadow-xs"">
                <span class=""badge bg-success mb-2"">Reporte 2</span>
                <h6 class=""fw-bold text-dark"">Ventas Diarias por Asesor/Categoría</h6>
                <p class=""small text-secondary mb-0"">Muestra el volumen de ventas, ticket promedio, cumplimiento de presupuesto comercial y artículos más vendidos del día.</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""border rounded-3 p-3 bg-white shadow-xs"">
                <span class=""badge bg-danger mb-2"">Reporte 3</span>
                <h6 class=""fw-bold text-dark"">Stock Crítico y Quiebres</h6>
                <p class=""small text-secondary mb-0"">Alerta inmediata de artículos que llegaron a su punto de reorden (quedan pocas unidades) para gestionar la compra antes de quedarse sin stock para el cliente.</p>
            </div>
        </div>
    </div>
</div>"
                        }
                    },
                    Quiz = new QuizData
                    {
                        Title = "Evaluación Sumativa: Fundamentos de Administración Empresarial",
                        Questions = new List<QuestionData>
                        {
                            new QuestionData
                            {
                                QuestionText = "¿Cuál de los siguientes departamentos es el responsable de evaluar cotizaciones, seleccionar proveedores y emitir la Orden de Compra?",
                                Options = new[] { "Departamento de Recursos Humanos", "Departamento de Compras y Aprovisionamiento", "Departamento de Soporte Técnico", "Caja y Despacho" },
                                CorrectIndex = 1,
                                Explanation = "El departamento de compras se encarga de la negociación con proveedores, búsqueda de precios competitivos y emisión de las órdenes de compra formales."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Qué documento formal emitido por la empresa compradora autoriza legalmente al proveedor a despachar las cantidades y precios convenidos?",
                                Options = new[] { "La Requisición Interna", "El Currículum Vitae", "La Orden de Compra (OC)", "El Volante de Promoción" },
                                CorrectIndex = 2,
                                Explanation = "La Orden de Compra es el documento vinculante que formaliza el pedido de compra entre la empresa y su proveedor."
                            },
                            new QuestionData
                            {
                                QuestionText = "En el ciclo comercial de ventas, ¿en qué momento exacto se da por concluida la operación de manera integral?",
                                Options = new[] { "Cuando el cliente solicita el presupuesto", "Cuando el vendedor saluda al cliente", "Al realizar la cobranza efectiva y registrar el ingreso en caja", "Cuando el cliente observa la vitrina" },
                                CorrectIndex = 2,
                                Explanation = "Una venta solo se cierra de forma completa cuando el cliente paga la factura y el dinero ingresa efectivamente a las arcas o cuentas de la empresa."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Qué significa el acrónimo ERP en el contexto de software empresarial?",
                                Options = new[] { "Empresa Rápida y Productiva", "Enterprise Resource Planning (Planificación de Recursos Empresariales)", "Enlace Remoto de Proveedores", "Envío Rápido de Paquetes" },
                                CorrectIndex = 1,
                                Explanation = "ERP son las siglas de Enterprise Resource Planning, sistema que centraliza y conecta compras, ventas, inventario y contabilidad."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Por qué es fundamental elaborar el reporte de 'Cuadre y Cierre de Caja' al finalizar cada turno o jornada laboral?",
                                Options = new[] { "Para verificar que el dinero físico y comprobantes bancarios coincidan exactamente con lo registrado en el sistema", "Para que los clientes esperen más tiempo en la tienda", "Para cambiar el organigrama de la empresa diariamente", "Es un trámite sin utilidad contable" },
                                CorrectIndex = 0,
                                Explanation = "El arqueo y cierre de caja garantiza la transparencia de los ingresos, previene faltantes no justificados y valida que los pagos bancarios cuadren con lo facturado."
                            }
                        }
                    }
                },

                // =========================================================================
                // CURSO 2: FILOSOFÍA EMPRESARIAL Y ÉTICA LABORAL
                // =========================================================================
                new CourseData
                {
                    CategorySlug = "empleabilidad-desarrollo-idiomas",
                    Title = "Filosofía Empresarial, Cultura Organizacional y Ética Laboral",
                    Slug = "filosofia-empresarial-etica-laboral",
                    ShortDescription = "Comprende la identidad corporativa: misión, visión, valores, código de ética, confidencialidad, puntualidad y conducta intachable en el puesto de trabajo.",
                    Level = "Básico",
                    EstimatedHours = 14,
                    BadgeColor = "info",
                    Modules = new List<ModuleData>
                    {
                        new ModuleData
                        {
                            Title = "Módulo 1: Filosofía Corporativa: Misión, Visión, Valores y Propósito",
                            LessonTitle = "La Brújula de la Organización: Por qué Existimos y Hacia Dónde Vamos",
                            Summary = "Aprende qué es la filosofía empresarial, la diferencia entre Misión, Visión y Valores corporativos, y cómo un empleado alinea sus metas con la empresa.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-compass me-1""></i> La Identidad y el Rumbo de una Empresa</h5>
        <p class=""mb-0 small"">La filosofía empresarial define el ADN de la organización. Cuando una persona ingresa a trabajar, debe conocer y respetar estos postulados para desempeñarse en armonía con la cultura de la empresa.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-award-fill text-primary me-2""></i>Los Tres Pilares Filosóficos</h4>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-4"">
            <div class=""card h-100 border-primary"">
                <div class=""card-header bg-primary text-white fw-bold"">1. La Misión</div>
                <div class=""card-body"">
                    <p class=""small text-secondary mb-1""><strong>¿Qué hacemos hoy?</strong></p>
                    <p class=""small mb-0"">Define la razón de ser actual de la empresa, su actividad comercial principal, a quién sirve y el beneficio concreto que aporta a la sociedad.</p>
                </div>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""card h-100 border-success"">
                <div class=""card-header bg-success text-white fw-bold"">2. La Visión</div>
                <div class=""card-body"">
                    <p class=""small text-secondary mb-1""><strong>¿A dónde queremos llegar?</strong></p>
                    <p class=""small mb-0"">Es la meta inspiradora de futuro (a 5 o 10 años). Marca la posición de liderazgo, expansión o innovación que la empresa aspira alcanzar.</p>
                </div>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""card h-100 border-warning"">
                <div class=""card-header bg-warning text-dark fw-bold"">3. Los Valores</div>
                <div class=""card-body"">
                    <p class=""small text-secondary mb-1""><strong>¿Bajo qué principios actuamos?</strong></p>
                    <p class=""small mb-0"">Son las normas morales innegociables: honestidad, puntualidad, excelencia, respeto, vocación de servicio y trabajo en equipo.</p>
                </div>
            </div>
        </div>
    </div>

    <h5 class=""fw-bold text-dark""><i class=""bi bi-check2-circle text-success me-1""></i> El Valor de la Congruencia Laboral</h5>
    <p class=""small text-secondary"">Un buen colaborador no solo memoriza la misión de la empresa; la refleja en su trato al cliente, en el cuidado de las instalaciones y en su honestidad con sus compañeros de labores.</p>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 2: Ética Profesional, Confidencialidad y Código de Conducta",
                            LessonTitle = "La Integridad en el Ejercicio Diario del Trabajo",
                            Summary = "Conoce qué es la ética laboral, el código de conducta, la protección de información confidencial, secretos comerciales y la prevención de conflictos de interés.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-danger bg-opacity-10 border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold text-danger mb-1""><i class=""bi bi-shield-check me-1""></i> La Ética: El Activo más Valioso de un Profesional</h5>
        <p class=""mb-0 small text-dark"">Los conocimientos técnicos se pueden enseñar en días o semanas, pero la honestidad y la ética forman parte de la reputación intachable que abre puertas laborales para siempre.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-journal-text text-primary me-2""></i>Situaciones Clave de Ética en la Empresa</h4>
    <div class=""table-responsive mb-4"">
        <table class=""table table-hover table-bordered small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Área Ética</th>
                    <th>Conducta Esperada (Correcta)</th>
                    <th>Conducta Inaceptable (Falta Grave)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold"">Manejo de Bienes y Dinero</td>
                    <td>Custodiar con celo las cajas registradoras, inventarios, herramientas y vuelto del cliente.</td>
                    <td>Tomar dinero prestado de caja ('jineteo'), sustraer mercancía o alterar facturas.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">Confidencialidad</td>
                    <td>Proteger listas de clientes, precios de compra, claves de sistema y datos bancarios.</td>
                    <td>Filtrar datos a la competencia, fotografiar pantallas del ERP o publicar información en redes sociales.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">Conflictos de Interés</td>
                    <td>Trato imparcial y transparente con todos los proveedores y clientes de la empresa.</td>
                    <td>Aceptar sobornos, dádivas o favores de proveedores para favorecerlos en compras.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">Uso del Tiempo Laboral</td>
                    <td>Enfocarse en las funciones asignadas con disciplina durante la jornada de trabajo.</td>
                    <td>Usar el celular para ocio personal prolongado o realizar trabajos privados en horario laboral.</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 3: Disciplina Laboral, Puntualidad y Reglamento Interno de Trabajo",
                            LessonTitle = "Hábitos Profesionales: Presentación Personal, Horarios y Normas",
                            Summary = "Aprende el impacto de la puntualidad, el cumplimiento de los reglamentos internos de trabajo, el uso correcto de uniformes y la gestión responsable de permisos y ausencias.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-clock-history me-1""></i> La Puntualidad y el Reglamento Interno</h5>
        <p class=""mb-0 small"">La puntualidad es la primera muestra de respeto hacia el equipo y hacia los clientes. La disciplina laboral es el cimiento de la confianza entre el empleador y el empleado.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-card-checklist text-primary me-2""></i>Los Pilares de la Disciplina Profesional</h4>
    <ul>
        <li><strong>Llegar 10-15 minutos antes de la hora:</strong> Para cambiarse de ropa, colocarse el uniforme, preparar el puesto de trabajo y estar listo para atender al cliente en el minuto exacto de apertura.</li>
        <li><strong>Presentación Personal Impecable:</strong> Ropa limpia y planchada, carnet visible a la altura del pecho, aseo personal adecuado y uso correcto de zapatos antiresbalantes o de seguridad según el cargo.</li>
        <li><strong>Notificación Oportuna de Emergencias:</strong> En caso de fuerza mayor o enfermedad, avisar con la mayor anticipación posible al supervisor directo y presentar el justificativo médico oficial correspondiente.</li>
        <li><strong>Respeto al Reglamento Interno de Trabajo (RIT):</strong> Conocer los deberes, prohibiciones y sanciones disciplinarias estipuladas por la ley laboral y las políticas de la empresa.</li>
    </ul>

    <div class=""card border-0 bg-light p-3"">
        <h6 class=""fw-bold text-dark""><i class=""bi bi-chat-quote-fill text-warning me-1""></i> Regla de Oro:</h6>
        <p class=""small text-secondary mb-0"">«Si llegas a tiempo, ya llegaste tarde. Si llegas 10 minutos antes, estás a tiempo. Si llegas tarde, no tienes excusa». La confiabilidad de un colaborador se mide primero en el reloj de entrada.</p>
    </div>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 4: Relaciones Humanas, Diversidad y Clima Laboral Positivo",
                            LessonTitle = "Convivencia Armoniosa y Resolución Pacífica de Diferencias",
                            Summary = "Desarrolla habilidades de convivencia laboral: respeto mutuo, comunicación constructiva, erradicación del chisme y aporte activo a un clima de trabajo positivo.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-people me-1""></i> El Clima Organizacional lo Construimos Todos</h5>
        <p class=""mb-0 small"">Pasamos más de 8 horas al día conviviendo con nuestros compañeros de trabajo. Un ambiente laboral basado en el respeto y el compañerismo multiplica la productividad y el bienestar emocional.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-heart-pulse text-danger me-2""></i>Reglas de Oro para un Ambiente Laboral Sano</h4>
    <ol>
        <li><strong>Tolerancia cero al chisme o murmuración de pasillo:</strong> Si tienes una inquietud o problema con un compañero de trabajo, dialoga directamente con él en privado de forma respetuosa o canalízalo con tu supervisor.</li>
        <li><strong>Saludo diario y cortesía:</strong> Un «Buenos días», «Por favor» y «Muchas gracias» humaniza la rutina laboral y desarma tensiones entre turnos.</li>
        <li><strong>Reconocer el trabajo de los demás:</strong> Si un compañero tuvo una buena idea o colaboró para resolver una urgencia en tienda, dale el crédito públicamente.</li>
        <li><strong>Cuidar los espacios comunes:</strong> El comedor, los baños y las zonas de descanso deben dejarse limpios después de su uso. La educación y la consideración se notan en los detalles.</li>
    </ol>
</div>"
                        }
                    },
                    Quiz = new QuizData
                    {
                        Title = "Evaluación Sumativa: Filosofía Empresarial y Ética Laboral",
                        Questions = new List<QuestionData>
                        {
                            new QuestionData
                            {
                                QuestionText = "¿Cuál es la principal diferencia entre la 'Misión' y la 'Visión' de una empresa?",
                                Options = new[] { "La Misión define el propósito y razón de ser actual, mientras que la Visión proyecta la meta inspiradora hacia el futuro", "Son exactamente lo mismo con diferente nombre", "La Misión es para el departamento de ventas y la Visión es para el vigilante", "La Misión es el precio de los productos y la Visión es el logotipo" },
                                CorrectIndex = 0,
                                Explanation = "La Misión responde a quiénes somos y qué hacemos hoy; la Visión establece a dónde queremos llegar a mediano y largo plazo."
                            },
                            new QuestionData
                            {
                                QuestionText = "Si un proveedor ofrece a un empleado un 'regalo' o dinero en efectivo para que favorezca sus productos sobre otros, ¿cómo se califica esta situación?",
                                Options = new[] { "Una oportunidad de negocio personal válida", "Un conflicto de interés grave que atenta contra la ética laboral", "Una costumbre comercial que no necesita ser reportada", "Un bono salarial de fin de año" },
                                CorrectIndex = 1,
                                Explanation = "Aceptar dádivas o sobornos de proveedores constituye un conflicto de interés y una falta ética grave a la lealtad que se le debe a la empresa."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Qué debe hacer un colaborador si por una causa de fuerza mayor o emergencia médica no podrá asistir a su jornada laboral?",
                                Options = new[] { "No avisar y aparecer 3 días después sin decir nada", "Avisar a su supervisor inmediato con la mayor antelación posible y presentar su justificativo formal", "Apagar el teléfono para que no lo llamen", "Enviar a un amigo que no trabaja en la empresa en su reemplazo" },
                                CorrectIndex = 1,
                                Explanation = "La responsabilidad y el reglamento interno exigen avisar oportunamente para reorganizar el turno y presentar el aval médico oficial."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Por qué es tan importante la confidencialidad respecto a datos de clientes, precios de costo y contraseñas de la empresa?",
                                Options = new[] { "Porque no tiene importancia real en el mercado", "Porque su divulgación viola leyes de privacidad, daña la ventaja competitiva y puede causar pérdidas económicas", "Para que los amigos del empleado puedan ver los datos", "Solo aplica para directores generales, los empleados no tienen deber de confidencialidad" },
                                CorrectIndex = 1,
                                Explanation = "La información corporativa es propiedad de la empresa; su fuga compromete la seguridad, genera riesgos legales y ventajas indebidas a competidores."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Cuál es la forma correcta de actuar ante un desacuerdo o diferencia de criterio con un compañero de trabajo?",
                                Options = new[] { "Gritar delante de los clientes para imponerse", "Hablar mal del compañero a sus espaldas con otros empleados", "Conversar con madurez en privado buscando una solución constructiva, o acudir al supervisor directo", "Ignorar las tareas de trabajo para que el compañero falle" },
                                CorrectIndex = 2,
                                Explanation = "La resolución pacífica y profesional de discrepancias en privado protege el clima laboral y evita afectar la atención al público."
                            }
                        }
                    }
                },

                // =========================================================================
                // CURSO 3: ATENCIÓN AL CLIENTE PRESENCIAL Y COMUNICACIÓN ASERTIVA
                // =========================================================================
                new CourseData
                {
                    CategorySlug = "empleabilidad-desarrollo-idiomas",
                    Title = "Atención al Cliente Presencial, Comunicación Asertiva y Fidelización",
                    Slug = "atencion-al-cliente-presencial-fidelizacion",
                    ShortDescription = "Aprende el protocolo de bienvenida, lenguaje corporal, escucha activa, desactivación de reclamos mediante el método LAST y fidelización en mostrador.",
                    Level = "Básico",
                    EstimatedHours = 16,
                    BadgeColor = "success",
                    Modules = new List<ModuleData>
                    {
                        new ModuleData
                        {
                            Title = "Módulo 1: Protocolo de Bienvenida, Presencia y Primera Impresión en Mostrador",
                            LessonTitle = "Los Primeros 10 Segundos: Cómo Recibir al Cliente",
                            Summary = "Domina la regla de los primeros 10 segundos, el contacto visual, la postura corporal abierta y el protocolo de bienvenida que genera confianza inmediata.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-emoji-smile me-1""></i> La Primera Impresión Nunca se Repite</h5>
        <p class=""mb-0 small"">Un cliente toma solo entre 7 y 10 segundos para crearse una opinión sobre la tienda y sobre la persona que lo recibe. Una bienvenida cálida predispone positivamente toda la experiencia de compra.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-check-circle-fill text-success me-2""></i>El Protocolo de los 4 Pasos al Entrar un Cliente</h4>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-3"">
            <div class=""card h-100 border-0 bg-light p-3 text-center"">
                <i class=""bi bi-eye fs-2 text-primary mb-2""></i>
                <h6 class=""fw-bold"">1. Contacto Visual</h6>
                <p class=""small text-secondary mb-0"">Levanta la mirada de inmediato. Nunca permitas que un cliente espere a que termines de escribir en el teléfono o la computadora.</p>
            </div>
        </div>
        <div class=""col-md-3"">
            <div class=""card h-100 border-0 bg-light p-3 text-center"">
                <i class=""bi bi-emoji-smile-fill fs-2 text-warning mb-2""></i>
                <h6 class=""fw-bold"">2. Sonrisa Genuina</h6>
                <p class=""small text-secondary mb-0"">Un gesto facial amable transmite apertura, cercanía y disposición sincera a colaborar.</p>
            </div>
        </div>
        <div class=""col-md-3"">
            <div class=""card h-100 border-0 bg-light p-3 text-center"">
                <i class=""bi bi-chat-quote-fill fs-2 text-success mb-2""></i>
                <h6 class=""fw-bold"">3. Saludo Institucional</h6>
                <p class=""small text-secondary mb-0"">«¡Buenos días! Bienvenido a [Nombre de la Empresa], ¿en qué podemos servirle hoy?»</p>
            </div>
        </div>
        <div class=""col-md-3"">
            <div class=""card h-100 border-0 bg-light p-3 text-center"">
                <i class=""bi bi-ear-fill fs-2 text-danger mb-2""></i>
                <h6 class=""fw-bold"">4. Escucha Activa</h6>
                <p class=""small text-secondary mb-0"">Permite que el cliente explique lo que busca sin interrumpirlo ni adelantarte precipitadamente.</p>
            </div>
        </div>
    </div>

    <div class=""alert alert-warning border-0 rounded-3"">
        <h6 class=""fw-bold""><i class=""bi bi-telephone-x me-1""></i> Prohibición Absoluta:</h6>
        <p class=""small mb-0"">El uso del teléfono móvil personal en el mostrador o piso de venta mientras hay clientes presentes está estrictamente prohibido en toda empresa profesional. Destruye la imagen de la tienda.</p>
    </div>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 2: Comunicación Asertiva, Lenguaje Corporal y Empatía Comercial",
                            LessonTitle = "Cómo Decir las Cosas: Palabras Positivas y Postura Abierta",
                            Summary = "Aprende a transformar frases negativas en soluciones, la técnica del parafraseo, modulación de voz y cómo leer el lenguaje corporal del comprador.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-chat-dots me-1""></i> La Asertividad: Firmeza con Amabilidad</h5>
        <p class=""mb-0 small"">Ser asertivo significa expresar las políticas y posibilidades de la empresa de manera clara, segura y respetuosa, sin caer en la sumisión ni en la agresividad.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-arrow-left-right text-primary me-2""></i>Transformación de Frases: Del 'No' a la Solución</h4>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th class=""text-danger""><i class=""bi bi-x-circle me-1""></i> Frase Prohibida (Negativa)</th>
                    <th class=""text-success""><i class=""bi bi-check-circle me-1""></i> Frase Profesional (Asertiva y Proactiva)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>«No hay, se agotó.»</td>
                    <td class=""fw-bold"">«En este momento no nos quedan unidades de ese modelo exacto, pero permítame mostrarle esta excelente alternativa con características muy similares.»</td>
                </tr>
                <tr>
                    <td>«Ese no es mi departamento, pregúntele a otro.»</td>
                    <td class=""fw-bold"">«Con mucho gusto, permítame acompañarlo con mi compañero Carlos del área especializada para que le brinde el asesoramiento exacto.»</td>
                </tr>
                <tr>
                    <td>«Usted no tiene razón, está equivocado.»</td>
                    <td class=""fw-bold"">«Comprendo perfectamente su punto de vista; permítame explicarle cómo funciona la garantía para encontrar la mejor salida a su caso.»</td>
                </tr>
                <tr>
                    <td>«Ya cerramos la caja, venga mañana.»</td>
                    <td class=""fw-bold"">«Estamos concluyendo el proceso de cierre contable, pero con gusto le tomo su pedido de inmediato para tenerlo listo a primera hora.»</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 3: Técnicas de Manejo de Quejas, Reclamos y Clientes Exigentes (Método LAST)",
                            LessonTitle = "Manejo de Crisis en Mostrador: El Método L.A.S.T.",
                            Summary = "Aprende el método LAST (Listen, Apologize, Solve, Thank) para desescalar situaciones tensas, controlar las propias emociones y convertir un reclamo en una oportunidad de fidelización.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-danger bg-opacity-10 border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold text-danger mb-1""><i class=""bi bi-shield-slash me-1""></i> Cuando el Cliente Llega Molesto</h5>
        <p class=""mb-0 small text-dark"">Un cliente enfadado no ataca a tu persona; está frustrado con un producto o con una expectativa no cumplida. Mantener la calma y seguir un método probado evita que el conflicto escale.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-lightning-charge-fill text-warning me-2""></i>El Método L.A.S.T. para Desactivar Reclamos</h4>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""card border-primary h-100"">
                <div class=""card-body"">
                    <h5 class=""fw-bold text-primary"">L - Listen (Escuchar sin Interrumpir)</h5>
                    <p class=""small text-secondary mb-0"">Deja que el cliente exprese todo su malestar durante los primeros dos minutos. No lo contradigas mientras habla. Toma notas si es necesario. Esto reduce su adrenalina.</p>
                </div>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""card border-success h-100"">
                <div class=""card-body"">
                    <h5 class=""fw-bold text-success"">A - Apologize (Disculparse Empáticamente)</h5>
                    <p class=""small text-secondary mb-0"">Pide disculpas por el inconveniente o tiempo perdido en nombre de la empresa: «Lamento profundamente la molestia que esta falla le ha causado, señor Gómez».</p>
                </div>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""card border-warning h-100"">
                <div class=""card-body"">
                    <h5 class=""fw-bold text-warning-emphasis"">S - Solve (Resolver y Ofrecer Opciones)</h5>
                    <p class=""small text-secondary mb-0"">Presenta de inmediato la solución: cambio inmediato del producto por garantía, nota de crédito, o escalamiento con servicio técnico en un plazo concreto de 24 horas.</p>
                </div>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""card border-info h-100"">
                <div class=""card-body"">
                    <h5 class=""fw-bold text-info"">T - Thank (Agradecer la Retroalimentación)</h5>
                    <p class=""small text-secondary mb-0"">Agradece al cliente por hacértelo saber: «Le agradezco mucho que nos lo haya informado; esto nos ayuda a mejorar nuestros controles de calidad».</p>
                </div>
            </div>
        </div>
    </div>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 4: Experiencia de Servicio (CX), Postventa y Fidelización del Cliente",
                            LessonTitle = "Más Allá de la Venta: Generar Clientes Recurrentes y Recomendaciones",
                            Summary = "Conoce las claves del servicio postventa, seguimiento telefónico o por WhatsApp, entrega de garantías y cómo generar valor agregado para que el cliente siempre regrese.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-star-fill me-1""></i> La Fidelización es Más Rentable que Conseguir Clientes Nuevos</h5>
        <p class=""mb-0 small"">Cuesta hasta 5 veces más atraer a un cliente nuevo que retener a uno existente. El trato amable y el soporte postventa transforman a compradores ocasionales en embajadores de la marca.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-magic text-primary me-2""></i>Estrategias para Superar Expectativas</h4>
    <ul>
        <li><strong>Despedida Afectuosa y Memorable:</strong> Acompañar al cliente unos pasos hacia la salida, agradecer su visita y desearle un excelente día con una sonrisa.</li>
        <li><strong>Claridad en Políticas de Garantía:</strong> Entregar siempre la factura y explicar amablemente cómo aplica la garantía y los plazos de cambio sin letras pequeñas engañosas.</li>
        <li><strong>Contacto de Seguimiento:</strong> Para ventas técnicas o de alto valor, un mensaje de WhatsApp a las 48 horas preguntando: «Buenas tardes estimado, ¿logró instalar el equipo satisfactoriamente? Estamos a su orden» genera un impacto impresionante.</li>
        <li><strong>Toma de Datos para Fidelización:</strong> Registrar al cliente en el sistema para enviarle felicitaciones de cumpleaños o promociones exclusivas de su interés.</li>
    </ul>
</div>"
                        }
                    },
                    Quiz = new QuizData
                    {
                        Title = "Evaluación Sumativa: Atención al Cliente Presencial y Comunicación",
                        Questions = new List<QuestionData>
                        {
                            new QuestionData
                            {
                                QuestionText = "¿Cuáles son los 4 pasos fundamentales que deben aplicarse en los primeros 10 segundos al recibir a un cliente en la tienda?",
                                Options = new[] { "Contacto visual, sonrisa genuina, saludo institucional y escucha activa", "Pedirle que espere mientras se envía un mensaje de texto personal", "Preguntarle cuánto dinero trae en la billetera", "Ofrecerle el producto más caro sin saludarlo" },
                                CorrectIndex = 0,
                                Explanation = "El contacto visual, la sonrisa, el saludo y la escucha activa forman el protocolo de bienvenida que genera confianza inmediata."
                            },
                            new QuestionData
                            {
                                QuestionText = "En lugar de responder 'No hay, se agotó', ¿cuál es la respuesta asertiva y orientada a soluciones recomendada?",
                                Options = new[] { "Decirle que vaya a comprarlo en la competencia", "Explicar amablemente que no está disponible ese modelo exacto y ofrecerle de inmediato una alternativa de similar calidad", "Encogerse de hombros y retirarse", "Culpar a la gerencia de compras en voz alta" },
                                CorrectIndex = 1,
                                Explanation = "La atención proactiva orienta al cliente hacia alternativas viables en vez de cortar la interacción con una negativa cortante."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Qué significan las siglas del método L.A.S.T. para desactivar reclamos de clientes molestos?",
                                Options = new[] { "Listen, Apologize, Solve, Thank (Escuchar, Disculparse, Resolver, Agradecer)", "Llamar, Atacar, Salir, Terminar", "Limpiar, Almorzar, Sentarse, Trabajar", "Llorar, Asustarse, Saltar, Toser" },
                                CorrectIndex = 0,
                                Explanation = "El método LAST consiste en: Escuchar sin interrumpir (Listen), pedir disculpas por el problema (Apologize), ofrecer la solución (Solve) y agradecer la queja (Thank)."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Por qué el uso del teléfono celular personal en el mostrador para fines de ocio está prohibido en la atención al cliente?",
                                Options = new[] { "Porque transmite desinterés, falta de profesionalismo y hace sentir al cliente ignorado", "Porque gasta la batería del teléfono", "Porque el teléfono emite sonidos musicales atractivos", "No está prohibido, el empleado puede chatear libremente" },
                                CorrectIndex = 0,
                                Explanation = "El teléfono celular crea una barrera de distracción que deteriora gravemente la percepción del servicio y la imagen del negocio."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Por qué es tan valioso realizar un seguimiento postventa o contactar al cliente luego de adquirir un producto?",
                                Options = new[] { "Para cobrarle un recargo sorpresa", "Para verificar su satisfacción, afianzar la confianza y convertirlo en un cliente fiel recurrente", "Para pedirle que devuelva la factura", "No sirve de nada en el comercio" },
                                CorrectIndex = 1,
                                Explanation = "La postventa demuestra verdadero interés por el cliente, previene malentendidos con el producto y asegura compras futuras."
                            }
                        }
                    }
                },

                // =========================================================================
                // CURSO 4: AUXILIAR DE ALMACÉN, INVENTARIOS Y LOGÍSTICA BÁSICA
                // =========================================================================
                new CourseData
                {
                    CategorySlug = "empleabilidad-desarrollo-idiomas",
                    Title = "Auxiliar de Almacén, Control de Inventarios y Logística Básica",
                    Slug = "auxiliar-almacen-inventarios-logistica",
                    ShortDescription = "Aprende recepción de mercancía, cotejo contra facturas, zonificación de bodegas, rotación PEPS/FIFO, inventarios físicos y seguridad industrial.",
                    Level = "Básico",
                    EstimatedHours = 16,
                    BadgeColor = "warning",
                    Modules = new List<ModuleData>
                    {
                        new ModuleData
                        {
                            Title = "Módulo 1: Recepción de Mercancía y Cotejo Contra Facturas y Guías",
                            LessonTitle = "El Procedimiento de Entrada: Inspección Física y Documental",
                            Summary = "Domina el protocolo de descarga, conteo físico, revisión de bultos dañados, cotejo contra la guía de remisión del proveedor y firma de conformidad.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-truck me-1""></i> La Puerta de Entrada del Patrimonio Empresarial</h5>
        <p class=""mb-0 small"">El inventario es dinero en forma física. Un auxiliar de almacén que inspecciona rigurosamente la mercancía entrante protege a la empresa contra faltantes y pérdidas financieras.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-clipboard-check text-primary me-2""></i>Pasos Obligatorios al Recibir un Despacho</h4>
    <ol class=""list-group list-group-numbered mb-4"">
        <li class=""list-group-item""><strong>Verificación de Precintos y Embalaje:</strong> Comprobar que las cajas no presenten golpes, roturas, manchas de humedad o cintas adhesivas violadas antes de descargar.</li>
        <li class=""list-group-item""><strong>Conteo Bulto a Bulto / Pieza a Pieza:</strong> Jamás firmar una guía 'a ciegas'. Se deben contar las cantidades físicas exactas y comparar con la Guía de Despacho y la Orden de Compra.</li>
        <li class=""list-group-item""><strong>Inspección de Fechas de Vencimiento y Lotes:</strong> En alimentos, medicamentos o químicos, rechazar mercancía con fecha de caducidad menor a la política permitida (ej. mínimo 6 meses de vida útil).</li>
        <li class=""list-group-item""><strong>Firma y Estampado del Sello de Recepción:</strong> Si todo está conforme, se firma indicando nombre, fecha y hora. Si hay faltantes o mercancía rota, se debe colocar la nota explícita en la guía: «Se reciben 8 de 10 unidades por daño evidente en 2 cajas».</li>
    </ol>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 2: Zonificación de Bodega y Rotación de Stock (Método PEPS/FIFO)",
                            LessonTitle = "Organización del Espacio y Rotación Inteligente de Mercancía",
                            Summary = "Aprende cómo zonificar un almacén (zona de recepción, almacenaje, picking y despacho) y cómo garantizar la rotación PEPS para evitar obsolescencia.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-grid-3x3-gap me-1""></i> Un Lugar para Cada Cosa y Cada Cosa en su Lugar</h5>
        <p class=""mb-0 small"">El desorden en bodega genera demoras en despachos, accidentes laborales y pérdidas de productos por caducidad o deterioro.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-boxes text-primary me-2""></i>1. Zonificación Básica de Bodega</h4>
    <ul>
        <li><strong>Zona de Carga y Descarga:</strong> Área amplia y despejada cerca del portón de acceso para camiones.</li>
        <li><strong>Zona de Cuarentena / Devoluciones:</strong> Espacio delimitado en amarillo donde se colocan productos averiados o en reclamo con proveedores para evitar que se mezclen con el stock vendible.</li>
        <li><strong>Zona de Almacenamiento General:</strong> Estanterías codificadas por pasillos, columnas y niveles (ej. Pasillo A, Estante 03, Nivel 02).</li>
        <li><strong>Zona de Picking y Despacho:</strong> Mesón donde se agrupan y embalan los pedidos facturados listos para ser entregados.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-arrow-repeat text-success me-2""></i>2. La Regla Inquebrantable: PEPS / FIFO</h4>
    <p><strong>Primero en Entrar, Primero en Salir:</strong> La mercancía más antigua debe colocarse al frente o arriba para despacharse primero. La mercancía recién llegada del camión se almacena detrás o al fondo.</p>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 3: Toma Física de Inventarios, Conteos Cíclicos y Control de Mermas",
                            LessonTitle = "Conteo Físico vs Saldo en Sistema: Prevención de Mermas",
                            Summary = "Conoce las diferencias entre inventario general y conteo cíclico diario, cómo identificar mermas y cómo reportar discrepancias al supervisor.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-calculator me-1""></i> La Exactitud de Inventario (Inventory Accuracy)</h5>
        <p class=""mb-0 small"">Si el sistema dice que hay 15 unidades de un televisor o de un repuesto, físicamente en la estantería deben haber exactamente 15 unidades. Las discrepancias paralizan las ventas.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-check2-square text-primary me-2""></i>Técnicas de Conteo Físico</h4>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""card h-100 border-0 bg-light p-3"">
                <h6 class=""fw-bold text-dark""><i class=""bi bi-arrow-clockwise text-primary me-1""></i> Conteos Cíclicos Diarios (Recomendado)</h6>
                <p class=""small text-secondary mb-0"">Consiste en contar cada día 1 o 2 estanterías o una categoría específica (ej. lunes tornillería, martes herramientas eléctricas). No interrumpe la operación de la empresa y detecta desvíos al instante.</p>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""card h-100 border-0 bg-light p-3"">
                <h6 class=""fw-bold text-dark""><i class=""bi bi-calendar-event text-danger me-1""></i> Inventario General / Anual</h6>
                <p class=""small text-secondary mb-0"">Se paraliza la empresa por 1 o 2 días y todo el personal cuenta el 100% de los artículos de la bodega para balance de cierre contable y fiscal.</p>
            </div>
        </div>
    </div>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 4: Seguridad en Almacén, Ergonomía de Carga y Uso de EPP",
                            LessonTitle = "Prevención de Accidentes y Salud Ocupacional en Bodega",
                            Summary = "Aprende técnicas seguras de levantamiento de cargas pesadas, postura ergonómica, uso de Equipos de Protección Personal (botas, fajas, guantes) y orden y limpieza.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-danger bg-opacity-10 border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold text-danger mb-1""><i class=""bi bi-shield-shaded me-1""></i> La Seguridad es lo Primero</h5>
        <p class=""mb-0 small text-dark"">En un almacén se manipulan cargas pesadas, transpaletas y alturas. Cumplir las normas de seguridad previene lesiones lumbares permanentes y accidentes graves.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-person-arms-up text-primary me-2""></i>Ergonomía en el Levantamiento Manual de Cargas</h4>
    <ul>
        <li><strong>Flexionar las rodillas, no la cintura:</strong> Mantener la espalda recta y usar la fuerza de las piernas para levantar el peso.</li>
        <li><strong>Mantener la carga pegada al cuerpo:</strong> Cuanto más lejos del pecho esté la carga, mayor es la presión destructiva sobre las vértebras lumbares.</li>
        <li><strong>Límite de peso individual:</strong> Como norma general, no levantar más de 25 kg de manera individual; para pesos superiores, solicitar ayuda a un compañero o usar carretilla/transpaleta.</li>
        <li><strong>Uso obligatorio de EPP:</strong> Botas de seguridad con puntera de acero, guantes antideslizantes de carnaza y casco en zonas de estanterías altas.</li>
    </ul>
</div>"
                        }
                    },
                    Quiz = new QuizData
                    {
                        Title = "Evaluación Sumativa: Auxiliar de Almacén y Logística",
                        Questions = new List<QuestionData>
                        {
                            new QuestionData
                            {
                                QuestionText = "¿Qué debe hacer un auxiliar de almacén si al recibir un camión detecta que 3 cajas de mercancía vienen golpeadas y con el contenido roto?",
                                Options = new[] { "Firmar la guía conforme sin mirar y botar las cajas rotas a la basura", "Anotar la observación explícita del daño y la cantidad afectada en la guía de remisión antes de firmar con el chofer", "Esconder las cajas detrás de las estanterías", "Culpar al cajero de la tienda" },
                                CorrectIndex = 1,
                                Explanation = "Toda avería o faltante debe asentarse formalmente por escrito en la guía del transportista para que proceda el reclamo al proveedor."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿En qué consiste el principio logístico PEPS / FIFO en la gestión de almacén?",
                                Options = new[] { "Primero en Entrar, Primero en Salir: La mercancía más antigua se despacha primero para evitar caducidad", "Pagar En Pocos Segundos", "Poner el producto más caro siempre escondido", "Primero en Salir, Primero en Entrar" },
                                CorrectIndex = 0,
                                Explanation = "PEPS (FIFO) garantiza que los lotes más antiguos salgan antes que los recién llegados, evitando mermas por vencimiento."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Cuál es la principal ventaja de realizar 'Conteos Cíclicos' frecuentes en lugar de esperar solo al inventario anual?",
                                Options = new[] { "Permite detectar y corregir descuadres de stock a tiempo sin detener las operaciones de la empresa", "Hace que el almacén cierre todos los días", "Elimina la necesidad de usar sistemas computarizados", "Aumenta las mermas de productos" },
                                CorrectIndex = 0,
                                Explanation = "Los conteos cíclicos auditan inventarios de forma continua sin paralizar las ventas y mantienen la exactitud de stock al día."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Cuál es la técnica ergonómica correcta para levantar una caja pesada del suelo?",
                                Options = new[] { "Doblar la cintura con las piernas totalmente rígidas", "Flexionar las rodillas, mantener la espalda recta y usar la fuerza de las piernas pegando la carga al pecho", "Levantar la carga girando bruscamente el tronco", "Patear la caja hacia la salida" },
                                CorrectIndex = 1,
                                Explanation = "Flexionar las rodillas con la columna recta traslada el esfuerzo a los cuádriceps, protegiendo los discos de la columna lumbar."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Qué función cumple el área de 'Cuarentena' en una bodega bien estructurada?",
                                Options = new[] { "Separar e identificar mercancía averiada, vencida o en reclamo para que no se mezcle con el inventario apto para la venta", "Comedor para los choferes de camiones", "Lugar para guardar las pertenencias personales de los clientes", "Zona para almacenar el dinero de caja" },
                                CorrectIndex = 0,
                                Explanation = "El área de cuarentena aísla físicamente los productos no conformes evitando despachos erróneos a clientes."
                            }
                        }
                    }
                },

                // =========================================================================
                // CURSO 5: TRABAJO EN EQUIPO Y HABILIDADES BLANDAS
                // =========================================================================
                new CourseData
                {
                    CategorySlug = "empleabilidad-desarrollo-idiomas",
                    Title = "Trabajo en Equipo, Liderazgo Personal y Productividad Laboral",
                    Slug = "trabajo-en-equipo-habilidades-blandas-productividad",
                    ShortDescription = "Desarrolla las competencias blandas más cotizadas: colaboración, matriz de Eisenhower para priorizar el tiempo, feedback constructivo y proactividad.",
                    Level = "Básico",
                    EstimatedHours = 14,
                    BadgeColor = "secondary",
                    Modules = new List<ModuleData>
                    {
                        new ModuleData
                        {
                            Title = "Módulo 1: Equipos de Trabajo de Alto Desempeño y Sinergia Laboral",
                            LessonTitle = "De Grupo a Equipo: La Sinergia en el Trabajo",
                            Summary = "Aprende qué diferencia a un simple grupo de personas de un verdadero equipo con metas compartidas, confianza mutua y roles complementarios.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-secondary border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-people-fill me-1""></i> El Poder de la Sinergia Laboral</h5>
        <p class=""mb-0 small"">Sinergia significa que el resultado del equipo unido es mucho mayor que la suma de los esfuerzos individuales aislados: $1 + 1 = 3$. Las empresas no buscan estrellas solitarias, buscan profesionales capaces de sumar.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-diagram-3 text-primary me-2""></i>Las 5 'C' del Trabajo en Equipo</h4>
    <ol class=""list-group list-group-numbered mb-4"">
        <li class=""list-group-item""><strong>Complementariedad:</strong> Cada miembro domina una parte del trabajo (ventas, técnica, logística) y juntos forman un engranaje completo.</li>
        <li class=""list-group-item""><strong>Comunicación:</strong> Los datos y las novedades fluyen abiertamente entre compañeros sin retener información por egoísmo.</li>
        <li class=""list-group-item""><strong>Coordinación:</strong> Actuar con orden bajo el liderazgo del supervisor para evitar choques y duplicidad de esfuerzos.</li>
        <li class=""list-group-item""><strong>Confianza:</strong> Cada colaborador sabe que puede apoyarse en su compañero porque este cumplirá su parte del compromiso.</li>
        <li class=""list-group-item""><strong>Compromiso:</strong> Cada integrante aporta lo mejor de sí mismo para alcanzar la meta colectiva de la jornada.</li>
    </ol>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 2: Gestión del Tiempo y Priorización Diaria (Matriz de Eisenhower)",
                            LessonTitle = "Organizar la Jornada: Diferenciar lo Urgente de lo Importante",
                            Summary = "Domina la matriz de Eisenhower para organizar tu día, eliminar los ladrones de tiempo y cumplir las tareas prioritarias sin estrés.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-hourglass-split me-1""></i> El Tiempo es un Recurso No Renovable</h5>
        <p class=""mb-0 small"">No se trata de trabajar más horas, sino de trabajar con mayor enfoque. Quien sabe priorizar sus tareas produce el doble con menor desgaste mental.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-grid-fill text-primary me-2""></i>La Matriz de Prioridades de Eisenhower</h4>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""card border-danger h-100"">
                <div class=""card-header bg-danger text-white fw-bold"">1. Urgente e Importante (HACER YA)</div>
                <div class=""card-body"">
                    <p class=""small mb-0"">Crisis inmediatas, un cliente molesto esperando en mostrador, un corte eléctrico en caja o un despacho con hora límite de salida.</p>
                </div>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""card border-primary h-100"">
                <div class=""card-header bg-primary text-white fw-bold"">2. Importante pero NO Urgente (PLANIFICAR)</div>
                <div class=""card-body"">
                    <p class=""small mb-0"">Capacitación, mantenimiento preventivo de equipos, limpieza de bodega y organización de planogramas. Si no se planifica, se convertirá en crisis urgente mañana.</p>
                </div>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""card border-warning h-100"">
                <div class=""card-header bg-warning text-dark fw-bold"">3. Urgente pero NO Importante (DELEGAR)</div>
                <div class=""card-body"">
                    <p class=""small mb-0"">Interrupciones menores, responder correos rutinarios o atender llamadas de proveedores que pueden resolverse con mensajes rápidos.</p>
                </div>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""card border-secondary h-100"">
                <div class=""card-header bg-secondary text-white fw-bold"">4. Ni Urgente ni Importante (ELIMINAR)</div>
                <div class=""card-body"">
                    <p class=""small mb-0"">Ladrones de tiempo: revisar redes sociales, chismes de pasillo y distracciones innecesarias durante la jornada.</p>
                </div>
            </div>
        </div>
    </div>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 3: Comunicación Constructiva y Retroalimentación Efectiva (Feedback)",
                            LessonTitle = "Cómo Dar y Recibir Sugerencias sin Ofenderse",
                            Summary = "Aprende la técnica del feedback constructivo, cómo recibir observaciones de un supervisor con madurez y cómo plantear mejoras a compañeros.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-arrow-left-right me-1""></i> La Retroalimentación es el Desayuno de los Campeones</h5>
        <p class=""mb-0 small"">Recibir una llamada de atención o sugerencia de un supervisor no es un ataque personal; es una oportunidad valiosa para corregir errores antes de que se vuelvan hábitos dañinos.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-chat-heart text-primary me-2""></i>Reglas de Oro del Feedback Profesional</h4>
    <ul>
        <li><strong>Felicitar en público, corregir en privado:</strong> Nunca expongas los errores de un compañero delante de clientes u otros empleados.</li>
        <li><strong>Enfocarse en la conducta y no en la persona:</strong> Di: «El reporte se entregó sin el cuadre bancario», en lugar de: «Tú eres descuidado y flojo».</li>
        <li><strong>Escuchar con humildad y sin defensividad:</strong> Si tu jefe te señala un error, respira, agradece el señalamiento y di: «Entendido, voy a corregirlo de inmediato para que no vuelva a ocurrir».</li>
    </ul>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 4: Proactividad, Iniciativa y Adaptabilidad ante el Cambio",
                            LessonTitle = "De Empleado Pasivo a Colaborador de Alto Valor",
                            Summary = "Supera la actitud de 'ese no es mi trabajo'. Descubre cómo anticiparte a las necesidades de la tienda, aportar soluciones y convertirte en una persona indispensable.",
                            DurationMinutes = 25,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 mb-4"">
        <h5 class=""fw-bold mb-1""><i class=""bi bi-rocket-takeoff me-1""></i> Ser Proactivo vs Ser Reactivo</h5>
        <p class=""mb-0 small"">El empleado reactivo espera que siempre le ordenen qué hacer y dice «a mí no me dijeron nada». El colaborador proactivo observa el entorno, detecta qué hace falta y actúa con responsabilidad.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-lightbulb text-warning me-2""></i>Acciones Proactivas que Impulsan tu Carrera</h4>
    <ul>
        <li>Si no hay clientes en la tienda, no te sientes a esperar: endereza la mercancía, limpia las vitrinas o ayuda en almacén.</li>
        <li>Si notas un problema recurrente, no te quejes sin más: lleva al supervisor el problema junto con dos posibles soluciones prácticas.</li>
        <li>Aprende constantemente: muestra interés por conocer cómo funcionan otros departamentos de la empresa. Esa versatilidad te convierte en el primer candidato a ascensos.</li>
    </ul>
</div>"
                        }
                    },
                    Quiz = new QuizData
                    {
                        Title = "Evaluación Sumativa: Trabajo en Equipo y Productividad",
                        Questions = new List<QuestionData>
                        {
                            new QuestionData
                            {
                                QuestionText = "¿Qué significa la palabra 'Sinergia' aplicada al trabajo en equipo dentro de una empresa?",
                                Options = new[] { "Que cada quien trabaje por su cuenta sin hablarse", "Que la unión coordinada de esfuerzos produce un resultado colectivo mucho mayor que la suma individual de las partes", "Que un solo empleado haga todo el trabajo y los demás descansen", "Que la empresa cierre operaciones los viernes" },
                                CorrectIndex = 1,
                                Explanation = "La sinergia multiplica el rendimiento cuando el equipo colabora con un propósito común y roles complementarios."
                            },
                            new QuestionData
                            {
                                QuestionText = "Según la Matriz de Eisenhower, ¿a qué cuadrante pertenecen tareas cruciales como la capacitación y el orden preventivo del almacén?",
                                Options = new[] { "Importante pero NO Urgente (Se deben planificar para evitar que se conviertan en crisis)", "Ni importante ni urgente", "Urgente e irrelevante", "Pérdida de tiempo" },
                                CorrectIndex = 0,
                                Explanation = "Las tareas importantes no urgentes son las que garantizan el crecimiento y previenen futuras urgencias si se planifican con tiempo."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Cuál es la regla fundamental para dar una retroalimentación o llamada de atención a un compañero de trabajo?",
                                Options = new[] { "Gritarle delante de los clientes para que aprenda", "Felicitar en público y corregir en privado con respeto y enfoque en la conducta objetiva", "Burlarse en el grupo de WhatsApp", "Ignorar el error y dejar que la tienda sufra pérdidas" },
                                CorrectIndex = 1,
                                Explanation = "Corregir en privado y enfocado en hechos objetivos cuida la dignidad de la persona y propicia un cambio positivo."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Qué caracteriza a un colaborador con actitud 'proactiva' en el puesto de trabajo?",
                                Options = new[] { "Sentarse a mirar el celular cuando no hay clientes", "Anticiparse a las necesidades de la tienda, colaborar con sus compañeros y aportar soluciones en lugar de quejas", "Decir 'a mí no me pagan para barrer'", "Llegar siempre 20 minutos tarde" },
                                CorrectIndex = 1,
                                Explanation = "La proactividad consiste en tomar la iniciativa responsable para resolver problemas y mejorar el entorno sin esperar órdenes continuas."
                            },
                            new QuestionData
                            {
                                QuestionText = "Cuando un supervisor señala un error en una tarea realizada por un colaborador, ¿cuál es la respuesta más profesional que este debe dar?",
                                Options = new[] { "Enojarse y renunciar de inmediato", "Culpar a todos sus compañeros de equipo", "Escuchar con madurez, reconocer la falla con humildad y comprometerse a corregirla de inmediato", "Decir que el sistema siempre se equivoca" },
                                CorrectIndex = 2,
                                Explanation = "La madurez profesional se demuestra asumiendo la responsabilidad y actuando con prontitud para rectificar."
                            }
                        }
                    }
                }
            };
        }
    }
}
