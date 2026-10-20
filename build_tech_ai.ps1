$techAiFile = "c:\Users\plase\source\repos\CursosCertificadosApp\CursosCertificadosApp\Data\CurriculumUpgrade.TechAI.cs"

# We read the existing file to extract questions for each course
$oldContent = Get-Content $techAiFile -Raw -Encoding UTF8

function Extract-Questions ($slug) {
    global:oldContent
    $pattern = '(?s)Slug\s*=\s*"' + [regex]::Escape($slug) + '".*?Questions\s*=\s*(new List<UpgradeQuestionData>\s*\{.*?\n\s*\})\s*\}'
    if ($oldContent -match $pattern) {
        return $matches[1]
    }
    Write-Warning "Could not extract questions for $slug"
    return "new List<UpgradeQuestionData>()"
}

$qGemini = Extract-Questions "domina-la-ia-con-gemini"
$qSec = Extract-Questions "introduccion-ciberseguridad"
$qSupport = Extract-Questions "servicio-tecnico-informatico-soporte-sistemas"
$qTI = Extract-Questions "ti-para-el-exito-empresarial"

$newCode = @'
using CursosCertificadosApp.Models.Entities;

namespace CursosCertificadosApp.Data
{
    public static class CurriculumUpgradeTechAI
    {
        public static async Task UpgradeAsync(AppDbContext context)
        {
            var courses = GetCourses();
            foreach (var courseData in courses)
            {
                await CurriculumUpgradeHelper.ApplyCourseUpgradeAsync(context, courseData);
            }
        }

        public static List<UpgradeCourseData> GetCourses()
        {
            return new List<UpgradeCourseData>
            {
                // =========================================================================
                // 1. DOMINA LA IA CON GEMINI Y CHATGPT
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "domina-la-ia-con-gemini",
                    Title = "Domina la IA con Gemini y ChatGPT: Prompt Engineering Avanzado y Productividad Empresarial",
                    CategorySlug = "tecnologia-ia-ofimatica",
                    ShortDescription = "Aprende a redactar prompts de nivel profesional, estructurar contextos con Few-Shot prompting, automatizar minutas de reuniones, analizar datos y redactar informes de oficina.",
                    FullDescription = "Capacitación práctica y avanzada en Inteligencia Artificial Generativa aplicada al trabajo corporativo. Domina la anatomía del prompt perfecto (Rol, Contexto, Instrucción, Formato de salida y Restricciones), técnicas de Few-Shot y Chain-of-Thought, automatización de resúmenes ejecutivos, formulación de consultas complejas en Excel, redacción de correos comerciales de alta persuasión y análisis ético de seguridad de datos corporativos.",
                    Level = "Intermedio",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Arquitectura de LLMs y la Anatomía del Prompt Perfecto (Framework RTFR)",
                            LessonTitle = "De Consultas Vagas a Instrucciones de Precisión Quirúrgica",
                            Summary = "Comprende cómo funcionan los Grandes Modelos de Lenguaje (LLMs), por qué ocurren las alucinaciones y cómo aplicar la estructura RTFR (Rol, Tarea, Formato, Restricciones) para obtener respuestas ejecutivas al primer intento.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-stars fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La IA es tan Inteligente como la Calidad de tu Instrucción</h5>
            <p class=""mb-0 small"">Pedirle a Gemini o ChatGPT 'escribe un correo para un cliente' produce un texto plano e inútil. El Prompt Engineering es la habilidad técnica de programar a la IA en lenguaje natural con directrices precisas y cuantificables.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/p2PqfRte46k"" title=""La Fórmula del Prompt Perfecto para ChatGPT (Guía Definitiva)"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Fundamentos de los Modelos de Lenguaje y Tokenización</h4>
    <p>Para utilizar herramientas como <strong>Google Gemini</strong> y <strong>OpenAI ChatGPT</strong> con eficacia corporativa, es indispensable derribar el mito de que 'la IA piensa o razona como un ser humano'. En realidad, los Grandes Modelos de Lenguaje (LLMs) son gigantescas redes neuronales probabilísticas entrenadas con billones de fragmentos de texto. Su función central consiste en predecir matemáticamente cuál es la siguiente unidad lingüística más coherente (denominada <em>token</em>, equivalente aproximado a 4 caracteres o tres cuartos de palabra en español) dado el contexto que el usuario le suministra.</p>
    <p>Cuando un profesional envía un mensaje sin contexto ('redacta un informe de ventas'), el modelo se ve obligado a explorar un espacio de probabilidades inmenso, entregando un resultado genérico, vago y carente de utilidad práctica. Por el contrario, cuando delimitamos la conversación aportando antecedentes específicos, el modelo restringe su espacio probabilístico a la terminología, tono y estructura requeridos por la organización.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-boxes text-primary me-2""></i>2. El Framework R.T.F.R. para Prompts de Alto Impacto</h4>
    <p>Para garantizar que cada instrucción genere una respuesta ejecutiva y aplicable sin necesidad de repreguntar múltiples veces, los consultores en productividad recomiendan estructurar el requerimiento bajo el estándar <strong>R.T.F.R.</strong>:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th style=""width: 15%;"">Componente</th>
                    <th style=""width: 25%;"">Función Pedagógica</th>
                    <th>Ejemplo Aplicado a una Empresa Real</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-primary"">R - Rol (Role)</td>
                    <td>Define la perspectiva experta, el nivel de seniority y el vocabulario técnico que la IA adoptará.</td>
                    <td><code>Actúa como un Director Financiero (CFO) y Auditor Corporativo con 20 años de trayectoria en retail.</code></td>
                </tr>
                <tr>
                    <td class=""fw-bold text-primary"">T - Tarea (Task)</td>
                    <td>Describe el objetivo operativo exacto, sin ambigüedades, verbos difusos ni peticiones cruzadas.</td>
                    <td><code>Analiza este estado de resultados preliminar del mes y detecta los 3 centros de costo con mayor desviación desfavorable frente al presupuesto.</code></td>
                </tr>
                <tr>
                    <td class=""fw-bold text-primary"">F - Formato (Format)</td>
                    <td>Fija la disposición visual de la respuesta: tablas, listas con viñetas, esquemas de reporte o código.</td>
                    <td><code>Presenta los hallazgos en una tabla comparativa con columnas: Centro de Costo, Presupuesto, Real, Desviación % y Acción Correctiva Sugerida.</code></td>
                </tr>
                <tr>
                    <td class=""fw-bold text-primary"">R - Restricciones (Restrictions)</td>
                    <td>Establece fronteras estrictas para erradicar el relleno, limitar extensión y prohibir alucinaciones.</td>
                    <td><code>No utilices saludos de cortesía ni introducciones vacías. Limítate a los datos suministrados. Máximo 250 palabras de análisis cualitativo.</code></td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-briefcase-fill text-primary me-2""></i>3. Caso de Estudio Empresarial: De la Instrucción Pobre al Prompt Profesional</h4>
    <div class=""card border-0 bg-light p-3 rounded-3 mb-4"">
        <h6 class=""fw-bold text-dark mb-2"">Escenario: Redacción de Reclamo Formal por Incumplimiento de Entrega</h6>
        <div class=""row g-3"">
            <div class=""col-md-6"">
                <div class=""p-3 bg-white rounded border border-danger h-100"">
                    <span class=""badge bg-danger mb-2"">Prompt Inadecuado (Resultado Mediocre)</span>
                    <p class=""small text-muted mb-0 font-monospace"">""Escribe una carta brava para un proveedor que no entregó la mercancía a tiempo y nos causó problemas.""</p>
                    <p class=""small text-secondary mt-2 mb-0""><em>Consecuencia:</em> La IA genera una carta genérica, cargada de agresividad infantil, sin fechas, sin referencias a cláusulas y sin fuerza jurídica mercantil.</p>
                </div>
            </div>
            <div class=""col-md-6"">
                <div class=""p-3 bg-white rounded border border-success h-100"">
                    <span class=""badge bg-success mb-2"">Prompt RTFR Profesional (Resultado Listo para Firma)</span>
                    <p class=""small text-dark mb-0 font-monospace"">""Actúa como Abogado Mercantil y Gerente de Compras. Redacta una notificación formal de intimación dirigida a 'Distribuciones Logísticas C.A.' por retraso de 14 días en la entrega de la Orden de Compra N° OC-4029. Cita la Cláusula 8 de penalidad diaria (0.5%). Exige entrega en 48 horas bajo apercibimiento de rescisión contractual y cobro de fianza. Tono firme, institucional y estrictamente profesional. Formato carta formal con membrete y campos entre corchetes.""</p>
                </div>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes y Cómo Evitarlos</h4>
    <ul>
        <li><strong>Instrucciones Negativas Ineficaces:</strong> Indicar 'no seas aburrido' o 'no uses lenguaje complejo' suele provocar confusión en los pesos de atención del modelo. Siempre es preferible usar pautas positivas directas: <em>'Utiliza oraciones breves, vocabulario accesible y tono comercial persuasivo'</em>.</li>
        <li><strong>Sobrecargar el Primer Turno con Información No Filtrada:</strong> Pegar un texto caótico de 20 páginas sin explicar primero qué se espera hacer con él genera respuestas superficiales. Primero define el marco analítico, y luego entrega los datos por bloques.</li>
        <li><strong>Falta de Parámetros de Extensión Cuantificables:</strong> Si pides 'un resumen', el modelo puede redactar 3 párrafos o 5 páginas según su configuración. Solicita siempre: <em>'Máximo 150 palabras divididas en 3 viñetas concisas'</em>.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Definiste claramente quién es el emisor ideal de la respuesta (Rol)?</li>
            <li>¿Indicaste el destinatario final del documento (Director, Cliente, Equipo Operativo)?</li>
            <li>¿Especificaste el formato de entrega (Tabla Markdown, Lista con viñetas, Código ejecutable)?</li>
            <li>¿Pusiste restricciones explícitas de longitud, tono y prohibición de supuestos no verificables?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Técnicas Avanzadas: Few-Shot Prompting, Chain of Thought y Roles Multidisciplinarios",
                            LessonTitle = "Guía a la IA Paso a Paso con Ejemplos y Razonamiento Lógico",
                            Summary = "Domina el aprendizaje por ejemplos (Few-Shot) para estandarizar el tono de marca y la técnica de Cadena de Pensamiento (Chain of Thought) para resolver problemas matemáticos, lógicos y financieros complejos.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-diagram-3-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Pensar Antes de Responder: Chain of Thought y Few-Shot</h5>
            <p class=""mb-0 small"">Cuando le pides a un modelo de IA que razone paso a paso ('Piensa paso a paso antes de dar el veredicto final'), la tasa de precisión matemática y lógica aumenta de un 60% a más del 92% en pruebas corporativas estandarizadas.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/5wQw3T9tb3c"" title=""🎓CURSO PROMPT ENGINEERING  en Español - GRATIS - 🤖CLASE 06- ZERO SHOT, ONE-SHOT, FEW-SHOT PROMPTING"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Jerarquía del Aprendizaje en el Contexto: De Zero a Few-Shot</h4>
    <p>En el uso diario de modelos como Gemini, existen tres niveles de contextualización según la cantidad de referencias previas suministradas:</p>
    <ul>
        <li><strong>Zero-Shot (Cero Ejemplos):</strong> Se le solicita al modelo realizar una tarea directamente sin proveer ningún patrón previo. Es útil para consultas sencillas de cultura general o traducciones literales, pero altamente riesgoso para tareas corporativas donde la empresa tiene un manual de estilo propio.</li>
        <li><strong>One-Shot (Un Ejemplo):</strong> Se le entrega un único par modelo de <em>Entrada ➔ Salida esperada</em>. Con esto el modelo alinea el vocabulario básico y la longitud deseada.</li>
        <li><strong>Few-Shot (Múltiples Ejemplos de Referencia):</strong> Se introducen de 3 a 5 ejemplos perfectamente estructurados antes de plantear la tarea real. Esta técnica elimina la ambigüedad y permite a la IA replicar clasificaciones complejas (por ejemplo: categorizar correos de clientes como 'Urgente Financiero', 'Duda Operativa' o 'Reclamo Legal') con más del 98% de fidelidad al criterio humano del departamento.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-cpu text-primary me-2""></i>2. La Técnica Chain-of-Thought (Cadena de Pensamiento)</h4>
    <p>Los LLMs no cuentan con una memoria de cálculo separada para números; calculan texto en base a probabilidades. Si le pides a una IA que calcule de golpe el inventario final con mermas y traslados múltiples, es probable que cometa un error aritmético. Sin embargo, al instruir al modelo a <strong>explicitar su razonamiento paso a paso</strong> antes de emitir la cifra definitiva, forzamos a la red a generar tokens de cálculo intermedio que retroalimentan el cálculo final.</p>

    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <h6 class=""fw-bold text-dark mb-2""><i class=""bi bi-terminal text-success me-2""></i>Estructura Práctica de un Prompt Chain-of-Thought (CoT) en Logística</h6>
        <p class=""small text-muted mb-2 font-monospace"">
            ""Actúa como Supervisor de Almacén. Tenemos la siguiente situación operativa:<br />
            - Inventario inicial el lunes: 1.250 bultos.<br />
            - El martes despachamos 420 bultos a sucursales.<br />
            - El miércoles recibimos 600 bultos, pero tras la inspección de calidad se rechaza el 8% por rotura de embalaje.<br />
            - El jueves transferimos el 25% del stock remanente disponible a la bodega secundaria.<br /><br />
            <strong>Instrucción Metodológica:</strong> No entregues la respuesta directamente. Resuelve desglosando obligatoriamente los siguientes 4 pasos:<br />
            Paso 1: Saldo neto al cierre del martes.<br />
            Paso 2: Bultos recibidos aptos el miércoles (mostrando el cálculo del 8% de rechazo y redondeo al entero más cercano).<br />
            Paso 3: Cálculo del 25% transferido el jueves sobre el saldo acumulado real.<br />
            Paso 4: Saldo final exacto de bultos en la bodega principal al cierre de semana en una tabla resumen.""
        </p>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-people-fill text-primary me-2""></i>3. Roles Multidisciplinarios y Comités de Expertos Virtuales</h4>
    <p>Para decisiones estratégicas (como evaluar el lanzamiento de un nuevo servicio o auditar un contrato), una técnica de vanguardia es simular un <em>Comité Virtual de Evaluación</em>. En lugar de pedir una sola opinión, solicitas que la IA analice el documento desde 3 ópticas simultáneas:</p>
    <ol>
        <li><strong>El Abogado Corporativo:</strong> Identifica riesgos legales, vacíos de responsabilidad civil y sanciones aplicables.</li>
        <li><strong>El Gerente de Operaciones:</strong> Evalúa la viabilidad técnica, tiempos de entrega y capacidad de personal.</li>
        <li><strong>El Director de Experiencia del Cliente (CX):</strong> Analiza el impacto en la satisfacción, facilidad de uso y percepción de marca.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos en el Uso de Técnicas Avanzadas</h4>
    <ul>
        <li><strong>Proveer Ejemplos Few-Shot Contradictorios:</strong> Si en el ejemplo 1 clasificas un reclamo como 'Nivel 1' y en el ejemplo 2 clasificas una queja idéntica como 'Nivel 3', el modelo se confundirá y generará clasificaciones erráticas.</li>
        <li><strong>Olvidar Desactivar el Razonamiento Extenso en Respuestas Finales:</strong> Para flujos automáticos donde solo requieres un dato ('Aprobado' o 'Rechazado'), debes indicar al final: <em>'Tras concluir el razonamiento interno, tu última línea debe contener exclusivamente la palabra de decisión'</em>.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Usaste la directriz 'Razona paso a paso' en prompts con cálculos o lógica de decisión?</li>
            <li>¿Verificaste que tus ejemplos Few-Shot tengan un formato 100% homogéneo?</li>
            <li>¿Separaste claramente las secciones de 'Contexto', 'Ejemplos' y 'Tarea Nueva' usando delimitadores como comillas triples ("""") o encabezados Markdown?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Flujos de Trabajo de Oficina: Minutas de Reunión, Contratos y Fórmulas Excel",
                            LessonTitle = "Productividad 10x en las Tareas Administrativas Diarias",
                            Summary = "Implementa flujos de trabajo de alta velocidad para convertir notas sucias en actas corporativas pulidas, comparar contratos de proveedores y redactar fórmulas avanzadas de Excel a partir de necesidades en lenguaje natural.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-speedometer2 fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">De la Teoría a la Automatización del Trabajo Diario</h5>
            <p class=""mb-0 small"">El verdadero valor de la Inteligencia Artificial en la oficina no es responder preguntas curiosas, sino eliminar horas de tareas administrativas repetitivas como minutas, auditoría de contratos y formulación de hojas de cálculo.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/ICqv3erKd84"" title=""Cómo calcular las horas trabajadas en excel"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Automatización de Minutas y Acuerdos de Reunión</h4>
    <p>Uno de los mayores sumideros de tiempo en las organizaciones es redactar las actas de reunión. Durante una sesión de trabajo de 60 minutos se toman notas rápidas y fragmentadas. Con un prompt bien estructurado, es posible transformar esos apuntes en un documento formal institucional en menos de 30 segundos.</p>
    <p>Para lograrlo, se instruye al modelo para que aplique la estructura estándar de minutas corporativas: <strong>Objetivo de la Sesión, Asistentes Clave, Temas Discutidos, Acuerdos Formalizados y Matriz RACI de Responsables con Fechas Límite</strong>.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-file-earmark-diff-fill text-primary me-2""></i>2. Análisis y Comparativa de Propuestas de Proveedores</h4>
    <p>Cuando un analista de compras recibe tres cotizaciones técnicas de 15 páginas cada una, comparar términos comerciales, tiempos de entrega y coberturas de garantía manualmente toma medio día de trabajo. Con la capacidad de lectura documental de Gemini, se puede cargar el contenido o texto de las tres ofertas y ejecutar un prompt de análisis comparativo:</p>
    <div class=""card border-0 bg-light p-3 mb-3 rounded-3"">
        <p class=""small mb-0 font-monospace text-dark"">
            ""Actúa como Especialista en Licitaciones Corporativas. A continuación te pego las cotizaciones de Proveedor A, Proveedor B y Proveedor C para la adquisición de 50 equipos de cómputo.<br />
            Genera una matriz comparativa en formato tabla Markdown con las siguientes columnas obligatorias:<br />
            1. Proveedor | 2. Precio Unitario USD | 3. Precio Total con IVA | 4. Tiempo de Entrega en Días Hábiles | 5. Cobertura de Garantía | 6. Condiciones de Pago | 7. Puntos Críticos de Riesgo.<br />
            Al pie de la tabla, incluye un párrafo de veredicto con la opción más costo-eficiente argumentada técnicamente.""
        </p>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-file-earmark-spreadsheet-fill text-primary me-2""></i>3. Generación y Depuración de Fórmulas Complejas de Excel</h4>
    <p>Muchos profesionales pierden horas buscando en foros de internet cómo anidar funciones complejas como <code>BUSCARX</code>, <code>INDICE/COINCIDIR</code> o <code>SUMAR.SI.CONJUNTO</code>. Para que la IA proporcione la fórmula exacta sin fallos de sintaxis en español, se debe seguir la regla de los tres datos clave:</p>
    <ol>
        <li><strong>Nombres exactos de las hojas y rangos de celdas:</strong> Especificar dónde están los datos de búsqueda y dónde debe escribirse el resultado.</li>
        <li><strong>Criterio lógico de negocio:</strong> Explicar claramente la condición ('si la fecha es menor a hoy y el estado es Pendiente').</li>
        <li><strong>Idioma y versión de Excel:</strong> Indicar si se utiliza Excel en español (con punto y coma <code>;</code> como separador de argumentos) o en inglés (con coma <code>,</code>).</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos y Prevención</h4>
    <ul>
        <li><strong>Copiar fórmulas a ciegas sin verificar los separadores regionales:</strong> Si tu Excel está configurado con separador de listas punto y coma (<code>;</code>) y copias una fórmula con comas generada para el estándar estadounidense, Excel arrojará un error de sintaxis inmediato.</li>
        <li><strong>No auditar las cifras de las cotizaciones:</strong> Siempre verifica que la IA haya transcrito exactamente las cantidades numéricas de las cotizaciones originales antes de someter el informe al comité directivo.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Estandarizaste el formato de tus actas para que cada acuerdo tenga responsable con nombre y fecha exacta de entrega?</li>
            <li>¿Probaste las fórmulas generadas con al menos dos filas de datos de prueba antes de arrastrarlas a toda la base de datos?</li>
            <li>¿Verificaste que la tabla comparativa refleje los montos con sus respectivos impuestos de ley?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Seguridad, Privacidad de Datos y Alucinaciones en Entornos Corporativos",
                            LessonTitle = "Uso Ético de la IA: Qué Subir y Qué NUNCA Compartir",
                            Summary = "Protege a tu organización y tu carrera profesional: aprende qué es una alucinación, cómo aplicar protocolos de anonimización (DLP) y cómo respetar las normas internacionales de privacidad sin comprometer la productividad.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-shield-lock-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Seguridad Informática y Responsabilidad Legal</h5>
            <p class=""mb-0 small"">El uso irresponsable de la IA pública ha provocado despidos disciplinarios y demandas judiciales en corporaciones globales debido a la filtración de código fuente propietario, nóminas de sueldos e historiales médicos de clientes.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/zvzwh8r0ABY"" title=""Implementación de privacidad y protección de datos - Curso de ética en el análisis de datos"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Anatomía y Origen de las Alucinaciones en LLMs</h4>
    <p>En el ámbito de la inteligencia artificial, una <strong>alucinación</strong> no es un fallo temporal del software ni un virus informático; es el resultado intrínseco de cómo operan los modelos de lenguaje. Dado que el sistema siempre busca generar una respuesta lingüísticamente persuasiva y estadísticamente plausible, cuando carece de datos fácticos sobre un tema oscuro, en lugar de reconocer 'no lo sé', puede inventar con absoluta seguridad citas bibliográficas inexistentes, sentencias judiciales inventadas o números contables falsos.</p>
    <p>Por esta razón, la regla de oro para cualquier profesional es: <em>'La IA nunca tiene la última palabra; la responsabilidad legal, ética y operativa ante la dirección siempre pertenece al profesional humano que firma el reporte'</em>.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shield-x text-danger me-2""></i>2. Qué Datos NUNCA Deben Subirse a Modelos de IA Públicos</h4>
    <p>A menos que tu empresa disponga de una instancia empresarial privada (Enterprise) con contrato formal de confidencialidad y cláusula de no-entrenamiento (como Gemini for Workspace Enterprise o ChatGPT Team/Enterprise), debes considerar cualquier plataforma pública como un entorno expuesto. Está terminantemente prohibido introducir:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-danger"">
                <tr>
                    <th>Categoría de Información</th>
                    <th>Ejemplos Concretos</th>
                    <th>Riesgo Laboral / Sanción</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold"">Datos Personales Identificables (PII)</td>
                    <td>Cédulas de identidad, nombres completos de clientes, números de teléfono, correos personales, historias clínicas.</td>
                    <td>Violación de leyes de protección de datos, multas regulatorias y despido por justa causa.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">Secretos Comerciales e Industriales</td>
                    <td>Fórmulas químicas, algoritmos propietarios, márgenes de utilidad confidenciales, costos unitarios de importación.</td>
                    <td>Pérdida de ventaja competitiva y demandas civiles por revelación de secretos empresariales.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">Credenciales y Cuentas de Acceso</td>
                    <td>Claves de servidores, contraseñas de correos institucionales, tokens de API de bases de datos, números de tarjetas de crédito.</td>
                    <td>Ataques de ransomware y hackeo masivo a la infraestructura de la empresa.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shield-check text-success me-2""></i>3. Protocolo de Anonimización y Ofuscación de Datos</h4>
    <p>Si necesitas que la IA analice un caso comercial complejo o un conflicto entre empleados, puedes aprovechar su potencial sin violar ninguna política de seguridad aplicando el <strong>Protocolo de Anonimización Previa</strong>:</p>
    <ol>
        <li><strong>Reemplazo de Nombres Propios:</strong> Convierte 'Lic. Juan Pérez de Distribuidora Caracas C.A.' en <code>[Gerente de Ventas - Empresa Proveedor A]</code>.</li>
        <li><strong>Normalización de Cifras Sensibles:</strong> Si los ingresos reales son de $485.320 USD, puedes multiplicar todas las cifras por un factor neutro (ej: dividir entre 10) o usar porcentajes relativos en lugar de los montos absolutos.</li>
        <li><strong>Eliminación de Direcciones IP y Rutas de Red:</strong> Reemplaza direcciones de servidores internos por nombres ficticios como <code>servidor-principal.local</code>.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confiar en citas de leyes o artículos de código civil sin contrastar:</strong> Los modelos suelen mezclar legislaciones de diferentes países (ej: citar el Código Civil español en un caso laboral venezolano o mexicano). Siempre verifica el texto de la ley en la gaceta oficial vigente.</li>
        <li><strong>Asumir que borrar el chat de la pantalla elimina los datos de los servidores:</strong> En cuentas gratuitas públicas, los datos pueden permanecer en logs de auditoría o ser utilizados para entrenar versiones futuras del modelo si no se ha desactivado manualmente la opción en la configuración de privacidad.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Revisaste que el texto a enviar no contenga números de cédula, cuentas bancarias ni claves de acceso?</li>
            <li>¿Verificaste manualmente cada cifra matemática y cada referencia normativa citada por la IA?</li>
            <li>¿Consultaste con el departamento de TI las políticas internas de la empresa sobre el uso autorizado de herramientas de IA generativa?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    Questions = 
'@ + $qGemini + @'
                },

                // =========================================================================
                // 2. INTRODUCCIÓN A LA CIBERSEGURIDAD
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "introduccion-ciberseguridad",
                    Title = "Introducción a la Ciberseguridad: Defensa contra Phishing, Ransomware y Gestión de Redes Corporativas",
                    CategorySlug = "tecnologia-ia-ofimatica",
                    ShortDescription = "Aprende los pilares de la seguridad informática empresarial: triada CIA, autenticación multifactor (MFA), prevención de ingeniería social, protección de redes Wi-Fi y protocolos de respaldo 3-2-1.",
                    FullDescription = "Capacitación vital para cualquier profesional en el entorno digital moderno. Conoce la anatomía de los ataques cibernéticos más destructivos (Phishing, Spear Phishing, Ransomware, Man-in-the-Middle), los fundamentos de la criptografía y certificados SSL/TLS, configuración de firewalls y redes privadas virtuales (VPN), gestión segura de credenciales y planes de continuidad de negocio ante incidentes de seguridad.",
                    Level = "Intermedio",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: La Triada de la Seguridad (CIA) y Amenazas Modernas: Phishing e Ingeniería Social",
                            LessonTitle = "Los Tres Pilares Defensivos y el Factor Humano como Primera Barrera",
                            Summary = "Domina los conceptos de Confidencialidad, Integridad y Disponibilidad. Aprende a detectar técnicas de Spear Phishing, analizar cabeceras de correo fraudulentas y neutralizar la ingeniería social en la oficina.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-shield-shaded fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Ciberseguridad no es un Asunto de Servidores, es un Comportamiento Humano</h5>
            <p class=""mb-0 small"">Más del 90% de las intrusiones corporativas exitosas en el mundo no ocurren por fallos matemáticos en los algoritmos de cifrado, sino porque un empleado distraído abrió un enlace malicioso o entregó su contraseña por teléfono.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/_MJt0ugOc_E"" title=""¿Qué es la triada CIA en ciberseguridad? | Curso CIBERSEGURIDAD desde 0 2025"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Triada C.I.A.: El Marco Universal de Protección</h4>
    <p>En seguridad de la información corporativa, todas las políticas, firewalls y procedimientos de auditoría se evalúan bajo tres pilares inquebrantables conocidos como la <strong>Triada C.I.A.</strong> (por sus siglas en inglés: <em>Confidentiality, Integrity, Availability</em>):</p>
    <ul>
        <li><strong>Confidencialidad:</strong> Garantizar que la información sea accesible exclusivamente para los individuos, procesos o sistemas debidamente autorizados. Ejemplo en la oficina: Las carpetas de nómina y sueldos no pueden ser visibles para el personal operativo, únicamente para Recursos Humanos y Gerencia General.</li>
        <li><strong>Integridad:</strong> Salvaguardar la exactitud, completitud y fidelidad de los datos a lo largo de todo su ciclo de vida, evitando alteraciones accidentales o modificaciones maliciosas no autorizadas. Ejemplo: Un archivo contable no puede permitir que nadie altere el monto de un cheque ya liquidado.</li>
        <li><strong>Disponibilidad:</strong> Asegurar que los usuarios autorizados tengan acceso ininterrumpido y oportuno a los sistemas, bases de datos y servicios cuando lo requieran para operar la empresa. Si el sistema de facturación cae durante el horario comercial, la disponibilidad ha sido vulnerada.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-envelope-exclamation-fill text-danger me-2""></i>2. Ingeniería Social y Phishing: La Anatomía del Engaño</h4>
    <p>La <strong>Ingeniería Social</strong> es el arte de manipular psicológicamente a las personas para que violen los protocolos de seguridad de forma voluntaria. El vector más extendido es el <strong>Phishing</strong> (pesca de credenciales). Existen variantes críticas que todo profesional debe reconocer:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Variante</th>
                    <th>Mecanismo de Ataque</th>
                    <th>Señales de Alerta Críticas</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-danger"">Phishing Masivo</td>
                    <td>Correos genéricos enviados a millones de usuarios simulando ser entidades bancarias, Netflix o servicios postales.</td>
                    <td>Saludos genéricos ('Estimado cliente'), remitentes con dominios sospechosos (ej: <code>soporte@banc0-venezuela-alert.com</code>) y enlaces falsos.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-danger"">Spear Phishing</td>
                    <td>Ataque quirúrgico dirigido a una persona específica de la empresa (ej: el asistente de pagos), utilizando su nombre real, cargo y nombres de sus superiores recopilados en LinkedIn.</td>
                    <td>El atacante se hace pasar por el Gerente General y exige una transferencia de emergencia urgente a una cuenta no registrada en el ERP.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-danger"">Smishing / Vishing</td>
                    <td>Engaño a través de mensajes de texto SMS o llamadas telefónicas directas simulando ser personal de soporte técnico bancario.</td>
                    <td>Exigen que se les dicte el código OTP de 6 dígitos que acaba de llegar al teléfono celular bajo pretexto de 'bloquear un cargo fraudulento'.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-briefcase-fill text-primary me-2""></i>3. Caso Práctico de Oficina: Protocolo de Verificación ante Correo Sospechoso</h4>
    <div class=""card border-0 bg-light p-3 rounded-3 mb-4"">
        <h6 class=""fw-bold text-dark mb-2"">Situación Real: Recibes un correo titulado: 'Urgente: Factura vencida y suspensión de servicio - Cuentas por Cobrar'</h6>
        <p class=""small text-secondary mb-2"">El correo contiene un archivo adjunto llamado <code>Factura_Vencida_402.pdf.exe</code> o un enlace que lleva a una página idéntica al portal de inicio de sesión de Microsoft Office 365.</p>
        <p class=""small text-dark mb-0 font-monospace"">
            <strong>Paso 1: Inspeccionar el remitente real:</strong> No te fíes del nombre visible. Haz clic en la dirección completa para verificar el dominio posterior a la arroba (<code>@dominio.com</code>). Si dice <code>facturacion@empresa-aliada.net.co.xyz</code>, es un fraude.<br />
            <strong>Paso 2: Inspeccionar el enlace sin hacer clic (Hovering):</strong> Pasa el cursor del ratón sobre el botón sin presionar. En la esquina inferior del navegador aparecerá la URL real a la que dirige. Si no coincide con el dominio oficial de la empresa, es phishing.<br />
            <strong>Paso 3: Verificación por canal secundario fuera de banda:</strong> Llama por teléfono o consulta por chat interno a la persona que supuestamente envió la factura antes de abrir cualquier archivo adjunto.<br />
            <strong>Paso 4: Notificación al departamento de TI:</strong> Reenvía el correo como archivo adjunto al equipo de seguridad informática para que bloqueen el remitente en el firewall del servidor.
        </p>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Creer en el candado del navegador a ciegas:</strong> El candado verde (HTTPS / SSL) solo significa que la conexión entre tu computador y el sitio está cifrada; NO garantiza que el dueño de la web sea honesto. Los atacantes también instalan certificados SSL gratuitos en sus páginas falsas.</li>
        <li><strong>Descargar archivos comprimidos con contraseñas provistas en el mismo correo:</strong> Los atacantes envían archivos <code>.zip</code> o <code>.rar</code> protegidos con clave para evitar que el antivirus del servidor de correo inspeccione el malware antes de que llegue a tu bandeja.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Verificaste el dominio exacto del remitente antes de responder o hacer clic?</li>
            <li>¿Comprobaste la extensión real de los archivos adjuntos (asegurando que no terminen en .exe, .scr, .vbs o .bat)?</li>
            <li>¿Desconfiaste de cualquier comunicación que te obligue a actuar 'con urgencia extrema antes de 1 hora'?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Autenticación Robusta: Contraseñas Seguras, Gestores y Autenticación Multifactor (MFA)",
                            LessonTitle = "Fortificación de Identidades: Más Allá de la Clave Tradicional",
                            Summary = "Comprende la matemática detrás de la entropía de contraseñas, la vulnerabilidad de ataques de fuerza bruta y por qué el doble factor de autenticación (TOTP/FIDO2) es el estándar obligatorio corporativo.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-key-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Una Contraseña Única ya NO es Suficiente</h5>
            <p class=""mb-0 small"">Las contraseñas débiles o reutilizadas son la causa principal de secuestro de cuentas corporativas. La autenticación moderna requiere combinar factores de conocimiento, posesión e inherencia para garantizar la seguridad.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/xkxYPon37eY"" title=""Qué es MFA (Autenticación Multifactor) y cómo se usa"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Entropía y Ataques de Fuerza Bruta</h4>
    <p>Las computadoras actuales pueden probar miles de millones de combinaciones de contraseñas por segundo utilizando tarjetas gráficas modernas y tablas precalculadas (Rainbow Tables). Una contraseña como <code>Empresa2024*</code> parece compleja para un ser humano, pero sigue un patrón predecible de diccionario que los programas de ataque descubren en menos de 3 minutos.</p>
    <p>La <strong>entropía</strong> mide la impredecibilidad matemática de una contraseña. El estándar moderno recomienda usar <em>frases de contraseña (passphrases)</em> de al menos 16 a 20 caracteres formadas por 4 o 5 palabras aleatorias sin conexión lógica (ejemplo: <code>camion-jirafa-teclado-naranja-velero</code>). Estas frases son extremadamente fáciles de memorizar para un ser humano, pero computacionalmente imposibles de descifrar por fuerza bruta (tomaría cientos de miles de años de cálculo).</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shield-lock text-primary me-2""></i>2. Los Tres Factores de Autenticación (MFA)</h4>
    <p>La <strong>Autenticación Multifactor (MFA)</strong> exige que el usuario demuestre su identidad combinando al menos dos de las siguientes tres categorías independientes:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-primary mb-2"">1. Algo que Sabes</span>
                <p class=""small mb-0"">Información memorizada: Contraseña maestra, código PIN personal o respuestas a preguntas de desafío.</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-success mb-2"">2. Algo que Tienes</span>
                <p class=""small mb-0"">Un dispositivo físico en tu posesión: Teléfono móvil con app autenticadora (TOTP como Google Authenticator o Microsoft Authenticator), o llave criptográfica USB física (YubiKey / FIDO2).</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-warning text-dark mb-2"">3. Algo que Eres</span>
                <p class=""small mb-0"">Biometría física única: Huella dactilar, reconocimiento facial por infrarrojos (Windows Hello / FaceID) o escaneo de iris.</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-safe2-fill text-primary me-2""></i>3. Gestores de Contraseñas Corporativos (Password Managers)</h4>
    <p>El cerebro humano no está diseñado para recordar 50 contraseñas diferentes de 20 caracteres cada una. La consecuencia inevitable es que los empleados reutilizan la misma contraseña en el correo del trabajo, en su banco y en tiendas online. Si una tienda online secundaria sufre una filtración, los cibercriminales prueban esa misma clave en el correo corporativo (ataque de <em>Credential Stuffing</em>).</p>
    <p>La solución profesional obligatoria es el uso de <strong>Gestores de Contraseñas</strong> (como Bitwarden, 1Password o KeePass). Estos programas cifran todas las contraseñas bajo un algoritmo de grado militar (AES-256) protegido por una única clave maestra robusta combinada con MFA.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confiar en el SMS como segundo factor:</strong> Los mensajes de texto SMS no están cifrados y son vulnerables a clonación de línea telefónica mediante ataques de <em>SIM Swapping</em>. Siempre que el sistema lo permita, utiliza aplicaciones TOTP autenticadoras en lugar de SMS.</li>
        <li><strong>Anotar contraseñas en notas adhesivas (Post-its) en el monitor:</strong> Esto anula toda la inversión tecnológica de la empresa al exponer las credenciales a cualquier visitante físico o personal de limpieza en la oficina.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Tienes activada la Verificación en Dos Pasos (MFA) en tu correo corporativo y cuentas principales?</li>
            <li>¿Cada una de tus cuentas laborales cuenta con una contraseña totalmente distinta a las demás?</li>
            <li>¿Utilizas un gestor de contraseñas cifrado en lugar de guardarlas en un archivo de bloc de notas o Excel?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Amenazas Graves: Ransomware, Criptojacking y Seguridad en Redes Wi-Fi",
                            LessonTitle = "Defensa Activa ante Ataques Destructivos y Fugas de Tráfico",
                            Summary = "Analiza el funcionamiento del Ransomware moderno (cifrado asimétrico forzado y doble extorsión), los riesgos del espionaje en redes Wi-Fi públicas y la configuración de defensas con VLANs y VPNs.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-radioactive fs-2 text-danger""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Ransomware: La Mayor Amenaza a la Continuidad del Negocio</h5>
            <p class=""mb-0 small"">El Ransomware no solo paraliza las operaciones de empresas de cualquier tamaño, sino que amenaza con publicar bases de datos de clientes si no se pagan rescates millonarios en criptomonedas. La prevención y los respaldos inmutables son la única defensa real.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/czuyM80wJJI"" title=""💻🚨 Malware: La Amenaza Oculta que Puede Robarte TODO🚨💻"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. ¿Cómo Opera el Ransomware Moderno? El Ciclo de Doble Extorsión</h4>
    <p>El <strong>Ransomware</strong> es un tipo de malware que se infiltra silenciosamente en los equipos de la red corporativa. A diferencia de los virus antiguos que dañaban el sistema inmediatamente, el ransomware moderno permanece oculto durante semanas (fase de reconocimiento) mapeando todos los servidores compartidos y eliminando copias de sombra locales (Shadow Copies).</p>
    <p>Una vez posicionado, ejecuta un cifrado asimétrico ultraveloz (RSA + AES) sobre todos los documentos comerciales, bases de datos y hojas de cálculo, cambiando sus extensiones y dejando una nota de rescate en el escritorio. Además, hoy en día aplican la <strong>Doble Extorsión</strong>: antes de cifrar, exfiltran gigabytes de contratos confidenciales para amenazar con publicarlos en internet si la directiva no paga el rescate.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-wifi text-primary me-2""></i>2. Vulnerabilidades en Redes Wi-Fi y Ataques Man-in-the-Middle (MitM)</h4>
    <p>Cuando un trabajador en modalidad remota o en viaje de negocios se conecta a la red Wi-Fi abierta de una cafetería, hotel o aeropuerto sin protección, se expone a ataques de intermediario (<em>Man-in-the-Middle</em>):</p>
    <ul>
        <li><strong>Gemelo Malvado (Evil Twin):</strong> El atacante levanta una red Wi-Fi falsa con el mismo nombre del hotel (ej: <code>Hotel_Guest_Free</code>). El computador del usuario se conecta automáticamente y todo el tráfico no cifrado fluye a través de la máquina del ciberdelincuente.</li>
        <li><strong>Red Privada Virtual (VPN) como Escudo:</strong> La regla de oro corporativa al conectarse a cualquier red externa es iniciar de inmediato una <strong>VPN (Virtual Private Network)</strong> institucional. La VPN crea un túnel cifrado punto a punto que encapsula los datos, impidiendo que cualquiera en la red local pueda espiar credenciales o paquetes transmitidos.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-briefcase-fill text-primary me-2""></i>3. Caso Práctico de Oficina: Protocolo de Aislamiento Inmediato ante Infección</h4>
    <div class=""card border-0 bg-light p-3 rounded-3 mb-4"">
        <h6 class=""fw-bold text-dark mb-2"">Si notas que tus archivos cambian de icono repentinamente o aparece una pantalla de advertencia exigiendo un rescate:</h6>
        <ol class=""small mb-0"">
            <li><strong>Desconectar inmediatamente el cable de red RJ45 y apagar el Wi-Fi:</strong> Esto corta la propagación lateral del ransomware hacia otros computadores y servidores compartidos de la empresa.</li>
            <li><strong>NO apagar el computador bruscamente:</strong> Déjalo encendido pero desconectado de la red. Apagarlo puede borrar evidencias clave en la memoria RAM que los peritos forenses necesitan para extraer llaves de descifrado.</li>
            <li><strong>Notificar por teléfono de inmediato al Administrador de Sistemas:</strong> Informa la hora exacta del suceso y qué carpetas estaban abiertas.</li>
            <li><strong>NUNCA contactar a los atacantes ni intentar pagar rescates por cuenta propia:</strong> Pagar no garantiza recibir la clave y financia actividades criminales organizadas.</li>
        </ol>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Mantener discos duros de respaldo conectados permanentemente al computador:</strong> Si un disco USB de respaldo está conectado a la máquina cuando se activa el ransomware, el malware cifrará tanto los archivos del computador como los del respaldo.</li>
        <li><strong>Desactivar el firewall de Windows o los antivirus para instalar programas piratas:</strong> El software craqueado suele contener troyanos durmientes diseñados para otorgar acceso remoto a bandas de cibercrimen.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Tu sistema operativo y programas de oficina están actualizados con los últimos parches de seguridad?</li>
            <li>¿Utilizas siempre una VPN corporativa cuando trabajas desde redes Wi-Fi externas o públicas?</li>
            <li>¿Tienes claro a quién llamar de inmediato en tu empresa en caso de detectar un comportamiento anómalo en tu computador?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Estrategia de Respaldo 3-2-1 y Plan de Recuperación ante Desastres (DRP)",
                            LessonTitle = "Inmunidad ante Pérdidas de Información y Continuidad Operativa",
                            Summary = "Implementa la regla universal de respaldo 3-2-1 con copias desconectadas e inmutables. Comprende los conceptos de RTO (Objetivo de Tiempo de Recuperación) y RPO (Objetivo de Punto de Recuperación).",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-cloud-arrow-up-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">No Existe Respaldo si Nunca se ha Probado su Restauración</h5>
            <p class=""mb-0 small"">Hacer copias de seguridad que nadie ha verificado es una ilusión peligrosa. El verdadero valor de una estrategia de respaldo se mide en la velocidad y certeza con la que la empresa puede volver a facturar tras un desastre.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/Fi1wPlUnh4k"" title=""4 claves para asegurar la continuidad de tú negocio con la estrategia DRP en AWS"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Regla Universal de Respaldo 3-2-1</h4>
    <p>La regla <strong>3-2-1</strong> es el estándar dorado recomendado por agencias internacionales de ciberseguridad para garantizar que ninguna catástrofe (incendio, inundación, fallo de hardware o ataque de ransomware) pueda destruir el patrimonio de datos de la organización:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-4"">
            <div class=""p-3 bg-white rounded border border-primary h-100"">
                <h5 class=""fw-bold text-primary mb-1"">3 Copias de los Datos</h5>
                <p class=""small text-muted mb-0"">Mantener el archivo de trabajo principal y al menos dos copias de seguridad actualizadas de toda la base de datos y documentos críticos.</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-white rounded border border-success h-100"">
                <h5 class=""fw-bold text-success mb-1"">2 Medios Diferentes</h5>
                <p class=""small text-muted mb-0"">Almacenar las copias en al menos dos tipos de soportes tecnológicos distintos (por ejemplo: un servidor NAS local y cintas o almacenamiento en la nube S3), para evitar que un fallo masivo de tecnología afecte a ambos.</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-white rounded border border-danger h-100"">
                <h5 class=""fw-bold text-danger mb-1"">1 Copia Fuera de Sitio</h5>
                <p class=""small text-muted mb-0"">Al menos una copia debe residir en una ubicación geográfica físicamente alejada o en la nube con política de <em>inmutabilidad (WORM: Write Once, Read Many)</em> que impida su borrado por 30 días.</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-stopwatch-fill text-primary me-2""></i>2. Métricas Clave de Continuidad: RTO y RPO</h4>
    <p>En el diseño de un <strong>Plan de Recuperación ante Desastres (DRP - Disaster Recovery Plan)</strong>, la gerencia de la empresa y el equipo técnico deben acordar dos parámetros vitales:</p>
    <ul>
        <li><strong>RPO (Recovery Point Objective - Objetivo de Punto de Recuperación):</strong> La cantidad máxima de tiempo de datos que la empresa está dispuesta a perder en el peor escenario. Si el RPO es de 2 horas, significa que se deben realizar respaldos cada 2 horas; si el sistema cae, solo se perderán como máximo las últimas 2 horas de transacciones.</li>
        <li><strong>RTO (Recovery Time Objective - Objetivo de Tiempo de Recuperación):</strong> El tiempo máximo tolerable que los sistemas pueden permanecer caídos antes de que la empresa sufra daños económicos irreversibles. Si el RTO es de 4 horas, el equipo de TI debe tener los servidores operativos antes de que venza ese plazo.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-clipboard2-pulse-fill text-primary me-2""></i>3. Simulacros Periódicos de Restauración (Disaster Drills)</h4>
    <p>El error más grave de los departamentos administrativos es dar por sentado que los respaldos automáticos funcionan porque una luz verde titila en la consola. Una vez por trimestre es obligatorio ejecutar una <strong>prueba de restauración en frío</strong>:</p>
    <ol>
        <li>Seleccionar una máquina virtual o servidor de pruebas totalmente aislado.</li>
        <li>Descargar la copia de respaldo de la semana anterior.</li>
        <li>Restaurar la base de datos completa y levantar el software administrativo ERP.</li>
        <li>Comprobar que un usuario pueda iniciar sesión, consultar el saldo de un cliente y emitir un reporte de inventario sin errores de corrupción.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Respaldos con credenciales compartidas con el dominio principal:</strong> Si el usuario administrador del dominio es el mismo que tiene permiso para borrar los respaldos en la nube, el ransomware usará esas credenciales para borrar los respaldos antes de cifrar el servidor.</li>
        <li><strong>No incluir en el respaldo los archivos de configuración y licencias:</strong> Restaurar la base de datos no sirve de nada si no se tienen respaldados los certificados digitales de facturación electrónica y las llaves de configuración del sistema.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Se ejecutan copias automáticas diarias y se guardan fuera de la oficina principal?</li>
            <li>¿Se ha realizado al menos una prueba exitosa de restauración de datos en los últimos 90 días?</li>
            <li>¿Está documentado el procedimiento paso a paso de recuperación ante desastres en un manual accesible fuera de línea?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    Questions = 
'@ + $qSec + @'
                },

                // =========================================================================
                // 3. SERVICIO TÉCNICO INFORMÁTICO Y SOPORTE A SISTEMAS
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "servicio-tecnico-informatico-soporte-sistemas",
                    Title = "Servicio Técnico Informático y Soporte a Sistemas: Hardware, Redes y Mantenimiento",
                    CategorySlug = "tecnologia-ia-ofimatica",
                    ShortDescription = "Formación integral para técnicos de soporte y mesa de ayuda: diagnóstico de hardware, mantenimiento preventivo/correctivo, instalación de Windows, cableado estructurado UTP y gestión de tickets.",
                    FullDescription = "Capacitación práctica orientada a formar técnicos de soporte en entornos corporativos y centros de servicio. Aprende a diagnosticar fallas de placa madre, procesador, memoria RAM y almacenamiento SMART; domina el protocolo ESD de descarga electrostática y sustitución de pasta térmica; realiza instalaciones limpias de Windows con esquema GPT/UEFI y crimpa cableado estructurado bajo la norma T568B para redes de oficina.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Niveles de Soporte Técnico (L1/L2/L3) y Gestión de Tickets de Incidencia",
                            LessonTitle = "La Mesa de Ayuda Corporativa y el Flujo de Resolución de Incidencias",
                            Summary = "Conoce la arquitectura de la mesa de ayuda (Help Desk / Service Desk), la clasificación de incidentes por impacto y urgencia, cumplimiento de SLAs y protocolo de atención al usuario final.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-headset fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Soporte Técnico es el Pulmón Operativo de la Empresa</h5>
            <p class=""mb-0 small"">Un técnico sobresaliente no solo sabe reparar computadores; sabe escuchar al usuario estresado, diagnosticar la causa raíz sin dar rodeos y registrar cada acción en el sistema de tickets para alimentar la base de conocimiento corporativa.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/7kEM9ZaD7jQ"" title=""Soporte Técnico: L1, L2, L3"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Estructura Jerárquica del Soporte IT (L1, L2, L3)</h4>
    <p>En organizaciones formales bajo el estándar ITIL, la atención a problemas tecnológicos se organiza en niveles para maximizar la eficiencia y no saturar a los ingenieros senior con incidencias básicas:</p>
    <ul>
        <li><strong>Nivel 1 (Tier 1 / Help Desk):</strong> Primer punto de contacto con el usuario. Atiende llamadas, correos o tickets web. Realiza el triaje inicial, restablece contraseñas, verifica conexiones físicas de cables, asiste en configuraciones sencillas de correo y resuelve problemas conocidos con guías paso a paso (SOPs). Resuelve entre el 70% y el 80% de los incidentes en el primer contacto.</li>
        <li><strong>Nivel 2 (Tier 2 / Soporte en Sitio - Desktop Support):</strong> Técnicos de campo que intervienen cuando L1 no puede solucionar el problema de forma remota. Diagnostican fallas físicas de hardware, reemplazan componentes dañados (fuentes de poder, discos duros, pantallas), reinstalan sistemas operativos e inspeccionan puntos de red físicos y conmutadores (switches).</li>
        <li><strong>Nivel 3 (Tier 3 / Especialistas e Ingeniería de Infraestructura):</strong> Administradores de servidores, ingenieros de redes (Cisco/MikroTik), especialistas en bases de datos y desarrolladores de software. Atienden caídas globales de servidores, configuraciones complejas de enrutamiento o fallas en el código de las aplicaciones empresariales.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-ticket-perforated-fill text-primary me-2""></i>2. Gestión de Tickets y Acuerdos de Nivel de Servicio (SLAs)</h4>
    <p>En una empresa, ninguna reparación se realiza 'por favor verbal de pasillo'. Todo requerimiento debe registrarse en un <strong>Sistema de Gestión de Tickets</strong> (como Jira Service Management, Zendesk, GLPI o Freshdesk). Cada ticket se clasifica evaluando dos variables:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Nivel de Prioridad</th>
                    <th>Criterio de Clasificación</th>
                    <th>SLA Típico de Respuesta y Solución</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-danger"">Crítica (P1)</td>
                    <td>Afecta a toda la empresa o a un servicio central de facturación/caja. No existe solución alternativa provisional.</td>
                    <td>Respuesta en menos de 15 minutos. Solución en menos de 2 horas.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-warning text-dark"">Alta (P2)</td>
                    <td>Afecta a un departamento completo (ej: el área de contabilidad no puede imprimir cheques en día de cierre).</td>
                    <td>Respuesta en menos de 1 hora. Solución en menos de 4 horas.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-info text-dark"">Media (P3)</td>
                    <td>Afecta a un solo usuario, pero este puede continuar trabajando en otras tareas o en un equipo alternativo.</td>
                    <td>Respuesta en menos de 4 horas. Solución en 24 horas hábiles.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-secondary"">Baja (P4)</td>
                    <td>Consultas informativas, solicitudes de instalación de programas no urgentes o mejoras visuales.</td>
                    <td>Respuesta en 24 horas. Solución en 48 a 72 horas.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-chat-left-dots-fill text-primary me-2""></i>3. Protocolo de Atención y Comunicación Asertiva con el Usuario</h4>
    <p>Uno de los errores más comunes de los técnicos novatos es utilizar jerga técnica incomprensible con usuarios no especializados. El estándar profesional exige:</p>
    <ol>
        <li><strong>Escucha Activa:</strong> Permitir que el usuario describa qué estaba haciendo cuando ocurrió la falla sin interrumpirle.</li>
        <li><strong>Preguntas de Descarte Guiadas:</strong> ¿El problema ocurrió de repente o después de instalar algo? ¿Apareció algún mensaje de error en pantalla? ¿Otros compañeros de su área experimentan lo mismo?</li>
        <li><strong>Confirmación de Cierre y Retroalimentación:</strong> Antes de cerrar el ticket en el sistema, pedir al usuario que pruebe la función reparada en su presencia para asegurar su total conformidad.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Cerrar tickets sin documentar la solución técnica aplicada:</strong> Dejar el campo de resolución vacío o con un simple 'reparado' priva a los demás técnicos de consultar la base de conocimiento cuando el problema se repita.</li>
        <li><strong>Manipular archivos personales del usuario sin autorización previa:</strong> Acceder a carpetas personales o fotos durante una asistencia técnica remota vulnera gravemente la privacidad y la ética profesional.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Registraste cada solicitud en el sistema de tickets asignándole el nivel de prioridad correcto?</li>
            <li>¿Notificaste al usuario los tiempos estimados de atención antes de iniciar la intervención?</li>
            <li>¿Documentaste detalladamente los pasos técnicos realizados en las notas de resolución del ticket?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Mantenimiento Preventivo y Correctivo de Hardware y Periféricos",
                            LessonTitle = "Diagnóstico Electrónico, Protocolo ESD y Desensamble Profesional",
                            Summary = "Aprende a diagnosticar fallas de fuente de poder, placa base, procesador y memoria RAM. Aplica medidas antiestáticas (ESD), realiza sustitución de pasta térmica y diagnostica la salud de discos con CrystalDiskInfo (SMART).",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-cpu-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Diagnóstico Preciso Ahorra Presupuesto y Tiempo</h5>
            <p class=""mb-0 small"">Cambiar piezas al azar hasta que el equipo funcione es una mala práctica. Un técnico calificado utiliza herramientas de medición, códigos de sonido del BIOS y pruebas de estrés para identificar el componente exacto averiado.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/SRFvGeLt18I"" title=""🖥️ Mantenimiento Correctivo en Windows: Repara tu PC Paso a Paso 🔧"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Protocolo ESD (Descarga Electroestática) y Seguridad en Taller</h4>
    <p>El cuerpo humano puede acumular miles de voltios de electricidad estática generada por la fricción de la ropa o el calzado sobre pisos sintéticos. Aunque para nosotros es una chispa imperceptible, una descarga de apenas 100 voltios puede destruir los transistores microscópicos de una memoria RAM o una tarjeta madre.</p>
    <p>Antes de abrir cualquier equipo, es obligatorio seguir el <strong>Protocolo ESD</strong>:</p>
    <ul>
        <li>Desconectar el cable de poder de la pared y presionar el botón de encendido del gabinete durante 10 segundos para descargar los condensadores residuales de la fuente de poder.</li>
        <li>Utilizar una <strong>pulsera antiestática</strong> conectada a tierra física o tocar una parte metálica no pintada del chasis de la computadora para equilibrar el potencial eléctrico antes de manipular componentes internos.</li>
        <li>Sujetar los módulos de memoria RAM y tarjetas de expansión únicamente por los bordes de la placa de circuito impreso (PCB), sin tocar jamás los contactos dorados de cobre.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-thermometer-high text-danger me-2""></i>2. Mantenimiento Térmico: Limpieza y Sustitución de Pasta Térmica</h4>
    <p>El calor es el enemigo número uno de los semiconductores. El polvo acumulado en los disipadores de aluminio bloquea el flujo de aire y hace que el procesador alcance temperaturas críticas (más de 85°C - 90°C), activando el mecanismo de protección <em>Thermal Throttling</em> (el equipo reduce drásticamente su velocidad o se apaga repentinamente para no quemarse).</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <h6 class=""fw-bold text-dark mb-2""><i class=""bi bi-wrench-adjustable text-primary me-2""></i>Paso a Paso Profesional de Renovación Térmica</h6>
        <ol class=""small mb-0"">
            <li>Retirar el disipador con cuidado (si está pegado, encender el equipo unos minutos antes para ablandar la pasta vieja).</li>
            <li>Limpiar los residuos resecos del procesador y la base del disipador utilizando <strong>alcohol isopropílico al 99%</strong> y toallas de microfibra que no desprendan pelusa.</li>
            <li>Aplicar una pequeña cantidad de pasta térmica de alta conductividad (equivalente al tamaño de un grano de arroz o arveja en el centro del procesador).</li>
            <li>Instalar el disipador ejerciendo presión uniforme en cruz (tornillos diagonales opuestos) para que la pasta se distribuya homogéneamente sin formar burbujas de aire.</li>
        </ol>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-hdd-network-fill text-primary me-2""></i>3. Diagnóstico de Almacenamiento con Tecnología S.M.A.R.T.</h4>
    <p>Los discos duros mecánicos (HDD) y unidades de estado sólido (SSD / NVMe) cuentan con el sistema <strong>S.M.A.R.T. (Self-Monitoring, Analysis and Reporting Technology)</strong>. Mediante utilidades de diagnóstico como <em>CrystalDiskInfo</em>, el técnico debe auditar:</p>
    <ul>
        <li><strong>Sectores Reasignados (Reallocated Sectors Count):</strong> Indica sectores físicos dañados que el disco tuvo que reubicar en su área de reserva. Si este valor es superior a cero en un HDD, el disco está muriendo y debe clonarse de inmediato.</li>
        <li><strong>Porcentaje de Salud en SSDs (Life Left):</strong> Las celdas de memoria flash NAND tienen un límite de ciclos de escritura (TBW). Monitorear este porcentaje previene la pérdida catastrófica de información contable o del sistema operativo.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Utilizar alcohol etílico común (al 70%) para limpiar componentes electrónicos:</strong> Contiene un 30% de agua que puede oxidar los circuitos o causar cortocircuitos si no se evapora por completo. Siempre debe usarse alcohol isopropílico de alta pureza.</li>
        <li><strong>Aplicar exceso de pasta térmica:</strong> Si se aplica demasiada cantidad, la pasta se desbordará por los lados hacia el zócalo (socket) del procesador, actuando como aislante térmico o generando cortocircuitos si la pasta contiene compuestos metálicos conductores.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Te aseguraste de descargar la estática antes de tocar módulos de memoria o placa base?</li>
            <li>¿Comprobaste las temperaturas en reposo y bajo carga con software de monitoreo (HWMonitor / Core Temp)?</li>
            <li>¿Auditaste el estado de salud SMART de la unidad de almacenamiento antes de formatear o cambiar piezas?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Sistemas Operativos Windows: Formateo, Instalación Limpia y Drivers",
                            LessonTitle = "Despliegue Estandarizado de Imágenes y Solución de Pantallas Azules (BSOD)",
                            Summary = "Domina la preparación de medios de arranque con Rufus, configuración de BIOS/UEFI, particionado GPT vs MBR, instalación de controladores oficiales y análisis de archivos Minidump ante errores BSOD.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-windows fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Instalación Limpia: La Solución Definitiva a Fallas Crónicas de Software</h5>
            <p class=""mb-0 small"">Un sistema operativo mal instalado con controladores genéricos o esquemas de partición obsoletos reduce el rendimiento del hardware a la mitad y genera inestabilidad continua en las operaciones diarias de la oficina.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/9vA2cI7I-6Q"" title=""✅ Cómo FORMATEAR tu PC e INSTALAR Windows 11 desde USB | 2026"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Arquitectura Moderna de Arranque: UEFI vs Legacy BIOS y GPT vs MBR</h4>
    <p>Para instalar sistemas operativos modernos como Windows 11 o Windows 10 en empresas actuales, es fundamental entender el salto tecnológico entre los estándares antiguos y modernos:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Parámetro</th>
                    <th>Estándar Antiguo (Legacy / MBR)</th>
                    <th>Estándar Corporativo Moderno (UEFI / GPT)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold"">Firmware de la Placa</td>
                    <td>BIOS tradicional (pantalla azul o gris sin soporte para ratón).</td>
                    <td><strong>UEFI (Unified Extensible Firmware Interface):</strong> Interfaz gráfica moderna, arranque seguro (Secure Boot) y soporte de red nativo.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">Tabla de Particiones</td>
                    <td>MBR (Master Boot Record): Límite máximo de 2 Terabytes por disco y un máximo de 4 particiones primarias.</td>
                    <td><strong>GPT (GUID Partition Table):</strong> Soporte para discos de hasta 18 Exabytes, particiones prácticamente ilimitadas y copias redundantes de la tabla de arranque para autorrecuperación.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">Seguridad de Arranque</td>
                    <td>Vulnerable a rootkits y virus que infectan el sector de arranque maestro antes de que cargue el antivirus.</td>
                    <td><strong>Secure Boot:</strong> Valida digitalmente la firma de cada controlador y cargador de arranque antes de ejecutarlo.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-usb-drive-fill text-primary me-2""></i>2. Preparación Profesional del Medio de Instalación (USB Booteable)</h4>
    <p>Para crear una memoria USB de instalación limpia estándar, la herramienta más confiable y extendida es <strong>Rufus</strong>:</p>
    <ol>
        <li>Descargar la imagen ISO oficial más reciente directamente desde el portal oficial de Microsoft.</li>
        <li>En Rufus, seleccionar la unidad USB (mínimo 8 GB a 16 GB).</li>
        <li>Seleccionar el esquema de partición: <strong>GPT</strong> y el sistema de destino: <strong>UEFI (no CSM)</strong>.</li>
        <li>Iniciar el proceso y esperar a que verifique la integridad del archivo ISO.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-bug-fill text-danger me-2""></i>3. Diagnóstico de Pantallas Azules (BSOD - Blue Screen of Death)</h4>
    <p>Una pantalla azul de Windows no ocurre 'por mala suerte'; es una detención de seguridad controlada del kernel cuando detecta que continuar ejecutándose corrompería la memoria del sistema. Cada BSOD genera un archivo de registro llamado <em>Minidump</em> (ubicado en <code>C:\Windows\Minidump</code>). Mediante herramientas gratuitas como <strong>BlueScreenView</strong> o el depurador oficial <em>WinDbg</em> de Microsoft, el técnico puede identificar el archivo exacto causante del fallo:</p>
    <ul>
        <li><code>DRIVER_IRQL_NOT_LESS_OR_EQUAL</code>: Controlador corrupto o incompatible (suele apuntar a controladores de tarjeta gráfica o tarjeta de red Wi-Fi).</li>
        <li><code>MEMORY_MANAGEMENT</code>: Casi siempre causado por un módulo de memoria RAM defectuoso o zócalo sucio. Se descarta ejecutando la herramienta de diagnóstico de memoria de Windows o <em>MemTest86</em>.</li>
        <li><code>INACCESSIBLE_BOOT_DEVICE</code>: Fallo en el controlador del disco de almacenamiento (modo AHCI/RAID mal configurado en BIOS) o corrupción en el registro de arranque.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Instalar controladores desde sitios web no oficiales o paquetes 'todo en uno':</strong> Muchos programas de actualización automática de drivers inyectan adware, versiones beta inestables o controladores genéricos que provocan pantallas azules. Siempre descarga los controladores desde el portal oficial de soporte del fabricante del equipo (Dell, HP, Lenovo, ASUS).</li>
        <li><strong>Formatear sin consultar la carpeta de descargas y documentos locales del usuario:</strong> Aunque los usuarios afirman que todo está en la nube, con frecuencia guardan claves bancarias o archivos contables críticos en el escritorio local o en carpetas temporales.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Respaldaste la información del usuario y confirmaste que los marcadores de su navegador estén sincronizados?</li>
            <li>¿Configuraste la BIOS/UEFI en modo GPT/UEFI y activaste el módulo TPM 2.0 y Secure Boot?</li>
            <li>¿Verificaste el Administrador de Dispositivos (devmgmt.msc) para comprobar que no quede ningún signo de interrogación amarillo sin controlador instalado?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Redes Locales (LAN), Cableado Estructurado UTP y Soporte a Cámaras CCTV",
                            LessonTitle = "Infraestructura Física de Redes, Norma T568B y Diagnóstico de Conectividad",
                            Summary = "Aprende a ponchar cables de red UTP Categoría 5e/6 bajo la norma T568B con conectores RJ45. Diagnostica conectividad con comandos Ping, Traceroute e Ipconfig, y configura direccionamiento IP fijo para impresoras y DVRs.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-diagram-2-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Sin Red Física Confiable no Existe Transformación Digital</h5>
            <p class=""mb-0 small"">El Wi-Fi es cómodo, pero las estaciones de trabajo fijas, servidores de bases de datos, impresoras de alto volumen y cámaras de seguridad corporativas requieren cableado estructurado físico de alta calidad para garantizar estabilidad y cero latencia.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/laWefp80lz4"" title=""¿Qué es el CABLEADO ESTRUCTURADO?"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Norma de Ponchado T568B: Código de Colores Estándar</h4>
    <p>Para armar cables de red directos (patch cords) utilizados para conectar computadoras a conmutadores de red (switches) o rosetas de pared, el estándar corporativo dominante en todo el continente americano es la norma <strong>TIA/EIA-568-B (T568B)</strong>.</p>
    <p>El cable de par trenzado UTP cuenta con 8 conductores organizados en 4 pares. Mirando el conector RJ45 de frente con la patilla plástica de traba hacia abajo y los pines dorados hacia arriba, el orden riguroso de izquierda a derecha (pin 1 al pin 8) es:</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <div class=""row g-2 font-monospace small"">
            <div class=""col-md-3""><strong>Pin 1:</strong> Blanco / Naranja</div>
            <div class=""col-md-3""><strong>Pin 2:</strong> Naranja</div>
            <div class=""col-md-3""><strong>Pin 3:</strong> Blanco / Verde</div>
            <div class=""col-md-3""><strong>Pin 4:</strong> Azul</div>
            <div class=""col-md-3""><strong>Pin 5:</strong> Blanco / Azul</div>
            <div class=""col-md-3""><strong>Pin 6:</strong> Verde</div>
            <div class=""col-md-3""><strong>Pin 7:</strong> Blanco / Marrón</div>
            <div class=""col-md-3""><strong>Pin 8:</strong> Marrón</div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-tools text-primary me-2""></i>2. Procedimiento de Crimpeado y Testeo de Cables</h4>
    <ol>
        <li>Desforrar aproximadamente 2.5 cm de la cubierta exterior del cable UTP con la cuchilla pelacables sin cortar el aislante de los conductores internos.</li>
        <li>Destrenzar cada par y peinarlos en línea recta para eliminar curvaturas.</li>
        <li>Ordenar los hilos exactamente bajo la norma T568B y cortar los extremos parejos a unos 1.2 cm con la cuchilla de corte transversal de la ponchadora.</li>
        <li>Introducir los hilos firmemente dentro del conector RJ45 asegurando que la cubierta exterior de PVC quede aprisionada dentro de la garganta del conector para que no se suelte por tirones.</li>
        <li>Introducir en la pinza crimpadora y presionar con firmeza hasta el fondo.</li>
        <li><strong>Comprobación Obligatoria:</strong> Conectar ambos extremos a un <em>Tester de Cable de Red</em> y constatar que las 8 luces LED se enciendan secuencialmente del 1 al 8 sin saltos ni cruces.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-terminal-fill text-dark me-2""></i>3. Diagnóstico de Conectividad por Consola (CLI de Windows)</h4>
    <p>Cuando un usuario reporta 'no tengo internet', un técnico nunca adivina; abre el símbolo del sistema (<code>cmd.exe</code>) y ejecuta el árbol de diagnóstico lógico:</p>
    <ol>
        <li><code>ipconfig /all</code>: Verifica si el computador tiene una dirección IP válida asignada por DHCP (ej: <code>192.168.1.105</code>). Si tiene una IP que empieza por <code>169.254.x.x</code> (APIPA), significa que el computador no tiene comunicación con el router y no recibe asignación de red.</li>
        <li><code>ping 127.0.0.1</code>: Prueba el adaptador de red local (Loopback). Si responde, la tarjeta de red interna está funcionando.</li>
        <li><code>ping [IP_Puerta_de_Enlace]</code> (ej: <code>ping 192.168.1.1</code>): Prueba la comunicación física con el router principal. Si no responde, la falla está en el cable o en el puerto del switch.</li>
        <li><code>ping 8.8.8.8</code>: Prueba la salida real a internet (servidores DNS de Google). Si responde, el enlace con el proveedor de internet está activo.</li>
        <li><code>ping google.com</code>: Prueba la resolución de nombres de dominio (DNS). Si el ping a 8.8.8.8 funciona pero a google.com falla, el problema es que el servidor DNS configurado no resuelve nombres.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar los pares destrenzados más de 1.3 cm dentro del conector:</strong> El trenzado de los cables existe específicamente para anular la diafonía y la interferencia electromagnética (Crosstalk). Destrenzar demasiado el cable causa caídas intermitentes de velocidad y errores de transmisión en redes Gigabit.</li>
        <li><strong>Asignar IPs estáticas duplicadas:</strong> Al configurar impresoras de red o cámaras de seguridad CCTV, si asignas una IP fija que ya está en uso por una computadora o dentro del rango dinámico del DHCP sin reservarla previamente, provocarás un <em>Conflicto de Direcciones IP</em> que desconectará a ambos dispositivos.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Verificaste con tester electrónico que los 8 pines tengan continuidad perfecta antes de conectar el cable a la pared?</li>
            <li>¿Etiquetaste ambos extremos del cable de red con la identificación del punto en el pach panel del rack?</li>
            <li>¿Verificaste la conectividad completa ejecutando los 5 pasos de ping en la consola de comandos?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    Questions = 
'@ + $qSupport + @'
                },

                // =========================================================================
                // 4. TI PARA EL ÉXITO EMPRESARIAL
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "ti-para-el-exito-empresarial",
                    Title = "Tecnología de la Información para el Éxito Empresarial: Transformación Digital y Sistemas Corporativos",
                    CategorySlug = "tecnologia-ia-ofimatica",
                    ShortDescription = "Comprende la visión estratégica de la tecnología: computación en la nube (SaaS, PaaS, IaaS), sistemas empresariales ERP y CRM, y gestión del riesgo tecnológico para líderes y directores.",
                    FullDescription = "Capacitación directiva y técnica diseñada para que profesionales, supervisores y gerentes comprendan el impacto de la tecnología en la rentabilidad y la escala del negocio. Aprende a evaluar costos totales de propiedad (TCO), liderar migraciones hacia servicios cloud en Amazon Web Services (AWS) y Microsoft Azure, seleccionar e implementar sistemas ERP/CRM sin fricciones operativas y formular planes de continuidad de negocio (BCP/DRP).",
                    Level = "Intermedio",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: La Era de la Transformación Digital: Más que Tecnología, un Cambio Cultural",
                            LessonTitle = "Cómo la Tecnología Redefine Modelos de Negocio Tradicionales",
                            Summary = "Descubre qué es verdaderamente la Transformación Digital, cómo superar la resistencia al cambio en los equipos de trabajo y cómo evaluar la madurez tecnológica de una organización.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-rocket-takeoff-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Transformación Digital: Rediseñar Procesos, no solo Comprar Software</h5>
            <p class=""mb-0 small"">Digitalizar un proceso burocrático y desordenado solo produce un proceso burocrático digitalizado más costoso. La transformación real comienza por simplificar el flujo de trabajo y empoderar a las personas.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/EBe51Q7-62k"" title=""La Revolución Digital: Cómo Cambió Todo"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. ¿Qué es la Transformación Digital en las Empresas Reales?</h4>
    <p>Existe la creencia equivocada de que transformar digitalmente una empresa significa comprar computadoras nuevas, escanear papeles o abrir una cuenta de Instagram. En el mundo corporativo contemporáneo, la <strong>Transformación Digital</strong> es la integración estratégica de tecnología en todas las áreas del negocio, provocando un cambio fundamental en cómo la empresa opera y cómo entrega valor a sus clientes.</p>
    <p>Implica derribar los <em>silos de información</em> (departamentos que no se comunican entre sí y guardan datos en hojas de cálculo aisladas) para crear una organización impulsada por datos (<em>Data-Driven Organization</em>), donde las decisiones de inventario, contratación y precios se toman con métricas en tiempo real y no por intuiciones personales de la gerencia.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-people-fill text-primary me-2""></i>2. Gestión del Cambio Cultural y Resistencia del Personal</h4>
    <p>El 70% de las iniciativas de digitalización en empresas fracasan no por problemas en los servidores, sino por la resistencia humana al cambio. Los colaboradores temen que los nuevos sistemas informáticos aumenten su carga de trabajo o amenacen su estabilidad laboral.</p>
    <p>Para mitigar este obstáculo, los líderes de proyectos deben aplicar metodologías probadas de gestión del cambio (como el modelo <strong>ADKAR</strong>):</p>
    <div class=""row g-2 mb-4"">
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>A</strong>wareness<br /><span class=""text-muted"">Consciencia del por qué cambiar</span></div></div>
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>D</strong>esire<br /><span class=""text-muted"">Deseo de apoyar el proyecto</span></div></div>
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>K</strong>nowledge<br /><span class=""text-muted"">Conocimiento mediante capacitación</span></div></div>
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>A</strong>bility<br /><span class=""text-muted"">Habilidad práctica en el puesto</span></div></div>
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>R</strong>einforcement<br /><span class=""text-muted"">Refuerzo continuo y métricas</span></div></div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-bar-chart-steps text-primary me-2""></i>3. Los 4 Niveles de Madurez Digital de una Empresa</h4>
    <ol>
        <li><strong>Nivel 1: Analógico / Desconectado:</strong> Procesos en papel, carpetas de archivo físico, comunicación por llamadas telefónicas no registradas y control contable en cuadernos o archivos locales individuales.</li>
        <li><strong>Nivel 2: Digitalizado Básico:</strong> Uso generalizado de hojas de cálculo de Excel para todo, correos electrónicos gratuitos y almacenamiento disperso en computadoras individuales. Alto riesgo de pérdida de datos.</li>
        <li><strong>Nivel 3: Integrado en Servidores / Nube:</strong> Uso de un sistema ERP o CRM centralizado, carpetas compartidas con permisos de seguridad y copias de seguridad automáticas.</li>
        <li><strong>Nivel 4: Optimizado e Inteligente:</strong> Automatización de flujos con bots o scripts (RPA), tableros ejecutivos en Power BI conectados en vivo y aplicación de algoritmos de IA predictiva para anticipar la demanda de inventario.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Implementar software costoso sin capacitar al equipo operativo:</strong> Comprar licencias de miles de dólares para que los empleados sigan usando cuadernos paralelos porque no entienden el software es una de las mayores fuentes de pérdida de capital en las empresas.</li>
        <li><strong>Digitalizar sin liderazgo visible de la Dirección General:</strong> Si los directores no utilizan el sistema y siguen pidiendo reportes impresos en papel, los mandos medios abandonarán el uso de la plataforma digital.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Se involucró a los usuarios finales operativos en las pruebas de selección del nuevo software?</li>
            <li>¿Se diseñó un plan formal de inducción y capacitación con manuales prácticos paso a paso?</li>
            <li>¿Se definieron indicadores clave (KPIs) para medir la reducción de tiempos de proceso tras la digitalización?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Computación en la Nube (Cloud Computing): SaaS, PaaS, IaaS y Costos TCO",
                            LessonTitle = "¿Servidores Propios o la Nube? Evaluación Económica y Operativa",
                            Summary = "Comprende los modelos de servicio en la nube (Software as a Service, Platform as a Service e Infrastructure as a Service). Aprende a calcular el Costo Total de Propiedad (TCO) comparando CAPEX frente a OPEX.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-cloud-check-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Nube es un Modelo Financiero y Operativo, no solo un Lugar de Almacenamiento</h5>
            <p class=""mb-0 small"">Migrar a la nube no se trata de apagar un servidor local para encenderlo en internet, sino de transformar gastos fijos monumentales de infraestructura física en costos operativos flexibles que crecen o disminuyen según el ritmo de las ventas.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/VR8aXePkQ5M"" title=""📌CLOUD COMPUTING ¿Qué es IaaS, PaaS y Saas? | Modelos de Servicio Cloud"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Los Tres Modelos Fundamentales de Servicio Cloud</h4>
    <p>Para tomar decisiones acertadas de contratación tecnológica, los gerentes deben dominar la pirámide de modelos en la nube:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Modelo</th>
                    <th>¿Qué Gestiona el Proveedor Cloud?</th>
                    <th>¿Qué Gestiona tu Empresa?</th>
                    <th>Ejemplos Cotidianos en la Oficina</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-primary"">SaaS (Software as a Service)</td>
                    <td>Todo: Hardware, redes, sistema operativo, base de datos y la aplicación completa.</td>
                    <td>Únicamente los datos que ingresas y los permisos de tus usuarios.</td>
                    <td>Microsoft 365, Google Workspace, Salesforce, Shopify, Zoom.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-success"">PaaS (Platform as a Service)</td>
                    <td>Infraestructura de hardware, sistema operativo, parches de seguridad y servidores web.</td>
                    <td>El código de tus aplicaciones propias y los datos de las bases de datos.</td>
                    <td>AWS Elastic Beanstalk, Google App Engine, Heroku, Azure App Services.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-danger"">IaaS (Infrastructure as a Service)</td>
                    <td>Hardware físico, centros de datos globales, energía eléctrica y virtualización base.</td>
                    <td>Todo lo demás: Instalación del sistema operativo, cortafuegos, bases de datos y programas.</td>
                    <td>Amazon EC2, Google Compute Engine, Microsoft Azure Virtual Machines.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-cash-coin text-success me-2""></i>2. Evaluación Financiera: CAPEX vs OPEX y Cálculo del TCO</h4>
    <p>Comprar un servidor físico propio (On-Premise) requiere un gasto de capital inicial masivo (<strong>CAPEX - Capital Expenditures</strong>): adquirir el servidor físico, baterías UPS, sistema de aire acondicionado para la sala de servidores, cableado y licencias perpetuas costosas. Tras 5 años, ese hardware se vuelve obsoleto y debe recomprarse.</p>
    <p>Por el contrario, la computación en la nube opera bajo un modelo de gastos operativos (<strong>OPEX - Operational Expenditures</strong>): pagas mensualmente solo por los recursos que efectivamente consumes. Si la empresa crece, amplías la memoria con un clic; si las ventas bajan, reduces los servidores y disminuyes el gasto de inmediato.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-briefcase-fill text-primary me-2""></i>3. Caso Práctico: Comparación de TCO a 3 Años</h4>
    <div class=""card border-0 bg-light p-3 rounded-3 mb-4"">
        <h6 class=""fw-bold text-dark mb-2"">Escenario: Servidor de Base de Datos para Sistema Administrativo</h6>
        <div class=""row g-3"">
            <div class=""col-md-6"">
                <div class=""p-3 bg-white rounded border h-100"">
                    <span class=""badge bg-secondary mb-2"">Opción Servidor Físico Propio (On-Premise)</span>
                    <ul class=""small mb-0 text-muted"">
                        <li>Compra de Servidor Dell PowerEdge: $4.500 USD</li>
                        <li>Licencia Windows Server + CALs: $1.800 USD</li>
                        <li>Aire acondicionado dedicado y energía 24/7: $1.200 USD/año</li>
                        <li>Soporte técnico y mantenimiento físico: $1.500 USD/año</li>
                        <li><strong>TCO Total a 3 años: ~$14.400 USD</strong></li>
                    </ul>
                </div>
            </div>
            <div class=""col-md-6"">
                <div class=""p-3 bg-white rounded border border-success h-100"">
                    <span class=""badge bg-success mb-2"">Opción Instancia Cloud (AWS / Azure)</span>
                    <ul class=""small mb-0 text-dark"">
                        <li>Máquina virtual escalable optimizada: $140 USD/mes</li>
                        <li>Respaldos automáticos georedundantes: $25 USD/mes</li>
                        <li>Cero costo de energía eléctrica local ni aire acondicionado.</li>
                        <li>Actualizaciones de hardware transparentes sin compras nuevas.</li>
                        <li><strong>TCO Total a 3 años: ~$5.940 USD (Ahorro del 58%)</strong></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar servidores cloud sobredimensionados encendidos sin control de costos:</strong> Si contratas máquinas virtuales gigantescas y no configuras apagados automáticos fuera de horario de oficina, las facturas mensuales de AWS o Azure pueden multiplicarse sorpresivamente.</li>
        <li><strong>No considerar la calidad de la conexión local a internet:</strong> Si migras todo tu sistema de facturación a la nube pero tu oficina tiene un único enlace de internet inestable y sin respaldo móvil (4G/5G de contingencia), cuando se corte el internet tu empresa no podrá operar.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Calculaste el costo total de propiedad (TCO) incluyendo energía, licencias y soporte antes de decidir?</li>
            <li>¿Configuraste alertas presupuestarias en la consola de la nube para evitar sorpresas en la facturación?</li>
            <li>¿Dispone la empresa de una conexión a internet secundaria de respaldo para asegurar la comunicación con la nube?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Sistemas ERP y CRM: La Columna Vertebral de la Operación Corporativa",
                            LessonTitle = "Selección, Implementación y Retorno de Inversión (ROI) en Software",
                            Summary = "Domina la diferencia estructural entre un ERP (Enterprise Resource Planning) y un CRM (Customer Relationship Management). Aprende a auditar procesos y liderar implementaciones exitosas sin frenar las ventas.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-diagram-3-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">ERP y CRM: Integrar para Conquistar el Mercado</h5>
            <p class=""mb-0 small"">Una empresa que crece sin un ERP centralizado se convierte en un archipiélago caótico de hojas de Excel donde compras no sabe qué vendió ventas, y finanzas no sabe si hay inventario real para cobrar.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/TLztJtLmKMw"" title=""SAP ERP: La Columna Vertebral de la Gestión Empresarial | Aprende con PRIME INSTITUTE"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. ERP vs CRM: ¿Cuál es la Diferencia y Cómo se Complementan?</h4>
    <p>Aunque ambos son sistemas de software empresarial, cumplen roles totalmente distintos pero simbióticos en la cadena de valor:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h5 class=""fw-bold text-primary mb-2""><i class=""bi bi-gear-wide-connected me-2""></i>ERP (Enterprise Resource Planning)</h5>
                <p class=""small text-muted mb-2"">Mira hacia el <strong>interior y la operación</strong> de la empresa. Gestiona los recursos materiales, productivos y financieros necesarios para cumplir los pedidos.</p>
                <ul class=""small mb-0"">
                    <li>Contabilidad general, tesorería y cuentas por pagar/cobrar.</li>
                    <li>Gestión de inventarios, almacenes y movimientos de stock.</li>
                    <li>Planificación de compras, órdenes y recepción de mercancía.</li>
                    <li>Facturación legal y liquidación de nóminas de empleados.</li>
                </ul>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h5 class=""fw-bold text-success mb-2""><i class=""bi bi-people-fill me-2""></i>CRM (Customer Relationship Management)</h5>
                <p class=""small text-muted mb-2"">Mira hacia el <strong>exterior y el cliente</strong>. Gestiona todas las interacciones, oportunidades comerciales y el ciclo de vida de los prospectos.</p>
                <ul class=""small mb-0"">
                    <li>Seguimiento de prospectos (leads) y embudos de ventas.</li>
                    <li>Historial completo de llamadas, correos y reuniones con clientes.</li>
                    <li>Automatización de campañas de marketing y fidelización.</li>
                    <li>Módulo de servicio postventa, garantías y resolución de quejas.</li>
                </ul>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-check2-circle text-primary me-2""></i>2. Las 5 Fases de una Implementación Exitosa de ERP</h4>
    <p>La adopción de un sistema como SAP Business One, Odoo, Oracle o Microsoft Dynamics debe ejecutarse bajo una metodología estricta para evitar sobrecostos catastróficos:</p>
    <ol>
        <li><strong>Fase 1: Levantamiento de Procesos (As-Is):</strong> Documentar detalladamente cómo opera la empresa hoy en día, identificando cuellos de botella y redundancias antes de tocar el software.</li>
        <li><strong>Fase 2: Diseño del Modelo Objetivo (To-Be):</strong> Parametrizar el software para que se adapte a las mejores prácticas de la industria, evitando en lo posible hacer desarrollos a la medida innecesarios que compliquen futuras actualizaciones.</li>
        <li><strong>Fase 3: Migración y Depuración de Datos Maestros:</strong> Limpiar las bases de datos de clientes, proveedores y artículos (eliminando duplicados, productos obsoletos y saldos descuadrados) antes de cargarlos al nuevo sistema.</li>
        <li><strong>Fase 4: Pruebas Integrales de Usuario (UAT):</strong> El personal operativo realiza simulaciones completas del ciclo de venta, compra y facturación en un entorno de pruebas controlado.</li>
        <li><strong>Fase 5: Salida en Vivo (Go-Live) y Soporte Hipercare:</strong> Inicio de la operación real con acompañamiento técnico continuo durante los primeros 30 días para resolver incidencias de arranque.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Migrar datos 'sucios' del sistema anterior:</strong> Si exportas una base de datos con clientes duplicados y códigos de inventario mal escritos, el nuevo ERP generará informes erróneos desde el primer día de operación.</li>
        <li><strong>Exceso de personalizaciones y código a medida:</strong> Intentar que el ERP haga exactamente lo mismo que hacía la hoja de cálculo antigua encarece el proyecto en un 300% y vuelve imposible actualizar el sistema a nuevas versiones.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Se depuraron y estandarizaron los catálogos de artículos y clientes antes de la migración?</li>
            <li>¿Se asignaron líderes funcionales por cada área (Compras, Ventas, Contabilidad) con tiempo dedicado al proyecto?</li>
            <li>¿Se realizaron pruebas piloto completas con facturas reales antes de apagar el sistema antiguo?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Ciberseguridad Gerencial y Continuidad de Negocios (BCP/DRP)",
                            LessonTitle = "Gestión del Riesgo Tecnológico para Directores y Líderes de Área",
                            Summary = "Aprende a formular matrices de riesgo tecnológico, establecer planes de continuidad de negocio (BCP) y liderar la respuesta corporativa ante crisis informáticas protegiendo la reputación institucional.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-shield-fill-exclamation fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Ciberseguridad es una Responsabilidad del Consejo Directivo</h5>
            <p class=""mb-0 small"">Los ciberataques ya no son solo problemas del departamento de sistemas; son riesgos corporativos estratégicos capaces de destruir la cotización bursátil, la confianza de los clientes y la solvencia financiera de la compañía.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/0IS6CDpBcfs"" title=""BCP, DRP y Gestión de Crisis: diferencias explicadas fácil"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. BCP vs DRP: Los Dos Escudos de la Resiliencia Corporativa</h4>
    <p>En el nivel directivo, es vital dominar la complementariedad entre los dos planes de contingencia más importantes de la organización:</p>
    <ul>
        <li><strong>BCP (Business Continuity Plan - Plan de Continuidad de Negocio):</strong> De alcance <strong>empresarial e integral</strong>. Define cómo la organización continuará operando sus funciones vitales durante una crisis (por ejemplo: si se incendia la sede principal o cae el sistema central, cómo los empleados continuarán atendiendo clientes por teléfono desde sedes alternas o en teletrabajo de emergencia).</li>
        <li><strong>DRP (Disaster Recovery Plan - Plan de Recuperación ante Desastres):</strong> De alcance <strong>estrictamente técnico y de TI</strong>. Se enfoca en los procedimientos paso a paso para restaurar los servidores, bases de datos, redes y aplicaciones de software afectadas hasta devolverlos a su estado normal de operación.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-grid-3x3-gap-fill text-primary me-2""></i>2. Construcción de una Matriz de Riesgos Tecnológicos</h4>
    <p>Para priorizar las inversiones de protección sin gastar dinero a ciegas, los directores deben construir y mantener actualizada la <strong>Matriz de Riesgos IT</strong> evaluando cada amenaza bajo la fórmula universal:</p>
    <div class=""p-3 bg-light rounded text-center my-3"">
        <code class=""fs-6 fw-bold"">Nivel de Riesgo = Probabilidad de Ocurrencia (1 a 5) × Impacto Financiero y Reputacional (1 a 5)</code>
    </div>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Escenario de Riesgo</th>
                    <th>Probabilidad</th>
                    <th>Impacto</th>
                    <th>Estrategia de Mitigación Obligatoria</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Infección masiva de Ransomware en servidores centrales</td>
                    <td class=""text-center"">Media (3)</td>
                    <td class=""text-center text-danger fw-bold"">Catastrófico (5)</td>
                    <td>Respaldos inmutables WORM fuera de sitio + MFA universal en todas las cuentas de administración.</td>
                </tr>
                <tr>
                    <td>Caída del enlace principal de internet durante día de ventas</td>
                    <td class=""text-center text-warning fw-bold"">Alta (4)</td>
                    <td class=""text-center"">Moderado (3)</td>
                    <td>Contratación de un enlace de internet secundario con tecnología distinta (Fibra Óptica + Enlace Satelital/4G).</td>
                </tr>
                <tr>
                    <td>Filtración de base de datos de clientes por empleado desleal</td>
                    <td class=""text-center"">Baja (2)</td>
                    <td class=""text-center text-danger fw-bold"">Catastrófico (5)</td>
                    <td>Políticas de Privilegio Mínimo (Zero Trust), cifrado de bases de datos y acuerdos de confidencialidad reforzados.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-megaphone-fill text-primary me-2""></i>3. Gestión de Comunicación en Crisis y Protección de Marca</h4>
    <p>Cuando ocurre una brecha de seguridad (por ejemplo, una filtración de datos), el daño reputacional puede ser diez veces más costoso que el daño técnico. Las mejores prácticas de comunicación en crisis exigen:</p>
    <ol>
        <li><strong>Comité de Crisis Activado:</strong> Conformado por el Director General (CEO), Director de TI (CTO), Director Legal y Director de Comunicaciones.</li>
        <li><strong>Transparencia Controlada:</strong> Admitir el incidente ante las autoridades y clientes afectados en los plazos legales, explicando qué medidas correctivas inmediatas se implementaron para blindar el sistema.</li>
        <li><strong>Canal Único de Vocería:</strong> Ningún empleado individual puede emitir declaraciones o comentarios en redes sociales sobre el incidente; toda comunicación oficial debe provenir exclusivamente del portavoz designado.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Ocultar una brecha de seguridad a los clientes:</strong> Ocultar un hackeo suele terminar en filtraciones públicas peores, destruyendo irreversiblemente la confianza comercial y atrayendo multas regulatorias masivas.</li>
        <li><strong>Considerar el plan de continuidad como un documento estático de biblioteca:</strong> Si el BCP fue redactado hace 4 años y cita nombres de personas que ya no trabajan en la empresa o sistemas que ya no existen, no servirá de nada en una emergencia real.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Cuenta la empresa con una póliza de ciberseguro adecuada a su volumen de facturación?</li>
            <li>¿Se realizan simulacros anuales del Plan de Continuidad de Negocio con todo el equipo directivo?</li>
            <li>¿Están claramente definidos los roles y voceros oficiales ante incidentes de ciberseguridad?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    Questions = 
'@ + $qTI + @'
                }
            };
        }
    }
}
'@

[System.IO.File]::WriteAllText($techAiFile, $newCode, [System.Text.Encoding]::UTF8)
Write-Host "Updated CurriculumUpgrade.TechAI.cs successfully!"
