using CursosCertificadosApp.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace CursosCertificadosApp.Data
{
    public static class NewPracticalCoursesSeeder
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
            // 1. Asegurar categorías requeridas
            var catTech = await context.Categories.FirstOrDefaultAsync(c => c.Slug == "tecnologia-ia-ofimatica");
            if (catTech == null)
            {
                catTech = new Category
                {
                    Name = "Tecnología, IA y Ofimática",
                    Slug = "tecnologia-ia-ofimatica",
                    Description = "Cursos de software, sistemas, comercio electrónico y herramientas digitales de alta demanda.",
                    IconClass = "bi-laptop",
                    DisplayOrder = 1
                };
                context.Categories.Add(catTech);
                await context.SaveChangesAsync();
            }

            var catEmploy = await context.Categories.FirstOrDefaultAsync(c => c.Slug == "empleabilidad-desarrollo-idiomas");
            if (catEmploy == null)
            {
                catEmploy = new Category
                {
                    Name = "Empleabilidad, Ventas y Gestión Comercial",
                    Slug = "empleabilidad-desarrollo-idiomas",
                    Description = "Formación en ventas, trade marketing, atención al cliente y supervisión de piso.",
                    IconClass = "bi-briefcase",
                    DisplayOrder = 2
                };
                context.Categories.Add(catEmploy);
                await context.SaveChangesAsync();
            }

            var categories = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase)
            {
                { "tecnologia-ia-ofimatica", catTech.Id },
                { "empleabilidad-desarrollo-idiomas", catEmploy.Id }
            };

            var courses = GetNewCoursesData();

            foreach (var courseData in courses)
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
                    course.CategoryId = catId;
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

        private static List<CourseData> GetNewCoursesData()
        {
            return new List<CourseData>
            {
                // =========================================================================================
                // 1. SAP BUSINESS ONE (SAP B1) BÁSICO
                // =========================================================================================
                new CourseData
                {
                    CategorySlug = "tecnologia-ia-ofimatica",
                    Title = "SAP Business One (SAP B1): Gestión Operativa de Ventas, Compras e Inventarios",
                    Slug = "sap-business-one-b1-gestion-operativa",
                    ShortDescription = "Domina la navegación en SAP B1, creación de Socios de Negocios, circuito de marketing de ventas, gestión de inventarios y trazabilidad con el Mapa de Relaciones.",
                    Level = "Básico",
                    EstimatedHours = 18,
                    BadgeColor = "primary",
                    Modules = new List<ModuleData>
                    {
                        new ModuleData
                        {
                            Title = "Módulo 1: Introducción a SAP Business One y Navegación del Sistema",
                            LessonTitle = "Interfaz, Menús Principales, Búsqueda y Conceptos ERP",
                            Summary = "Conoce la arquitectura de SAP B1, barra de herramientas, modos Buscar vs. Crear, y cómo navegar con flechas naranjas de enlace.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Introducción al Ecosistema SAP Business One</h4>
<p><strong>SAP Business One (SAP B1)</strong> es el sistema ERP (<em>Enterprise Resource Planning</em>) líder para pequeñas y medianas empresas. Integra en una única base de datos compartida todas las áreas operativas: Ventas, Compras, Gestión de Inventario, Finanzas y Producción.</p>

<div class=""row g-3 my-3"">
    <div class=""col-md-6"">
        <div class=""card p-3 border-primary h-100"">
            <h5 class=""fw-bold text-primary""><i class=""bi bi-arrow-right-circle-fill me-1""></i> Flechas Naranjas (Link Arrows)</h5>
            <p class=""small text-muted mb-0"">En SAP B1, cada campo con una pequeña flecha naranja permite navegar instantáneamente al registro maestro (por ejemplo, del código de cliente a su ficha completa de Socio de Negocio).</p>
        </div>
    </div>
    <div class=""col-md-6"">
        <div class=""card p-3 border-success h-100"">
            <h5 class=""fw-bold text-success""><i class=""bi bi-search me-1""></i> Modos de Trabajo: Buscar vs. Crear</h5>
            <p class=""small text-muted mb-0"">Los formularios se abren en modo <strong>Buscar</strong> (campos amarillos) con Ctrl+F. Para crear un nuevo registro, se pasa a modo <strong>Crear</strong> (Ctrl+A, campos en blanco).</p>
        </div>
    </div>
</div>

<h4>2. Estructura Estándar de los Documentos de Marketing</h4>
<p>Todos los documentos en SAP B1 (Cotización, Pedido, Entrega, Factura) comparten una arquitectura uniforme en tres niveles:</p>
<ul>
    <li><strong>Cabecera:</strong> Datos del Socio de Negocios (Código, Nombre, Persona de Contacto, Moneda, Fecha de Contabilización).</li>
    <li><strong>Contenido / Líneas:</strong> Artículos solicitados, cantidad, precio unitario, almacén de destino y descuentos.</li>
    <li><strong>Pie de Documento:</strong> Subtotal, cálculo de impuestos (IVA), redondeo, comentarios y total general.</li>
</ul>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 2: Maestros de Artículos y Control de Inventarios en Almacenes",
                            LessonTitle = "Datos Maestros de Artículo, Métodos de Valoración y Almacenes",
                            Summary = "Aprende a dar de alta artículos, definir unidades de medida, métodos de costeo (FIFO, Ponderado) y consultar stock comprometido vs. disponible.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Datos Maestros del Artículo (OITM)</h4>
<p>La ficha maestra del artículo centraliza la información técnica, comercial y contable de cada producto. Contiene pestañas esenciales:</p>
<div class=""table-responsive my-3"">
    <table class=""table table-bordered table-striped"">
        <thead class=""table-dark"">
            <tr>
                <th>Pestaña</th>
                <th>Datos Clave</th>
                <th>Importancia Operativa</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>General</strong></td>
                <td>Tipo de artículo (Inventario, Venta, Compra)</td>
                <td>Determina si el artículo descuenta stock y si puede facturarse.</td>
            </tr>
            <tr>
                <td><strong>Datos de Inventario</strong></td>
                <td>Stock actual, Comprometido, Solicitado y Disponible</td>
                <td>Fórmula: <code>Disponible = En Stock - Comprometido + Solicitado</code>.</td>
            </tr>
            <tr>
                <td><strong>Datos de Venta / Compra</strong></td>
                <td>Unidad de medida (Cajas, Unidades), Código de barras</td>
                <td>Asegura el cálculo correcto de bultos y lectura en punto de venta.</td>
            </tr>
        </tbody>
    </table>
</div>

<h4>2. Entradas y Salidas de Mercancía Manuales</h4>
<p>Cuando ocurren ajustes de inventario, tomas físicas o mermas que no provienen de compras o ventas, se utilizan las transacciones de <strong>Entrada de Mercancía</strong> y <strong>Salida de Mercancía</strong>, asignando siempre la cuenta contable y almacén correspondiente.</p>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 3: El Circuito de Ventas: De la Cotización a la Factura de Deudores",
                            LessonTitle = "Flujo Completo de Ventas y Trazabilidad con el Mapa de Relaciones",
                            Summary = "Crea ofertas de venta, pedidos de clientes, guías de entrega y facturas de clientes, copiando documentos de destino a origen.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. El Circuito Comercial Estándar en SAP B1</h4>
<p>En el módulo de <strong>Ventas - Clientes</strong>, los documentos siguen una secuencia cronológica vinculada:</p>
<ol class=""lead fs-6"">
    <li><strong>Oferta de Venta (Cotización):</strong> Propuesta comercial sin impacto contable ni de inventario.</li>
    <li><strong>Orden de Venta (Pedido):</strong> Compromete el inventario físico (aumenta el valor 'Comprometido').</li>
    <li><strong>Entrega (Guía de Despacho):</strong> Descuenta físicamente el stock del almacén y genera asiento de costo de ventas.</li>
    <li><strong>Factura de Clientes (Factura de Deudores):</strong> Genera la cuenta por cobrar, registra el ingreso fiscal y cierra la entrega.</li>
</ol>

<div class=""alert alert-warning border-0 my-3"">
    <strong><i class=""bi bi-exclamation-triangle-fill me-1""></i> La Regla de Oro 'Copiar De / Copiar A':</strong> Nunca se debe volver a tipear los artículos en cada paso. Siempre se usa el botón <strong>Copiar a</strong> o <strong>Copiar de</strong> para heredar precios, líneas y mantener la trazabilidad documental.
</div>

<h4>2. El Mapa de Relaciones</h4>
<p>Haciendo clic derecho sobre cualquier documento y seleccionando <strong>Mapa de Relaciones</strong>, SAP B1 muestra gráficamente todo el árbol documental: desde la cotización original, pedido, entrega, factura hasta el pago recibido en tesorería.</p>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 4: Circuito de Compras, Informes Operativos y Gestión de Socios",
                            LessonTitle = "Pedidos a Proveedores, Entradas de Mercancía y Reportes de Stock",
                            Summary = "Aprende el flujo de compras a proveedores, verificación de precios y cómo extraer informes de inventario y saldos de clientes.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Circuito de Compras a Proveedores</h4>
<p>El flujo en <strong>Compras - Proveedores</strong> es el reflejo inverso del de ventas:</p>
<ul>
    <li><strong>Pedido de Compra:</strong> Notifica al proveedor y aumenta el stock 'Solicitado'.</li>
    <li><strong>Entrada de Mercancías por Compras (EMPC):</strong> Ingresa físicamente los productos al almacén y actualiza el costo ponderado.</li>
    <li><strong>Factura de Proveedores:</strong> Contabiliza la cuenta por pagar y el crédito fiscal.</li>
</ul>

<h4>2. Reportes e Informes Clave para la Toma de Decisiones</h4>
<p>Los tres reportes más consultados en el día a día operativo son:</p>
<ul>
    <li><strong>Informe de Auditoría de Stock:</strong> Historial completo de movimientos de cada artículo por fecha y almacén.</li>
    <li><strong>Lista de Partidas Abiertas:</strong> Muestra pedidos pendientes de entregar o facturar.</li>
    <li><strong>Antigüedad de Saldos de Clientes:</strong> Detalla qué clientes tienen facturas vencidas para cobranza.</li>
</ul>"
                        }
                    },
                    Quiz = new QuizData
                    {
                        Title = "Evaluación Sumativa: Fundamentos Operativos de SAP Business One (SAP B1)",
                        Questions = new List<QuestionData>
                        {
                            new QuestionData
                            {
                                QuestionText = "¿Qué función cumple la pequeña flecha naranja que aparece junto a ciertos campos en SAP Business One?",
                                Options = new[]
                                {
                                    "Eliminar inmediatamente el registro seleccionado del sistema.",
                                    "Abrir directamente el dato maestro o documento de origen vinculado.",
                                    "Imprimir el documento en formato fiscal obligatorio.",
                                    "Cambiar el color de la interfaz de usuario."
                                },
                                CorrectIndex = 1,
                                Explanation = "La flecha naranja es el elemento de navegación insignia de SAP B1 y permite abrir la ficha del dato maestro o documento relacionado con un solo clic."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Cuál es la fórmula para calcular el 'Inventario Disponible' en el dato maestro de artículo de SAP B1?",
                                Options = new[]
                                {
                                    "Stock Disponible = En Stock + Comprometido + Solicitado",
                                    "Stock Disponible = En Stock - Comprometido + Solicitado",
                                    "Stock Disponible = Comprometido - Solicitado",
                                    "Stock Disponible = En Stock / 2"
                                },
                                CorrectIndex = 1,
                                Explanation = "El stock disponible real resta lo que ya está apartado para pedidos de clientes (Comprometido) y suma las órdenes de compra ya colocadas a proveedores (Solicitado)."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Cuál de los siguientes documentos es el que descuenta físicamente la mercancía del almacén en el ciclo de ventas?",
                                Options = new[]
                                {
                                    "Oferta de Venta (Cotización)",
                                    "Orden de Venta (Pedido de Cliente)",
                                    "Entrega (Guía de Despacho)",
                                    "Llamada de Servicio"
                                },
                                CorrectIndex = 2,
                                Explanation = "El documento de Entrega es el que registra la salida física de inventario del almacén y genera el asiento contable de costo de venta."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Para qué sirve la herramienta 'Mapa de Relaciones' en SAP B1?",
                                Options = new[]
                                {
                                    "Para ver el organigrama jerárquico de los empleados de la empresa.",
                                    "Para visualizar de forma gráfica todos los documentos encadenados (cotización, pedido, entrega, factura y pago).",
                                    "Para diseñar la disposición física de los anaqueles en el almacén.",
                                    "Para cambiar la tasa de cambio de las monedas extranjeras."
                                },
                                CorrectIndex = 1,
                                Explanation = "El Mapa de Relaciones permite visualizar gráficamente la cadena documental completa y el estado de cada documento vinculado."
                            },
                            new QuestionData
                            {
                                QuestionText = "Al pasar de una Cotización a una Orden de Venta, ¿cuál es la mejor práctica recomendada en SAP B1?",
                                Options = new[]
                                {
                                    "Escribir manualmente los artículos y precios desde cero en una ventana nueva.",
                                    "Utilizar la función 'Copiar a' o 'Copiar de' para transferir los datos y mantener la trazabilidad.",
                                    "Eliminar la cotización previa para que no ocupe espacio en la base de datos.",
                                    "Tomar una captura de pantalla y adjuntarla en un correo electrónico."
                                },
                                CorrectIndex = 1,
                                Explanation = "Utilizar 'Copiar a' o 'Copiar de' ahorra tiempo, evita errores de transcripción y garantiza la trazabilidad documental en el Mapa de Relaciones."
                            }
                        }
                    }
                },

                // =========================================================================================
                // 2. SHOPIFY BÁSICO: COMERCIO ELECTRÓNICO Y GESTIÓN DE TIENDAS ONLINE
                // =========================================================================================
                new CourseData
                {
                    CategorySlug = "tecnologia-ia-ofimatica",
                    Title = "Shopify Básico: Creación, Configuración y Gestión de Tiendas Online",
                    Slug = "shopify-comercio-electronico-tiendas-online",
                    ShortDescription = "Aprende a configurar tu tienda en Shopify: catálogo de productos, colecciones, pasarelas de pago, logística de envíos y procesamiento eficiente de pedidos.",
                    Level = "Básico",
                    EstimatedHours = 16,
                    BadgeColor = "success",
                    Modules = new List<ModuleData>
                    {
                        new ModuleData
                        {
                            Title = "Módulo 1: Arquitectura de Shopify y Configuración General de la Tienda",
                            LessonTitle = "Panel de Control, Dominio, Moneda, Impuestos y Políticas Legales",
                            Summary = "Familiarízate con el panel administrativo de Shopify, configuración de monedas (USD / Bolívares), páginas informativas y términos legales obligatorios.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. ¿Qué es Shopify y cómo funciona el modelo SaaS?</h4>
<p><strong>Shopify</strong> es la plataforma de comercio electrónico líder a nivel mundial que aloja y gestiona tiendas online sin necesidad de configurar servidores web ni bases de datos manuales. Su modelo <em>Software as a Service (SaaS)</em> garantiza alta disponibilidad y pasarelas de pago seguras con certificación PCI-DSS.</p>

<h4>2. Primeros Pasos en la Configuración Global</h4>
<p>Antes de subir productos, se deben configurar las bases de la tienda en <strong>Configuración (Settings)</strong>:</p>
<ul>
    <li><strong>Datos de la Tienda:</strong> Razón social, moneda predeterminada de facturación y zona horaria.</li>
    <li><strong>Políticas Legales:</strong> Generar plantillas de Política de Reembolso, Política de Privacidad, Términos de Servicio y Envíos.</li>
    <li><strong>Dominio Personalizado:</strong> Conectar un dominio propio (ejemplo: <code>mitienda.com</code>) para generar confianza profesional.</li>
</ul>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 2: Catálogo de Productos, Variantes, Precios y Colecciones",
                            LessonTitle = "Carga de Productos, SKUs, Fotos de Alta Calidad y Colecciones Inteligentes",
                            Summary = "Crea fichas de producto atractivas, gestiona variantes de talla/color, códigos de inventario (SKU) y organiza colecciones manuales e inteligentes.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Creación de una Ficha de Producto de Alta Conversión</h4>
<p>Una ficha de producto profesional en Shopify debe contener:</p>
<ul>
    <li><strong>Título descriptivo y SEO-friendly:</strong> Claro, conciso y con palabras clave de búsqueda.</li>
    <li><strong>Descripción con formato:</strong> Beneficios clave, especificaciones técnicas y llamadas a la acción.</li>
    <li><strong>Galería Multimedia:</strong> Mínimo 3 imágenes de alta resolución en fondo limpio o neutro.</li>
    <li><strong>Precios y Costo:</strong> Precio de venta, precio de comparación (para mostrar ofertas tachadas) y costo por artículo (para medir margen de ganancia).</li>
    <li><strong>Inventario:</strong> Seguimiento de stock por SKU y activación de venta con o sin stock disponible.</li>
</ul>

<h4>2. Colecciones Manuales vs. Colecciones Automatizadas</h4>
<p>Las <strong>Colecciones</strong> agrupan productos para facilitar la navegación del cliente:</p>
<div class=""card p-3 bg-light my-2"">
    <p class=""mb-1""><strong>Colección Automatizada (Recomendada):</strong> Se crean reglas automáticas (ejemplo: 'Incluir productos donde la etiqueta sea igual a <em>Novedades</em> y el precio sea mayor a 10'). Ahorra horas de trabajo al actualizar inventarios.</p>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 3: Pasarelas de Pago, Tarifas de Envío y Personalización del Tema",
                            LessonTitle = "Configuración de Pagos Manuales / Automáticos, Zonas de Envío y Personalización",
                            Summary = "Configura métodos de pago (Pago Móvil, Binance, Transferencia, Stripe/PayPal), zonas de delivery/envíos y personalización del tema visual (Dawn).",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Pasarelas de Pago en Shopify</h4>
<p>En mercados con modalidades mixtas (como Venezuela o Latinoamérica), es vital combinar:</p>
<ul>
    <li><strong>Pagos Manuales:</strong> 'Pago Móvil / Transferencia Bancaria' y 'Binance Pay / USDT', donde el cliente recibe instrucciones en pantalla y luego reporta su comprobante.</li>
    <li><strong>Pasarelas Automáticas:</strong> Procesadores como PayPal, Stripe o Mercado Pago para cobros inmediatos con tarjeta de crédito/débito.</li>
</ul>

<h4>2. Zonas de Envío y Tarifas</h4>
<p>Se configuran en <strong>Envíos y Entregas</strong>:</p>
<ul>
    <li><strong>Zona Local (Delivery):</strong> Tarifa fija o gratis para compras superiores a cierto monto.</li>
    <li><strong>Zona Nacional:</strong> Envíos cobro a destino o tarifa calculada según peso y agencia de encomiendas.</li>
</ul>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 4: Ciclo de Pedidos, Carritos Abandonados y Estrategias de Venta",
                            LessonTitle = "Procesamiento de Órdenes, Empaque, Guías de Envío y Notificaciones al Cliente",
                            Summary = "Gestiona pedidos entrantes, marcas de pagado/preparado, recuperación de carritos abandonados mediante email y creación de cupones de descuento.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Ciclo de Vida de una Orden en Shopify</h4>
<p>Al recibir una compra, la orden pasa por los siguientes estados:</p>
<ol>
    <li><strong>No Pagada / Pagada:</strong> Si es pago manual, se verifica el comprobante bancario antes de marcar 'Pago Recibido'.</li>
    <li><strong>No Preparada:</strong> La orden está pendiente por embalar y alistar en el almacén.</li>
    <li><strong>Preparada (Fulfillment):</strong> Se asigna el número de guía de seguimiento y Shopify envía automáticamente un correo de confirmación con el tracking al cliente.</li>
</ol>

<h4>2. Recuperación de Carritos Abandonados</h4>
<p>Entre el 60% y el 75% de los compradores en internet abandonan el carrito antes de pagar. Shopify incluye una herramienta nativa para enviar correos de recordatorio automáticos a las 10 o 24 horas ofreciendo ayuda o un cupón de descuento, recuperando entre un 10% y 20% de las ventas perdidas.</p>"
                        }
                    },
                    Quiz = new QuizData
                    {
                        Title = "Evaluación Sumativa: Fundamentos Operativos de Shopify",
                        Questions = new List<QuestionData>
                        {
                            new QuestionData
                            {
                                QuestionText = "¿Cuál es la principal diferencia entre una 'Colección Manual' y una 'Colección Automatizada' en Shopify?",
                                Options = new[]
                                {
                                    "La colección manual solo permite 5 productos, la automatizada no tiene límite.",
                                    "La colección manual requiere agregar cada producto a mano, mientras que la automatizada agrupa productos según condiciones y etiquetas.",
                                    "La colección automatizada cobra una comisión adicional por cada venta.",
                                    "Las colecciones automatizadas solo se pueden ver desde la aplicación móvil."
                                },
                                CorrectIndex = 1,
                                Explanation = "Las colecciones automatizadas seleccionan los productos dinámicamente según reglas predefinidas (tipo de producto, etiquetas, precio, etc.)."
                            },
                            new QuestionData
                            {
                                QuestionText = "En una tienda de Shopify que recibe transferencias y Pago Móvil, ¿qué tipo de método de pago se debe configurar?",
                                Options = new[]
                                {
                                    "Shopify Payments exclusivo para tarjetas bancarias estadounidenses.",
                                    "Métodos de pago manuales (Custom / Manual Payment Methods) con instrucciones en pantalla.",
                                    "No es posible recibir pagos locales en Shopify.",
                                    "Solo a través de cheques en papel enviados por correo postal."
                                },
                                CorrectIndex = 1,
                                Explanation = "Los métodos de pago manuales permiten colocar los datos bancarios y teléfono para que el cliente haga su pago móvil y reporte el comprobante."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Para qué sirve configurar el 'Precio de Comparación' (Compare at price) en un producto de Shopify?",
                                Options = new[]
                                {
                                    "Para mostrar el precio original tachado y resaltar una oferta o descuento al cliente.",
                                    "Para comparar el precio de la competencia en tiempo real.",
                                    "Para calcular el costo de aduana automáticamente.",
                                    "Para pagar comisiones dobles a la plataforma."
                                },
                                CorrectIndex = 0,
                                Explanation = "El precio de comparación se muestra tachado junto al precio actual, comunicando visualmente una rebaja o promoción especial."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Qué acción realiza Shopify cuando una orden es marcada como 'Preparada' (Fulfill items) y se ingresa el número de rastreo?",
                                Options = new[]
                                {
                                    "Borra la orden del historial del sistema.",
                                    "Envía automáticamente una notificación por correo al cliente con su número de guía para rastrear su paquete.",
                                    "Cancela la compra y devuelve el dinero al comprador.",
                                    "Publica la información del cliente en redes sociales."
                                },
                                CorrectIndex = 1,
                                Explanation = "Al marcar como preparada, Shopify notifica al cliente con el enlace de seguimiento de su encomienda para brindarle tranquilidad."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Por qué es crucial la herramienta de 'Carritos Abandonados' en el comercio electrónico?",
                                Options = new[]
                                {
                                    "Porque permite recuperar ventas enviando recordatorios automáticos a usuarios que no finalizaron su compra.",
                                    "Porque bloquea permanentemente a los visitantes indecisos.",
                                    "Porque borra automáticamente los productos que no se vendieron en el mes.",
                                    "Porque aumenta obligatoriamente el precio de los artículos."
                                },
                                CorrectIndex = 0,
                                Explanation = "Los correos de carritos abandonados rescatan ventas de clientes que tuvieron una distracción o duda en el momento del checkout."
                            }
                        }
                    }
                },

                // =========================================================================================
                // 3. ASISTENTE DE VENTAS COMERCIAL (BASADO EN DESCRIPCIÓN DE CARGO)
                // =========================================================================================
                new CourseData
                {
                    CategorySlug = "empleabilidad-desarrollo-idiomas",
                    Title = "Asistente de Ventas Comercial: Gestión Administrativa, Atención y Supervisión en Piso",
                    Slug = "asistente-de-ventas-comercial-supervision",
                    ShortDescription = "Aprende el rol integral del Asistente de Ventas: apoyo administrativo al Jefe de Ventas, supervisión de piso, control de inventario, cotizaciones y atención al cliente.",
                    Level = "Básico",
                    EstimatedHours = 18,
                    BadgeColor = "primary",
                    Modules = new List<ModuleData>
                    {
                        new ModuleData
                        {
                            Title = "Módulo 1: Propósito del Cargo, Organigrama y Relaciones Operativas",
                            LessonTitle = "Estructura Organizacional, Autoridad y Supervisión de Personal",
                            Summary = "Comprende la posición del Asistente de Ventas en el organigrama comercial, apoyo al Jefe de Ventas y supervisión del personal de Atención al Cliente (ATC), Mercaderistas y aprendices.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Propósito Principal del Asistente de Ventas</h4>
<p>El <strong>Asistente de Ventas</strong> apoya al equipo comercial en las actividades administrativas y en la gestión de información referente a los procesos y objetivos del departamento, mediante la supervisión e implementación de estrategias que faciliten el trabajo del personal de <strong>Atención al Cliente (ATC)</strong> y <strong>Mercaderistas</strong>, asegurando el manejo oportuno y efectivo de las operaciones.</p>

<div class=""card p-3 border-primary my-3"">
    <h5 class=""fw-bold text-primary mb-2""><i class=""bi bi-diagram-3-fill me-2""></i>Organigrama y Línea de Mando</h5>
    <ul>
        <li><strong>Supervisor Inmediato:</strong> Jefe de Ventas.</li>
        <li><strong>Personal Supervisado Directo:</strong> Mercaderistas, Personal de Atención al Cliente (ATC) y Aprendices.</li>
        <li><strong>Personal Supervisado Indirecto:</strong> Ayudantes, Auxiliares de Piso y Cajeros.</li>
    </ul>
</div>

<h4>2. Nivel de Autonomía y Responsabilidad</h4>
<ul>
    <li><strong>Toma de decisiones:</strong> Respaldadas por el Supervisor Inmediato (Jefe de Ventas).</li>
    <li><strong>Manejo de dinero:</strong> No maneja dinero en efectivo directo en caja, pero supervisa que los cobros y despachos fluyan sin irregularidades.</li>
    <li><strong>Firma requerida:</strong> Firma cotizaciones, solicitudes de almacén y formatos administrativos autorizados por el departamento.</li>
</ul>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 2: Supervisión en Piso de Venta y Gestión de Atención al Cliente (ATC)",
                            LessonTitle = "Recorridos de Supervisión, Etiquetado, Exhibición y Normas de Cortesía",
                            Summary = "Aprende a ejecutar recorridos de supervisión, verificar el uso correcto de uniformes y EPP, calidad de atención al cliente y resolución inmediata de situaciones irregulares.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Recorridos Constantes en Piso de Venta</h4>
<p>El Asistente de Ventas realiza recorridos continuos para verificar:</p>
<ul>
    <li><strong>Ejecución del Personal ATC:</strong> Postura profesional, lenguaje adecuado, actitud de servicio y asesoría oportuna a los clientes.</li>
    <li><strong>Presentación de la Tienda:</strong> Limpieza de áreas de venta, orden de productos, sistemas de seguridad y alarmas activas.</li>
    <li><strong>Etiquetado y Habladores:</strong> Que todos los productos en exhibición tengan su precio actualizado, hablador visible y descripción correcta.</li>
</ul>

<h4>2. Resolución Inmediata de Situaciones Irregulares</h4>
<p>Ante cualquier reclamo, disconformidad de un cliente o cuello de botella en caja o despacho, el Asistente de Ventas interviene de forma inmediata, aplicando escucha activa, respeto y soluciones dentro del marco de políticas de la empresa.</p>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 3: Planificación de Inventarios, Rotación de Stock y Cotizaciones",
                            LessonTitle = "Control de Stock en Piso, Mercancía de Lenta Salida y Coordinación con Almacén",
                            Summary = "Gestiona la planificación del inventario mensual, validación de stock en almacén, detección de mercancía sin rotación y elaboración de cotizaciones para clientes.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Control y Necesidad de Mercancía en Piso de Venta</h4>
<p>Es responsabilidad del Asistente de Ventas garantizar que <strong>todo producto existente en el almacén esté exhibido en piso</strong>. Si un producto no está en anaquel, no se vende.</p>
<ul>
    <li><strong>Planificación de Inventarios Mensuales:</strong> Cotejar stock físico vs. sistema, reportando novedades y diferencias al supervisor.</li>
    <li><strong>Recepción y Despacho:</strong> Recibir mercancía proveniente de Almacén, Gestión de Garantías y Despacho, coordinando su etiquetado inmediato.</li>
    <li><strong>Análisis de Mercancía de Lenta Rotación:</strong> Identificar productos estancados y pasar informe al Jefe de Ventas para proponer promociones o reubicación.</li>
</ul>

<h4>2. Elaboración de Cotizaciones y Contacto con Proveedores</h4>
<p>El Asistente elabora cotizaciones formales para clientes institucionales o compras de volumen y atiende a proveedores de marcas aliadas para revisar inventario y solicitar <strong>Material POP</strong> publicitario.</p>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 4: Indicadores de Gestión, Canales de Comunicación y Seguridad Laboral",
                            LessonTitle = "Estadísticas de Venta, Seguimiento por WhatsApp y Seguridad y Salud Laboral",
                            Summary = "Reporta estadísticas de ventas al supervisor, coordina solicitudes por grupos de WhatsApp/correo y cumple con normas de Seguridad y Salud en el Trabajo.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Seguimiento por Canales Digitales (WhatsApp y Correo)</h4>
<p>El flujo moderno de ventas exige coordinación continua:</p>
<ul>
    <li>Hacer seguimiento en grupos de WhatsApp del departamento con respecto a productos de exhibición entregados a Despacho.</li>
    <li>Verificar que de inmediato se haga la reposición del artículo en la exhibición para no dejar huecos en anaquel.</li>
    <li>Consolidar indicadores de ventas diarias para la toma de decisiones.</li>
</ul>

<h4>2. Seguridad, Salud Laboral y Equipos de Protección Personal (EPP)</h4>
<p>El Asistente vela por el uso correcto del uniforme, credenciales y equipos de protección asignados (como botas de seguridad en áreas de carga), reportando cualquier condición insegura al supervisor inmediato.</p>"
                        }
                    },
                    Quiz = new QuizData
                    {
                        Title = "Evaluación Sumativa: Asistente de Ventas Comercial",
                        Questions = new List<QuestionData>
                        {
                            new QuestionData
                            {
                                QuestionText = "¿A qué personal supervisa de forma DIRECTA el Asistente de Ventas según la descripción oficial del cargo?",
                                Options = new[]
                                {
                                    "Directores y Gerentes Generales.",
                                    "Mercaderistas, Personal de Atención al Cliente (ATC) y Aprendices.",
                                    "Auditores Externos y Personal de Mantenimiento.",
                                    "Conductores de Encomiendas Externas."
                                },
                                CorrectIndex = 1,
                                Explanation = "El Asistente de Ventas supervisa directamente a los Mercaderistas, al personal de Atención al Cliente (ATC) y aprendices INCES."
                            },
                            new QuestionData
                            {
                                QuestionText = "Si un cliente presenta una disconformidad o reclamo en el piso de venta o caja, ¿cuál debe ser la actuación del Asistente de Ventas?",
                                Options = new[]
                                {
                                    "Ignorar al cliente y esperar a que termine su turno de trabajo.",
                                    "Brindar atención inmediata, hacer acto de presencia y buscar una solución oportuna y respetuosa.",
                                    "Llamar a seguridad para desalojar al cliente inmediatamente.",
                                    "Discutir acaloradamente con el cliente para defender a la empresa."
                                },
                                CorrectIndex = 1,
                                Explanation = "El cargo establece brindar atención inmediata de presentarse alguna situación irregular con los clientes y resolver con normas de cortesía."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Qué debe hacer el Asistente de Ventas con respecto a la mercancía que lleva mucho tiempo en tienda sin tener salida?",
                                Options = new[]
                                {
                                    "Esconderla en el almacén para que no se vea en tienda.",
                                    "Realizar análisis de indicadores de gestión y pasar informe a su Supervisor Inmediato.",
                                    "Desecharla en el contenedor de basura sin consultar.",
                                    "Regalarla a los clientes sin autorización de la gerencia."
                                },
                                CorrectIndex = 1,
                                Explanation = "Debe analizar los indicadores de mercancía de lenta rotación y pasar informe al supervisor para definir acciones comerciales."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Por qué es fundamental que el Asistente supervise el etiquetado y los 'habladores' en piso de venta?",
                                Options = new[]
                                {
                                    "Para garantizar que los precios estén actualizados, visibles y correctos para el cliente en todo momento.",
                                    "Para gastar el papel sobrante de la oficina.",
                                    "Porque la ley exige que no haya precios en las exhibiciones.",
                                    "Para tapar las fallas de pintura de los anaqueles."
                                },
                                CorrectIndex = 0,
                                Explanation = "Los habladores y etiquetas garantizan la transparencia de precios y evitan confusiones en el momento de cobro en caja."
                            },
                            new QuestionData
                            {
                                QuestionText = "Cuando se entrega un producto que estaba en exhibición al área de despacho para solventar la entrega a un cliente, ¿qué acción inmediata debe verificar el Asistente?",
                                Options = new[]
                                {
                                    "Dejar el espacio vacío permanentemente en la estantería.",
                                    "Verificar la reposición inmediata del producto en la exhibición del piso de venta.",
                                    "Cerrar la tienda por el resto del día.",
                                    "Borrar el producto de la lista de inventario general."
                                },
                                CorrectIndex = 1,
                                Explanation = "El Asistente debe garantizar la reposición inmediata del producto en exhibición para que el piso de venta siempre esté surtido."
                            }
                        }
                    }
                },

                // =========================================================================================
                // 4. MERCADERISTA Y TRADE MERCHANDISING
                // =========================================================================================
                new CourseData
                {
                    CategorySlug = "empleabilidad-desarrollo-idiomas",
                    Title = "Mercaderista y Trade Merchandising: Exhibición, Rotación y Gestión en Punto de Venta",
                    Slug = "mercaderista-trade-merchandising-punto-venta",
                    ShortDescription = "Domina el arte de la exhibición comercial en punto de venta: planogramas, frentes de anaquel, rotación FIFO/PEPS, material POP y prevención de mermas.",
                    Level = "Básico",
                    EstimatedHours = 16,
                    BadgeColor = "warning",
                    Modules = new List<ModuleData>
                    {
                        new ModuleData
                        {
                            Title = "Módulo 1: Fundamentos del Trade Merchandising y el Rol del Mercaderista",
                            LessonTitle = "El Vendedor Silencioso: Zonas de Anaquel, Puntos Calientes y Fríos",
                            Summary = "Aprende los niveles de visibilidad en estanterías (ojos, manos, suelo), cómo transformar puntos fríos en calientes y la misión del mercaderista.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. ¿Qué es un Mercaderista y cuál es su impacto comercial?</h4>
<p>El <strong>Mercaderista</strong> es el profesional responsable de que el producto sea visible, atractivo y accesible para el consumidor en el punto de venta (PDV). Más del 70% de las decisiones de compra se toman directamente frente al anaquel.</p>

<h4>2. Los Cuatro Niveles del Anaquel Comercial</h4>
<div class=""table-responsive my-3"">
    <table class=""table table-bordered table-striped"">
        <thead class=""table-dark"">
            <tr>
                <th>Nivel</th>
                <th>Altura Aproximada</th>
                <th>Potencial de Venta</th>
                <th>Uso Recomendado</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>Nivel de los Ojos</strong></td>
                <td>1.40 m - 1.70 m</td>
                <td><strong>Máximo (El más codiciado)</strong></td>
                <td>Productos estrella, marcas aliadas y artículos de mayor rentabilidad.</td>
            </tr>
            <tr>
                <td><strong>Nivel de las Manos</strong></td>
                <td>0.80 m - 1.40 m</td>
                <td><strong>Alto</strong></td>
                <td>Productos de compra impulsiva y novedades.</td>
            </tr>
            <tr>
                <td><strong>Nivel de la Cintura / Rodillas</strong></td>
                <td>0.40 m - 0.80 m</td>
                <td><strong>Medio</strong></td>
                <td>Productos de consumo masivo habitual y reposición continua.</td>
            </tr>
            <tr>
                <td><strong>Nivel del Suelo</strong></td>
                <td>0.00 m - 0.40 m</td>
                <td><strong>Bajo</strong></td>
                <td>Productos pesados, bultos grandes o de búsqueda obligada.</td>
            </tr>
        </tbody>
    </table>
</div>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 2: Técnicas de Rotación FIFO/PEPS y Prevención de Mermas",
                            LessonTitle = "Primero en Entrar, Primero en Salir (PEPS) y Revisión de Caducidad",
                            Summary = "Implementa la técnica FIFO para rotar mercancía, evitar productos vencidos o deteriorados y reportar anomalías oportunamente.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. La Regla de Oro: Principio FIFO / PEPS</h4>
<p><strong>FIFO (First In, First Out)</strong> o <strong>PEPS (Primero en Entrar, Primero en Salir)</strong> es el pilar fundamental del mercaderista:</p>
<div class=""alert alert-info border-0 my-3"">
    <strong>Método Operativo:</strong> Al reponer anaqueles, <em>siempre</em> se retira la mercancía que ya estaba exhibida hacia adelante, y la mercancía nueva que viene del almacén se coloca en la parte trasera del anaquel.
</div>
<p>Esto garantiza que los productos con fecha de vencimiento más próxima salgan primero, evitando mermas financieras millonarias para la empresa.</p>

<h4>2. Control de Averías y Daños</h4>
<p>El mercaderista debe revisar constantemente que los empaques no estén rotos, abollados o decolorados por la luz. Un producto dañado en exhibición perjudica la imagen de toda la tienda.</p>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 3: Planogramas, Frentes de Anaquel y Gestión de Material POP",
                            LessonTitle = "Facing, Cabeceras de Góndola, Rompetráficos y Habladores",
                            Summary = "Interpreta planogramas de marcas, maximiza los 'facings' visibles y monta material publicitario en el punto de venta.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Planogramas y 'Facing'</h4>
<ul>
    <li><strong>Planograma:</strong> Diagrama gráfico que indica exactamente la posición, cantidad de caras (<em>facings</em>) y altura que debe ocupar cada marca en la estantería.</li>
    <li><strong>Facing (Frente):</strong> Es la cara visible del producto hacia el pasillo. A mayor cantidad de facings de una marca, mayor probabilidad de compra.</li>
    <li><strong>Efecto Espejo / Fachada:</strong> Todos los productos deben estar alineados al borde frontal del anaquel, nunca hundidos en el fondo.</li>
</ul>

<h4>2. Material POP (Point of Purchase)</h4>
<p>El material promocional en tienda incluye:</p>
<ul>
    <li><strong>Habladores / Cenefas:</strong> Señalizadores de precio y promociones en el riel del anaquel.</li>
    <li><strong>Cabeceras de Góndola:</strong> Espacio de alto impacto al inicio y final de los pasillos.</li>
    <li><strong>Dangling / Stoppers:</strong> Elementos que sobresalen perpendicularmente para llamar la atención del transeúnte.</li>
</ul>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 4: Comunicación con el Asistente de Ventas y Control de Agotados",
                            LessonTitle = "Detección de Quiebres de Stock, Reportes y Trabajo en Equipo",
                            Summary = "Aprende a reportar quiebres de stock (agotados) al Asistente de Ventas, verificar existencias en bodega y normas de seguridad en piso.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Prevención y Reporte de Quiebres de Stock (Agotados)</h4>
<p>El <strong>quiebre de stock</strong> ocurre cuando hay demanda de un producto pero no está disponible para la venta. El mercaderista debe:</p>
<ol>
    <li>Verificar inmediatamente si el producto se encuentra en el almacén de reserva.</li>
    <li>Si no hay en almacén, reportar la novedad de inmediato al <strong>Asistente de Ventas</strong> para que solicite reposición al departamento de compras.</li>
    <li>Nunca dejar el 'hueco' vacío de forma antiestética: ensanchar provisionalmente los facings adyacentes hasta que llegue la reposición.</li>
</ol>

<h4>2. Trabajo Coordinado y Servicio al Cliente</h4>
<p>Aunque su foco principal es el producto, el mercaderista está permanentemente en contacto con clientes en los pasillos, por lo que debe mantener una actitud amable, orientar con una sonrisa y canalizar consultas complejas con el personal de Atención al Cliente (ATC).</p>"
                        }
                    },
                    Quiz = new QuizData
                    {
                        Title = "Evaluación Sumativa: Mercaderista y Trade Merchandising",
                        Questions = new List<QuestionData>
                        {
                            new QuestionData
                            {
                                QuestionText = "¿Cuál es el nivel del anaquel que genera el mayor porcentaje de ventas por coincidir naturalmente con la mirada del cliente?",
                                Options = new[]
                                {
                                    "Nivel del Suelo.",
                                    "Nivel de los Ojos (entre 1.40 m y 1.70 m).",
                                    "La parte trasera oculta del anaquel.",
                                    "El techo de la tienda."
                                },
                                CorrectIndex = 1,
                                Explanation = "El nivel de los ojos es la zona de mayor rentabilidad comercial porque el consumidor la visualiza de inmediato sin agacharse ni estirarse."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿En qué consiste la técnica de rotación FIFO / PEPS al surtir un anaquel?",
                                Options = new[]
                                {
                                    "Poner los productos nuevos adelante y esconder los viejos atrás.",
                                    "Mover la mercancía antigua hacia el frente y colocar la mercancía recién llegada en la parte trasera.",
                                    "Mezclar todos los productos al azar sin importar su fecha.",
                                    "No rotar la mercancía hasta que el estante quede totalmente vacío."
                                },
                                CorrectIndex = 1,
                                Explanation = "FIFO / PEPS exige colocar lo nuevo atrás y lo anterior adelante para asegurar que se venda primero lo que tiene menor tiempo de vida útil."
                            },
                            new QuestionData
                            {
                                QuestionText = "En merchandising, ¿qué significa el término 'Facing'?",
                                Options = new[]
                                {
                                    "La cara frontal del producto visible directamente hacia el pasillo para el comprador.",
                                    "La fotografía del mercaderista en su credencial de trabajo.",
                                    "La factura de compra emitida por el proveedor.",
                                    "El peso neto en kilogramos de la caja."
                                },
                                CorrectIndex = 0,
                                Explanation = "El facing es la cantidad de caras visibles de un producto colocadas al frente de la balda o anaquel."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Qué debe hacer un mercaderista si nota que un producto se ha agotado en la estantería?",
                                Options = new[]
                                {
                                    "Irse a descansar porque ya no hay mercancía.",
                                    "Verificar si hay existencias en almacén y reportar de inmediato la novedad al Asistente de Ventas.",
                                    "Decirle a los clientes que la tienda va a quebrar.",
                                    "Romper el hablador de precios."
                                },
                                CorrectIndex = 1,
                                Explanation = "Debe buscar en bodega para reponer y notificar al Asistente de Ventas para activar el pedido de compra correspondiente."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Cuál es la función principal del Material POP (Point of Purchase) en una tienda?",
                                Options = new[]
                                {
                                    "Destacar el producto, comunicar promociones y llamar la atención del consumidor en el punto de compra.",
                                    "Servir como material de limpieza al final de la jornada.",
                                    "Ocultar los defectos del suelo del local comercial.",
                                    "Sustituir al personal de seguridad de la tienda."
                                },
                                CorrectIndex = 0,
                                Explanation = "El Material POP (cenefas, habladores, rompetráficos) actúa como un vendedor silencioso que destaca las ventajas y precios de la marca."
                            }
                        }
                    }
                },

                // =========================================================================================
                // 5. SERVICIO TÉCNICO INFORMÁTICO Y SOPORTE A SISTEMAS
                // =========================================================================================
                new CourseData
                {
                    CategorySlug = "tecnologia-ia-ofimatica",
                    Title = "Servicio Técnico Informático y Soporte a Sistemas: Hardware, Redes y Mantenimiento",
                    Slug = "servicio-tecnico-informatico-soporte-sistemas",
                    ShortDescription = "Aprende mantenimiento preventivo y correctivo de hardware, configuración de sistemas operativos, soporte a usuarios, redes locales y periféricos de oficina.",
                    Level = "Básico",
                    EstimatedHours = 18,
                    BadgeColor = "info",
                    Modules = new List<ModuleData>
                    {
                        new ModuleData
                        {
                            Title = "Módulo 1: Rol del Técnico de Sistemas, Priorización y Gestión de Activos",
                            LessonTitle = "Atención de Requerimientos, Niveles de Complejidad y Control de Equipos",
                            Summary = "Conoce las funciones del Técnico en Tecnología y Sistemas: recepción de solicitudes de soporte, priorización por criticidad y administración del inventario de activos TI.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Propósito y Alcance del Técnico en Tecnología y Sistemas</h4>
<p>El <strong>Técnico en Tecnología y Sistemas</strong> es el responsable de instalar, configurar y mantener en óptimo funcionamiento los equipos informáticos, periféricos, telecomunicaciones y redes de la empresa, brindando soporte técnico y soluciones oportunas a todos los departamentos.</p>

<h4>2. Gestión y Priorización de Incidencias Técnicas</h4>
<p>Las solicitudes de asistencia se clasifican según su impacto en la continuidad del negocio:</p>
<ul>
    <li><strong>Prioridad Crítica (P1):</strong> Falla de servidores, caída total de red, servidor de facturación o sistema de cobro en caja detenido. Respuesta inmediata.</li>
    <li><strong>Prioridad Alta (P2):</strong> Equipo de facturación individual o puesto clave con fallas intermitentes.</li>
    <li><strong>Prioridad Normal (P3):</strong> Solicitudes de instalación de software, cambio de consumibles o configuración de cuentas de usuario.</li>
</ul>

<h4>3. Control de Activos Tecnológicos</h4>
<p>El técnico lleva el registro detallado (marca, modelo, serial, procesador, RAM, disco y usuario asignado) de cada equipo, garantizando el resguardo de la infraestructura de la empresa.</p>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 2: Mantenimiento Preventivo y Correctivo de Hardware y Periféricos",
                            LessonTitle = "Limpieza de Componentes, Pasta Térmica, Fuentes de Poder e Impresoras",
                            Summary = "Aprende protocolos de mantenimiento preventivo, limpieza con aire comprimido y alcohol isopropílico, diagnóstico de fallas térmicas y configuración de impresoras y escáneres.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Mantenimiento Preventivo de Computadores</h4>
<p>El polvo y el calor son los mayores enemigos de los circuitos electrónicos. Un protocolo preventivo periódico incluye:</p>
<ol>
    <li>Desconexión eléctrica total y descarga de energía estática con pulsera antiestática.</li>
    <li>Soplado con aire comprimido o soplador técnico de ventiladores, disipadores y fuente de poder.</li>
    <li>Reemplazo de pasta térmica en el procesador (CPU) cada 6 a 12 meses para evitar apagados por sobrecalentamiento.</li>
    <li>Limpieza de contactos de memoria RAM con borrador o alcohol isopropílico de alta pureza.</li>
</ol>

<h4>2. Mantenimiento de Equipos de Oficina (Impresoras, Escáneres y CCTV)</h4>
<ul>
    <li><strong>Impresoras Láser y Térmicas:</strong> Limpieza de rodillos de arrastre (feed rollers), sustitución oportuna de tóner y verificación de atascos de papel.</li>
    <li><strong>CCTV y Seguridad:</strong> Revisión del grabador DVR/NVR, fuentes de poder centralizadas y enfoque de cámaras de vigilancia.</li>
</ul>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 3: Sistemas Operativos, Controladores y Asistencia al Usuario",
                            LessonTitle = "Instalación de Windows, Drivers, Herramientas de Diagnóstico y Soporte Remoto",
                            Summary = "Domina la instalación limpia de sistemas operativos, gestión de particiones, actualización de drivers, herramientas de soporte remoto (AnyDesk/TeamViewer) y respaldo de datos.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Puesta a Punto del Puesto de Trabajo</h4>
<p>Al preparar una computadora para un usuario de la empresa:</p>
<ul>
    <li>Instalar el Sistema Operativo oficial en unidad de estado sólido (SSD) para máxima velocidad.</li>
    <li>Instalar controladores oficiales de chipset, video y red directamente del fabricante.</li>
    <li>Configurar software corporativo: suites ofimáticas (Office / Google Workspace), antivirus empresarial y navegadores actualizados.</li>
    <li>Configurar políticas de usuario estándar (sin privilegios de administrador para evitar infecciones por malware).</li>
</ul>

<h4>2. Soporte Técnico en Terreno y Remoto</h4>
<p>El técnico atiende incidencias directamente en el puesto de trabajo o mediante software de asistencia remota (AnyDesk, TeamViewer o RDP), documentando la solución en la bitácora de soporte.</p>"
                        },
                        new ModuleData
                        {
                            Title = "Módulo 4: Redes Locales (LAN), Cableado Estructurado y Respaldo de Datos",
                            LessonTitle = "Switches, Routers, Cable UTP (RJ-45), Conectividad y Políticas de Backup",
                            Summary = "Aprende conceptos de direccionamiento IP, crimpado de cables de red con norma T568B, diagnóstico con ping e ipconfig, y ejecución de copias de seguridad de la empresa.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Fundamentos de Redes Locales (LAN)</h4>
<p>La conectividad empresarial se basa en una infraestructura de red estable:</p>
<ul>
    <li><strong>Cableado Estructurado:</strong> Uso de cable UTP Categoría 6 con conectores RJ-45 bajo la norma estándar <strong>T568B</strong>.</li>
    <li><strong>Comandos de Diagnóstico en Consola:</strong>
        <ul>
            <li><code>ipconfig /all</code>: Muestra dirección IP, máscara de subred y puerta de enlace (Gateway).</li>
            <li><code>ping 8.8.8.8</code> o <code>ping 192.168.1.1</code>: Verifica la comunicación con el router o con internet.</li>
        </ul>
    </li>
</ul>

<h4>2. Políticas de Respaldos (Backups)</h4>
<p>Los datos son el activo más valioso de la organización. El técnico aplica la regla <strong>3-2-1</strong>:</p>
<div class=""card p-3 bg-light border-warning my-2"">
    <strong>Regla 3-2-1 de Respaldos:</strong> Guardar <strong>3</strong> copias de los datos importantes, en <strong>2</strong> soportes diferentes (ej: disco local y NAS/servidor), y al menos <strong>1</strong> copia en una ubicación remota o en la nube.
</div>"
                        }
                    },
                    Quiz = new QuizData
                    {
                        Title = "Evaluación Sumativa: Servicio Técnico Informático y Soporte a Sistemas",
                        Questions = new List<QuestionData>
                        {
                            new QuestionData
                            {
                                QuestionText = "¿Cuál de las siguientes incidencias debe clasificarse con 'Prioridad Crítica (P1)' en el área de tecnología de una empresa comercial?",
                                Options = new[]
                                {
                                    "A un empleado se le desgastó la alfombrilla del ratón (mousepad).",
                                    "Caída general del servidor principal de base de datos o sistema de facturación en cajas.",
                                    "El fondo de pantalla de un monitor está desalineado.",
                                    "Un usuario solicita cambiar el tipo de letra de su cliente de correo."
                                },
                                CorrectIndex = 1,
                                Explanation = "Las fallas que paralizan la facturación o la continuidad operativa central del negocio son siempre de prioridad crítica inmediata."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Para qué se utiliza la pasta térmica entre el procesador (CPU) y el disipador metálico?",
                                Options = new[]
                                {
                                    "Para pegar permanentemente el procesador para que nadie lo pueda robar.",
                                    "Para rellenar imperfecciones microscópicas y transferir eficientemente el calor generado hacia el disipador.",
                                    "Para lubricar los ventiladores y reducir el ruido acústico.",
                                    "Para alimentar eléctricamente los núcleos del chip."
                                },
                                CorrectIndex = 1,
                                Explanation = "La pasta térmica elimina las bolsas de aire entre ambas superficies y maximiza la transferencia de calor para evitar recalentamiento."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Qué comando de consola en Windows permite verificar si un computador tiene comunicación con el router o con otra máquina de la red?",
                                Options = new[]
                                {
                                    "format c:",
                                    "ping [dirección IP]",
                                    "notepad.exe",
                                    "calc"
                                },
                                CorrectIndex = 1,
                                Explanation = "El comando 'ping' envía paquetes ICMP de eco y mide el tiempo de respuesta para verificar la conectividad de red."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿Cuál es el conector y estándar de cableado más utilizado en redes de datos cableadas Ethernet?",
                                Options = new[]
                                {
                                    "Conector RJ-11 de telefonía analógica.",
                                    "Conector RJ-45 con cable de par trenzado (UTP) bajo norma T568B.",
                                    "Cable coaxial de antena de televisión aérea.",
                                    "Cable de audio auxiliar de 3.5 mm."
                                },
                                CorrectIndex = 1,
                                Explanation = "El estándar de redes LAN Ethernet corporativas utiliza conectores RJ-45 de 8 pines con cable UTP."
                            },
                            new QuestionData
                            {
                                QuestionText = "¿En qué consiste la regla '3-2-1' para las copias de seguridad (backups) en soporte informático?",
                                Options = new[]
                                {
                                    "Reiniciar el computador 3 veces, esperar 2 minutos y llamar a 1 supervisor.",
                                    "Tener 3 copias de los datos, en 2 medios diferentes, con al menos 1 copia fuera de la empresa o en la nube.",
                                    "Hacer respaldos únicamente los días 3, 2 y 1 de cada mes.",
                                    "Guardar los archivos en 3 carpetas dentro del mismo disco duro."
                                },
                                CorrectIndex = 1,
                                Explanation = "La regla 3-2-1 es el estándar mundial de ciberseguridad y continuidad operativa para evitar pérdida total de información ante catástrofes."
                            }
                        }
                    }
                }
            };
        }
    }
}
