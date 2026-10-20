$officeFile = "c:\Users\plase\source\repos\CursosCertificadosApp\CursosCertificadosApp\Data\CurriculumUpgrade.OfficeData.cs"

# Read existing questions from OfficeData.cs
$oldContent = Get-Content $officeFile -Raw -Encoding UTF8

function Extract-Questions ($slug) {
    global:oldContent
    $pattern = '(?s)Slug\s*=\s*"' + [regex]::Escape($slug) + '".*?Questions\s*=\s*(new List<UpgradeQuestionData>\s*\{.*?\n\s*\})\s*\}'
    if ($oldContent -match $pattern) {
        return $matches[1]
    }
    Write-Warning "Could not extract questions for $slug"
    return "new List<UpgradeQuestionData>()"
}

$qOfficeBasico = Extract-Questions "office-basico"
$qExcelAvanzado = Extract-Questions "excel-avanzado"
$qPowerBi = Extract-Questions "power-bi"
$qCienciaDatos = Extract-Questions "ciencia-y-analisis-de-datos"
$qOfficeIntermedio = Extract-Questions "office-intermedio"

$newCode = @'
using CursosCertificadosApp.Models.Entities;

namespace CursosCertificadosApp.Data
{
    public static class CurriculumUpgradeOfficeData
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
                // 1. MICROSOFT OFFICE BÁSICO
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "office-basico",
                    Title = "Microsoft Office Básico: Word, Excel y PowerPoint para el Entorno Laboral",
                    CategorySlug = "tecnologia-ia-ofimatica",
                    ShortDescription = "Domina las herramientas indispensables de oficina: redacción de documentos formales en Word, hojas de cálculo y fórmulas básicas en Excel, y presentaciones de impacto en PowerPoint.",
                    FullDescription = "Formación integral y práctica orientada al trabajo diario de oficina. Aprende desde el formato profesional de correspondencia, memorándums e informes en Word, hasta el diseño de tablas ordenadas, sumatorias y porcentajes en Excel, y la estructuración de diapositivas ejecutivas en PowerPoint sin sobrecargar texto.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Word Profesional: Formato de Documentos, Estilos y Correspondencia",
                            LessonTitle = "Elaboración de Informes, Cartas y Memorándums Corporativos",
                            Summary = "Aprende a maquetar documentos bajo normas corporativas, usar la cinta de opciones, aplicar estilos de título para generar tablas de contenido automáticas y configurar encabezados/pies de página diferenciados.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-file-earmark-word-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Estándar de Redacción en Empresas Modernas</h5>
            <p class=""mb-0 small"">Un documento mal formateado resta credibilidad institucional. Aprender a dominar sangrías, estilos de párrafo y numeración jerárquica ahorra horas de trabajo y previene el desorden documental en cualquier oficina.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/XeqAyA6juCg"" title=""Word desde CERO: Cómo DAR FORMATO PROFESIONAL con ESTILOS y TABLA Automática"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Jerarquía Estructural de un Documento de Negocios</h4>
    <p>El error más recurrente de los usuarios novatos en Microsoft Word es aplicar negritas, cambiar el tamaño de letra manualmente a 14pt o 16pt y dar múltiples 'Enter' para separar párrafos o forzar saltos de página. En un entorno laboral formal, este método artesanal provoca que al modificar una línea en la página 2, todo el informe de 30 páginas se desconfigure por completo.</p>
    <p>El estándar profesional exige el uso riguroso del panel de <strong>Estilos de Word</strong>:</p>
    <ul>
        <li><strong>Título 1 (Heading 1):</strong> Reservado exclusivamente para los capítulos o secciones principales del documento (ej: 1. INTRODUCCIÓN, 2. DIAGNÓSTICO FINANCIERO).</li>
        <li><strong>Título 2 (Heading 2):</strong> Para subtítulos de segundo nivel (ej: 2.1 Análisis de Costos Fijos, 2.2 Proyección de Ingresos).</li>
        <li><strong>Normal (Body Text):</strong> Para todo el texto corrido. Tipografía estándar corporativa (Aptos, Calibri o Arial de 11pt a 12pt, interlineado 1.15 a 1.5, con espaciado posterior de 6pt a 8pt entre párrafos para erradicar la necesidad de dar dobles saltos de línea con la tecla Enter).</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-gear-fill text-primary me-2""></i>2. Generación Automatizada de Tablas de Contenido (Índices)</h4>
    <p>Cuando un informe se estructura utilizando la jerarquía oficial de Estilos (Título 1, Título 2, Título 3), crear el índice general de la obra toma exactamente dos clics:</p>
    <ol>
        <li>Posicionar el cursor en la página donde se requiere el índice (después de la portada y la carta de presentación).</li>
        <li>Ir a la pestaña superior <strong>Referencias</strong> de la cinta de opciones.</li>
        <li>Hacer clic en <strong>Tabla de contenido</strong> y seleccionar el estilo automático preferido.</li>
        <li><strong>Actualización Dinámica:</strong> Si en el futuro agregas texto o cambian los números de página, basta con hacer clic derecho sobre la tabla y seleccionar <em>'Actualizar campos ➔ Actualizar toda la tabla'</em> para que Word sincronice títulos y páginas al milisegundo sin digitar números a mano.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-briefcase-fill text-primary me-2""></i>3. Caso Práctico de Oficina: Memorándum Corporativo Estandarizado</h4>
    <div class=""card border-0 bg-light p-3 rounded-3 mb-4"">
        <h6 class=""fw-bold text-dark mb-2"">Estructura Obligatoria de Correspondencia Interna</h6>
        <div class=""font-monospace small bg-white p-3 rounded border"">
            <strong>MEMORÁNDUM INTERNO N° 2026-ADM-042</strong><br />
            <strong>PARA:</strong> Todo el Personal de Operaciones y Ventas<br />
            <strong>DE:</strong> Gerencia de Administración y Recursos Humanos<br />
            <strong>FECHA:</strong> 24 de Octubre de 2026<br />
            <strong>ASUNTO:</strong> Implementación del Nuevo Protocolo de Rendición de Gastos de Viaje<br />
            <hr class=""my-2"" />
            Se informa a todos los colaboradores que a partir del primer día hábil del próximo mes entrará en vigencia el sistema digital de rendición de viáticos...
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Presionar Enter repetidamente para pasar a la siguiente página:</strong> Provoca que cualquier edición previa mueva los títulos a mitad de página. La regla profesional es presionar siempre el atajo de teclado <code>Ctrl + Enter</code> para insertar un <em>Salto de Página</em> limpio.</li>
        <li><strong>Encabezados idénticos en la portada:</strong> Para evitar que el número de página o el logotipo aparezca en la primera hoja, se debe marcar la casilla <em>'Primera página diferente'</em> en la pestaña de Diseño de Encabezado y Pie de página.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Utilizaste los estilos Título 1 y Título 2 en lugar de cambiar el tamaño de letra manualmente?</li>
            <li>¿Insertaste saltos de página con Ctrl + Enter en lugar de múltiples líneas vacías?</li>
            <li>¿Verificaste la ortografía y gramática completa presionando la tecla F7 antes de exportar a PDF?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Excel Básico: Estructura de Celdas, Operadores y Formato de Tablas",
                            LessonTitle = "Diseño de Hojas de Cálculo Claras, Ordenadas y Profesionales",
                            Summary = "Domina la cuadrícula de Excel: tipos de datos (texto, número, fecha, moneda), operadores matemáticos (+, -, *, /), formateo de tablas oficiales con filtros y atajos esenciales de navegación.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-file-earmark-excel-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Excel: El Lenguaje Universal de las Finanzas y la Operación</h5>
            <p class=""mb-0 small"">En cualquier puesto administrativo, desde recepcionista hasta director general, saber estructurar una tabla limpia y comprender cómo Excel trata números y textos es el primer paso hacia la autonomía laboral.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/qtuElizNx9g"" title=""Cómo hacer una tabla en Excel y aplicar formatos en celdas"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Anatomía de la Cuadrícula y Tipos de Datos</h4>
    <p>Excel organiza los datos en columnas (identificadas por letras: A, B, C...) y filas (identificadas por números: 1, 2, 3...). La intersección de una columna y una fila es una <strong>celda</strong> (ejemplo: <code>B4</code>). El secreto para no frustrarse con fórmulas que fallan es entender cómo Excel interpreta lo que escribes:</p>
    <ul>
        <li><strong>Texto (Cadenas alfanuméricas):</strong> Se alinea automáticamente a la <em>izquierda</em> de la celda. Si un número está alineado a la izquierda, significa que Excel lo guardó como texto (a menudo por tener un apóstrofe inicial o espacios invisibles) y no podrá sumarlo.</li>
        <li><strong>Números puros y Moneda:</strong> Se alinean automáticamente a la <em>derecha</em>. Siempre deben ingresarse sin símbolos de moneda escritos a mano (nunca escribas '$ 100'; escribe <code>100</code> y aplica el formato de moneda desde la barra superior).</li>
        <li><strong>Fechas:</strong> Para Excel, una fecha es internamente un número entero secuencial (donde el número 1 representa el 1 de enero de 1900). Esto permite restar dos fechas para calcular días de vencimiento o mora.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-calculator-fill text-primary me-2""></i>2. Operadores Matemáticos Básicos y Jerarquía de Operaciones</h4>
    <p>Toda fórmula en Excel debe comenzar obligatoriamente con el signo igual (<code>=</code>) o el signo más (<code>+</code>). Los operadores matemáticos elementales son:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Operación</th>
                    <th>Operador</th>
                    <th>Ejemplo Escrito</th>
                    <th>Resultado Práctico</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Suma</td>
                    <td><code>+</code></td>
                    <td><code>=A1 + B1</code></td>
                    <td>Suma los valores de ambas celdas.</td>
                </tr>
                <tr>
                    <td>Resta</td>
                    <td><code>-</code></td>
                    <td><code>=A1 - B1</code></td>
                    <td>Calcula la diferencia o margen bruto.</td>
                </tr>
                <tr>
                    <td>Multiplicación</td>
                    <td><code>*</code> (Asterisco)</td>
                    <td><code>=C2 * D2</code></td>
                    <td>Calcula Total = Cantidad × Precio Unitario.</td>
                </tr>
                <tr>
                    <td>División</td>
                    <td><code>/</code> (Barra inclinada)</td>
                    <td><code>=E2 / 1.16</code></td>
                    <td>Desglosa la base imponible extrayendo el IVA.</td>
                </tr>
            </tbody>
        </table>
    </div>
    <p class=""small text-muted""><strong>Jerarquía de Operaciones (PEMDAS):</strong> Excel siempre resuelve primero los paréntesis, luego potencias, luego multiplicaciones y divisiones, y finalmente sumas y restas. La fórmula <code>=10 + 5 * 2</code> da como resultado <strong>20</strong> (no 30). Si deseas sumar primero, debes agrupar entre paréntesis: <code>=(10 + 5) * 2</code> (que da 30).</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-table text-primary me-2""></i>3. La Herramienta 'Dar Formato como Tabla' (Ctrl + T)</h4>
    <p>Muchos usuarios dibujan bordes negros celda por celda y pintan los encabezados a mano. El método profesional es seleccionar cualquier celda del rango y presionar <code>Ctrl + T</code> para convertir el rango en una <strong>Tabla Oficial de Excel</strong>. Ventajas automáticas inmediatas:</p>
    <ol>
        <li>Filtros automáticos desplegables en cada columna para ordenar de la A a la Z o buscar por montos.</li>
        <li>Fórmulas autorrellenadas: Al escribir una fórmula en una celda, Excel la calcula automáticamente hacia abajo en toda la columna.</li>
        <li>Expansión automática: Si agregas una fila nueva al final, la tabla absorbe el formato y las fórmulas al instante.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Escribir texto dentro de celdas con números:</strong> Escribir <code>100 cajas</code> o <code>$50 USD</code> en la celda impide que Excel reconozca el valor como número, arrojando el temido error <code>#¡VALOR!</code> al intentar sumarlo. Coloca el número puro (<code>100</code>) y especifica la unidad ('Cajas') en el encabezado de la columna.</li>
        <li><strong>Celdas combinadas en columnas de bases de datos:</strong> Usar 'Combinar y centrar' sobre filas de datos bloquea el ordenamiento y rompe las fórmulas de búsqueda. Las celdas combinadas solo deben usarse en títulos superiores fuera de la tabla.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Verificaste que todos los números estén alineados a la derecha y con formato de moneda o millares?</li>
            <li>¿Respetaste los paréntesis en fórmulas combinadas de suma y multiplicación?</li>
            <li>¿Convertiste tus listas de datos en Tablas Oficiales con Ctrl + T para habilitar filtros rápidos?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Excel Funcional: Funciones Esenciales SUMA, PROMEDIO, CONTAR y Referencias",
                            LessonTitle = "Automatización de Cálculos: De la Suma Simple a las Referencias Absolutas ($)",
                            Summary = "Domina las funciones núcleo de oficina: SUMA, PROMEDIO, CONTAR, MAX y MIN. Comprende la diferencia vital entre referencias relativas (A1) y referencias absolutas fijadas ($A$1) con F4.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-currency-dollar fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Secreto de Excel: Fijar Celdas con el Signo de Dólar ($)</h5>
            <p class=""mb-0 small"">El 90% de los errores al arrastrar fórmulas hacia abajo o hacia la derecha ocurren por no entender cuándo fijar una celda fija (como una tasa de cambio o un porcentaje de comisión) con la tecla F4.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/9eTxxrRVF2Q"" title=""Funciones de Excel Básicas: SUMA, PROMEDIO, CONTAR"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Las 5 Funciones Núcleo de la Oficina</h4>
    <p>En lugar de sumar celda por celda (<code>=A1+A2+A3+A4...</code>), Excel provee funciones preprogramadas que procesan rangos enteros en milisegundos indicando la celda inicial y la final separadas por dos puntos (<code>:</code>):</p>
    <ul>
        <li><code>=SUMA(C2:C100)</code>: Suma todas las cantidades numéricas del rango indicado, ignorando celdas con texto o en blanco.</li>
        <li><code>=PROMEDIO(D2:D100)</code>: Calcula la media aritmética (suma de valores dividida entre la cantidad de celdas con número).</li>
        <li><code>=CONTAR(A2:A100)</code>: Cuenta cuántas celdas contienen valores puramente numéricos.</li>
        <li><code>=CONTARA(A2:A100)</code>: Cuenta celdas no vacías (útil para saber cuántos empleados o clientes hay en la lista, contenga texto o números).</li>
        <li><code>=MAX(E2:E100)</code> y <code>=MIN(E2:E100)</code>: Devuelven la venta más alta y el costo más bajo del período respectivamente.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-pin-angle-fill text-danger me-2""></i>2. Referencias Relativas vs Referencias Absolutas ($ con F4)</h4>
    <p>Cuando escribes <code>=B2 * C2</code> y arrastras la celda hacia abajo, Excel inteligentemente adapta la fórmula a <code>=B3 * C3</code>, luego <code>=B4 * C4</code>. Esto se llama <strong>Referencia Relativa</strong>.</p>
    <p>Pero imagínate que en la celda <code>$F$1</code> tienes la tasa de cambio oficial del BCV o el porcentaje de IVA (16%), y quieres multiplicar las ventas de cada fila por esa celda fija. Si arrastras la fórmula normal, en la siguiente fila Excel buscará en F2, luego en F3 (celdas vacías), multiplicando por cero y arrojando ceros en toda la columna.</p>
    <p>Para evitarlo, debes presionar la tecla <strong>F4</strong> sobre la celda para convertirla en <strong>Referencia Absoluta</strong> (aparecerán los signos de dólar: <code>$F$1</code>):</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <p class=""small mb-0 font-monospace text-dark"">
            <strong>Fórmula Correcta:</strong> <code>=D2 * $F$1</code><br />
            Al arrastrar hacia abajo, se convierte en:<br />
            Fila 3: <code>=D3 * $F$1</code><br />
            Fila 4: <code>=D4 * $F$1</code><br />
            <em>(D2 se mueve libremente por ser relativa, pero $F$1 queda firmemente anclada como referencia absoluta).</em>
        </p>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-briefcase-fill text-primary me-2""></i>3. Caso Práctico: Cálculo de Comisiones con Meta Mínima</h4>
    <p>Si deseas calcular comisiones únicamente a los asesores que superaron la meta mínima de ventas, se combina una referencia absoluta con una lógica de porcentaje:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Asesor</th>
                    <th>Venta Real (B)</th>
                    <th>Meta Fija ($E$1 = $5.000)</th>
                    <th>Tasa Comisión ($E$2 = 5%)</th>
                    <th>Fórmula en Columna C</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Carlos R.</td>
                    <td>$6.200</td>
                    <td>$5.000</td>
                    <td>5%</td>
                    <td><code>=B2 * $E$2</code> ➔ $310 USD</td>
                </tr>
                <tr>
                    <td>María L.</td>
                    <td>$4.800</td>
                    <td>$5.000</td>
                    <td>5%</td>
                    <td><code>=B3 * $E$2</code> ➔ $240 USD</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Escribir los signos de dólar ($) a mano y equivocarse de posición:</strong> Recuerda siempre presionar la tecla <code>F4</code> (o <code>Fn + F4</code> en algunas laptops portátiles) con el cursor ubicado sobre la celda para alternar automáticamente entre <code>$A$1</code> (fija fila y columna), <code>A$1</code> (fija solo fila) y <code>$A1</code> (fija solo columna).</li>
        <li><strong>Incluir la celda del total dentro del propio rango de la suma:</strong> Si en la celda A10 escribes <code>=SUMA(A1:A10)</code>, provocarás un error de <em>Referencia Circular</em>, donde la fórmula intenta sumarse a sí misma infinitamente bloqueando el cálculo. La fórmula correcta es <code>=SUMA(A1:A9)</code>.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Utilizaste referencias absolutas ($) para fijar celdas de impuestos, comisiones o tasas de cambio?</li>
            <li>¿Verificaste que no existan referencias circulares en la barra de estado inferior de Excel?</li>
            <li>¿Revisaste que los rangos de SUMA no incluyan filas de encabezado de texto?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: PowerPoint Efectivo: Estructura de Diapositivas y Storytelling Visual",
                            LessonTitle = "Diseño de Diapositivas Ejecutivas de Alto Impacto para Juntas Directivas",
                            Summary = "Elimina diapositivas sobrecargadas de texto. Aplica la regla 6x6, el contraste tipográfico, el uso de iconografía vectorial corporativa y la estructuración de narrativas de negocios (Storytelling).",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-file-earmark-slides-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Una Diapositiva es una Ayuda Visual, no un Teleprompter</h5>
            <p class=""mb-0 small"">El error más destructivo en presentaciones corporativas es proyectar párrafos enteros de texto para que el expositor los lea de espaldas al público. La diapositiva debe complementar tu voz, no competir contra ella.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/LIXfGkAca0g"" title=""Cómo usar PowerPoint [ Guía completa ]"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Regla de Oro 6x6 y Jerarquía Visual</h4>
    <p>Para mantener la atención de un comité directivo o un cliente potencial, se recomienda aplicar el principio de diseño ejecutivo <strong>Regla 6x6</strong>:</p>
    <ul>
        <li>Máximo <strong>6 viñetas (bullets)</strong> por diapositiva.</li>
        <li>Máximo <strong>6 a 8 palabras</strong> por viñeta (oraciones concisas tipo telegrama, no párrafos literarios).</li>
        <li>Una única idea central por diapositiva. Si tienes tres argumentos comerciales distintos, es preferible utilizar tres diapositivas limpias y dinámicas que una sola diapositiva abarrotada de letras microscópicas.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-palette-fill text-primary me-2""></i>2. Contraste de Color, Tipografía e Iconografía Vectorial</h4>
    <p>El diseño profesional de diapositivas se basa en tres reglas visuales obligatorias:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h6 class=""fw-bold text-dark mb-1"">1. Alto Contraste</h6>
                <p class=""small text-muted mb-0"">Texto oscuro (gris grafito o azul marino profundo) sobre fondo blanco/claro, o texto blanco sobre fondo oscuro. Nunca utilices texto amarillo o verde claro sobre fondos blancos.</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h6 class=""fw-bold text-dark mb-1"">2. Máximo 2 Tipografías</h6>
                <p class=""small text-muted mb-0"">Una tipografía robusta para títulos (ej: Arial Black, Montserrat o Trebuchet MS) y una limpia sin serifas para el contenido (ej: Calibri, Aptos o Segoe UI).</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h6 class=""fw-bold text-dark mb-1"">3. Iconos en vez de Puntos</h6>
                <p class=""small text-muted mb-0"">Reemplaza las tradicionales viñetas de puntos negros por iconos vectoriales limpios que representen el concepto (una moneda para costos, un reloj para plazos, un usuario para clientes).</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-layout-wtf text-primary me-2""></i>3. Estructura Narrativa de Presentación Ejecutiva (Problema ➔ Solución ➔ Impacto)</h4>
    <p>Para presentar una propuesta o un balance trimestral con éxito persuasivo, organiza las diapositivas en tres actos claros:</p>
    <ol>
        <li><strong>El Desafío / Problema Actual (20% del tiempo):</strong> Mostrar la realidad con cifras contundentes (ej: 'El tiempo de despacho aumentó 3 días en el último mes').</li>
        <li><strong>La Solución Propuesta / Plan de Acción (50% del tiempo):</strong> Explicar la iniciativa paso a paso, los responsables y los recursos necesarios.</li>
        <li><strong>El Retorno / Impacto Económico Esperado (30% del tiempo):</strong> Concluir con la ganancia concreta para la empresa (ej: 'Ahorro proyectado de $12.000 USD anuales y 98% de entregas a tiempo').</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Abusar de animaciones de entrada y transiciones ruidosas:</strong> Efectos como rebotes, espirales o sonidos de aplausos restan seriedad institucional. Utiliza transiciones sobrias como <em>'Desvanecer' (Fade)</em> o transiciones suaves de medio segundo.</li>
        <li><strong>Estirar o deformar imágenes y logotipos:</strong> Al redimensionar una imagen corporativa, mantén siempre presionada la tecla <code>Shift</code> y arrastra desde las esquinas diagonales para conservar las proporciones perfectas sin achatarlas.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Respetaste la regla 6x6 evitando saturar de texto las diapositivas?</li>
            <li>¿El tamaño de letra de los textos principales es de al menos 24pt a 28pt para que sea legible al fondo de la sala?</li>
            <li>¿Probaste el modo Presentador con la tecla F5 y comprobaste el funcionamiento de tus notas del orador?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    Questions = 
'@ + $qOfficeBasico + @'
                },

                // =========================================================================
                // 2. EXCEL AVANZADO
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "excel-avanzado",
                    Title = "Excel Avanzado: Modelado Financiero, Fórmulas Anidadas, Tablas Dinámicas y Macros",
                    CategorySlug = "tecnologia-ia-ofimatica",
                    ShortDescription = "Lleva tus habilidades de análisis al nivel profesional: funciones de búsqueda avanzada (XLOOKUP/BUSCARX), lógica condicional compleja, tablas dinámicas analíticas y automatización con macros VBA.",
                    FullDescription = "Capacitación de alto nivel para analistas financieros, contadores y supervisores de operaciones. Domina la transición moderna de BUSCARV hacia BUSCARX e ÍNDICE/COINCIDIR bidireccional; estructura fórmulas anidadas con SI.CONJUNTO y operadores booleanos Y/O; diseña cuadros de mando interactivos con Tablas Dinámicas, campos calculados y segmentadores; y automatiza procesos repetitivos con macros grabadas y código VBA esencial.",
                    Level = "Avanzado",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Búsqueda y Extracción Avanzada: De BUSCARV a BUSCARX (XLOOKUP) e ÍNDICE/COINCIDIR",
                            LessonTitle = "Búsquedas Dinámicas hacia la Izquierda y Extracción Multicolumna",
                            Summary = "Supera las limitaciones históricas de BUSCARV. Domina la función BUSCARX (XLOOKUP) para búsquedas hacia la izquierda, valores predeterminados ante errores y la clásica combinación robusta ÍNDICE y COINCIDIR.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-search fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">BUSCARX: La Función que Revolucionó el Análisis de Datos en Excel</h5>
            <p class=""mb-0 small"">Durante décadas, BUSCARV fue la función reina, pero su incapacidad para buscar hacia la izquierda y su vulnerabilidad al insertar columnas en la base de datos la convirtieron en una fuente constante de errores. BUSCARX resuelve todas esas fallas con una sintaxis moderna y flexible.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/tx9kugxoQRk"" title=""Excel - Uso de función BUSCARX / XLOOKUP"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. ¿Por qué BUSCARV se Quedó Obsoleta?</h4>
    <p>La tradicional función <code>BUSCARV</code> exigía contar manualmente el número de columna (ej: <code>=BUSCARV(A2; D:Z; 7; FALSO)</code>). Esto presentaba tres debilidades críticas en entornos corporativos:</p>
    <ul>
        <li><strong>Incapacidad de buscar hacia la izquierda:</strong> El dato a buscar debía estar obligatoriamente en la primera columna del rango. Si tenías el número de cédula en la columna C y querías extraer el nombre ubicado en la columna A, BUSCARV era completamente inútil.</li>
        <li><strong>Fragilidad ante inserción de columnas:</strong> Si un compañero insertaba una columna nueva en la base de datos, el número índice '7' quedaba desfasado, trayendo datos incorrectos en silencio.</li>
        <li><strong>Falta de manejo nativo de errores:</strong> Si el código no existía, devolvía el feo error <code>#N/D</code>, obligando a anidar la función dentro de <code>SI.ERROR()</code>.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-code-square text-success me-2""></i>2. La Sintaxis Quirúrgica de BUSCARX (XLOOKUP)</h4>
    <p>Disponible en Excel para Microsoft 365 y versiones recientes, <strong>BUSCARX</strong> utiliza rangos desacoplados en lugar de matrices fijas:</p>
    <div class=""p-3 bg-light rounded border font-monospace small mb-3"">
        <code>=BUSCARX(valor_buscado; matriz_busqueda; matriz_devuelta; [si_no_se_encuentra]; [modo_coincidencia]; [modo_busqueda])</code>
    </div>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Argumento</th>
                    <th>Propósito Práctico</th>
                    <th>Ejemplo en Oficina</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>valor_buscado</code></td>
                    <td>La celda con el código o criterio a rastrear.</td>
                    <td><code>A2</code> (el código de producto <code>PRD-104</code>).</td>
                </tr>
                <tr>
                    <td><code>matriz_busqueda</code></td>
                    <td>La columna exacta donde reside ese código.</td>
                    <td><code>Inventario!$C$2:$C$5000</code></td>
                </tr>
                <tr>
                    <td><code>matriz_devuelta</code></td>
                    <td>La columna que contiene el dato que deseas extraer (¡puede estar a la izquierda o derecha!).</td>
                    <td><code>Inventario!$A$2:$A$5000</code> (columna de Nombres).</td>
                </tr>
                <tr>
                    <td><code>[si_no_se_encuentra]</code></td>
                    <td>El texto a mostrar si el código no existe, sin necesidad de usar SI.ERROR.</td>
                    <td><code>""Artículo No Registrado""</code></td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shuffle text-primary me-2""></i>3. El Dúo Clásico: ÍNDICE y COINCIDIR (Para Versiones Antiguas)</h4>
    <p>Si trabajas en una empresa con computadoras que usan Excel 2016 o 2013, BUSCARX no estará disponible. En ese escenario, el estándar profesional universal es combinar <strong>ÍNDICE</strong> con <strong>COINCIDIR</strong>:</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <p class=""small mb-0 font-monospace text-dark"">
            <code>=INDICE(Columna_Resultado; COINCIDIR(Valor_Buscado; Columna_Busqueda; 0))</code><br /><br />
            <strong>¿Cómo funciona internamente?</strong><br />
            1. <code>COINCIDIR(A2; C:C; 0)</code> localiza el número de fila exacto donde se encuentra el valor (por ejemplo, fila 42).<br />
            2. <code>INDICE(A:A; 42)</code> va directamente a esa fila en la columna de nombres y extrae el resultado con máxima velocidad computacional.
        </p>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Discrepancia en el tamaño de las matrices en BUSCARX:</strong> Si tu <code>matriz_busqueda</code> es de <code>C2:C500</code> (499 filas) pero tu <code>matriz_devuelta</code> es de <code>A2:A600</code> (599 filas), Excel arrojará un error <code>#¡VALOR!</code> inmediato. Ambas columnas deben tener exactamente la misma cantidad de filas.</li>
        <li><strong>Olvidar el cero (0) en COINCIDIR:</strong> Si omites el tercer argumento (<code>0</code> para coincidencia exacta), Excel asumirá coincidencia aproximada, trayendo datos de filas cercanas incorrectos si la lista no está ordenada alfabéticamente.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Reemplazaste BUSCARV por BUSCARX para evitar fallas al insertar columnas en la base de datos?</li>
            <li>¿Definiste el argumento [si_no_se_encuentra] en BUSCARX para mantener tu informe limpio de errores #N/D?</li>
            <li>¿Fijaste con F4 ($) los rangos de búsqueda y retorno al arrastrar fórmulas hacia abajo?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Lógica Condicional Multivariable: SI.CONJUNTO, Y, O, y Validación de Datos",
                            LessonTitle = "Árboles de Decisión Empresarial y Blindaje de Celdas contra Errores de Usuario",
                            Summary = "Domina la evaluación lógica en cascada con SI.CONJUNTO. Combina múltiples criterios con Y() y O(), y blinda tus hojas de cálculo con listas desplegables y reglas estrictas de Validación de Datos.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-diagram-3-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Lógica Condicional: Programar la Inteligencia de tu Negocio en Celdas</h5>
            <p class=""mb-0 small"">Anidar cinco funciones 'SI' tradicionales una dentro de otra produce fórmulas kilométricas ilegibles e imposibles de auditar. SI.CONJUNTO simplifica las escalas salariales, comisiones y categorizaciones en una sola línea elegante.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/Ua2gMyITt4g"" title=""La función SI.CONJUNTO en Excel"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Evolución de la Lógica: De SI() Anidado a SI.CONJUNTO()</h4>
    <p>En análisis de negocios, frecuentemente debemos categorizar registros según múltiples rangos (ej: comisiones por tramos de ventas, calificación de riesgo crediticio o antigüedad de cartera). Antiguamente se escribía:</p>
    <div class=""p-2 bg-light rounded font-monospace small mb-2 text-muted"">
        <code>=SI(B2>10000; ""Excelente""; SI(B2>5000; ""Bueno""; SI(B2>2000; ""Regular""; ""Deficiente"")))</code>
    </div>
    <p>Con <strong>SI.CONJUNTO</strong>, la sintaxis opera por pares directos de <code>(Condición; Resultado)</code> que se evalúan de izquierda a derecha. En el instante en que una condición resulta verdadera, Excel devuelve ese valor y detiene la evaluación:</p>
    <div class=""p-3 bg-light rounded border font-monospace small mb-3 text-dark"">
        <code>=SI.CONJUNTO(B2>=10000; ""Excelente""; B2>=5000; ""Bueno""; B2>=2000; ""Regular""; VERDADERO; ""Deficiente"")</code>
    </div>
    <p class=""small text-muted""><em>Nota clave:</em> El último par <code>VERDADERO; ""Deficiente""</code> actúa como la cláusula 'ELSE' o por defecto: si ninguna de las condiciones anteriores se cumplió, devolverá 'Deficiente'.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-intersect text-primary me-2""></i>2. Evaluación Booleana con Y() y O()</h4>
    <p>Cuando un incentivo comercial exige que se cumplan <strong>dos o más condiciones simultáneamente</strong>, se utiliza la función lógica <code>Y()</code> dentro del SI:</p>
    <ul>
        <li><code>=SI(Y(Ventas>=10000; Cobranza>=95%); ""Bono Aprobado""; ""Sin Bono"")</code>: Exige que el asesor haya vendido más de $10.000 Y ADEMÁS haya recuperado al menos el 95% de la cartera. Si una de las dos falla, no cobra bono.</li>
        <li><code>=SI(O(Antiguedad>5; Desempeno=""Sobresaliente""); ""Aplica Ascenso""; ""En Espera"")</code>: La función <code>O()</code> devuelve verdadero si <strong>al menos una</strong> de las dos condiciones se cumple.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shield-check text-success me-2""></i>3. Blindaje de Celdas con Validación de Datos</h4>
    <p>Si una columna de tu hoja de cálculo se titula 'Estado de Pedido', permitir que los usuarios escriban libremente provocará que uno escriba 'Entregado', otro 'entregado', otro 'ENTREGADA' y otro 'Despachado'. Esto destruye cualquier tabla dinámica o reporte de Power BI.</p>
    <p>Para garantizar consistencia absoluta, se debe aplicar <strong>Validación de Datos</strong>:</p>
    <ol>
        <li>Seleccionar el rango de celdas a proteger.</li>
        <li>Ir a la pestaña <strong>Datos</strong> y hacer clic en <strong>Validación de datos</strong>.</li>
        <li>En el campo 'Permitir', seleccionar <strong>Lista</strong>.</li>
        <li>En el campo 'Origen', escribir los valores permitidos separados por punto y coma (ej: <code>Pendiente; En Tránsito; Entregado; Anulado</code>) o seleccionar un rango de celdas maestro.</li>
        <li>En la pestaña 'Mensaje de error', configurar estilo <strong>Alto (Stop)</strong> para impedir que el usuario ingrese cualquier texto fuera de la lista oficial.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Alterar el orden de mayor a menor en escalas numéricas:</strong> Si en SI.CONJUNTO colocas primero <code>B2>=2000; ""Regular""</code> y luego <code>B2>=10000; ""Excelente""</code>, una venta de $15.000 se clasificará como 'Regular' porque 15.000 es mayor a 2.000 y Excel evalúa en cascada de izquierda a derecha. Siempre ordena tus condiciones numéricas de mayor a menor (o de menor a mayor usando <code><</code>).</li>
        <li><strong>Olvidar comillas en textos dentro de fórmulas:</strong> En Excel, cualquier palabra o texto literal dentro de una función debe ir obligatoriamente entre comillas dobles (<code>""Aprobado""</code>). Si omites las comillas, Excel creerá que es el nombre de una fórmula no existente y arrojará el error <code>#¿NOMBRE?</code>.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Estructuraste tus condiciones en SI.CONJUNTO ordenadas rigurosamente de mayor a menor?</li>
            <li>¿Agregaste el cierre VERDADERO al final de SI.CONJUNTO para capturar valores que no cumplen ningún criterio?</li>
            <li>¿Protegiste las columnas críticas de entrada con Listas Desplegables de Validación de Datos?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Tablas Dinámicas Profesionales, Segmentadores y Campos Calculados",
                            LessonTitle = "De Millones de Registros a Reportes Ejecutivos en Menos de 60 Segundos",
                            Summary = "Transforma grandes bases de datos en resúmenes visuales interactivos. Domina los cuatro cuadrantes de las Tablas Dinámicas, campos calculados matemáticos, segmentadores visuales de datos y agrupación por fechas.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-grid-3x3-gap-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Tablas Dinámicas: El Motor de la Analítica Empresarial</h5>
            <p class=""mb-0 small"">Un reporte que tomaría tres días de trabajo manual escribiendo fórmulas SUMAR.SI.CONJUNTO puede generarse en 30 segundos con una Tabla Dinámica bien configurada, lista para responder cualquier pregunta de la gerencia.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/JTSAnYHbPrc"" title=""Power Query y Tablas Dinámicas para consolidar datos de Excel"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Los Cuatro Cuadrantes de una Tabla Dinámica</h4>
    <p>Para construir un análisis sólido, la base de datos de origen debe estar en formato tabular puro (sin filas vacías, sin celdas combinadas y con encabezados únicos en la primera fila). Al hacer clic en <em>Insertar ➔ Tabla Dinámica</em>, se abre el panel lateral con cuatro zonas fundamentales:</p>
    <ul>
        <li><strong>Filas (Rows):</strong> Los campos que organizan la información verticalmente (ej: Nombres de Vendedores, Sucursales o Familias de Producto).</li>
        <li><strong>Columnas (Columns):</strong> Los campos que desglosan la información horizontalmente (ej: Meses del año o Canales de Venta: Tienda Física vs E-commerce).</li>
        <li><strong>Valores (Values):</strong> Las métricas numéricas que se desean calcular (ej: Suma de Ventas en USD, Cantidad de Facturas emitidas, Promedio de Descuento).</li>
        <li><strong>Filtros (Filters):</strong> Criterios globales para filtrar todo el informe (ej: Filtrar solo las ventas de la región Centro).</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-calculator text-primary me-2""></i>2. Campos Calculados vs Columnas Calculadas en la Base</h4>
    <p>Un error muy común de los principiantes es agregar columnas de cálculo directamente en la base de datos de 100.000 filas (ej: calcular el IVA multiplicando cada fila por 0.16), lo que infla el tamaño del archivo en megabytes innecesarios. En su lugar, el analista profesional crea un <strong>Campo Calculado</strong> dentro de la propia Tabla Dinámica:</p>
    <ol>
        <li>Hacer clic sobre la Tabla Dinámica y entrar en la pestaña superior <strong>Análisis de tabla dinámica</strong>.</li>
        <li>Hacer clic en <strong>Campos, elementos y conjuntos ➔ Campo calculado</strong>.</li>
        <li>Asignar un nombre al campo (ej: <code>IVA_16</code>) y definir la fórmula matemática: <code>= Ventas_Netas * 0.16</code>.</li>
        <li>Excel calculará la métrica al vuelo de forma instantánea sobre el resumen, manteniendo el archivo liviano y ultraveloz.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-funnel-fill text-primary me-2""></i>3. Segmentadores de Datos (Slicers) y Conexiones de Informe</h4>
    <p>Para que una junta directiva o un cliente pueda interactuar con el informe como si fuera una aplicación web moderna, se reemplazan los filtros desplegables aburridos por <strong>Segmentadores de Datos (Slicers)</strong>:</p>
    <ul>
        <li>Botones visuales de clic rápido que filtran la información por Año, Vendedor o Categoría con código de colores.</li>
        <li><strong>Conexiones de Informe (Report Connections):</strong> Al hacer clic derecho sobre un segmentador y seleccionar <em>'Conexiones de informe'</em>, puedes vincular ese único botón a cuatro tablas dinámicas y tres gráficos dinámicos diferentes al mismo tiempo. Al presionar '2026', todo el panel ejecutivo se actualiza en sincronía perfecta.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Olvidar actualizar la Tabla Dinámica al cambiar datos en la base:</strong> A diferencia de las fórmulas estándar que se recalculan en tiempo real, las Tablas Dinámicas almacenan una instantánea en memoria (Caché de Tabla Dinámica). Si modificas montos en la tabla base, debes presionar obligatoriamente <code>Alt + F5</code> (o hacer clic en <em>Actualizar</em>) para reflejar los cambios.</li>
        <li><strong>Agrupación de fechas que no funciona:</strong> Si intentas hacer clic derecho sobre una columna de fechas para agrupar por Meses y Años y Excel arroja el mensaje <em>'No se puede agrupar esa selección'</em>, significa que al menos una celda de la columna tiene un espacio en blanco o una fecha escrita como texto. Todas las celdas deben tener formato de fecha válido.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Verificaste que la base de datos de origen no tenga subtotales manuales ni celdas combinadas?</li>
            <li>¿Utilizaste campos calculados en lugar de agregar columnas pesadas en la base de datos?</li>
            <li>¿Conectaste tus segmentadores de datos (Slicers) a todos los gráficos del panel de control?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Automatización de Tareas Repetitivas con Macros Grabadas y VBA Básico",
                            LessonTitle = "De Tareas Manuales de 4 Horas a Procesos de 1 Clic con Visual Basic",
                            Summary = "Elimina la monotonía diaria. Habilita la pestaña Programador, graba macros relativas para formatear reportes descargados del ERP, guarda archivos en formato .xlsm y comprende la estructura básica de código VBA.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-play-circle-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Automatización es el Salto de Analista a Profesional Imparable</h5>
            <p class=""mb-0 small"">Si todos los lunes por la mañana descargas un archivo plano del sistema ERP y pasas tres horas borrando columnas, pintando encabezados y aplicando fórmulas idénticas, una macro de 5 líneas de código puede hacer exactamente lo mismo en 2 segundos.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/40Am88JtgIU"" title=""Curso Excel VBA y Macros - Introducción al desarrollo de aplicaciones"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. ¿Qué es una Macro y Qué es Visual Basic for Applications (VBA)?</h4>
    <p>Una <strong>Macro</strong> es una secuencia grabada de instrucciones, clics y pulsaciones de teclas que Excel almacena para reproducirlas tantas veces como sea necesario. Debajo del capó, cada acción que realizas en pantalla se traduce automáticamente a un lenguaje de programación formal llamado <strong>Visual Basic for Applications (VBA)</strong>.</p>
    <p>Para comenzar a trabajar con macros, el primer paso técnico obligatorio es activar la pestaña oculta de <strong>Programador (o Desarrollador)</strong> en Excel:</p>
    <ol>
        <li>Ir a <em>Archivo ➔ Opciones ➔ Personalizar cinta de opciones</em>.</li>
        <li>En la columna derecha, marcar la casilla de verificación <strong>Programador</strong> (o Desarrollador) y hacer clic en Aceptar.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-record-btn-fill text-danger me-2""></i>2. Grabación Profesional de Macros: Referencias Absolutas vs Relativas</h4>
    <p>En la pestaña Programador existen dos modos de grabación con comportamientos totalmente distintos:</p>
    <ul>
        <li><strong>Grabación Estándar (Absoluta):</strong> Si grabas una macro que selecciona la celda <code>C5</code> y le aplica negrita, al ejecutar la macro en cualquier otra hoja siempre modificará la celda <code>C5</code> fija. Es perfecta para reportes que siempre tienen la misma estructura fija proveniente del ERP.</li>
        <li><strong>Usar Referencias Relativas:</strong> Al activar este botón antes de grabar, la macro opera respecto a la celda que tengas seleccionada en ese momento (ej: 'baja 2 filas y desplázate 1 columna a la derecha'). Es ideal para procesar listas de tamaño variable donde no sabes cuántas filas habrá cada semana.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-code-slash text-primary me-2""></i>3. Estructura Básica de un Módulo VBA y Asignación de Botones</h4>
    <p>Al presionar <code>Alt + F11</code> se abre el Entorno de Desarrollo Integrado (IDE) de VBA. Una macro bien escrita se estructura dentro de un procedimiento <code>Sub</code>:</p>
    <div class=""card border-0 bg-light p-3 mb-3 rounded-3"">
        <pre class=""font-monospace small mb-0 text-dark"">
Sub LimpiarYFormatearReporte()
    ' Desactiva el parpadeo de pantalla para máxima velocidad
    Application.ScreenUpdating = False
    
    ' Aplica formato a los encabezados
    Range(""A1:F1"").Font.Bold = True
    Range(""A1:F1"").Interior.Color = RGB(13, 110, 253) ' Azul corporativo
    Range(""A1:F1"").Font.Color = RGB(255, 255, 255)    ' Texto blanco
    
    ' Autoajustar el ancho de todas las columnas utilizadas
    Cells.EntireColumn.AutoFit
    
    Application.ScreenUpdating = True
    MsgBox ""¡Reporte semanal procesado exitosamente en 1 segundo!"", vbInformation, ""Éxito""
End Sub
        </pre>
    </div>
    <p class=""small text-muted""><strong>Creación del Botón de 1 Clic:</strong> Ve a <em>Insertar ➔ Formas ➔ Rectángulo redondeado</em>, dibújalo en la hoja, escribe 'Procesar Reporte' con diseño elegante, haz clic derecho sobre la forma y selecciona <em>'Asignar macro...'</em> vinculando tu código. A partir de ese momento, cualquier empleado podrá ejecutar el proceso presionando ese botón.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Guardar el archivo como un libro de Excel normal (.xlsx):</strong> El formato estándar <code>.xlsx</code> por motivos de seguridad informática elimina automáticamente todas las macros grabadas al guardar. Todo libro con código VBA debe guardarse obligatoriamente bajo el tipo <strong>Libro de Excel habilitado para macros (*.xlsm)</strong>. Si lo guardas como xlsx, perderás todo el trabajo de programación de la jornada.</li>
        <li><strong>Las macros NO se pueden deshacer con Ctrl + Z:</strong> Cuando ejecutas una macro que borra filas o sobrescribe datos, la memoria de deshecho de Excel se borra por completo. Siempre guarda una copia de respaldo del archivo antes de ejecutar una macro masiva en producción.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Guardaste el libro con la extensión obligatoria .xlsm (habilitado para macros)?</li>
            <li>¿Incluiste Application.ScreenUpdating = False al inicio de tus macros para acelerar la ejecución?</li>
            <li>¿Asignaste la macro a un botón visible e intuitivo para el usuario final?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    Questions = 
'@ + $qExcelAvanzado + @'
                },

                // =========================================================================
                // 3. POWER BI DASHBOARDS
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "power-bi",
                    Title = "Power BI: Modelado de Datos, DAX y Construcción de Dashboards Ejecutivos",
                    CategorySlug = "tecnologia-ia-ofimatica",
                    ShortDescription = "Convierte datos crudos en decisiones estratégicas: ETL con Power Query, modelado relacional en estrella, fórmulas analíticas en DAX (CALCULATE) y tableros interactivos.",
                    FullDescription = "Formación corporativa completa en Business Intelligence con Microsoft Power BI. Domina la extracción y limpieza automatizada de datos (ETL) con Power Query; diseña modelos de datos robustos bajo el Esquema en Estrella (Star Schema) con relaciones 1 a Varios; escribe medidas analíticas dinámicas utilizando DAX avanzado (CALCULATE, ALL, FILTER, RELATED); y construye dashboards ejecutivos aplicando principios de Storytelling y diseño UX/UI.",
                    Level = "Intermedio",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Fundamentos de BI y Conexión de Datos con Power Query",
                            LessonTitle = "Extracción, Transformación y Limpieza de Datos (ETL) Automatizada",
                            Summary = "Domina el proceso ETL en Power Query: conectar múltiples fuentes (Excel, CSV, SQL), desanular columnas (Unpivot), corregir tipos de datos y automatizar la limpieza de archivos mensuales.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-database-fill-gear fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Power Query: El 80% del Éxito en Business Intelligence es la Limpieza</h5>
            <p class=""mb-0 small"">Ningún gráfico elegante de Power BI servirá si los datos subyacentes están mal estructurados. Power Query permite programar una tubería de transformación automática que limpia y estandariza los datos cada vez que presionas 'Actualizar'.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/xeXfc8Y_y7o"" title=""Curso de Microsoft Power BI desde cero - INTRODUCCION"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. El Ciclo E.T.L. (Extract, Transform, Load)</h4>
    <p>En el mundo del análisis de datos empresarial, los datos nunca vienen limpios. Vienen en archivos de texto desordenados, sistemas contables con formatos incompatibles o múltiples hojas de cálculo con columnas cruzadas. El proceso <strong>ETL</strong> resuelve este problema mediante tres fases continuas:</p>
    <ul>
        <li><strong>Extract (Extracción):</strong> Conectar Power BI a los repositorios de información (bases de datos SQL, carpetas de red con archivos Excel de ventas, APIs web, SharePoint o archivos CSV).</li>
        <li><strong>Transform (Transformación):</strong> Limpiar los datos sin alterar el archivo original. Se eliminan filas vacías, se corrigen tipos de datos, se rellenan valores nulos, se separan nombres y apellidos, y se transforman tablas cruzadas en listas normalizadas.</li>
        <li><strong>Load (Carga):</strong> Cargar el modelo purificado en la memoria interna de Power BI (motor VertiPaq) para permitir consultas instantáneas sobre millones de registros.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-table text-success me-2""></i>2. La Operación Clave: Anulación de Dinamización de Columnas (Unpivot)</h4>
    <p>Uno de los mayores dolores de cabeza para los analistas es recibir reportes de finanzas donde los meses están repartidos horizontalmente en 12 columnas distintas (Enero, Febrero, Marzo...). Para un ser humano esto es fácil de leer, pero para una base de datos relacional es un desastre que impide filtrar por fecha.</p>
    <p>En Power Query, la solución es la función <strong>Anular dinamización de columnas (Unpivot Columns)</strong>:</p>
    <ol>
        <li>Seleccionar las columnas fijas (ej: Código de Producto y Sucursal).</li>
        <li>Hacer clic derecho y elegir <em>'Anular dinamización de otras columnas'</em>.</li>
        <li>Power Query transformará instantáneamente las 12 columnas horizontales en dos columnas verticales ordenadas: <strong>Atributo (el Mes)</strong> y <strong>Valor (el Monto)</strong>. A partir de ese momento, podrás analizar tendencias temporales con facilidad.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-folder-symlink-fill text-primary me-2""></i>3. Consolidación de Carpetas Mensuales en 1 Clic</h4>
    <p>Si cada mes tu empresa genera un archivo Excel nuevo con las ventas del período (ej: <code>Ventas_Enero.xlsx</code>, <code>Ventas_Febrero.xlsx</code>), en lugar de copiar y pegar los datos a mano en una hoja gigante, en Power BI seleccionas <em>'Obtener datos ➔ Carpeta'</em>:</p>
    <ul>
        <li>Power Query lee todos los archivos contenidos en la carpeta y los apila verticalmente de forma automática.</li>
        <li>Cuando termine el mes de Marzo, simplemente guardas el archivo <code>Ventas_Marzo.xlsx</code> en esa carpeta y presionas el botón <strong>Actualizar</strong> en Power BI: el nuevo mes se incorporará al tablero ejecutivo en cuestión de segundos.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>No definir los tipos de datos en el último paso:</strong> Si una columna de fechas o precios queda configurada con el tipo de dato 'Cualquiera' (icono 123/ABC), Power BI no podrá sumar las cantidades ni ordenar los meses cronológicamente en los gráficos. Asegúrate de que cada columna tenga explícitamente su tipo (Número decimal, Número entero, Fecha o Texto).</li>
        <li><strong>Realizar transformaciones complejas en DAX en lugar de Power Query:</strong> Todo proceso de limpieza, fusión de columnas y eliminación de espacios debe realizarse en Power Query (en la fase de carga) para no ralentizar el rendimiento del reporte en vivo con fórmulas DAX innecesarias.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Verificaste que cada columna tenga su tipo de dato exacto (Fecha, Texto, Número Decimal)?</li>
            <li>¿Utilizaste 'Anular dinamización de columnas' en reportes con meses repartidos horizontalmente?</li>
            <li>¿Asignaste nombres descriptivos a cada paso aplicado en el panel lateral de Power Query?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Modelado Relacional: El Esquema en Estrella (Star Schema)",
                            LessonTitle = "Tablas de Hechos vs Tablas de Dimensiones y Relaciones 1 a Varios",
                            Summary = "Diseña modelos de datos de estándar corporativo. Diferencia Tablas de Hechos (Fact Tables) de Tablas de Dimensiones (Dim Tables), configura la dirección del filtro cruzado y evita relaciones Muchos a Muchos.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-diagram-2-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Esquema en Estrella: La Arquitectura del Análisis Rápido</h5>
            <p class=""mb-0 small"">Tener una sola tabla 'sábana' de 50 columnas con datos repetidos de clientes y productos degrada el rendimiento de Power BI. Un modelo relacional profesional separa los hechos de las dimensiones para lograr máxima velocidad.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/6A40lYojW84"" title=""Modelamiento de Datos en POWER BI. Modelo Estrella y Buenas Prácticas"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Tablas de Hechos (Fact Tables) vs Tablas de Dimensiones (Dim Tables)</h4>
    <p>El estándar internacional formulado por Ralph Kimball para Business Intelligence divide las tablas del modelo en dos categorías estrictas:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h5 class=""fw-bold text-primary mb-2""><i class=""bi bi-receipt me-2""></i>Tabla de Hechos (Fact Table)</h5>
                <p class=""small text-muted mb-2"">Registra los <strong>eventos o transacciones cuantitativas</strong> del negocio que ocurren a lo largo del tiempo. Es angosta (pocas columnas) pero muy larga (cientos de miles o millones de filas).</p>
                <ul class=""small mb-0"">
                    <li>Ejemplo: <code>FactVentas</code>, <code>FactCobranzas</code>, <code>FactInventarioDiario</code>.</li>
                    <li>Contiene claves foráneas (ID_Cliente, ID_Producto, ID_Fecha) y métricas numéricas (Cantidad_Vendida, Precio_Total, Costo).</li>
                </ul>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h5 class=""fw-bold text-success mb-2""><i class=""bi bi-card-checklist me-2""></i>Tablas de Dimensiones (Dim Tables)</h5>
                <p class=""small text-muted mb-2"">Contienen los <strong>atributos descriptivos cualitativos</strong> que responden a las preguntas: ¿Quién?, ¿Qué?, ¿Dónde? y ¿Cuándo? Son anchas (muchas columnas) pero cortas (pocos registros únicos).</p>
                <ul class=""small mb-0"">
                    <li>Ejemplo: <code>DimClientes</code>, <code>DimProductos</code>, <code>DimSucursales</code>, <code>DimCalendario</code>.</li>
                    <li>Cada fila es un registro único sin duplicados identificado por una Llave Primaria (Primary Key).</li>
                </ul>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-stars text-primary me-2""></i>2. La Tabla Calendario Obligatoria (DimDate)</h4>
    <p>Para realizar cálculos de inteligencia de tiempo en DAX (comparar ventas de este mes contra el mismo mes del año anterior, o calcular ventas acumuladas anuales YTD), es un requisito técnico indispensable contar con una <strong>Tabla Calendario continua</strong> sin saltos de días ni fines de semana vacíos.</p>
    <p>Se puede generar en Power BI con una sencilla fórmula DAX en la vista de modelado:</p>
    <div class=""p-3 bg-light rounded border font-monospace small mb-3 text-dark"">
        <code>Calendario = CALENDAR(DATE(2023; 1; 1); DATE(2026; 12; 31))</code>
    </div>
    <p class=""small text-muted"">Posteriormente se añaden columnas calculadas para <code>Año = YEAR(Calendario[Date])</code>, <code>Mes = FORMAT(Calendario[Date]; ""MMMM"")</code> y <code>NumeroMes = MONTH(Calendario[Date])</code> (asegurando ordenar la columna Mes por NumeroMes para que no se ordenen alfabéticamente: Abril, Agosto, Diciembre...).</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-arrow-left-right text-primary me-2""></i>3. Configuración de Relaciones: Cardinalidad y Dirección del Filtro</h4>
    <p>En el editor de relaciones (Vista de Modelo):</p>
    <ul>
        <li>La relación dorada en Power BI es <strong>1 a Varios (1:*)</strong>: Un cliente en <code>DimClientes</code> realiza muchas compras en <code>FactVentas</code>.</li>
        <li><strong>Dirección de Filtro Cruzado Única (Single):</strong> El filtro siempre debe viajar desde la dimensión hacia los hechos (al seleccionar un cliente en el segmentador, la tabla de ventas se filtra automáticamente).</li>
        <li><strong>Evitar Relaciones Varios a Varios (*:*):</strong> Provocan resultados impredecibles, duplicación oculta de montos financieros y degradación severa de la velocidad de cálculo.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Activar la dirección de filtro cruzado en 'Ambas' (Both) por defecto:</strong> Provoca ambigüedades en el modelo, trayendo totales incorrectos y generando bucles de filtrado circulares que confunden al motor DAX. La dirección debe ser siempre 'Única' a menos que exista una justificación analítica avanzada específica.</li>
        <li><strong>Dejar columnas descriptivas en la tabla de hechos:</strong> Colocar el nombre del cliente y su dirección en cada una de las 500.000 filas de ventas en lugar de dejar únicamente su ID_Cliente multiplica el tamaño del archivo por diez.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Estructuraste el modelo como un Esquema en Estrella con la tabla de hechos en el centro?</li>
            <li>¿Creaste y marcaste como 'Tabla de Fechas' una tabla calendario dedicada sin huecos?</li>
            <li>¿Comprobaste que todas las relaciones sean 1 a Varios (1:*) con filtro en dirección única?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Introducción a DAX: Columnas Calculadas vs Medidas (CALCULATE)",
                            LessonTitle = "El Motor Matemático de Power BI y el Contexto de Evaluación",
                            Summary = "Domina el lenguaje DAX (Data Analysis Expressions). Entiende la diferencia crucial entre Columnas Calculadas (consumen RAM) y Medidas Dinámicas. Domina la función reina CALCULATE, ALL y FILTER.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-cpu-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">DAX no es Excel: El Poder del Contexto de Filtro</h5>
            <p class=""mb-0 small"">El error más frecuente al aprender DAX es intentar escribir fórmulas pensando como en las celdas de Excel. En DAX no existen referencias tipo 'A1'; se opera sobre columnas enteras y se evalúan contextos de filtro dinámicos.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/iWdHdo58Uos"" title=""Tutorial rápido: función CALCULATE para sumar en Power BI"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Columna Calculada vs Medida Explícita</h4>
    <p>Para escribir DAX profesional, la primera decisión técnica es saber cuándo usar una columna y cuándo crear una medida:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Característica</th>
                    <th>Columna Calculada</th>
                    <th>Medida Dinámica (DAX Measure)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold"">Momento de Cálculo</td>
                    <td>Se calcula una sola vez durante la carga o actualización de datos.</td>
                    <td>Se calcula 'al vuelo' cada vez que el usuario hace clic o filtra un visual en el tablero.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">Consumo de Memoria</td>
                    <td>Almacena un valor físico fila por fila en el disco/memoria RAM (infla el archivo).</td>
                    <td>No consume memoria de almacenamiento; utiliza la CPU momentáneamente para responder la consulta.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">Uso Profesional</td>
                    <td>Únicamente cuando necesitas usar el resultado como un filtro o eje en una gráfica (ej: clasificar clientes por Edad).</td>
                    <td><strong>Para todas las operaciones matemáticas y porcentajes:</strong> Sumas, promedios, márgenes, variaciones temporales.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-lightning-charge-fill text-danger me-2""></i>2. La Función Reina de DAX: CALCULATE</h4>
    <p>Si existe una función indispensable en Business Intelligence es <strong>CALCULATE</strong>. Es la única función de DAX capaz de <em>modificar o anular el contexto de filtro</em> impuesto por los visuales del informe:</p>
    <div class=""p-3 bg-light rounded border font-monospace small mb-3 text-dark"">
        <code>Ventas_Venezuela = CALCULATE([Total_Ventas]; DimPaises[Pais] = ""Venezuela"")</code>
    </div>
    <p class=""small text-muted"">Sin importar qué país seleccione el usuario en los segmentadores del tablero, esta medida específica siempre calculará únicamente las ventas correspondientes a Venezuela.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-percent text-success me-2""></i>3. Cálculo de Participación de Mercado con ALL()</h4>
    <p>Para calcular qué porcentaje representa cada vendedor sobre el <strong>Total General de la Empresa</strong>, se utiliza la función <code>ALL()</code> dentro de CALCULATE para retirar el filtro de fila:</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3 font-monospace small"">
        1. <code>Total_Ventas = SUM(FactVentas[Monto])</code><br />
        2. <code>Ventas_Todas = CALCULATE([Total_Ventas]; ALL(DimVendedores))</code><br />
        3. <code>% Participacion = DIVIDE([Total_Ventas]; [Ventas_Todas]; 0)</code>
    </div>
    <p class=""small text-muted""><em>Consejo profesional:</em> Utiliza siempre la función <code>DIVIDE(Numerador; Denominador; 0)</code> en lugar del operador barra (<code>/</code>). La función DIVIDE previene que la aplicación arroje errores fatales de 'División por Cero' cuando las ventas son nulas.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Crear columnas calculadas para sumatorias simples:</strong> Escribir una columna calculada para sumar las ventas de cada fila gasta megabytes de memoria innecesarios. Las sumas siempre deben ser Medidas (<code>SUM</code> o <code>SUMX</code>).</li>
        <li><strong>Usar el operador barra (/) para calcular márgenes:</strong> Provoca errores <code>#ERROR</code> o 'Infinity' en meses sin ventas. La función <code>DIVIDE</code> maneja divisiones entre cero con total elegancia devolviendo 0 o blanco.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Escribiste medidas explícitas para todas tus métricas en lugar de arrastrar campos numéricos directos?</li>
            <li>¿Utilizaste DIVIDE con valor alternativo cero para todos tus ratios y porcentajes?</li>
            <li>¿Creaste una tabla dedicada exclusiva para almacenar y organizar todas tus medidas DAX?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Diseño de Dashboards Ejecutivos y Storytelling de Negocios",
                            LessonTitle = "UX/UI para Analistas: Creación de Cuadros de Mando Claros e Intuitivos",
                            Summary = "Diseña tableros de control de nivel C-Level: jerarquía visual en 'Z', tarjetas de KPI con formato condicional, selección correcta de gráficos (Barras, Líneas, Dispersión) y publicación en Power BI Service.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-pie-chart-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Storytelling con Datos: Guiar la Mirada hacia la Decisión</h5>
            <p class=""mb-0 small"">Un panel de control lleno de gráficos abigarrados con 15 colores distintos no informa; aturde. El diseño ejecutivo aplica principios de psicología visual para que el director general entienda el estado del negocio en 5 segundos.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/JvWjgIJE77M"" title=""Data Storytelling: Aprende a contar historias con datos"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. El Patrón de Lectura en 'Z' (Gutenberg) para Dashboards</h4>
    <p>En la cultura occidental, los ojos exploran una pantalla siguiendo un patrón natural en forma de 'Z': de izquierda a derecha en la parte superior, bajando diagonalmente hacia la izquierda, y cruzando finalmente hacia la esquina inferior derecha. Los diseñadores de tableros organizan el espacio en tres niveles de profundidad:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-primary mb-2"">1. Nivel Superior (KPIs Globales)</span>
                <p class=""small mb-0 text-muted"">Tarjetas grandes con las cifras vitales del mes: <strong>Ventas Totales, Margen Bruto %, Clientes Nuevos y Tasa de Retención</strong>. Respaldadas por un color semáforo (Verde / Rojo) frente a la meta.</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-success mb-2"">2. Nivel Medio (Tendencia y Desglose)</span>
                <p class=""small mb-0 text-muted"">Gráficos de líneas para ver la evolución de las ventas a lo largo de los 12 meses, y gráficos de barras horizontales para comparar el desempeño de las 5 sucursales principales.</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-secondary mb-2"">3. Nivel Inferior (Detalle Operativo)</span>
                <p class=""small mb-0 text-muted"">Tabla o matriz detallada con la lista de clientes o artículos críticos para que el usuario pueda hacer auditoría fina o exportar a Excel si lo requiere.</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-bar-chart-line-fill text-primary me-2""></i>2. Selección Quirúrgica del Tipo de Gráfico</h4>
    <p>Utilizar el gráfico equivocado distorsiona el mensaje de negocio. Aplica la siguiente guía estandarizada:</p>
    <ul>
        <li><strong>Gráficos de Pastel (Donas / Pie Charts):</strong> Terminantemente desaconsejados si tienen más de 3 categorías. El ojo humano tiene dificultades para comparar ángulos; prefiere comparar longitudes de barras.</li>
        <li><strong>Gráficos de Barras Horizontales:</strong> La mejor opción para comparar categorías con nombres largos (ej: 'Servicio Técnico Especializado' vs 'Venta Mayorista de Insumos') porque el texto se lee cómodamente de izquierda a derecha sin inclinar el cuello.</li>
        <li><strong>Gráficos de Líneas o Área:</strong> Exclusivos para representar variables continuas en el <strong>tiempo</strong> (días, semanas, meses, trimestres).</li>
        <li><strong>Gráficos de Dispersión (Scatter Plot):</strong> Para analizar la correlación entre dos variables cuantitativas (ej: ¿A mayor descuento otorgado, mayor volumen de compra del cliente?).</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-palette text-primary me-2""></i>3. Paleta de Colores y Formato Condicional Semafórico</h4>
    <p>Aplica la regla del 60-30-10:</p>
    <ul>
        <li><strong>60% Color Dominante Neutro:</strong> Fondos blancos o grises muy suaves (<code>#F8F9FA</code>) para no fatigar la vista.</li>
        <li><strong>30% Color Corporativo Secundario:</strong> Azul marino, gris oscuro o grafito para barras, textos principales y marcos.</li>
        <li><strong>10% Color de Acento Semafórico:</strong> Rojo exclusivamente para alertas negativas (ej: rentabilidad bajo cero o caída de ventas) y Verde para metas superadas. Nunca uses colores chillones como adornos decorativos.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Llenar la pantalla de visuales sin dejar márgenes en blanco:</strong> El espacio en blanco (White Space) es un elemento de diseño fundamental que permite al cerebro descansar y enfocar la atención en los datos importantes.</li>
        <li><strong>No configurar interacciones entre visuales:</strong> En la pestaña <em>Formato ➔ Editar interacciones</em>, verifica que al hacer clic en un gráfico de barras los demás visuales se filtren limpiamente en lugar de resaltar una porción borrosa.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Organizaste las métricas de mayor a menor jerarquía siguiendo el patrón de lectura en 'Z'?</li>
            <li>¿Evitaste gráficos de pastel con más de 3 rebanadas y usaste barras horizontales para nombres largos?</li>
            <li>¿Probaste el reporte con la vista de diseño móvil (Mobile Layout) para directores que consultan en teléfonos?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    Questions = 
'@ + $qPowerBi + @'
                },

                // =========================================================================
                // 4. CIENCIA Y ANÁLISIS DE DATOS CON PYTHON Y SQL
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "ciencia-y-analisis-de-datos",
                    Title = "Ciencia y Análisis de Datos con Python y SQL: De Consultas a Machine Learning",
                    CategorySlug = "tecnologia-ia-ofimatica",
                    ShortDescription = "Domina el stack técnico de los Científicos de Datos: consultas analíticas con SQL (GROUP BY, JOINs), manipulación masiva con Pandas/NumPy y modelado con Scikit-Learn.",
                    FullDescription = "Capacitación intensiva para analistas que desean superar las barreras de Excel y dominar el lenguaje de las grandes empresas. Aprende a escribir consultas complejas en PostgreSQL y MySQL utilizando JOINs y subconsultas; manipula DataFrames de millones de filas en Python con Pandas; genera visualizaciones científicas con Matplotlib y Seaborn; y entrena tus primeros modelos predictivos de Machine Learning supervisado.",
                    Level = "Avanzado",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: SQL para Análisis de Datos: Consultas Avanzadas y Agregaciones",
                            LessonTitle = "Extracción de Métricas de Negocio desde Bases de Datos Relacionales",
                            Summary = "Domina el lenguaje SQL estándar: SELECT, WHERE, filtros booleanos, funciones de agregación (COUNT, SUM, AVG) con GROUP BY y cruce de tablas maestras mediante INNER, LEFT y RIGHT JOINs.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-database-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">SQL: La Habilidad Más Demandada en el Mercado Laboral Tecnológico</h5>
            <p class=""mb-0 small"">Todo sistema empresarial, tienda online o banco almacena sus datos en motores SQL. Dominar consultas directas permite extraer la verdad de los datos sin depender de que el departamento de sistemas genere un reporte exportado a Excel.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/xuASGBwNboU"" title=""SUBCONSULTAS SQL | CON PRÁCTICA | Bases de Datos"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. El Orden de Ejecución Real de una Consulta SQL</h4>
    <p>Aunque una consulta SQL se escribe comenzando con la cláusula <code>SELECT</code>, el motor de la base de datos (PostgreSQL, SQL Server, MySQL) la procesa internamente en un orden lógico completamente diferente:</p>
    <ol>
        <li><code>FROM & JOIN</code>: El motor primero ubica las tablas y realiza las uniones entre ellas.</li>
        <li><code>WHERE</code>: Filtra las filas individuales que no cumplen la condición preliminar.</li>
        <li><code>GROUP BY</code>: Agrupa los registros restantes por categorías (ej: por Cliente o por Ciudad).</li>
        <li><code>HAVING</code>: Filtra los grupos ya agregados (ej: <code>HAVING SUM(Monto) > 5000</code>).</li>
        <li><code>SELECT</code>: Extrae y calcula las columnas solicitadas por el analista.</li>
        <li><code>ORDER BY</code>: Ordena el conjunto final de registros de forma ascendente (ASC) o descendente (DESC).</li>
        <li><code>LIMIT / TOP</code>: Restringe la cantidad final de filas que se muestran en pantalla.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-intersect text-success me-2""></i>2. Cruce de Tablas con JOINs (INNER, LEFT, RIGHT)</h4>
    <p>En bases de datos normalizadas, la información de una factura está separada en una tabla de Clientes y una tabla de Ventas. Para unirlas en un solo reporte analítico se utiliza la sentencia <code>JOIN</code> vinculando sus claves:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Tipo de JOIN</th>
                    <th>Comportamiento de Unión</th>
                    <th>Uso Práctico en la Empresa</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-primary"">INNER JOIN</td>
                    <td>Devuelve únicamente los registros que coinciden en ambas tablas simultáneamente.</td>
                    <td>Obtener facturas donde el cliente está registrado formalmente en la base de datos.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-success"">LEFT JOIN</td>
                    <td>Devuelve <strong>todos</strong> los registros de la tabla izquierda, y los datos coincidentes de la derecha. Si no hay coincidencia, devuelve <code>NULL</code>.</td>
                    <td><strong>Auditoría de Inactividad:</strong> Encontrar qué clientes registrados NUNCA han realizado una compra (<code>WHERE Ventas.Id IS NULL</code>).</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-terminal-fill text-dark me-2""></i>3. Consulta de Agregación Real para Auditoría Financiera</h4>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <pre class=""font-monospace small mb-0 text-dark"">
SELECT 
    c.nombre_cliente,
    c.pais,
    COUNT(v.id_factura) AS total_compras,
    ROUND(SUM(v.monto_usd)::numeric, 2) AS facturacion_total,
    ROUND(AVG(v.monto_usd)::numeric, 2) AS ticket_promedio
FROM Clientes c
INNER JOIN Ventas v ON c.id_cliente = v.id_cliente
WHERE v.fecha_emision >= '2026-01-01'
GROUP BY c.nombre_cliente, c.pais
HAVING SUM(v.monto_usd) >= 10000
ORDER BY facturacion_total DESC
LIMIT 10;
        </pre>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Filtrar agregaciones en la cláusula WHERE:</strong> Escribir <code>WHERE SUM(Monto) > 1000</code> arrojará un error de sintaxis inmediato. Las funciones de agregación se deben filtrar obligatoriamente en la cláusula <code>HAVING</code> después del <code>GROUP BY</code>.</li>
        <li><strong>Olvidar incluir en el GROUP BY todas las columnas del SELECT:</strong> Si en el SELECT pides <code>c.nombre_cliente</code> y <code>c.pais</code>, ambas columnas deben aparecer obligatoriamente en la instrucción <code>GROUP BY c.nombre_cliente, c.pais</code>.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Respetaste la distinción lógica entre WHERE (filtra filas) y HAVING (filtra grupos calculados)?</li>
            <li>¿Utilizaste LEFT JOIN cuando necesitas detectar clientes que no tienen registros de compra asociados?</li>
            <li>¿Agregaste índices en las columnas de claves foráneas para acelerar consultas sobre millones de filas?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Fundamentos de Python para Ciencia de Datos: NumPy y Pandas",
                            LessonTitle = "Manipulación de Tablas Masivas en DataFrames de Pandas",
                            Summary = "Domina el entorno Jupyter Notebooks. Crea vectores matriciales con NumPy y manipula DataFrames con Pandas: filtrado condicional (.loc, .iloc), tratamiento de valores nulos (.dropna, .fillna) y agregaciones agrupadas (.groupby).",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-filetype-py fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Pandas: El Motor que Supera las Barreras del Millón de Filas de Excel</h5>
            <p class=""mb-0 small"">Excel tiene un límite físico estricto de 1.048.576 filas por hoja y se congela al manipular fórmulas en archivos grandes. Con la biblioteca Pandas de Python puedes procesar 10 millones de filas en memoria en cuestión de segundos.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/2KCQQHpi2Qk"" title=""CURSO de PYTHON con PANDAS Para Ciencia de Datos"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. ¿Qué es un DataFrame en Pandas?</h4>
    <p>En Python, la biblioteca <strong>Pandas</strong> es la herramienta central de los científicos de datos. Su estructura principal es el <strong>DataFrame</strong>: una tabla bidimensional compuesta por filas y columnas etiquetadas, similar a una hoja de cálculo pero respaldada por la velocidad matemática de <strong>NumPy</strong> (escrito en lenguaje C para cálculo vectorial ultrarrápido).</p>
    <p>La convención estándar mundial para importar estas librerías en cualquier script o Jupyter Notebook es:</p>
    <div class=""p-3 bg-light rounded border font-monospace small mb-3 text-dark"">
        <code>import numpy as np<br />import pandas as pd</code>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-funnel text-primary me-2""></i>2. Carga, Exploración y Limpieza de Valores Nulos (NaN)</h4>
    <p>El flujo básico de trabajo en análisis de datos consta de cuatro pasos esenciales:</p>
    <ol>
        <li><code>df = pd.read_csv('ventas_anuales.csv')</code>: Carga el archivo en memoria.</li>
        <li><code>df.info()</code> y <code>df.describe()</code>: Inspecciona la cantidad de registros, los tipos de datos de cada columna y estadísticas básicas (media, desviación estándar, valores máximos y mínimos).</li>
        <li><strong>Tratamiento de Datos Faltantes:</strong>
            <ul>
                <li><code>df.dropna()</code>: Elimina las filas que contienen valores nulos (usar con precaución para no perder datos valiosos).</li>
                <li><code>df['precio'].fillna(df['precio'].median(), inplace=True)</code>: Imputa los valores faltantes rellenándolos con la mediana del grupo para no sesgar el análisis.</li>
            </ul>
        </li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-code-square text-success me-2""></i>3. Indexación y Agrupaciones Avanzadas (.loc y .groupby)</h4>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <pre class=""font-monospace small mb-0 text-dark"">
# Filtrar ventas de la sucursal Norte con monto superior a $500
ventas_top = df.loc[(df['sucursal'] == 'Norte') & (df['monto'] > 500)]

# Resumen ejecutivo agrupado por Vendedor
resumen = df.groupby('vendedor').agg({
    'monto': ['sum', 'mean'],
    'id_factura': 'count'
}).reset_index()

# Exportar el reporte final limpio a Excel
resumen.to_excel('reporte_gerencial_limpio.xlsx', index=False)
        </pre>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir .loc con .iloc:</strong> <code>.loc</code> busca por <em>etiquetas o condiciones lógicas</em> (ej: <code>df.loc[df['edad'] > 18]</code>), mientras que <code>.iloc</code> busca estrictamente por <em>posiciones de índice numéricas enteras</em> (ej: <code>df.iloc[0:5, 0:2]</code> para extraer las primeras 5 filas y 2 columnas).</li>
        <li><strong>Olvidar resetear el índice tras un groupby:</strong> Si no utilizas <code>.reset_index()</code>, la columna agrupada se convierte en el índice de la tabla, dificultando exportarla de forma limpia a Power BI o bases de datos SQL.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Inspeccionaste el tipo de datos de cada columna con df.dtypes antes de calcular sumatorias?</li>
            <li>¿Gestionaste los valores nulos con imputación estadística o eliminación controlada?</li>
            <li>¿Optimizaste las operaciones usando métodos vectorizados en lugar de bucles 'for' lentos?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Análisis Exploratorio de Datos (EDA) y Visualización con Matplotlib y Seaborn",
                            LessonTitle = "Detección de Outliers, Correlaciones y Distribuciones Estadísticas",
                            Summary = "Domina el análisis exploratorio visual en Python. Grafica histogramas de distribución, diagramas de dispersión, mapas de calor de correlación (Heatmaps) con Seaborn y detecta valores atípicos (Boxplots).",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-graph-up-arrow fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">EDA: Ver los Datos antes de Entrenar Cualquier Algoritmo</h5>
            <p class=""mb-0 small"">El Análisis Exploratorio de Datos (EDA) es el paso fundamental para descubrir patrones ocultos, sesgos y anomalías (outliers) que podrían arruinar cualquier modelo de inteligencia artificial o predicción financiera.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/CU0C8SK7fTw"" title=""Descubre el poder del Análisis Exploratorio de Datos (EDA)"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Las Dos Bibliotecas Visuales Estándar: Matplotlib y Seaborn</h4>
    <p>En el ecosistema científico de Python, la visualización se construye sobre dos pilares integrados:</p>
    <ul>
        <li><strong>Matplotlib (pyplot):</strong> La librería base de bajo nivel. Controla cada detalle milimétrico de la figura: títulos, ejes, tamaños de lienzo, etiquetas de texto y guardado en archivos de alta resolución (PNG/PDF vectoriales).</li>
        <li><strong>Seaborn:</strong> Construida sobre Matplotlib, provee estilos modernos de alto impacto visual y funciones preprogramadas para análisis estadístico complejo con una sola línea de código.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-bounding-box-circles text-primary me-2""></i>2. Los 3 Gráficos Indispensables en Todo Análisis Exploratorio</h4>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h6 class=""fw-bold text-dark mb-1"">1. Histograma (sns.histplot)</h6>
                <p class=""small text-muted mb-0"">Muestra la <strong>distribución y asimetría</strong> de una variable numérica (ej: Salarios de los empleados). Permite comprobar si los datos siguen una distribución normal acampanada o si están sesgados hacia la izquierda.</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h6 class=""fw-bold text-dark mb-1"">2. Diagrama de Caja (Boxplot)</h6>
                <p class=""small text-muted mb-0"">Identifica la mediana, el rango intercuartílico (IQR) y los <strong>Outliers (valores atípicos)</strong> representados como puntos aislados fuera de los bigotes (ej: un error de digitación de un precio de $10.000.000).</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h6 class=""fw-bold text-dark mb-1"">3. Mapa de Calor (Heatmap)</h6>
                <p class=""small text-muted mb-0"">Muestra la <strong>matriz de correlación de Pearson</strong> entre todas las variables numéricas, coloreando de azul o rojo intenso aquellas variables fuertemente ligadas entre sí.</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-code-slash text-dark me-2""></i>3. Código Python para Generar una Matriz de Correlación Ejecutiva</h4>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <pre class=""font-monospace small mb-0 text-dark"">
import matplotlib.pyplot as plt
import seaborn as sns

plt.figure(figsize=(10, 6))
matriz_corr = df[['ingresos', 'gasto_publicidad', 'visitas_web', 'ventas_netas']].corr()

sns.heatmap(matriz_corr, annot=True, cmap='coolwarm', fmt="".2f"", linewidths=0.5)
plt.title('Matriz de Correlación de Indicadores de Negocio', fontsize=14, pad=15)
plt.tight_layout()
plt.savefig('correlacion_negocio.png', dpi=300)
plt.show()
        </pre>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir Correlación con Causalidad:</strong> Que dos variables tengan una correlación estadística alta de 0.90 (ej: el aumento en las ventas de helados y el aumento en el uso de gafas de sol) no significa que una cause la otra; ambas son causadas por una tercera variable oculta (el verano caluroso).</li>
        <li><strong>Eliminar outliers sin investigar su origen:</strong> Si un cliente compró $50.000 en una tienda donde el promedio es $100, no siempre es un error; puede ser una compra institucional de un cliente corporativo VIP que debe analizarse por separado.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Graficaste boxplots para detectar valores atípicos que puedan distorsionar la media?</li>
            <li>¿Calculaste la matriz de correlación para descartar variables redundantes antes del modelado?</li>
            <li>¿Guardaste los gráficos en alta resolución (300 DPI) para incluirlos en el informe ejecutivo?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Introducción al Modelado Predictivo con Scikit-Learn",
                            LessonTitle = "De la Descripción a la Predicción: Regresión y Clasificación Supervisada",
                            Summary = "Entrena tus primeros algoritmos predictivos con Scikit-Learn: división de datos Train/Test, modelos de Regresión Lineal para ventas, Clasificación (Regresión Logística / Árboles) y métricas de exactitud.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-robot fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Machine Learning: Anticipar el Futuro con Datos Históricos</h5>
            <p class=""mb-0 small"">El análisis descriptivo nos dice qué pasó en la empresa el año pasado. El Machine Learning nos permite responder qué cliente tiene un 85% de probabilidad de cancelar su suscripción el próximo mes para que podamos actuar antes de que se vaya.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/J8VOHBkNIT0"" title=""Curso scikit-learn - Temario y Machine Learning en Python"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Aprendizaje Supervisado: Regresión vs Clasificación</h4>
    <p>En el <strong>Aprendizaje Automático Supervisado</strong>, el algoritmo aprende a partir de un conjunto de datos histórico que ya contiene la respuesta correcta (denominada <em>etiqueta o target Y</em>):</p>
    <ul>
        <li><strong>Modelos de Regresión:</strong> La variable objetivo a predecir es un <strong>número continuo</strong> (ej: Predecir el monto de ventas en dólares del próximo trimestre, o el precio de alquiler de una propiedad).</li>
        <li><strong>Modelos de Clasificación:</strong> La variable objetivo es una <strong>categoría binaria o múltiple</strong> (ej: ¿Este cliente pagará el crédito o entrará en mora? [Sí / No]; o ¿Este correo es spam o legítimo?).</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-scissors text-danger me-2""></i>2. La Regla de Oro: División Train / Test Split</h4>
    <p>El error más grave de un principiante en ciencia de datos es entrenar el modelo con todos los datos y evaluarlo con esos mismos datos (provocando <em>Sobreajuste o Overfitting</em>: el modelo simplemente 'memoriza' los datos del pasado pero fracasa estrepitosamente al predecir datos nuevos del mundo real).</p>
    <p>La metodología estricta exige dividir la base de datos en dos conjuntos aislados utilizando Scikit-Learn:</p>
    <ol>
        <li><strong>Conjunto de Entrenamiento (Train - 80% de los datos):</strong> Utilizado por el algoritmo para calibrar sus pesos matemáticos.</li>
        <li><strong>Conjunto de Prueba (Test - 20% de los datos):</strong> Datos nunca vistos por el modelo, utilizados exclusivamente para evaluar su precisión real.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-code-square text-primary me-2""></i>3. Flujo Completo de Código de un Modelo Predictivo en Python</h4>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <pre class=""font-monospace small mb-0 text-dark"">
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score

# 1. Separar variables explicativas (X) de la variable objetivo (y)
X = df[['gasto_marketing', 'num_vendedores', 'visitas_tienda']]
y = df['ventas_totales']

# 2. División en conjuntos de entrenamiento (80%) y prueba (20%)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 3. Instanciar y entrenar el modelo
modelo = LinearRegression()
modelo.fit(X_train, y_train)

# 4. Generar predicciones sobre datos nunca vistos
predicciones = modelo.predict(X_test)

# 5. Evaluar la calidad del modelo con métricas profesionales
r2 = r2_score(y_test, predicciones)
print(f""Coeficiente de Determinación R²: {r2:.3f}"")
        </pre>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Fuga de Datos (Data Leakage):</strong> Incluir como variable de entrada una columna que solo se conoce <em>después</em> de que el evento ya ocurrió (ej: incluir 'fecha_de_cancelacion' para predecir si el cliente cancelará su cuenta). El modelo tendrá un 100% de precisión aparente en pruebas pero será inútil en la vida real.</li>
        <li><strong>Evaluar un modelo de clasificación desbalanceado solo con 'Accuracy' (Exactitud):</strong> Si en un banco el 99% de las transacciones son legítimas y solo el 1% es fraude, un modelo tonto que prediga 'No es Fraude' para todas las transacciones tendrá un 99% de exactitud, pero no detectará ningún fraude. En estos casos se deben evaluar métricas como <strong>Precision, Recall y F1-Score</strong>.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Dividiste tus datos en conjuntos de Train (80%) y Test (20%) antes de entrenar?</li>
            <li>¿Escalaste las variables numéricas si utilizas algoritmos basados en distancias (KNN / SVM)?</li>
            <li>¿Evaluaste el modelo con métricas de negocio reales (R², RMSE, Curva ROC/AUC)?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    Questions = 
'@ + $qCienciaDatos + @'
                },

                // =========================================================================
                // 5. MICROSOFT OFFICE INTERMEDIO
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "office-intermedio",
                    Title = "Microsoft Office Intermedio: Gestión Documental, Fórmulas de Análisis y Presentaciones Avanzadas",
                    CategorySlug = "tecnologia-ia-ofimatica",
                    ShortDescription = "Domina el puente hacia la productividad avanzada: combinación de correspondencia masiva en Word, fórmulas estadísticas en Excel (CONTAR.SI, SUMAR.SI) y plantillas maestras en PowerPoint.",
                    FullDescription = "Capacitación enfocada en optimizar los tiempos de respuesta administrativos. Aprende a redactar contratos y cartas masivas conectando Word con bases de datos en Excel; domina las fórmulas de conteo y suma condicional con múltiples criterios; analiza tendencias con gráficos estadísticos profesionales; y estandariza la imagen institucional de tu empresa utilizando el Patrón de Diapositivas en PowerPoint.",
                    Level = "Intermedio",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Combinación de Correspondencia en Word: Cartas Masivas y Contratos Automatizados",
                            LessonTitle = "Automatización Documental: De una Lista en Excel a Cientos de Cartas Personalizadas",
                            Summary = "Aprende el flujo oficial de Combinación de Correspondencia (Mail Merge). Conecta plantillas de Word a bases de datos de Excel para emitir contratos laborales, cartas de cobranza y certificados individuales en segundos.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-envelope-paper-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Combinación de Correspondencia: El Poder del Envío Masivo Personalizado</h5>
            <p class=""mb-0 small"">Copiar y pegar nombres, cédulas y salarios a mano en 200 contratos de trabajo toma tres días y está plagado de errores humanos. Con Mail Merge, Word fusiona una plantilla con una tabla de Excel en 30 segundos.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/D1UB0MzVH3M"" title=""Combinación de correspondencia en Word desde Excel paso a paso"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Arquitectura de la Combinación de Correspondencia</h4>
    <p>El sistema de <strong>Combinación de Correspondencia (Mail Merge)</strong> funciona vinculando dos componentes totalmente independientes:</p>
    <ul>
        <li><strong>1. El Documento Principal (Plantilla en Word):</strong> El texto maestro que contiene la estructura formal fija de la carta, contrato, memorándum o recibo de pago, intercalado con <em>Campos Combinados</em> especiales (ej: <code>«Nombre_Completo»</code>, <code>«Cedula»</code>, <code>«Monto_Adeudado»</code>).</li>
        <li><strong>2. El Origen de Datos (Lista en Excel):</strong> Una tabla limpia de Excel donde la primera fila contiene los encabezados exactos de cada columna y cada fila subsiguiente representa un destinatario o empleado individual.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-play-circle-fill text-success me-2""></i>2. Guía Paso a Paso del Procedimiento Oficial</h4>
    <ol>
        <li>Abrir la plantilla en Word y dirigirse a la pestaña superior <strong>Correspondencia</strong>.</li>
        <li>Hacer clic en <strong>Iniciar combinación de correspondencia</strong> y seleccionar <em>Cartas</em> (o <em>Documentos normales de Word</em>).</li>
        <li>Hacer clic en <strong>Seleccionar destinatarios ➔ Usar una lista existente...</strong> y buscar el archivo de Excel con los datos.</li>
        <li>Seleccionar la hoja correspondiente y marcar la casilla <em>'La primera fila de datos contiene encabezados de columna'</em>.</li>
        <li>Ubicar el cursor en los puntos estratégicos del texto y hacer clic en <strong>Insertar campo combinado</strong>, eligiendo el campo deseado (ej: <code>Estimado(a) «Nombre»:</code>).</li>
        <li>Hacer clic en <strong>Vista previa de resultados</strong> para navegar entre los registros y constatar que cada nombre se inserte perfectamente.</li>
        <li>Finalizar con <strong>Finalizar y combinar ➔ Editar documentos individuales...</strong> para generar un archivo con todas las cartas listas para imprimir o enviar.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-briefcase-fill text-primary me-2""></i>3. Caso Práctico de Oficina: Notificación de Cobranza Personalizada</h4>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3 font-monospace small"">
        Caracas, 24 de Octubre de 2026<br /><br />
        Señor(a): <strong>«Nombre_Cliente»</strong><br />
        Dirección: <strong>«Direccion_Fiscal»</strong><br />
        Número de Factura: <strong>«Numero_Factura»</strong><br /><br />
        Estimado(a) <strong>«Contacto_Principal»</strong>:<br />
        Por medio de la presente le notificamos que su cuenta registra un saldo pendiente por valor de <strong>«Monto_USD» USD</strong>, con fecha de vencimiento al <strong>«Fecha_Vencimiento»</strong>. Agradecemos canalizar la liquidación correspondiente a través de nuestros canales autorizados...
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Tener el archivo de Excel abierto al momento de vincularlo en Word:</strong> Si mantienes la hoja de cálculo abierta en Excel, Windows bloqueará el archivo por concurrencia y Word arrojará un error de 'Archivo en uso o denegado'. Siempre guarda y cierra el archivo de Excel antes de conectarlo a Word.</li>
        <li><strong>Pérdida del formato de moneda y fechas en Word:</strong> Por defecto, Word a veces importa los números de Excel como decimales puros (ej: <code>1500.250000001</code>). Para obligar a Word a mostrar formato monetario con dos decimales, se debe presionar <code>Alt + F9</code> sobre el campo y agregar el modificador de formato: <code>{ MERGEFIELD Monto_USD \# ""$#,##0.00"" }</code>.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Guardaste y cerraste el archivo de Excel antes de iniciar la combinación en Word?</li>
            <li>¿Utilizaste 'Vista previa de resultados' para verificar el formato de al menos tres registros?</li>
            <li>¿Generaste el archivo combinado individual para auditar las cartas antes de enviarlas a imprimir?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Fórmulas Intermedias de Excel: CONTAR.SI, SUMAR.SI y Formato Condicional",
                            LessonTitle = "Métricas Condicionales y Alertas Visuales Dinámicas en la Oficina",
                            Summary = "Domina el análisis cuantitativo por criterios: SUMAR.SI, SUMAR.SI.CONJUNTO, CONTAR.SI.CONJUNTO y PROMEDIO.SI. Configura reglas de Formato Condicional con fórmulas para semaforizar vencimientos automáticamente.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-calculator-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Análisis Condicional: Sumar con Criterio Empresarial</h5>
            <p class=""mb-0 small"">Saber sumar una columna entera es básico. Saber sumar únicamente las facturas de un vendedor específico que superen los $500 y que estén vencidas es lo que diferencia a un asistente de un analista calificado.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/2P_5nENJXyA"" title=""Función CONTAR.SI y SUMAR.SI en Excel con ejemplos reales"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Familia de Funciones .SI y .SI.CONJUNTO</h4>
    <p>Excel provee funciones estadísticas que evalúan criterios antes de realizar el cálculo:</p>
    <ul>
        <li><code>=CONTAR.SI(Rango; Criterio)</code>: Cuenta cuántas celdas cumplen una condición única. Ejemplo: <code>=CONTAR.SI(C2:C500; ""Pendiente"")</code> devuelve cuántas facturas están sin cobrar.</li>
        <li><code>=SUMAR.SI(Rango_Criterio; Criterio; [Rango_Suma])</code>: Suma las cantidades de una columna solo si otra columna cumple la condición. Ejemplo: <code>=SUMAR.SI(B2:B500; ""Sucursal Centro""; E2:E500)</code>.</li>
        <li><code>=SUMAR.SI.CONJUNTO(Rango_Suma; Rango_Crit1; Crit1; Rango_Crit2; Crit2...)</code>: La versión avanzada definitiva que permite evaluar hasta 127 criterios simultáneos. <em>(¡Cuidado con la sintaxis: en SUMAR.SI.CONJUNTO el rango que se suma va obligatoriamente al principio, a diferencia de SUMAR.SI donde iba al final!).</em></li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-paint-bucket text-primary me-2""></i>2. Formato Condicional con Fórmulas Propias</h4>
    <p>El <strong>Formato Condicional</strong> cambia el color de relleno o fuente de una celda de forma automática cuando cambia su valor. Para resaltar en rojo suave todas las facturas vencidas respecto al día de hoy:</p>
    <ol>
        <li>Seleccionar la columna de fechas de vencimiento (ej: <code>F2:F200</code>).</li>
        <li>Ir a <em>Inicio ➔ Formato condicional ➔ Nueva regla...</em></li>
        <li>Seleccionar la opción: <strong>'Utilice una fórmula que determine las celdas para aplicar formato'</strong>.</li>
        <li>Escribir la fórmula: <code>=F2 < HOY()</code> (utilizando referencia relativa en F2 para que Excel evalúe cada fila).</li>
        <li>Hacer clic en <em>Formato</em>, elegir relleno rojo claro con texto rojo oscuro y aceptar. Todas las facturas con fecha anterior a hoy se pintarán de rojo automáticamente sin intervención manual.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Invertir el orden de los rangos en SUMAR.SI.CONJUNTO:</strong> Como mencionamos, en <code>SUMAR.SI</code> el rango a sumar es el último argumento, mientras que en <code>SUMAR.SI.CONJUNTO</code> es el primero. Invertirlos hace que Excel devuelva 0 o un error de sintaxis.</li>
        <li><strong>No usar comillas en operadores lógicos de comparación:</strong> Si deseas sumar valores mayores a 100, el criterio debe escribirse entre comillas dobles: <code>"">100""</code>. Si escribes <code>>100</code> sin comillas, la fórmula fallará.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Recordaste que en SUMAR.SI.CONJUNTO el rango numérico a sumar va obligatoriamente al inicio?</li>
            <li>¿Escribiste entre comillas los operadores relacionales en criterios (ej: "">=500"")?</li>
            <li>¿Utilizaste la función HOY() en tus reglas de formato condicional para que los vencimientos se actualicen solos cada día?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Gráficos Estadísticos y Tendencias en Excel",
                            LessonTitle = "Visualización Analítica: Gráficos Combinados con Eje Secundario y Líneas de Tendencia",
                            Summary = "Domina la graficación profesional: gráficos combinados (Columnas + Líneas) con Eje Secundario para comparar montos en dólares contra porcentajes de margen, y cálculo de líneas de tendencia predictivas.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-bar-chart-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Gráficos con Eje Secundario: Comparar Cifras Gigantes contra Porcentajes</h5>
            <p class=""mb-0 small"">Si intentas graficar en una misma barra la facturación mensual ($100.000 USD) junto con el margen de ganancia (15%), la línea del 15% quedará pegada al suelo del gráfico en el cero absoluto. El Eje Secundario resuelve este problema al instante.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/ECmDkh50Zz8"" title=""Cómo hacer un gráfico combinado con eje secundario en Excel"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. ¿Por qué es Necesario un Eje Secundario?</h4>
    <p>Cuando un analista financiero debe presentar un informe de gestión, necesita responder dos preguntas en un solo gráfico: <em>¿Cuánto vendimos en volumen monetario?</em> y <em>¿Cuál fue la rentabilidad porcentual de esas ventas?</em></p>
    <p>Dado que las ventas se miden en miles o millones de dólares (escala de 0 a 100.000) y el margen se mide en fracciones porcentuales (escala de 0% a 100%), graficarlos en un solo eje vertical inutiliza la lectura. Un <strong>Gráfico Combinado</strong> asigna el eje vertical izquierdo a las ventas en barras, y crea un eje vertical derecho independiente con escala del 0% al 100% representado por una línea dinámica.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-gear-fill text-primary me-2""></i>2. Paso a Paso para Construir un Gráfico Combinado</h4>
    <ol>
        <li>Seleccionar la tabla de datos que contenga las tres columnas: <code>Mes</code>, <code>Ventas_USD</code> y <code>Margen_%</code>.</li>
        <li>Ir a la pestaña <strong>Insertar ➔ Gráficos recomendados ➔ Cuadro combinado</strong>.</li>
        <li>En la serie <code>Ventas_USD</code>, seleccionar el tipo: <strong>Columnas agrupadas</strong>.</li>
        <li>En la serie <code>Margen_%</code>, seleccionar el tipo: <strong>Línea con marcadores</strong>.</li>
        <li>Marcar la casilla de verificación <strong>Eje secundario</strong> al lado de la serie <code>Margen_%</code>.</li>
        <li>Hacer clic en Aceptar.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-graph-up text-primary me-2""></i>3. Incorporación de Líneas de Tendencia Proyectadas</h4>
    <p>Para estimar si las ventas seguirán creciendo o caerán en los próximos tres meses:</p>
    <ul>
        <li>Hacer clic derecho sobre la serie de datos en el gráfico y seleccionar <em>'Agregar línea de tendencia...'</em></li>
        <li>Elegir el modelo <strong>Lineal</strong> (o Polinómico si el negocio tiene alta estacionalidad).</li>
        <li>En la sección 'Extrapolación / Pronóstico', indicar hacia adelante <code>3 períodos</code>.</li>
        <li>Marcar la casilla <em>'Presentar el valor R cuadrado en el gráfico'</em>: si el valor R² supera 0.85, la tendencia matemática es altamente confiable para proyecciones presupuestarias.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Saturar el gráfico con líneas de cuadrícula y etiquetas redundantes:</strong> Si cada barra ya tiene una etiqueta de datos con el número encima, el eje vertical izquierdo sobra por completo y debe eliminarse para limpiar el espacio visual.</li>
        <li><strong>Truncar el eje vertical en gráficos de barras:</strong> En gráficos de barras, el eje numérico DEBE comenzar obligatoriamente en cero (0). Si inicias el eje en 80.000 para resaltar diferencias mínimas, estás manipulando visualmente la percepción de los datos, lo que es considerado una mala práctica ética en finanzas.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Configuraste el eje secundario para separar montos monetarios de tasas porcentuales?</li>
            <li>¿Comprobaste que el eje vertical de tus gráficos de barras inicie obligatoriamente en cero?</li>
            <li>¿Agregaste títulos de eje claros especificando las unidades monetarias (USD, Bs, Millares)?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Presentaciones Dinámicas en PowerPoint: Patrón de Diapositivas y Animaciones",
                            LessonTitle = "Estandarización Corporativa con Plantillas Maestras y Efecto Morph (Transformación)",
                            Summary = "Domina el Patrón de Diapositivas (Slide Master) para crear plantillas institucionales inmutables con logotipos y tipografías fijas. Aplica la transición Transformación (Morph) para animaciones ejecutivas fluidas.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-collection-play-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Patrón de Diapositivas: Blindar la Identidad Visual de la Empresa</h5>
            <p class=""mb-0 small"">Pegar el logotipo corporativo a mano en cada una de las 40 diapositivas es una pérdida de tiempo que provoca que el logo quede chueco o con tamaños diferentes en cada lámina. Con el Patrón de Diapositivas lo fijas una sola vez y se propaga a todo el archivo.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/2rU_g5WAYGc"" title=""Cómo usar el PATRÓN DE DIAPOSITIVAS en PowerPoint"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. ¿Qué es el Patrón de Diapositivas (Slide Master)?</h4>
    <p>El <strong>Patrón de Diapositivas</strong> es la 'capa invisible' que gobierna el diseño de toda la presentación. Todo lo que coloques en la diapositiva maestra superior (logotipos, número de página, pie de página confidencial, colores institucionales y fuentes) se bloquea en las diapositivas normales de trabajo, impidiendo que los usuarios lo muevan o borren por error.</p>
    <p>Para ingresar al editor maestro:</p>
    <ol>
        <li>Ir a la pestaña <strong>Vista ➔ Patrón de diapositivas</strong>.</li>
        <li>Hacer clic en la diapositiva número 1 ubicada arriba del todo (la Diapositiva Maestra Principal).</li>
        <li>Insertar el logotipo oficial de la empresa en la esquina superior y configurar las fuentes corporativas.</li>
        <li>Hacer clic en <strong>Cerrar vista patrón</strong>. A partir de ese instante, cualquier diapositiva nueva que agregues ya vendrá automáticamente con el logotipo perfecto en su lugar.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-magic text-primary me-2""></i>2. La Transición 'Transformación' (Morph): Animaciones Cinemáticas sin Esfuerzo</h4>
    <p>La transición <strong>Transformación (Morph)</strong> analiza automáticamente los objetos compartidos entre dos diapositivas consecutivas y calcula una animación fluida de movimiento, tamaño y posición sin necesidad de programar complejas trayectorias de animación manuales:</p>
    <ul>
        <li><strong>Ejemplo Práctico en Negocios:</strong> En la diapositiva 1 tienes una vista general del mapa del país con cuatro sucursales pequeñas. En la diapositiva 2 duplicas la lámina, agrandas el círculo de la sucursal Caracas al centro de la pantalla y aplicas la transición <em>Transformación</em>. Al proyectar, la cámara hará un zoom suave y profesional hacia la sucursal como si fuera una producción audiovisual de televisión.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-card-image text-primary me-2""></i>3. Creación de Marcadores de Posición Personalizados (Placeholders)</h4>
    <p>En el Patrón de Diapositivas puedes insertar <strong>Marcadores de Posición</strong> (para imágenes, texto, tablas o gráficos). Cuando un miembro de tu equipo utilice tu plantilla, solo verá un botón que dice <em>'Haga clic para agregar imagen'</em>: la foto que suba se recortará y adaptará automáticamente al tamaño y forma geométrica definida sin deformar la diapositiva.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Editar el texto de trabajo dentro del Patrón de Diapositivas:</strong> El Patrón solo debe contener elementos estructurales vacíos y marcadores; nunca redactes el contenido específico de tu presentación dentro de la vista patrón porque se repetirá en todas las láminas.</li>
        <li><strong>No cambiar los nombres de los objetos para la transición Morph compleja:</strong> Si deseas transformar un círculo en un cuadrado con la transición Morph, debes abrir el Panel de Selección (<code>Alt + F10</code>) y anteponer dos signos de exclamación al nombre de ambos objetos (ej: <code>!!Figura1</code>) para forzar a PowerPoint a vincularlos en la transformación.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Configuraste los logotipos corporativos en el Patrón de Diapositivas para evitar que se muevan?</li>
            <li>¿Utilizaste la transición Transformación (Morph) para zooms ejecutivos en gráficos y mapas?</li>
            <li>¿Creaste marcadores de posición de imagen para que tu equipo mantenga la estética uniforme?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    Questions = 
'@ + $qOfficeIntermedio + @'
                }
            };
        }
    }
}
'@

[System.IO.File]::WriteAllText($officeFile, $newCode, [System.Text.Encoding]::UTF8)
Write-Host "Updated CurriculumUpgrade.OfficeData.cs successfully!"
