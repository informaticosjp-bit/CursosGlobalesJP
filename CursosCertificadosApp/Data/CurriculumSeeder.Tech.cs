namespace CursosCertificadosApp.Data
{
    public static partial class CurriculumSeeder
    {
        public static List<CourseSeedData> GetTechCourses()
        {
            return new List<CourseSeedData>
            {
                // =========================================================================
                // CURSO 1: ALFABETIZACIÓN Y USO PRÁCTICO DE LA IA (GEMINI Y CHATGPT)
                // =========================================================================
                new CourseSeedData
                {
                    CategorySlug = "tecnologia-ia-ofimatica",
                    Title = "Alfabetización y Uso Práctico de la Inteligencia Artificial (Gemini y ChatGPT) en el Entorno Laboral",
                    Slug = "alfabetizacion-ia-gemini-chatgpt",
                    ShortDescription = "Aprende a integrar Google Gemini y ChatGPT en flujos laborales reales: ingeniería de prompts, automatización de tareas y redacción profesional asistida.",
                    Level = "Intermedio",
                    EstimatedHours = 16,
                    BadgeColor = "primary",
                    Modules = new List<ModuleSeedData>
                    {
                        new ModuleSeedData
                        {
                            Title = "Módulo 1: Fundamentos de Modelos de Lenguaje (LLMs) y Arquitecturas de Gemini y ChatGPT",
                            LessonTitle = "Guía Conceptual: De los Modelos de Lenguaje a la Multimodalidad Nativa",
                            Summary = "Comprende la arquitectura Transformer, el funcionamiento probabilístico de los tokens y las capacidades multimodales de Google Gemini y OpenAI ChatGPT.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. De los Algoritmos Tradicionales a los Grandes Modelos de Lenguaje</h4>
<p>La inteligencia artificial generativa moderna se fundamenta en la arquitectura <strong>Transformer</strong> y el mecanismo de autoatención (<em>Self-Attention</em>). A diferencia de los motores de búsqueda que indexan páginas estáticas, modelos como <strong>Google Gemini</strong> y <strong>OpenAI ChatGPT</strong> generan texto probabilísticamente calculando la secuencia de palabras (tokens) más coherente y contextual.</p>

<div class=""row g-3 my-3"">
    <div class=""col-md-6"">
        <div class=""card h-100 p-3 border-primary"">
            <h5 class=""fw-bold text-primary""><i class=""bi bi-stars me-1""></i> Google Gemini (1.5 Pro / Flash)</h5>
            <p class=""small text-muted mb-0"">Arquitectura <strong>multimodal nativa</strong> capaz de procesar conjuntamente audio, video de larga duración, bibliotecas de código y hojas de cálculo extensas gracias a su ventana de contexto de más de 1 millón de tokens.</p>
        </div>
    </div>
    <div class=""col-md-6"">
        <div class=""card h-100 p-3 border-success"">
            <h5 class=""fw-bold text-success""><i class=""bi bi-chat-quote-fill me-1""></i> OpenAI ChatGPT (GPT-4o)</h5>
            <p class=""small text-muted mb-0"">Excelente capacidad analítica y razonamiento secuencial, análisis avanzado de datos mediante intérprete de código Python en tiempo real y generación conversacional adaptativa.</p>
        </div>
    </div>
</div>

<div class=""alert alert-info border-0 p-3 rounded-3 my-3"">
    <strong><i class=""bi bi-lightbulb-fill text-warning me-1""></i> Principio Fundamental:</strong> Los LLMs no 'piensan' ni tienen intencionalidad humana; actúan como sofisticados predictores de contexto. Por ende, la precisión del resultado está directamente condicionada por la estructura de las instrucciones que recibe.
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 2: Técnicas de Prompt Engineering Profesional: El Marco R-T-C-F",
                            LessonTitle = "Presentación Metodológica: Construcción de Instrucciones Estructuradas",
                            Summary = "Aprende a estructurar instrucciones infalibles mediante el marco R-T-C-F: Rol, Tarea, Contexto y Formato de salida.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>Metodología de Ingeniería de Prompts: Estándar R-T-C-F</h4>
<p>Un prompt mal planteado genera respuestas genéricas y alucinaciones. En el entorno corporativo, se aplica el estándar metodológico <strong>R-T-C-F</strong> para garantizar resultados reproducibles y profesionales:</p>

<div class=""table-responsive my-3"">
    <table class=""table table-bordered table-striped align-middle"">
        <thead class=""table-dark"">
            <tr>
                <th style=""width: 20%;"">Elemento</th>
                <th style=""width: 35%;"">Función Operativa</th>
                <th>Ejemplo de Instrucción Profesional</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><strong class=""text-primary"">R - Rol</strong></td>
                <td>Establece el nivel de especialización y punto de vista analítico.</td>
                <td><em>'Actúa como un Auditor Financiero Senior con 12 años de experiencia en conciliaciones...'</em></td>
            </tr>
            <tr>
                <td><strong class=""text-success"">T - Tarea</strong></td>
                <td>Describe la acción concreta con verbos imperativos exactos.</td>
                <td><em>'Examina el siguiente informe de flujo de caja y detecta variaciones inusuales...'</em></td>
            </tr>
            <tr>
                <td><strong class=""text-warning"">C - Contexto</strong></td>
                <td>Aporta restricciones normativas, audiencia meta y condiciones de contorno.</td>
                <td><em>'La empresa opera en bolívares a tasa oficial BCV y debe liquidar cuentas por cobrar en 30 días.'</em></td>
            </tr>
            <tr>
                <td><strong class=""text-danger"">F - Formato</strong></td>
                <td>Define la estructura del entregable (tabla, Markdown, viñetas, JSON).</td>
                <td><em>'Presenta los hallazgos en una tabla con columnas: Cta, Monto, Desviación %, Recomendación.'</em></td>
            </tr>
        </tbody>
    </table>
</div>

<div class=""card bg-light border p-3 rounded-3 my-3"">
    <h6 class=""fw-bold text-dark mb-1""><i class=""bi bi-check2-circle text-success me-1""></i> Consejo para la Vida Real:</h6>
    <p class=""small text-muted mb-0"">Nunca uses prompts de una sola frase como <em>'Hazme una propuesta comercial'</em>. Especifica siempre el perfil de tu cliente, tu propuesta de valor única y el tono requerido (formal, persuasivo o técnico).</p>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 3: Automatización Documental, Análisis de Datos y Generación de Contenidos",
                            LessonTitle = "Guía Práctica: Casos de Uso Laboral Diario",
                            Summary = "Aplica IA generativa para procesar minutas de reuniones, redactar contratos base y generar fórmulas complejas para hojas de cálculo.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>Casos de Aplicación Inmediata en la Oficina Moderna</h4>
<p>La adopción de asistentes de IA permite reducir hasta un 60% el tiempo dedicado a tareas repetitivas de oficina. A continuación se presentan las 3 áreas de mayor retorno de inversión operativa:</p>

<div class=""row g-3 my-3"">
    <div class=""col-lg-4"">
        <div class=""border rounded-3 p-3 bg-white h-100"">
            <h6 class=""fw-bold text-primary""><i class=""bi bi-file-earmark-text me-1""></i> 1. Síntesis Documental</h6>
            <p class=""small text-muted mb-0"">Carga transcripciones de reuniones, correos extensos o actas de asamblea y solicita: <em>'Extrae los compromisos acordados, los responsables asignados y las fechas límites en un listado de tareas'</em>.</p>
        </div>
    </div>
    <div class=""col-lg-4"">
        <div class=""border rounded-3 p-3 bg-white h-100"">
            <h6 class=""fw-bold text-success""><i class=""bi bi-envelope-check me-1""></i> 2. Correspondencia Diplomática</h6>
            <p class=""small text-muted mb-0"">Transforma notas rápidas o quejas complejas en correos comerciales asertivos, manteniendo un tono formal que preserve relaciones comerciales ante desacuerdos en facturación.</p>
        </div>
    </div>
    <div class=""col-lg-4"">
        <div class=""border rounded-3 p-3 bg-white h-100"">
            <h6 class=""fw-bold text-info""><i class=""bi bi-table me-1""></i> 3. Generador de Fórmulas</h6>
            <p class=""small text-muted mb-0"">Describe en lenguaje natural tu necesidad de datos: <em>'Necesito una fórmula en Excel/Google Sheets que busque el valor de la columna C si el cliente está activo y la fecha es anterior a hoy'</em>.</p>
        </div>
    </div>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 4: Mitigación de Alucinaciones, Privacidad de Datos y Ética Laboral",
                            LessonTitle = "Guía de Seguridad: Verificación Crítica y Protección de Información Confidencial",
                            Summary = "Domina técnicas para evitar alucinaciones, proteger información corporativa confidencial y cumplir con directrices de privacidad.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Qué son las Alucinaciones y Cómo Mitigarlas</h4>
<p>Una <strong>alucinación</strong> ocurre cuando el modelo de IA responde con información plausible, estructurada y convincente, pero completamente falsa o fabricada. Ocurre con frecuencia en citas bibliográficas, jurisprudencia legal o cifras estadísticas exactas.</p>

<div class=""alert alert-warning border-0 p-3 rounded-3 my-3"">
    <h6 class=""fw-bold mb-1""><i class=""bi bi-shield-exclamation me-1""></i> Protocolo Anti-Alucinaciones en 3 Pasos:</h6>
    <ol class=""small mb-0 ps-3"">
        <li><strong>Fijar Grounding:</strong> Adjunta siempre el documento fuente y ordénale: <em>'Responde única y exclusivamente utilizando los datos del archivo adjunto. Si un dato no figura allí, indica explícitamente: Información no disponible'</em>.</li>
        <li><strong>Solicitar Citas Textuales:</strong> Pide al modelo que cite el párrafo o sección exacta de donde extrajo cada conclusión.</li>
        <li><strong>Verificación Humana (Human-in-the-Loop):</strong> Nunca envíes un documento legal, médico o fiscal generado por IA sin revisión humana experta.</li>
    </ol>
</div>

<h4>2. Privacidad y Seguridad Corporativa</h4>
<p>Al interactuar con herramientas públicas en la nube, jamás introduzcas números de tarjetas de crédito, contraseñas, secretos comerciales o bases de datos de clientes con nombres y cédulas sin anonimizar previamente.</p>"
                        }
                    },
                    Quiz = new QuizSeedData
                    {
                        Title = "Evaluación Sumativa: Alfabetización y Uso Práctico de la IA en el Trabajo",
                        Questions = new List<QuestionSeedData>
                        {
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál es la función del componente 'Rol' dentro del marco de ingeniería de prompts R-T-C-F?",
                                Options = new[]
                                {
                                    "Establecer la longitud máxima del archivo en kilobytes.",
                                    "Definir la perspectiva técnica, experiencia y punto de vista profesional desde el cual el modelo debe razonar.",
                                    "Limitar el número de tokens por respuesta.",
                                    "Borrar la memoria caché del navegador web."
                                },
                                CorrectIndex = 1,
                                Explanation = "El 'Rol' condiciona al modelo para adoptar el tono, vocabulario y criterios especializados propios de un perfil profesional específico (ej. Auditor, Abogado, Diseñador)."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Qué representa una 'alucinación' en un modelo de lenguaje generativo?",
                                Options = new[]
                                {
                                    "Un fallo eléctrico en el centro de datos del proveedor de IA.",
                                    "Una respuesta generada que parece convincente y lógica, pero contiene hechos falsos o inventados.",
                                    "La velocidad con la que el modelo descarga archivos de internet.",
                                    "Un modo de hibernación automática del sistema."
                                },
                                CorrectIndex = 1,
                                Explanation = "Las alucinaciones son respuestas factualmente erróneas pero gramaticalmente impecables que el modelo genera al predecir secuencias de palabras sin validación de verdad intrínseca."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál es la mejor práctica para proteger la confidencialidad de la empresa al usar asistentes de IA?",
                                Options = new[]
                                {
                                    "Anonimizar los datos eliminando nombres, números de identificación y cifras bancarias antes de consultar.",
                                    "Compartir las contraseñas del servidor en el prompt para que el modelo tenga acceso directo.",
                                    "Desactivar el cortafuegos de la computadora.",
                                    "Escribir todo en mayúsculas para indicar urgencia."
                                },
                                CorrectIndex = 0,
                                Explanation = "La anonimización previa de datos personales y sensibles protege a la organización frente a fugas de información confidencial en plataformas de IA en la nube."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Qué ventaja clave aporta Google Gemini 1.5 Pro en el análisis documental corporativo?",
                                Options = new[]
                                {
                                    "Una ventana de contexto masiva capaz de procesar documentos extensos, hojas de cálculo y video en una sola sesión.",
                                    "No requiere conexión a internet bajo ninguna circunstancia.",
                                    "Garantiza el 100% de acierto legal sin necesidad de revisión humana.",
                                    "Reemplaza por completo el sistema operativo de la computadora."
                                },
                                CorrectIndex = 0,
                                Explanation = "Gemini 1.5 Pro destaca por su amplia ventana de contexto, permitiendo analizar libros completos, contratos extensos o grabaciones audiovisuales de una sola pasada."
                            }
                        }
                    }
                },

                // =========================================================================
                // CURSO 2: OFIMÁTICA EN LA NUBE Y TRABAJO COLABORATIVO (GOOGLE WORKSPACE)
                // =========================================================================
                new CourseSeedData
                {
                    CategorySlug = "tecnologia-ia-ofimatica",
                    Title = "Ofimática en la Nube y Trabajo Colaborativo con Google Drive y Google Workspace",
                    Slug = "ofimatica-nube-google-workspace",
                    ShortDescription = "Domina la gestión de archivos en la nube, trabajo simultáneo en equipo con Google Docs, Sheets y Gmail empresarial para maximizar la productividad.",
                    Level = "Básico",
                    EstimatedHours = 14,
                    BadgeColor = "success",
                    Modules = new List<ModuleSeedData>
                    {
                        new ModuleSeedData
                        {
                            Title = "Módulo 1: Estructura, Permisos y Almacenamiento Centralizado en Google Drive",
                            LessonTitle = "Guía Operativa: Organización y Jerarquía de Accesos en la Nube",
                            Summary = "Aprende a estructurar carpetas corporativas compartidas y a gestionar permisos de visualización, comentario y edición con máxima seguridad.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. La Nube como Repositorio Centralizado de Archivos</h4>
<p>Google Drive permite a los equipos de trabajo eliminar la duplicación de versiones ('informe_final_v2_definitivo.docx') mediante el almacenamiento unificado en la nube accesible desde cualquier dispositivo autorizado.</p>

<div class=""card p-3 border-0 bg-light rounded-3 my-3"">
    <h5 class=""fw-bold text-dark mb-2""><i class=""bi bi-key-fill text-warning me-2""></i>Niveles de Permiso en Google Workspace</h5>
    <ul class=""mb-0 small"">
        <li><strong>Lector (Viewer):</strong> Puede consultar y descargar el documento, pero no modificarlo ni añadir notas. Ideal para manuales de políticas y circulares informativas.</li>
        <li><strong>Comentador (Commenter):</strong> Puede sugerir modificaciones y dejar comentarios al margen sin alterar el texto original directamente.</li>
        <li><strong>Editor (Editor):</strong> Posee facultades para modificar texto, borrar celdas y cambiar la configuración del contenido.</li>
    </ul>
</div>

<div class=""alert alert-success border-0 p-3 rounded-3"">
    <strong><i class=""bi bi-check-circle-fill me-1""></i> Regla de Oro de Seguridad:</strong> Al compartir enlaces públicos, desmarca siempre la casilla 'Cualquier persona con el enlace puede editar'. Limita el acceso únicamente a correos específicos con permisos de lectura.
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 2: Edición Simultánea y Control de Versiones en Google Docs",
                            LessonTitle = "Presentación Visual: Coautoría en Tiempo Real y Trazabilidad de Cambios",
                            Summary = "Domina la redacción colaborativa en vivo, el uso del historial de versiones para revertir errores y la asignación de tareas con menciones.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Coautoría en Tiempo Real sin Conflictos</h4>
<p>Google Docs permite que decenas de colaboradores redacten simultáneamente en el mismo documento. Cada usuario es identificado mediante un cursor con un color asignado, registrando en vivo cada aportación.</p>

<div class=""row g-3 my-3"">
    <div class=""col-md-6"">
        <div class=""card h-100 p-3 border"">
            <h6 class=""fw-bold text-primary""><i class=""bi bi-clock-history me-1""></i> Historial de Versiones (Ctrl + Alt + Shift + H)</h6>
            <p class=""small text-muted mb-0"">Cada cambio se almacena automáticamente en los servidores de Google. Puedes consultar quién modificó cada párrafo, asignar nombres a hitos importantes (ej. 'Versión Aprobada por Gerencia') y restaurar cualquier versión previa con un solo clic.</p>
        </div>
    </div>
    <div class=""col-md-6"">
        <div class=""card h-100 p-3 border"">
            <h6 class=""fw-bold text-success""><i class=""bi bi-at me-1""></i> Asignación de Tareas con @@Menciones</h6>
            <p class=""small text-muted mb-0"">Escribe <code>@@correo@empresa.com</code> en un comentario para asignar una tarea concreta a un compañero. El sistema le enviará una notificación por correo electrónico con enlace directo al párrafo en cuestión.</p>
        </div>
    </div>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 3: Procesamiento de Datos y Fórmulas Esenciales en Google Sheets",
                            LessonTitle = "Guía Práctica: Hojas de Cálculo Colaborativas y Vistas de Filtro",
                            Summary = "Aprende funciones clave en Google Sheets, validaciones de datos para evitar errores y vistas de filtro que no interrumpen el trabajo de otros.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Funciones Esenciales en Google Sheets</h4>
<p>Google Sheets ofrece compatibilidad con fórmulas de Excel junto con capacidades nativas de trabajo en la nube:</p>
<ul>
    <li><code>=SUMA(A1:A50)</code>: Totaliza rangos numéricos continuos.</li>
    <li><code>=PROMEDIO(B2:B30)</code>: Obtiene la media aritmética de ventas o rendimientos.</li>
    <li><code>=CONTAR.SI(C2:C100, ""Pagado"")</code>: Cuenta registros que cumplen una condición exacta.</li>
    <li><code>=BUSCARV(D2, Clientes!A:E, 3, FALSO)</code>: Localiza datos de clientes entre distintas hojas.</li>
</ul>

<div class=""alert alert-info border-0 p-3 rounded-3 my-3"">
    <h6 class=""fw-bold mb-1""><i class=""bi bi-funnel-fill me-1""></i> La Herramienta Estrella: Vista de Filtro (Filter View)</h6>
    <p class=""small mb-0"">A diferencia del filtro ordinario que oculta filas para todos los que están viendo el archivo, una <strong>Vista de Filtro</strong> te permite ordenar y filtrar la hoja para ti exclusivamente, sin alterar la visualización de los demás compañeros que trabajan en ella al mismo tiempo.</p>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 4: Comunicación y Organización con Gmail y Google Calendar",
                            LessonTitle = "Guía de Productividad: Dominio del Correo y la Agenda Corporativa",
                            Summary = "Configura filtros automáticos, etiquetas por cliente y agenda reuniones sincronizadas en Google Calendar con enlaces automáticos a Google Meet.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Organización Efectiva en Gmail: Inbox Zero</h4>
<p>La acumulación de cientos de correos sin procesar genera pérdidas de tiempo y olvidos de pagos o compromisos. Implementa la metodología de 3 acciones inmediatas:</p>
<ol>
    <li><strong>Responder:</strong> Si la tarea requiere menos de 2 minutos, respóndela de inmediato.</li>
    <li><strong>Archivar:</strong> Si es meramente informativa, clasifícala con una etiqueta de cliente y archívala.</li>
    <li><strong>Programar:</strong> Si requiere trabajo profundo, conviértela en un evento de Google Calendar arrastrando el correo al panel lateral.</li>
</ol>

<h4>2. Programación de Citas en Google Calendar</h4>
<p>Crea calendarios secundarios (ej. 'Cobranzas', 'Reuniones de Proyecto') y comparte tu disponibilidad horaria para que colegas y clientes reserven espacios sin cruces de agenda.</p>"
                        }
                    },
                    Quiz = new QuizSeedData
                    {
                        Title = "Evaluación Sumativa: Ofimática en la Nube y Google Workspace",
                        Questions = new List<QuestionSeedData>
                        {
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál es la ventaja de utilizar una 'Vista de Filtro' en Google Sheets en lugar de un filtro tradicional?",
                                Options = new[]
                                {
                                    "Permite que un usuario filtre datos sin alterar la pantalla de los demás colaboradores que editan en tiempo real.",
                                    "Aumenta la velocidad de descarga de la computadora.",
                                    "Elimina automáticamente los registros duplicados de la base de datos.",
                                    "Convierte la hoja en un archivo PDF sin fórmulas."
                                },
                                CorrectIndex = 0,
                                Explanation = "Las vistas de filtro son personales e independientes, evitando que un filtro altere la vista de otros miembros del equipo en sesiones colaborativas."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Qué nivel de permiso en Google Drive permite a un usuario revisar el texto y proponer cambios sin modificar directamente el contenido original?",
                                Options = new[]
                                {
                                    "Administrador del dominio.",
                                    "Comentador (Commenter).",
                                    "Lector exclusivo.",
                                    "Propietario de facturación."
                                },
                                CorrectIndex = 1,
                                Explanation = "El rol de 'Comentador' faculta para dejar sugerencias y comentarios al margen, requiriendo que un editor las acepte para integrarlas al texto."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cómo se puede restaurar una versión anterior de un documento en Google Docs en caso de un error accidental?",
                                Options = new[]
                                {
                                    "Apagando el módem de internet.",
                                    "Accediendo al Historial de Versiones (Ctrl + Alt + Shift + H) y seleccionando la versión deseada.",
                                    "Enviando una solicitud física a las oficinas centrales de Google.",
                                    "Cerrando sesión en Gmail."
                                },
                                CorrectIndex = 1,
                                Explanation = "El historial de versiones conserva todos los cambios cronológicos guardados automáticamente en la nube, permitiendo restaurar cualquier punto anterior con un clic."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Qué acción realiza Google Docs al colocar '@correo@empresa.com' dentro de un comentario?",
                                Options = new[]
                                {
                                    "Bloquea la cuenta del usuario mencionado.",
                                    "Asigna una tarea directa al usuario y le remite una notificación por correo con acceso al párrafo.",
                                    "Borra el comentario de forma permanente.",
                                    "Descarga una copia en la carpeta de descargas del usuario."
                                },
                                CorrectIndex = 1,
                                Explanation = "La sintaxis de mención (@) genera una tarea asignada directamente a la persona y le envía una alerta por correo electrónico con enlace directo."
                            }
                        }
                    }
                },

                // =========================================================================
                // CURSO 3: FUNDAMENTOS DE CIBERSEGURIDAD BÁSICA Y REDES PARA PYMES
                // =========================================================================
                new CourseSeedData
                {
                    CategorySlug = "tecnologia-ia-ofimatica",
                    Title = "Fundamentos de Ciberseguridad Básica y Protección de Redes para Pymes",
                    Slug = "ciberseguridad-y-redes-pymes",
                    ShortDescription = "Protege los activos digitales de tu negocio: defensa contra phishing, autenticación en dos pasos, seguridad de contraseñas y protocolos para redes locales.",
                    Level = "Intermedio",
                    EstimatedHours = 16,
                    BadgeColor = "danger",
                    Modules = new List<ModuleSeedData>
                    {
                        new ModuleSeedData
                        {
                            Title = "Módulo 1: Amenazas de Ingeniería Social y Detección Temprana de Phishing",
                            LessonTitle = "Guía Práctica: Anatomía de un Ataque de Ingeniería Social",
                            Summary = "Aprende a reconocer correos maliciosos, suplantación de identidad (spoofing) y llamadas fraudulentas dirigidas a la administración de la empresa.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. La Ingeniería Social como Vector Principal de Ataque</h4>
<p>Más del 85% de las brechas de seguridad en pequeñas y medianas empresas no ocurren por vulnerabilidades complejas de software, sino por <strong>ingeniería social</strong>: tácticas psicológicas destinadas a manipular al personal para que entregue claves o ejecute archivos maliciosos.</p>

<div class=""card p-3 border-danger bg-light rounded-3 my-3"">
    <h6 class=""fw-bold text-danger mb-2""><i class=""bi bi-exclamation-triangle-fill me-1""></i> Señales de Alerta de un Correo de Phishing:</h6>
    <ul class=""small mb-0"">
        <li><strong>Urgencia o Amenaza Extrema:</strong> 'Su cuenta será cancelada en 2 horas si no actualiza sus credenciales bancarias'.</li>
        <li><strong>Discrepancia en el Remitente:</strong> El nombre para mostrar dice 'Banco Mercantil', pero la dirección real es <code>notificaciones@seguridad-banco-soporte.xyz</code>.</li>
        <li><strong>Archivos Adjuntos Sospechosos:</strong> Comprobantes de pago con extensiones <code>.zip</code>, <code>.exe</code>, <code>.iso</code> o macros de Word (<code>.docm</code>).</li>
    </ul>
</div>

<div class=""alert alert-info border-0 p-3 rounded-3"">
    <strong><i class=""bi bi-telephone-fill me-1""></i> Protocolo de Confirmación Fuera de Banda:</strong> Ante cualquier solicitud de cambio de número de cuenta bancaria o de pago inesperado de un proveedor, comunícate telefónicamente por un número previamente guardado, nunca por el número que aparece en el correo sospechoso.
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 2: Políticas de Contraseñas Fuertes y Autenticación Multifactor (MFA)",
                            LessonTitle = "Presentación Técnica: Protección de Accesos e Identidad Digital",
                            Summary = "Comprende por qué las contraseñas simples fallan ante ataques de fuerza bruta y cómo implementar autenticación multifactor (MFA) con apps TOTP.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. La Ilusión de las Contraseñas Simples</h4>
<p>Combinaciones como <code>Admin2026*</code> o <code>Empresa1234</code> son vulneradas en fracciones de segundo mediante ataques de diccionario y bases de datos filtradas en la Deep Web.</p>

<div class=""row g-3 my-3"">
    <div class=""col-md-6"">
        <div class=""card h-100 p-3 border-primary"">
            <h6 class=""fw-bold text-primary"">Frases de Contraseña (Passphrases)</h6>
            <p class=""small text-muted mb-0"">En lugar de palabras cortas, utiliza frases de 4 palabras inconexas: <code>Girasol-Trompeta-Carro-Azul-2026</code>. Su longitud hace matemáticamente inviable el descifrado por fuerza bruta.</p>
        </div>
    </div>
    <div class=""col-md-6"">
        <div class=""card h-100 p-3 border-success"">
            <h6 class=""fw-bold text-success"">Autenticación de Dos Factores (MFA / 2FA)</h6>
            <p class=""small text-muted mb-0"">Requiere algo que sabes (contraseña) y algo que posees (código temporal en app como Google Authenticator o Microsoft Authenticator). Aunque roben tu clave, no podrán acceder sin el token físico.</p>
        </div>
    </div>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 3: Seguridad en Redes Wi-Fi Locales y la Regla de Respaldo 3-2-1",
                            LessonTitle = "Guía de Infraestructura: Segmentación de Red y Respaldos Inmunes",
                            Summary = "Aprende a separar la red de invitados de la red contable de la empresa y a aplicar la regla de respaldo 3-2-1 contra ransomware.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Segmentación de Redes en la Empresa</h4>
<p>Nunca conectes los teléfonos personales de clientes o empleados a la misma red Wi-Fi donde se encuentran las computadoras de facturación y bases de datos. Configura en el router una <strong>Red de Invitados (Guest Network)</strong> con aislamiento de clientes.</p>

<div class=""card bg-light border p-3 rounded-3 my-3"">
    <h5 class=""fw-bold text-dark mb-2""><i class=""bi bi-database-fill-lock text-primary me-2""></i>La Regla de Respaldo 3-2-1 contra Ransomware</h5>
    <ul class=""mb-0 small"">
        <li><strong>3 Copias:</strong> Mantén tres copias de todos los datos críticos (la base de datos operativa y 2 respaldos).</li>
        <li><strong>2 Soportes Distintos:</strong> Utiliza al menos dos tipos de medios diferentes (ej. Disco duro externo cifrado y almacenamiento en la nube).</li>
        <li><strong>1 Copia Fuera de Sitio (Off-site):</strong> Conserva al menos un respaldo fuera de las instalaciones físicas de la empresa para protegerte ante incendios, robos o secuestro digital de red.</li>
    </ul>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 4: Protocolo de Respuesta a Incidentes y Protección de Datos",
                            LessonTitle = "Guía de Contingencia: Cómo Actuar ante una Infección o Fuga de Información",
                            Summary = "Conoce los pasos inmediatos ante una sospecha de ransomware: aislamiento físico de red, notificación y recuperación ordenada.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>Plan de Respuesta Inmediata ante Sospecha de Ransomware</h4>
<p>Si la pantalla de un equipo muestra una nota de rescate o los archivos comienzan a cambiar de extensión rápidamente, cada segundo cuenta para evitar que el malware se propague al resto de la oficina:</p>

<ol class=""my-3"">
    <li><strong>Desconexión Física Inmediata:</strong> Desconecta de inmediato el cable de red Ethernet y apaga el Wi-Fi del equipo afectado. No reinicies la máquina inmediatamente para no borrar volcados de memoria volátil.</li>
    <li><strong>Aislamiento de Servidores:</strong> Desconecta los discos duros externos y desconecta temporalmente las carpetas de red compartidas.</li>
    <li><strong>Restauración desde Respaldo Limpio:</strong> Nunca pagues rescate a ciberdelincuentes; no garantiza la recuperación y financia el cibercrimen. Restaura los datos desde el último respaldo validado.</li>
</ol>"
                        }
                    },
                    Quiz = new QuizSeedData
                    {
                        Title = "Evaluación Sumativa: Fundamentos de Ciberseguridad para Pymes",
                        Questions = new List<QuestionSeedData>
                        {
                            new QuestionSeedData
                            {
                                QuestionText = "¿En qué consiste la regla de respaldo 3-2-1 en la protección de datos?",
                                Options = new[]
                                {
                                    "Tener 3 contraseñas, cambiarlas cada 2 meses y compartirlas con 1 persona.",
                                    "Conservar 3 copias de datos, en 2 soportes diferentes, con al menos 1 copia fuera de la sede física.",
                                    "Hacer respaldos 3 veces al día durante 2 horas con 1 empleado.",
                                    "Comprar 3 computadoras cada 2 años con 1 solo antivirus."
                                },
                                CorrectIndex = 1,
                                Explanation = "La regla 3-2-1 exige 3 copias de la información en 2 tipos de almacenamiento distintos y 1 copia off-site (en la nube o fuera de sitio)."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Por qué la autenticación multifactor (MFA/2FA) con app es superior a usar solo contraseña?",
                                Options = new[]
                                {
                                    "Porque acelera la velocidad de internet en un 50%.",
                                    "Porque aunque un atacante obtenga la contraseña, no puede acceder sin el código temporal dinámico generado por el dispositivo físico del usuario.",
                                    "Porque permite iniciar sesión sin estar conectado a internet.",
                                    "Porque elimina la necesidad de recordar cualquier contraseña."
                                },
                                CorrectIndex = 1,
                                Explanation = "El segundo factor añade una capa que requiere posesión física del dispositivo del usuario, impidiendo accesos remotos basados únicamente en claves robadas."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál es la primera acción técnica inmediata que se debe tomar al detectar que un equipo está siendo cifrado por ransomware?",
                                Options = new[]
                                {
                                    "Pagar inmediatamente el monto solicitado en criptomonedas.",
                                    "Desconectar físicamente el cable de red y apagar el Wi-Fi para cortar la propagación lateral a otras computadoras de la empresa.",
                                    "Reenviar el correo malicioso a todos los clientes de la empresa.",
                                    "Instalar videojuegos para saturar la memoria RAM."
                                },
                                CorrectIndex = 1,
                                Explanation = "El aislamiento físico inmediato de la red impide que el ransomware alcance las unidades compartidas y otros servidores de la oficina."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Qué método se recomienda para validar un cambio inesperado en el número de cuenta bancaria solicitado por un proveedor vía correo?",
                                Options = new[]
                                {
                                    "Responder directamente al correo pidiendo confirmación.",
                                    "Hacer una llamada de verificación telefónica por un canal oficial y número previamente conocido (fuera de banda).",
                                    "Hacer la transferencia de inmediato sin preguntar.",
                                    "Ignorar el correo y no pagarle nunca más."
                                },
                                CorrectIndex = 1,
                                Explanation = "La verificación fuera de banda mediante llamada telefónica a un número previamente registrado previene fraudes de tipo BEC (Business Email Compromise)."
                            }
                        }
                    }
                },

                // =========================================================================
                // CURSO 4: GESTIÓN DE DATOS Y ANÁLISIS CON EXCEL (DE BÁSICO A AVANZADO)
                // =========================================================================
                new CourseSeedData
                {
                    CategorySlug = "tecnologia-ia-ofimatica",
                    Title = "Gestión de Datos y Análisis con Excel (De Básico a Avanzado)",
                    Slug = "gestion-datos-analisis-excel",
                    ShortDescription = "Domina Microsoft Excel desde la estructura de celdas hasta funciones lógicas, BUSCARV/BUSCARX, tablas dinámicas y gráficos interactivos para la toma de decisiones.",
                    Level = "Intermedio",
                    EstimatedHours = 20,
                    BadgeColor = "success",
                    Modules = new List<ModuleSeedData>
                    {
                        new ModuleSeedData
                        {
                            Title = "Módulo 1: Arquitectura de Hojas de Cálculo, Referencias y Fórmulas Aritméticas",
                            LessonTitle = "Guía Práctica: Referencias Absolutas ($A$1) y Estructura de Fórmulas",
                            Summary = "Domina la diferencia entre referencias relativas, absolutas y mixtas, fundamentales para calcular porcentajes e impuestos sin errores de arrastre.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Referencias Relativas vs. Absolutas ($)</h4>
<p>El error más frecuente al construir modelos en Excel ocurre al arrastrar fórmulas hacia abajo o a los lados. Comprender los signos de dólar (<code>$</code>) es vital:</p>

<div class=""table-responsive my-3"">
    <table class=""table table-bordered align-middle"">
        <thead class=""table-dark"">
            <tr><th>Tipo de Referencia</th><th>Sintaxis</th><th>Comportamiento al Arrastrar</th></tr>
        </thead>
        <tbody>
            <tr><td><strong>Relativa</strong></td><td><code>A1</code></td><td>La fila y columna cambian según la dirección del arrastre.</td></tr>
            <tr><td><strong>Absoluta</strong></td><td><code>$A$1</code></td><td>La celda queda completamente fija. Ideal para celdas con la tasa BCV, porcentaje de IVA o comisiones.</td></tr>
            <tr><td><strong>Mixta</strong></td><td><code>$A1</code> o <code>A$1</code></td><td>Fija únicamente la columna o la fila respectivamente. Vital para matrices de doble entrada.</td></tr>
        </tbody>
    </table>
</div>

<div class=""alert alert-success border-0 p-3 rounded-3"">
    <strong><i class=""bi bi-magic me-1""></i> Atajo Productivo:</strong> Selecciona la referencia en la barra de fórmulas y presiona la tecla <code>F4</code> para alternar rápidamente entre <code>A1</code>, <code>$A$1</code>, <code>A$1</code> y <code>$A1</code>.
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 2: Funciones Lógicas y Búsqueda Avanzada (SI, Y, O, BUSCARX)",
                            LessonTitle = "Presentación Técnica: Automatización de Decisiones y Cruce de Tablas",
                            Summary = "Aprende a condicionar cálculos con SI anidado y a reemplazar BUSCARV por BUSCARX (XLOOKUP) para búsquedas bidireccionales y tolerantes a errores.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Lógica Condicional: Función SI, Y, O</h4>
<p>Permite evaluar reglas de negocio automáticas:</p>
<pre class=""bg-dark text-white p-3 rounded-3 small""><code>=SI(Y(B2>=1000, C2=""Contado""), B2*0.05, 0)</code></pre>
<p class=""small text-muted"">Otorga 5% de descuento solo si las ventas superan $1,000 Y la forma de pago es de contado.</p>

<h4>2. La Revolución de BUSCARX (XLOOKUP)</h4>
<p>Supera las limitaciones del antiguo <code>BUSCARV</code> (que exigía ordenar de izquierda a derecha y se rompía al insertar columnas):</p>
<pre class=""bg-dark text-white p-3 rounded-3 small""><code>=BUSCARX(F2, A2:A500, D2:D500, ""No Encontrado"")</code></pre>
<p class=""small text-muted"">Busca el código de la celda F2 en la columna A y devuelve el precio de la columna D, devolviendo un texto amigable si no existe.</p>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 3: Depuración, Limpieza de Texto y Validación de Celdas",
                            LessonTitle = "Guía Operativa: Normalización de Bases de Datos",
                            Summary = "Limpia espacios en blanco residuales, unifica textos con CONCAT y establece listas desplegables para impedir errores de tipeo.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Limpieza de Texto para Conciliaciones</h4>
<p>Al importar datos de sistemas bancarios o ERPs, los textos suelen venir con espacios invisibles que arruinan las coincidencias de fórmulas. Aplica estas funciones:</p>
<ul>
    <li><code>=ESPACIOS(A2)</code>: Elimina todos los espacios dobles y residuales al inicio y final.</li>
    <li><code>=NOMPROPIO(A2)</code>: Convierte nombres a mayúscula inicial respetando el estándar formal.</li>
    <li><code>=TEXTO(B2, ""dd/mm/aaaa"")</code>: Estandariza fechas para reportes ejecutivos.</li>
</ul>

<h4>2. Validación de Datos (Listas Desplegables)</h4>
<p>Desde la pestaña <em>Datos &gt; Validación de datos</em>, restringe celdas a una lista fija (ej. <code>Pendiente, Aprobado, Rechazado</code>) para garantizar que los operadores nunca ingresen valores con errores tipográficos.</p>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 4: Tablas Dinámicas, Segmentadores y Construcción de Dashboards",
                            LessonTitle = "Presentación Ejecutiva: Reportes Gerenciales Interactivos",
                            Summary = "Crea resúmenes multidimensionales en segundos, añade campos calculados y construye un panel interactivo con segmentadores visuales de fecha y categoría.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Creación Eficiente de Tablas Dinámicas</h4>
<p>Una <strong>Tabla Dinámica</strong> permite resumir 50,000 filas de transacciones en una cuadrícula compacta con totales por vendedor, mes y sucursal sin redactar una sola fórmula manual.</p>

<div class=""row g-3 my-3"">
    <div class=""col-md-6"">
        <div class=""border p-3 rounded-3 bg-white"">
            <h6 class=""fw-bold text-primary"">Segmentación de Datos (Slicers)</h6>
            <p class=""small text-muted mb-0"">Añade botones visuales clicables para que gerencia filtre ventas por año, trimestre o estado geográfico instantáneamente.</p>
        </div>
    </div>
    <div class=""col-md-6"">
        <div class=""border p-3 rounded-3 bg-white"">
            <h6 class=""fw-bold text-success"">Gráficos Dinámicos Conectados</h6>
            <p class=""small text-muted mb-0"">Conecta gráficos de barras y líneas a la tabla dinámica para que se actualicen en vivo al tocar los segmentadores.</p>
        </div>
    </div>
</div>"
                        }
                    },
                    Quiz = new QuizSeedData
                    {
                        Title = "Evaluación Sumativa: Gestión de Datos y Análisis con Excel",
                        Questions = new List<QuestionSeedData>
                        {
                            new QuestionSeedData
                            {
                                QuestionText = "¿Qué efecto produce aplicar el signo de dólar ($) como '$B$5' en una fórmula de Excel?",
                                Options = new[]
                                {
                                    "Convierte el valor de la celda a moneda Dólar estadounidense.",
                                    "Fija de manera absoluta tanto la columna B como la fila 5 para que no cambien al arrastrar la fórmula.",
                                    "Oculta la celda para que no aparezca en la impresión.",
                                    "Borra el contenido de la celda si el resultado es cero."
                                },
                                CorrectIndex = 1,
                                Explanation = "La notación '$B$5' convierte la celda en referencia absoluta fija, impidiendo que la posición cambie al duplicar la fórmula en otras celdas."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál es una ventaja clave de la función BUSCARX (XLOOKUP) sobre el tradicional BUSCARV?",
                                Options = new[]
                                {
                                    "Solo funciona con números impares.",
                                    "Puede buscar hacia la izquierda, no se rompe al insertar columnas intermedias y maneja errores nativamente.",
                                    "Requiere que la computadora esté conectada a un servidor SQL.",
                                    "Es una función exclusiva de Word."
                                },
                                CorrectIndex = 1,
                                Explanation = "BUSCARX supera a BUSCARV al no requerir que la columna de búsqueda sea la primera a la izquierda y soportar valores predeterminados para coincidencias fallidas."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Para qué sirve la herramienta de 'Validación de Datos' con opción de Lista en Excel?",
                                Options = new[]
                                {
                                    "Para formatear los bordes de la tabla en color dorado.",
                                    "Para obligar al usuario a elegir un valor de una lista predefinida, eliminando errores de tipeo.",
                                    "Para ordenar los datos en orden alfabético inverso automáticamente.",
                                    "Para enviar la hoja por correo electrónico."
                                },
                                CorrectIndex = 1,
                                Explanation = "La validación por lista crea un menú desplegable en la celda que garantiza la consistencia e integridad de los datos ingresados."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Qué componente interactivo se asocia a las Tablas Dinámicas para crear filtros visuales estilo botones en un Dashboard?",
                                Options = new[]
                                {
                                    "Segmentación de Datos (Slicers).",
                                    "Macro de Visual Basic 6.0.",
                                    "Impresión a PDF.",
                                    "Fuente en negrita."
                                },
                                CorrectIndex = 0,
                                Explanation = "Los segmentadores de datos (Slicers) son controles visuales que permiten filtrar de forma interactiva una o varias tablas dinámicas conectadas."
                            }
                        }
                    }
                },

                // =========================================================================
                // CURSO 5: TRANSFORMACIÓN DIGITAL Y APLICACIONES INFORMÁTICAS DE GESTIÓN (EMPRESAS 4.0)
                // =========================================================================
                new CourseSeedData
                {
                    CategorySlug = "tecnologia-ia-ofimatica",
                    Title = "Introducción a la Transformación Digital y Aplicaciones Informáticas de Gestión (Empresas 4.0)",
                    Slug = "transformacion-digital-empresas",
                    ShortDescription = "Descubre cómo las empresas modernas integran sistemas ERP, CRM en la nube, facturación digital y automatización de procesos para escalar su competitividad.",
                    Level = "Intermedio",
                    EstimatedHours = 18,
                    BadgeColor = "info",
                    Modules = new List<ModuleSeedData>
                    {
                        new ModuleSeedData
                        {
                            Title = "Módulo 1: Fundamentos de la Empresa 4.0 y la Transformación Digital",
                            LessonTitle = "Guía Conceptual: De la Digitalización de Documentos a la Agilidad Operativa",
                            Summary = "Comprende qué es la transformación digital real: no solo comprar software, sino rediseñar procesos para generar valor continuo al cliente.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Qué es (y qué no es) la Transformación Digital</h4>
<p>Escanear facturas en papel para guardarlas como PDF no es transformación digital; es simple digitalización analógica. La verdadera <strong>Transformación Digital (Empresas 4.0)</strong> implica rediseñar los procesos de negocio para que la información fluya sin fricción humana entre departamentos, basando las decisiones en datos en tiempo real.</p>

<div class=""row g-3 my-3"">
    <div class=""col-md-4"">
        <div class=""card p-3 border h-100 bg-light"">
            <h6 class=""fw-bold text-primary"">1. Nivel Datos</h6>
            <p class=""small text-muted mb-0"">Unificación de inventario, finanzas y clientes en una sola fuente verídica (Single Source of Truth).</p>
        </div>
    </div>
    <div class=""col-md-4"">
        <div class=""card p-3 border h-100 bg-light"">
            <h6 class=""fw-bold text-success"">2. Nivel Procesos</h6>
            <p class=""small text-muted mb-0"">Automatización de tareas mecánicas: alertas de stock mínimo, cobros recurrentes y conciliaciones bancarias.</p>
        </div>
    </div>
    <div class=""col-md-4"">
        <div class=""card p-3 border h-100 bg-light"">
            <h6 class=""fw-bold text-warning"">3. Nivel Cultura</h6>
            <p class=""small text-muted mb-0"">Capacitación del talento humano para liderar con herramientas digitales sin temor a la obsolescencia.</p>
        </div>
    </div>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 2: Sistemas Integrados de Gestión ERP y CRM en la Nube",
                            LessonTitle = "Presentación Técnica: La Columna Vertebral del Negocio Digital",
                            Summary = "Conoce cómo operan los sistemas de planificación de recursos empresariales (ERP) y los gestores de relación con clientes (CRM).",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Sistemas ERP (Enterprise Resource Planning)</h4>
<p>Un sistema <strong>ERP</strong> centraliza en una sola base de datos todos los módulos funcionales de la organización: compras, inventario, almacén, facturación, cuentas por cobrar y contabilidad general.</p>

<div class=""table-responsive my-3"">
    <table class=""table table-bordered align-middle"">
        <thead class=""table-dark"">
            <tr><th>Sistema</th><th>Objetivo Central</th><th>Módulos Clave</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong class=""text-primary"">ERP</strong></td>
                <td>Optimizar la eficiencia operativa interna y el control de costos.</td>
                <td>Inventarios, Compras, Facturación, Tesorería, Nómina, Contabilidad.</td>
            </tr>
            <tr>
                <td><strong class=""text-success"">CRM</strong></td>
                <td>Maximizar la captación, conversión y fidelización de clientes.</td>
                <td>Embudo de ventas (Pipeline), Historial de contactos, Soporte posventa.</td>
            </tr>
        </tbody>
    </table>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 3: Facturación Electrónica, Pasarelas de Pago Digital y Conciliación",
                            LessonTitle = "Guía Operativa: El Ecosistema de Pagos Digitales",
                            Summary = "Aprende a integrar pasarelas de cobro, conciliación automática bancaria y liquidación multimoneda a tasa oficial.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Reducción de la Fricción en el Cobro Comercial</h4>
<p>Los negocios que limitan sus opciones de cobro experimentan tasas de abandono de clientes superiores al 40%. La empresa 4.0 implementa pasarelas omnicanal:</p>
<ul>
    <li><strong>Pago Móvil y Transferencia Bancaria Inmediata:</strong> Liquidación instantánea con validación de código de referencia bancaria.</li>
    <li><strong>Criptoactivos Estables (USDT / Binance Pay):</strong> Cobro internacional sin costos de comisiones SWIFT ni demoras transfronterizas.</li>
    <li><strong>Liquidación Oficial BCV:</strong> Cumplimiento normativo estricto con cálculo automatizado a la cotización oficial del día.</li>
</ul>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 4: Gestión del Cambio Organizacional y Métricas Digitales (KPIs)",
                            LessonTitle = "Guía Estratégica: Liderazgo y Medición del Éxito Tecnológico",
                            Summary = "Supera la resistencia humana al cambio tecnológico y define indicadores clave de rendimiento (KPIs) para evaluar la digitalización.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Vencer la Resistencia al Cambio</h4>
<p>La principal causa de fracaso en la implementación de un nuevo software de gestión no es técnica, sino humana: los colaboradores prefieren seguir utilizando hojas de cálculo desordenadas o cuadernos por costumbre.</p>

<div class=""card p-3 border-0 bg-light rounded-3 my-3"">
    <h6 class=""fw-bold text-dark mb-2""><i class=""bi bi-graph-up-arrow text-success me-2""></i>Métricas Clave de Transformación Digital (KPIs):</h6>
    <ul class=""mb-0 small"">
        <li><strong>Tasa de Adopción de Software:</strong> Porcentaje de transacciones procesadas dentro del sistema versus métodos manuales.</li>
        <li><strong>Tiempo del Ciclo de Facturación:</strong> Reducción de horas requeridas para emitir y conciliar pagos.</li>
        <li><strong>Tasa de Error en Inventario:</strong> Discrepancia entre el stock físico y el stock registrado en el sistema ERP.</li>
    </ul>
</div>"
                        }
                    },
                    Quiz = new QuizSeedData
                    {
                        Title = "Evaluación Sumativa: Transformación Digital y Empresas 4.0",
                        Questions = new List<QuestionSeedData>
                        {
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál es la función primordial de un sistema ERP (Enterprise Resource Planning)?",
                                Options = new[]
                                {
                                    "Centralizar en una sola base de datos los módulos operativos como compras, inventario, facturación y contabilidad.",
                                    "Diseñar logotipos y folletos publicitarios para redes sociales.",
                                    "Acelerar la velocidad del disco duro de las computadoras.",
                                    "Reemplazar por completo a los directores de la empresa."
                                },
                                CorrectIndex = 0,
                                Explanation = "Un ERP integra y centraliza todas las áreas operativas de la empresa, evitando silos de información y duplicación de tareas."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál es la diferencia esencial entre un ERP y un CRM?",
                                Options = new[]
                                {
                                    "El ERP optimiza procesos operativos internos (inventario, costos, finanzas), mientras que el CRM gestiona las relaciones y ventas con los clientes.",
                                    "El CRM es un hardware físico y el ERP es un cable de red.",
                                    "El ERP solo funciona en teléfonos y el CRM en computadoras portátiles.",
                                    "No existe ninguna diferencia; son exactamente lo mismo."
                                },
                                CorrectIndex = 0,
                                Explanation = "El ERP mira hacia el interior de la operación (inventario, finanzas, suministros), mientras que el CRM mira hacia el mercado y el cliente (prospectos, ventas, soporte)."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Por qué es riesgoso considerar que escanear documentos en PDF ya constituye 'Transformación Digital'?",
                                Options = new[]
                                {
                                    "Porque la transformación digital requiere rediseñar procesos para que los datos fluyan en tiempo real y automaticen decisiones, no solo cambiar el papel por PDF.",
                                    "Porque los archivos PDF están prohibidos por las leyes internacionales.",
                                    "Porque los escáneres gastan demasiada energía eléctrica.",
                                    "Porque los PDFs no pueden abrirse en teléfonos celulares."
                                },
                                CorrectIndex = 0,
                                Explanation = "Escanear papel es mera digitalización de soporte; la transformación digital implica optimizar la lógica y flujo de los procesos con datos estructurados."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál suele ser el obstáculo más común y determinante en el fracaso de implantación de nuevos sistemas empresariales?",
                                Options = new[]
                                {
                                    "La resistencia humana al cambio y la falta de capacitación progresiva de los colaboradores.",
                                    "El color de los botones en la pantalla del sistema.",
                                    "La marca del teclado de las computadoras.",
                                    "La temperatura ambiente de la oficina."
                                },
                                CorrectIndex = 0,
                                Explanation = "La resistencia de las personas al cambio es el factor crítico de fracaso si no se acompaña de formación, liderazgo empático y demostración de beneficios prácticos."
                            }
                        }
                    }
                }
            };
        }
    }
}
