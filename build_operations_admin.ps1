$opsFile = "c:\Users\plase\source\repos\CursosCertificadosApp\CursosCertificadosApp\Data\CurriculumUpgrade.OperationsAdmin.cs"

# Read existing questions from OperationsAdmin.cs
$oldContent = Get-Content $opsFile -Raw -Encoding UTF8

function Extract-QuizQuestions ($slug) {
    global:oldContent
    $pattern = '(?s)Slug\s*=\s*"' + [regex]::Escape($slug) + '".*?QuizQuestions\s*=\s*(new List<UpgradeQuizQuestionData>\s*\{.*?\n\s*\})\s*\}'
    if ($oldContent -match $pattern) {
        return $matches[1]
    }
    Write-Warning "Could not extract quiz questions for $slug"
    return "new List<UpgradeQuizQuestionData>()"
}

$qAdminEmp = Extract-QuizQuestions "administracion-empresarial-procesos-reportes"
$qInv = Extract-QuizQuestions "administracion-de-inventario"
$qAlmacen = Extract-QuizQuestions "auxiliar-almacen-inventarios-logistica"
$qAgile = Extract-QuizQuestions "gestion-proyectos-agile"
$qEstrategia = Extract-QuizQuestions "planificacion-estrategica"

$newCode = @'
using CursosCertificadosApp.Models.Entities;

namespace CursosCertificadosApp.Data
{
    public static class CurriculumUpgradeOperationsAdmin
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
                // 1. ADMINISTRACIÓN EMPRESARIAL BÁSICA
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "administracion-empresarial-procesos-reportes",
                    Title = "Administración Empresarial Básica: Estructura, Compras, Ventas y Reportes",
                    CategorySlug = "administracion-procesos-reportes",
                    ShortDescription = "El mapa de operaciones corporativo: organigramas, circuito de compras y cuentas por pagar, ciclo de facturación y cobranza, e informes ejecutivos para la toma de decisiones.",
                    FullDescription = "Capacitación práctica y transversal para asistentes administrativos, secretarias ejecutivas y supervisores de área. Conoce los departamentos clave de una empresa y cómo interactúan entre sí; domina el ciclo de compras desde la requisición interna hasta la orden de compra y el pago a proveedores; gestiona la emisión de facturas y la cobranza sin fricciones; y elabora informes ejecutivos y tableros de control claros para la gerencia.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: La Estructura Organizacional y Departamentos Clave",
                            LessonTitle = "Organigramas, Jerarquías y Funciones de Cada Área de la Empresa",
                            Summary = "Comprende la arquitectura empresarial: tipos de organigramas (lineal, funcional, matricial), roles de dirección vs mandos medios y el flujo de comunicación interdepartamental sin silos.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-diagram-3-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Empresa como un Sistema Vivo: Nada Funciona Aislado</h5>
            <p class=""mb-0 small"">El error más recurrente de los colaboradores recién contratados es pensar que su puesto es una isla. Comprender cómo las decisiones de compras afectan a almacén, y cómo ventas impacta en finanzas, es la clave para ascender a puestos de supervisión.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/NpsflJIWNIg"" title=""La estructura organizacional - Growp"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. ¿Qué es la Estructura Organizacional y el Organigrama?</h4>
    <p>La <strong>Estructura Organizacional</strong> es el marco formal que define cómo se dividen, agrupan y coordinan las tareas laborales en una organización. Se plasma visualmente en un <strong>Organigrama</strong>, el cual refleja:</p>
    <ul>
        <li><strong>Líneas de Autoridad y Dependencia Jerárquica:</strong> Quién rinde cuentas a quién (evitando que un empleado reciba órdenes contradictorias de dos jefes distintos, respetando el principio de <em>Unidad de Mando</em> de Henri Fayol).</li>
        <li><strong>Tramos de Control (Span of Control):</strong> La cantidad de colaboradores directos que supervisa cada gerente o jefe de área.</li>
        <li><strong>Departamentalización:</strong> División por funciones (Finanzas, Ventas, Operaciones, RRHH), por productos o por áreas geográficas.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-building text-primary me-2""></i>2. Las 5 Áreas Funcionales Clave de una Empresa</h4>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Departamento</th>
                    <th>Misión Central</th>
                    <th>Interacción Vital con Otras Áreas</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-primary"">Administración y Finanzas</td>
                    <td>Custodiar la liquidez, pagar impuestos, gestionar la contabilidad y planificar presupuestos.</td>
                    <td>Autoriza los pagos a proveedores gestionados por Compras y cobra las facturas emitidas por Ventas.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-success"">Comercial y Ventas</td>
                    <td>Generar ingresos, captar clientes, cerrar acuerdos y atender canales de distribución.</td>
                    <td>Depende de Almacén para prometer plazos de entrega realistas a los clientes.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-warning text-dark"">Operaciones y Logística</td>
                    <td>Fabricar los productos o almacenar, embalar y despachar la mercancía vendida.</td>
                    <td>Informa a Compras cuándo los stocks mínimos están en peligro de agotarse.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-danger"">Compras y Abastecimiento</td>
                    <td>Negociar con proveedores las mejores condiciones de precio, calidad y plazo de entrega.</td>
                    <td>Suministra insumos a Operaciones respetando los presupuestos de Finanzas.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-secondary"">Talento Humano (RRHH)</td>
                    <td>Reclutar, seleccionar, capacitar y cuidar el clima laboral y el cumplimiento legal del personal.</td>
                    <td>Apoya a todos los departamentos en la resolución de conflictos y pago puntual de nómina.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-arrow-left-right text-primary me-2""></i>3. La Erradicación de los Silos de Información</h4>
    <p>Cuando un departamento se niega a compartir información con los demás o culpa a otra área ante los errores, se producen <strong>silos organizacionales</strong>:</p>
    <ul>
        <li>Si Ventas lanza una promoción masiva con 30% de descuento sin avisar a Almacén, la tienda se quedará sin mercancía en dos horas, enfadando a los clientes.</li>
        <li>La gestión moderna utiliza reuniones interdepartamentales semanales de alineación y plataformas compartidas (ERP) donde todos los líderes ven el mismo tablero de datos en tiempo real.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Falta de Manual de Organización y Funciones (MOF):</strong> Si no existen descripciones escritas y firmadas de las responsabilidades de cada puesto, ante un error grave nadie asume la culpa ('a mí no me dijeron que me tocaba hacer eso').</li>
        <li><strong>Saltarse los canales regulares de jerarquía:</strong> Acudir directamente al Presidente de la compañía para quejarse de un tema operativo diario sin hablar primero con tu supervisor inmediato socava la autoridad de los mandos medios y genera fricciones internas.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Conoces el organigrama oficial y tienes claro quién es tu supervisor directo?</li>
            <li>¿Cuentas con una descripción formal escrita de tus funciones y metas del puesto?</li>
            <li>¿Comunicas oportunamente los cambios de tu área a los departamentos interconectados?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: De la Requisición Interna a la Orden de Compra y Pago a Proveedores",
                            LessonTitle = "El Circuito Administrativo de Abastecimiento y Cuentas por Pagar",
                            Summary = "Domina el circuito documental de egresos: la Requisición interna, la solicitud de tres cotizaciones, la emisión de la Orden de Compra (PO), la verificación de recepción y la programación de pagos.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-file-earmark-spreadsheet-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Control de Compras: El Dinero que se Ahorra en Compras es Utilidad Pura</h5>
            <p class=""mb-0 small"">Para ganar $1.000 USD de utilidad neta, una empresa con margen del 10% tiene que vender $10.000 USD adicionales. En cambio, negociar un ahorro de $1.000 USD en compras va directo al 100% como ganancia neta en el balance general.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/WzqqoigQsuk"" title=""Requisiciones de Compras en Business Central y ERP"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. El Circuito Documental de Compras en 5 Pasos</h4>
    <p>En cualquier empresa auditada, ningún empleado puede llamar a un proveedor y encargar materiales por teléfono sin respaldo documental. El circuito oficial exige:</p>
    <ol>
        <li><strong>Requisición Interna de Compra (Requisition):</strong> El área solicitante (ej: Contabilidad pidiendo resmas de papel, o Taller pidiendo repuestos) llena el formulario interno indicando especificaciones técnicas, cantidad requerida y justificación operativa. Debe estar firmada por el jefe del departamento.</li>
        <li><strong>Cuadro Comparativo de Cotizaciones (Licitación):</strong> El analista de compras solicita presupuestos a un mínimo de <strong>3 proveedores independientes</strong>, comparando en una matriz: precio unitario, tiempo de entrega, condiciones de crédito y garantías.</li>
        <li><strong>Orden de Compra Formal (Purchase Order - PO):</strong> Contrato mercantil legal firmado por la Gerencia que autoriza al proveedor ganador a despachar. Fija de forma inmutable los precios pactados e impuestos de ley.</li>
        <li><strong>Nota de Recepción en Almacén (Goods Receipt):</strong> Al recibir el camión, el almacenista cuenta y verifica que la mercancía esté en perfecto estado antes de firmar la guía de despacho.</li>
        <li><strong>Factura Fiscal y Programación de Pago:</strong> Administración recibe la factura original del proveedor, verifica la coincidencia con la Orden de Compra y la Nota de Recepción (Conciliación a Tres Bandas) y programa la transferencia bancaria según el plazo de crédito pactado (ej: crédito a 30 días).</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-wallet2 text-primary me-2""></i>2. Cuentas por Pagar (CXP) y Flujo de Caja</h4>
    <p>El departamento de Cuentas por Pagar es el encargado de proteger la liquidez de la empresa:</p>
    <ul>
        <li><strong>Aprovechamiento de Descuentos por Pronto Pago:</strong> Muchos proveedores ofrecen condiciones tipo <code>2/10 neto 30</code> (un 2% de descuento si se cancela en los primeros 10 días, o pago neto a los 30 días). Aprovechar estos descuentos representa un rendimiento financiero superior al de cualquier banco.</li>
        <li><strong>Calendario Semanal de Pagos:</strong> En lugar de emitir transferencias todos los días a cualquier hora, las empresas ordenadas fijan un día específico a la semana (ej: los jueves) para procesar pagos a proveedores, facilitando la conciliación bancaria.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Pagar facturas sin la Orden de Compra aprobada adjunta:</strong> Pagar requerimientos verbales o facturas sueltas abre la puerta a fraudes internos, compras a precios inflados y pagos duplicados.</li>
        <li><strong>No solicitar comprobantes de retención fiscal:</strong> En países como Venezuela con agentes de retención de IVA e ISLR (SENIAT), no emitir y archivar los comprobantes de retención dentro del plazo legal acarrea multas tributarias y cierre temporal del establecimiento comercial.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Exiges la Requisición interna firmada antes de cotizar compras departamentales?</li>
            <li>¿Comparas al menos 3 cotizaciones independientes en una matriz de decisión transparente?</li>
            <li>¿Realizas la conciliación a tres bandas (Factura + OC + Recepción) antes de programar pagos?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Cotizaciones, Emisión de Facturas, Cobro y Gestión de Cartera",
                            LessonTitle = "El Ciclo de Facturación y Cuentas por Cobrar (CXC)",
                            Summary = "Aprende el ciclo de ingresos: elaboración de cotizaciones comerciales con validez legal, emisión de facturas fiscales, seguimiento preventivo de cobranza y gestión de antigüedad de saldos (Aging).",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-receipt-cutoff fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Una Venta no Termina cuando se Entrega el Producto; Termina cuando se Cobra</h5>
            <p class=""mb-0 small"">Facturar millones no sirve de nada si el dinero queda atrapado en cuentas por cobrar vencidas de clientes morosos. La gestión rigurosa de cartera garantiza que las ventas se conviertan en dinero líquido en el banco.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/8oMGEuH5qT0"" title=""Flujo Operativo de Ventas y Facturación en ERP"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Cotización Comercial Profesional</h4>
    <p>Una cotización comercial no es solo una lista de precios; es un documento formal que blinda legalmente a la empresa. Toda cotización ejecutiva debe contener obligatoriamente 5 cláusulas clave:</p>
    <ul>
        <li><strong>Tiempo de Validez de la Oferta:</strong> (ej: <em>'Válida por 5 días hábiles a partir de la fecha de emisión'</em>). Protege al negocio frente a fluctuaciones de costos de reposición o inflación.</li>
        <li><strong>Condiciones de Pago:</strong> Anticipo del 50% al ordenar y 50% contra entrega, o crédito a 15 días previa aprobación del departamento financiero.</li>
        <li><strong>Tiempos de Entrega Estimados:</strong> Expresados en días hábiles tras la confirmación del pago o la recepción formal de la orden de compra.</li>
        <li><strong>Desglose de Impuestos de Ley:</strong> Detallar claramente la base imponible y el porcentaje exacto de IVA.</li>
        <li><strong>Lugar de Entrega (Incoterms básicos):</strong> Especificar si el flete está incluido hasta el almacén del cliente o si la mercancía se retira en el mostrador del vendedor.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-calendar-range text-primary me-2""></i>2. Gestión de Cartera y Reporte de Antigüedad de Saldos (Aging)</h4>
    <p>En el departamento de <strong>Cuentas por Cobrar (CXC)</strong>, los analistas auditan semanalmente el estado de la cartera clasificando las deudas en tramos de vencimiento:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Tramo de Cartera</th>
                    <th>Estado de Riesgo</th>
                    <th>Acción de Cobranza Profesional</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-success"">Por Vencer (0 a 30 días)</td>
                    <td>Riesgo Bajo / Corriente</td>
                    <td><strong>Cobranza Preventiva:</strong> Enviar estado de cuenta cordial 5 días antes del vencimiento recordando la fecha límite de pago y los datos bancarios.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-warning text-dark"">Vencida de 1 a 15 días</td>
                    <td>Riesgo Moderado</td>
                    <td>Llamada telefónica directa de seguimiento al jefe de pagos del cliente solicitando fecha programada de transferencia.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-danger"">Vencida de 16 a 45 días</td>
                    <td>Riesgo Alto</td>
                    <td><strong>Bloqueo Comercial en ERP:</strong> Suspender automáticamente nuevos despachos o pedidos al cliente hasta que liquide el saldo vencido.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-dark"">Más de 60 días</td>
                    <td>Riesgo Crítico / Incobrable</td>
                    <td>Paso a cobro jurídico y aplicación de intereses moratorios pactados contractualmente.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Esperar a que la factura venza para contactar al cliente:</strong> La cobranza moderna es preventiva. Si esperas al día del vencimiento, el cliente te dirá que su programación de pagos ya cerró y que te pagará la semana siguiente. Contáctalo con anticipación.</li>
        <li><strong>Entregar mercancía a crédito sin consultar el límite crediticio en el sistema:</strong> Si un asesor de ventas despacha productos a un cliente que ya tiene el límite de crédito copado o facturas vencidas, la empresa asume un riesgo de incobrabilidad inaceptable.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Incluyen tus cotizaciones plazo de validez, condiciones de pago y desglose fiscal?</li>
            <li>¿Auditas semanalmente el reporte de antigüedad de saldos (Aging) de tus clientes?</li>
            <li>¿Ejecutas llamadas de cobranza preventiva antes de que se cumpla la fecha de vencimiento?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Diseño de Informes Ejecutivos, Tableros de Control y Resumen Financiero Básico",
                            LessonTitle = "Presentación de Resultados a la Gerencia: Claridad, Métricas y Decisiones",
                            Summary = "Aprende a sintetizar datos operativos en reportes gerenciales de 1 página: Estado de Resultados simplificado (EBITDA), flujo de caja libre, indicadores de gestión y recomendaciones accionables.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-clipboard2-data-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Resumen Ejecutivo: La Regla de la Página Única</h5>
            <p class=""mb-0 small"">Los directores y gerentes generales no tienen tiempo para leer informes de 80 páginas llenos de rodeos. Un asistente administrativo de alto nivel sintetiza el pulso financiero y operativo de la empresa en una sola página contundente.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/dzh7faTkHCk"" title=""Diseño de Informes Ejecutivos y Tableros de Control"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Estructura Estándar de un Informe Ejecutivo (One-Pager)</h4>
    <p>Todo informe dirigido al comité de dirección debe organizarse en 4 bloques visuales limpios:</p>
    <ol>
        <li><strong>Encabezado Institucional:</strong> Fecha, autor, departamento y objetivo del reporte en una sola línea (ej: <em>'Balance Operativo y Financiero - Cierre Tercer Trimestre 2026'</em>).</li>
        <li><strong>Panel de Métricas Clave (KPIs):</strong> 4 tarjetas destacadas con los números sagrados del mes (Ventas Reales vs Meta Presupuestaria, Margen Bruto %, Cobranza Efectiva y Saldo en Bancos).</li>
        <li><strong>Análisis de Variaciones Significativas:</strong> Explicación concisa de las desviaciones mayores al 5% (ej: <em>'Los costos de transporte aumentaron un 8% debido al alza de tarifas de fletes interurbanos'</em>).</li>
        <li><strong>Plan de Acción y Recomendaciones Concretas:</strong> Propuestas operativas con responsable y fecha límite para corregir las desviaciones observadas.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-cash-stack text-success me-2""></i>2. Conceptos Financieros Básicos que Todo Asistente Debe Dominar</h4>
    <p>Para hablar con solvencia con la gerencia, se deben dominar las líneas maestras de un estado financiero:</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <div class=""font-monospace small"">
            <strong>(+) Ingresos Operativos Netos (Ventas Totales sin IVA)</strong><br />
            <strong>(-) Costo de Ventas (Costo de adquisición de la mercancía vendida)</strong><br />
            <span class=""text-primary fw-bold"">(=) Utilidad Bruta (Gross Profit)</span><br /><br />
            <strong>(-) Gastos Operativos de Administración y Ventas (Sueldos, alquileres, servicios, publicidad)</strong><br />
            <span class=""text-success fw-bold"">(=) EBITDA (Utilidad antes de Intereses, Impuestos, Depreciaciones y Amortizaciones)</span><br /><br />
            <strong>(-) Depreciaciones, Amortizaciones e Intereses Financieros</strong><br />
            <strong>(-) Impuesto sobre la Renta (ISLR)</strong><br />
            <span class=""text-danger fw-bold"">(=) Utilidad Neta (El dinero limpio que queda para los accionistas)</span>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Presentar datos crudos sin interpretación cualitativa:</strong> Pegar una tabla con 500 números sin explicar qué significan es una pérdida de tiempo. La labor del analista es resaltar: <em>'La sucursal Norte creció un 14% impulsada por la venta de la nueva línea de calzado'</em>.</li>
        <li><strong>Ocultar malas noticias o errores operativos en el reporte:</strong> Si las ventas cayeron o hubo una pérdida de inventario, presentarlo con honestidad profesional y con un plan correctivo inmediato genera mucha más confianza gerencial que intentar maquillar los números.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Sintetizaste los hallazgos principales en una sola página con formato ejecutivo?</li>
            <li>¿Comparaste las cifras reales del mes contra el presupuesto aprobado y el mes anterior?</li>
            <li>¿Acompañaste cada desviación negativa de una propuesta de acción correctiva concreta?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = 
'@ + $qAdminEmp + @'
                },

                // =========================================================================
                // 2. ADMINISTRACIÓN Y CONTROL DE INVENTARIOS
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "administracion-de-inventario",
                    Title = "Administración y Control de Inventarios: Modelos ABC, Stocks de Seguridad y Auditoría",
                    CategorySlug = "administracion-procesos-reportes",
                    ShortDescription = "Domina la gestión matemática de almacenes: Clasificación ABC por Pareto, cálculo del Punto de Reorden (ROP), Lote Económico (EOQ), stock de seguridad y tomas físicas.",
                    FullDescription = "Capacitación especializada para analistas de inventario, jefes de almacén y administradores de logística. Aprende a clasificar existencias con el Principio de Pareto (Modelo ABC); calcula puntos óptimos de reabastecimiento (ROP) y stocks de seguridad para eliminar quiebres de existencias; equilibra los costos de ordenar contra los costos de almacenamiento con el modelo EOQ; y ejecuta auditorías cíclicas y tomas físicas ciegas con conciliación contable.",
                    Level = "Intermedio",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Clasificación de Inventarios por el Método ABC (Principio de Pareto)",
                            LessonTitle = "Categorización por Valor Monetario y Frecuencia de Movimiento",
                            Summary = "Domina la regla 80/20 aplicada a bodegas: clasifica SKUs en Tipo A (alto valor), Tipo B (rotación media) y Tipo C (artículos masivos de bajo costo), optimizando el tiempo de control y custodia.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-pie-chart-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Principio de Pareto: No Todos los Productos se Cuidan por Igual</h5>
            <p class=""mb-0 small"">Intentar auditar y controlar con la misma intensidad los tornillos de $0.05 que los motores de $5.000 USD es un error que satura al personal de almacén. La clasificación ABC focaliza el esfuerzo de control en el 20% de los artículos que concentran el 80% del capital de la empresa.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/NMu9evFpGps"" title=""Análisis ABC de Inventarios y PARETO - Paso a paso en EXCEL"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Jerarquía del Modelo ABC</h4>
    <p>Basado en el <strong>Principio de Pareto (Regla del 80/20)</strong> formulado por Vilfredo Pareto, el método ABC categoriza el catálogo de productos evaluando su <em>Valor Monetario Anual de Utilización (Ventas Totales = Demanda Anual × Costo Unitario)</em>:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Categoría</th>
                    <th>% de Artículos Físicos (SKUs)</th>
                    <th>% del Valor Monetario Acumulado</th>
                    <th>Protocolo de Custodia y Auditoría Obligatorio</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-danger fs-6"">Artículos A</td>
                    <td>10% a 20%</td>
                    <td><strong>70% a 80%</strong> del capital</td>
                    <td><strong>Máxima Prioridad:</strong> Conteos cíclicos semanales, resguardo bajo llave o jaulas de seguridad, órdenes de compra ajustadas al consumo semanal y cero tolerancia a discrepancias.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-warning text-dark fs-6"">Artículos B</td>
                    <td>20% a 30%</td>
                    <td><strong>15% a 20%</strong> del capital</td>
                    <td><strong>Prioridad Moderada:</strong> Conteos mensuales, pedidos mensuales estandarizados y monitoreo regular de rotación.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-secondary fs-6"">Artículos C</td>
                    <td>50% a 60%</td>
                    <td><strong>Apenas 5% a 10%</strong> del capital</td>
                    <td><strong>Control Simplificado:</strong> Compras en grandes volúmenes para ahorrar fletes (pedidos para 3 a 6 meses), conteo semestral o anual y almacenamiento abierto sin burocracia excesiva.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-calculator text-primary me-2""></i>2. Paso a Paso para Construir la Clasificación ABC en Excel</h4>
    <ol>
        <li>Listar todos los SKUs con su <code>Costo Unitario</code> y su <code>Demanda Anual en Unidades</code>.</li>
        <li>Crear la columna <code>Valor Total = Costo × Demanda</code>.</li>
        <li>Ordenar la tabla completa de <strong>Mayor a Menor</strong> según la columna <code>Valor Total</code>.</li>
        <li>Calcular el <code>% de Participación Individual = Valor Total / Suma Total</code>.</li>
        <li>Crear la columna <code>% Acumulado</code> sumando progresivamente las participaciones de arriba hacia abajo.</li>
        <li>Aplicar la regla condicional:
            <ul>
                <li>Hasta el 80% acumulado ➔ <strong>Categoría A</strong>.</li>
                <li>Del 80% al 95% acumulado ➔ <strong>Categoría B</strong>.</li>
                <li>Del 95% al 100% acumulado ➔ <strong>Categoría C</strong>.</li>
            </ul>
        </li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Clasificar únicamente por volumen de unidades vendidas y no por valor monetario:</strong> Vender 10.000 tuercas de $0.02 representa apenas $200 USD de movimiento; vender 5 servidores de $8.000 representa $40.000 USD. El valor monetario siempre manda en el análisis ABC.</li>
        <li><strong>No considerar la criticidad operativa del artículo:</strong> Aunque un fusible especial cueste solo $2 (Categoría C), si ese fusible se quema y no hay repuesto en almacén la fábrica entera se detiene. Estos insumos críticos deben reclasificarse como <em>'A Crítico'</em> con stock de seguridad obligatorio.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Actualizas tu clasificación ABC al menos dos veces al año según las variaciones de demanda?</li>
            <li>¿Están los artículos A resguardados en zonas de acceso restringido con auditoría semanal?</li>
            <li>¿Identificaste los repuestos de bajo costo pero críticos para la continuidad operativa?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Fórmulas de Abastecimiento para Evitar Quiebres de Existencia",
                            LessonTitle = "Cálculo del Punto de Reorden (ROP) y Stock de Seguridad (Safety Stock)",
                            Summary = "Domina la matemática de reabastecimiento: Punto de Reorden (ROP), tiempo de entrega del proveedor (Lead Time), demanda promedio diaria y cálculo del Stock de Seguridad para resistir retrasos.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-graph-up-arrow fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Punto de Reorden: Cuándo Emitir la Orden de Compra con Exactitud Matemática</h5>
            <p class=""mb-0 small"">Esperar a que el estante quede vacío para pedir mercancía al proveedor garantiza un quiebre de stock. El Punto de Reorden te dice el número exacto de unidades al que debe bajar el inventario para encender la alarma de compra.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/3kSM2bu0KkA"" title=""Cómo Calcular el PUNTO DE REORDEN en Inventarios"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Fórmula Universal del Punto de Reorden (ROP)</h4>
    <p>El <strong>Punto de Reorden (Reorder Point - ROP)</strong> es el nivel de existencias que dispara una nueva orden de compra para que el camión del proveedor llegue exactamente cuando el inventario operativo llegue a su nivel de seguridad:</p>
    <div class=""p-3 bg-light rounded border text-center my-3"">
        <code class=""fs-6 fw-bold"">Punto de Reorden (ROP) = (Demanda Diaria Promedio × Tiempo de Entrega en Días) + Stock de Seguridad</code>
    </div>
    <ul>
        <li><strong>Demanda Diaria Promedio (d):</strong> Cuántas unidades se venden o consumen en promedio cada día (Ventas mensuales / 30).</li>
        <li><strong>Tiempo de Entrega / Lead Time (L):</strong> Los días exactos que tarda el proveedor desde que recibe la orden de compra hasta que descarga la mercancía en el almacén.</li>
        <li><strong>Stock de Seguridad (SS):</strong> El colchón de reserva destinado a absorber picos inesperados de demanda o demoras del transporte.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shield-check text-success me-2""></i>2. Cálculo del Stock de Seguridad (Safety Stock)</h4>
    <p>Para no sobredimensionar el inventario ni quedarse corto, se calcula el Stock de Seguridad considerando la variabilidad del proveedor y del mercado:</p>
    <div class=""p-3 bg-light rounded border font-monospace small mb-3 text-dark text-center"">
        <code>Stock de Seguridad (SS) = (Venta Diaria Máxima × Plazo Máximo de Entrega) - (Venta Diaria Promedio × Plazo Promedio)</code>
    </div>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3 font-monospace small"">
        <strong>Ejemplo Real de Oficina:</strong><br />
        - Vendemos en promedio <strong>20 cajas de aceite al día</strong> (en días picos vendemos 35).<br />
        - El proveedor tarda en promedio <strong>5 días</strong> en entregar (si se retrasa tarda 8 días).<br /><br />
        Cálculo del Stock de Seguridad: <code>(35 × 8) - (20 × 5) = 280 - 100 = 180 cajas</code>.<br />
        Cálculo del ROP: <code>(20 × 5) + 180 = 100 + 180 = 280 cajas</code>.<br /><br />
        <em>Veredicto operativo:</em> En el instante en que el conteo de almacén marque <strong>280 cajas</strong>, el analista debe emitir la orden de compra de inmediato.
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Considerar el Lead Time del proveedor como días de calendario en lugar de días hábiles:</strong> Si el proveedor trabaja solo de lunes a viernes y promete '5 días de entrega', una orden emitida un miércoles llegará el miércoles siguiente (7 días calendario de espera real).</li>
        <li><strong>Mantener el mismo ROP en temporadas altas (Navidad / Día de la Madre):</strong> La demanda promedio cambia drásticamente en temporadas pico. Los parámetros de ROP y Stock de Seguridad deben recalcularse estacionalmente para no quebrar inventario en las semanas de mayores ventas.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Calculaste el ROP considerando el Lead Time real del proveedor puerta a puerta?</li>
            <li>¿Tienes configurado un Stock de Seguridad para proteger a la empresa de retrasos logísticos?</li>
            <li>¿Ajustas los parámetros de demanda antes de iniciar temporadas comerciales altas?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Costo de Almacenamiento, Costo de Ordenar y Trade-Offs Financieros",
                            LessonTitle = "El Modelo del Lote Económico de Compra (EOQ - Cantidad Óptima)",
                            Summary = "Equilibra los dos costos opuestos de la logística: Costo de Mantener Inventario (Holding Cost) vs Costo de Pedir (Ordering Cost). Domina la fórmula matemática del Lote Económico (EOQ) de Ford Harris.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-balance fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Tensión Sagrada: ¿Pedir Mucho y Poco Frecuente, o Pedir Poco y Seguido?</h5>
            <p class=""mb-0 small"">Si pides camiones llenos una vez al año, ahorras en fletes pero te arruinas pagando bodegas gigantes y mercancía dañada. Si pides una cajita cada dos días, el flete y la burocracia de facturación devorarán tus ganancias. El modelo EOQ encuentra el punto de equilibrio exacto.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/ywgGvFw6SDo"" title=""Métodos de Inventario PEPS, UEPS y Promedio Ponderado"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Los Dos Costos Contrapuestos del Inventario</h4>
    <p>Para determinar cuánto comprar en cada pedido, los directores de logística analizan el conflicto entre dos fuerzas financieras:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h5 class=""fw-bold text-danger mb-2""><i class=""bi bi-box-arrow-in-down me-2""></i>Costo de Mantener / Almacenar (Holding Cost - H)</h5>
                <p class=""small text-muted mb-2"">Crece de forma directamente proporcional a la cantidad de stock acumulado en bodega:</p>
                <ul class=""small mb-0"">
                    <li>Alquiler del metro cuadrado de almacén y energía de refrigeración.</li>
                    <li>Seguros contra incendios y robos.</li>
                    <li>Costo de oportunidad del capital financiero inmovilizado.</li>
                    <li>Riesgo de mermas, caducidades y obsolescencia tecnológica.</li>
                </ul>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h5 class=""fw-bold text-primary mb-2""><i class=""bi bi-truck me-2""></i>Costo de Ordenar / Pedir (Ordering Cost - S)</h5>
                <p class=""small text-muted mb-2"">Costo administrativo fijo generado cada vez que se emite una orden de compra:</p>
                <ul class=""small mb-0"">
                    <li>Flete fijo del camión y peajes.</li>
                    <li>Mano de obra de cotización, emisión de OC y liquidación contable.</li>
                    <li>Tiempo de descarga, conteo físico e inspección de calidad en muelle.</li>
                </ul>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-calculator-fill text-primary me-2""></i>2. La Fórmula del Lote Económico de Pedido (EOQ)</h4>
    <p>Formulado por Ford Whitman Harris, el modelo <strong>EOQ (Economic Order Quantity)</strong> calcula el tamaño de lote que minimiza la suma de ambos costos:</p>
    <div class=""p-3 bg-light rounded border text-center my-3"">
        <code class=""fs-6 fw-bold"">EOQ = √ [ (2 × Demanda Anual D × Costo de Pedido S) / Costo Unitario de Almacenamiento H ]</code>
    </div>
    <p class=""small text-muted"">Al graficar ambas curvas, el punto exacto donde la curva del costo de ordenar se cruza con la curva del costo de almacenamiento representa el <strong>Costo Total Mínimo</strong> de operación logística.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-cash-coin text-success me-2""></i>3. Métodos de Valuación de Existencias (FIFO vs Promedio Ponderado)</h4>
    <p>En economías inflacionarias o con variación de precios internacionales, elegir el método contable de valuación impacta directamente en el pago de impuestos:</p>
    <ul>
        <li><strong>Promedio Ponderado (PMP):</strong> Cada vez que entra una compra a un precio distinto, se recalcula el costo unitario medio: <code>Costo Medio = Valor Total en Dinero / Cantidad Total de Unidades</code>. Es el método más estable y extendido en América Latina.</li>
        <li><strong>PEPS / FIFO:</strong> El costo del producto vendido se calcula al precio del lote más antiguo. En inflación, muestra utilidades artificialmente altas que aumentan el pago de impuestos sobre la renta.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Comprar lotes gigantescos solo por obtener un pequeño descuento por volumen:</strong> Si el proveedor te ofrece un 5% de descuento por comprar 5.000 unidades en vez de 500, pero la mercancía ocupará tu almacén durante dos años pagando seguros y arriesgando caducidades, el costo financiero superará con creces el descuento del 5%.</li>
        <li><strong>Ignorar la vida útil del producto al aplicar la fórmula EOQ:</strong> La fórmula matemática del EOQ puede decir que el lote óptimo es de 1.000 unidades, pero si el producto vence en 60 días y tu demanda bimestral es de solo 300 unidades, debes respetar la caducidad por encima del cálculo matemático puro.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Calculaste el costo de almacenamiento anual incluyendo seguros, mermas y costo de capital?</li>
            <li>¿Utilizas el modelo EOQ para balancear los fletes de transporte contra el costo de bodega?</li>
            <li>¿Aplicas el método de Promedio Ponderado de forma consistente en el software contable?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Conteo Físico Ciego, Detección de Discrepancias y Ajustes Contables",
                            LessonTitle = "Auditoría de Almacén: Del Marbete al Acta de Diferencias de Inventario",
                            Summary = "Domina la técnica de auditoría de inventarios: el conteo cíclico vs la toma física anual, el uso de marbetes numerados de doble talón, el conteo ciego y la conciliación de mermas y faltantes.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-clipboard2-check-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Auditoría de Inventario: La Verdad Detrás de las Cifras del Sistema</h5>
            <p class=""mb-0 small"">Una hoja de cálculo o un sistema ERP puede decir que en la bodega hay 500 laptops. Si al abrir el candado físico del almacén solo hay 480, la empresa tiene una pérdida patrimonial real que debe auditarse, investigarse y ajustarse legalmente.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/YP4584tjhC8"" title=""Control de Inventarios y Auditoría de Bodega"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Conteo Físico General vs Conteos Cíclicos</h4>
    <p>En la gestión moderna de bodegas existen dos filosofías de auditoría:</p>
    <ul>
        <li><strong>Toma Física Anual Total:</strong> Paralizar toda la empresa durante un fin de semana completo, cerrar puertas y contar cada tornillo del almacén. Es costosa, agota al personal y detecta las pérdidas cuando ya es demasiado tarde para encontrar a los responsables.</li>
        <li><strong>Conteos Cíclicos Continuos (Recomendado):</strong> Auditar todos los días un grupo pequeño de SKUs según su categoría ABC (los productos A se cuentan semanalmente, los B mensualmente y los C semestralmente). No paraliza la empresa, mantiene el inventario con más del 98% de exactitud todo el año (IRA - Inventory Record Accuracy) y detecta hurtos o errores de digitación en el momento en que ocurren.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-tags-fill text-primary me-2""></i>2. La Metodología del Conteo Ciego con Marbetes de Doble Talón</h4>
    <p>Para garantizar que los operarios no 'adivinen' o copien los saldos teóricos del sistema, se aplica el <strong>Conteo Ciego</strong> utilizando marbetes numerados:</p>
    <ol>
        <li><strong>Marbete de Doble Talón:</strong> Tarjeta física numerada consecutivamente que se adhiere a cada tarima o lote en el estante.</li>
        <li><strong>Primer Conteo (Auditor 1):</strong> Cuenta físicamente las unidades, escribe la cantidad en el Talón 1, lo desprende y lo entrega a la mesa de control sin dejar marca visible en la tarima.</li>
        <li><strong>Segundo Conteo Independiente (Auditor 2):</strong> Pasa otro operario distinto y cuenta la misma tarima, anotando en el Talón 2.</li>
        <li><strong>Confrontación en Mesa de Control:</strong> Si el Talón 1 y el Talón 2 coinciden exactamente, el dato se da por bueno. Si hay discrepancia (uno contó 45 y el otro 48), un supervisor realiza un tercer conteo en su presencia para definir la cifra definitiva.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-file-earmark-diff text-danger me-2""></i>3. Detección de Discrepancias y el Indicador IRA</h4>
    <p>El indicador de calidad logística fundamental es el <strong>IRA (Exactitud del Registro de Inventario)</strong>:</p>
    <div class=""p-3 bg-light rounded border font-monospace small mb-3 text-dark text-center"">
        <code>IRA % = (Cantidad de SKUs con Saldo Físico Exacto / Total de SKUs Auditados) × 100</code>
    </div>
    <p class=""small text-muted"">Un almacén de clase mundial mantiene un IRA superior al <strong>98%</strong>. Las discrepancias típicas suelen originarse en: errores de digitación en ingresos de compras, códigos de barra cruzados (entregar el producto X pensando que era el producto Y) o sustracción de mercancía.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Entregar la lista con las cantidades teóricas a los operarios que cuentan:</strong> Si el operario ve en el papel que el sistema dice '50 unidades', mirará de lejos el estante y escribirá '50' para terminar rápido sin contar bulto por bulto. El conteo ciego es la única garantía de verdad.</li>
        <li><strong>Mover mercancía o despachar camiones durante la toma física:</strong> Si el almacén está en proceso de conteo y se reciben despachos de camiones o se mueven tarimas entre pasillos, los productos se contarán dos veces o no se contarán, arruinando toda la auditoría. El almacén debe estar estrictamente 'congelado' durante la toma de datos.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Implementaste conteos cíclicos semanales para productos de alto valor (Categoría A)?</li>
            <li>¿Aplicas marbetes y conteo ciego sin entregar saldos teóricos al personal de campo?</li>
            <li>¿Documentas cada ajuste de inventario con acta formal firmada por auditoría y gerencia?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = 
'@ + $qInv + @'
                },

                // =========================================================================
                // 3. AUXILIAR DE ALMACÉN, CONTROL DE INVENTARIOS Y LOGÍSTICA
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "auxiliar-almacen-inventarios-logistica",
                    Title = "Auxiliar de Almacén, Control de Inventarios y Logística Básica",
                    CategorySlug = "administracion-procesos-reportes",
                    ShortDescription = "Formación práctica para operarios y auxiliares logísticos: diseño de Layout, técnicas de Picking y Packing, seguridad industrial con EPP, y metodología 5S en bodegas.",
                    FullDescription = "Capacitación 100% orientada al trabajo físico y operativo en centros de distribución y almacenes comerciales. Aprende a interpretar la zonificación y layout del almacén (muelles, pulmón, picking, consolidación); domina los métodos de picking por olas y packing seguro con film plástico; aplica protocolos de ergonomía y manejo seguro de cargas manuales y montacargas; e implementa la metodología 5S para mantener orden y cero accidentes.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Distribución Física del Almacén (Layout) y Zonas Operativas",
                            LessonTitle = "Muelle de Carga, Zona de Pulmón, Picking y Despachos",
                            Summary = "Conoce la arquitectura funcional de un centro de distribución: flujo en 'U' vs flujo en línea recta ('I'), muelles de recepción, áreas de almacenamiento masivo y zonas de consolidación de envíos.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-grid-1x2-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Layout: Diseñar el Espacio para Minimizar Pasos Inútiles</h5>
            <p class=""mb-0 small"">En un almacén de 2.000 metros cuadrados, el 60% del tiempo de un operario se pierde caminando de un lado a otro buscando productos. Un diseño de layout inteligente reduce las distancias de recorrido a la mitad y acelera los despachos.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/sI2-qTBqY0I"" title=""Layout prácticos para analizar y optimizar los procesos de almacén"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Las 5 Zonas Obligatorias de un Almacén Funcional</h4>
    <p>Para que las operaciones fluyan sin colisiones entre montacargas y operarios de a pie, la bodega se divide en zonas bien delimitadas con pintura epóxica de alto tráfico en el suelo:</p>
    <ul>
        <li><strong>Zona de Carga y Descarga (Muelles / Docks):</strong> Área donde atracan los camiones. Requiere rampas niveladoras mecánicas o hidráulicas para compensar la diferencia de altura con la plataforma del vehículo.</li>
        <li><strong>Zona de Recepción y Control de Calidad:</strong> Área de triaje donde se abren las tarimas, se cotejan los albaranes del transportista, se inspecciona el estado de los empaques y se colocan las etiquetas de código de barras internas.</li>
        <li><strong>Zona de Almacenamiento Masivo (Pulmón / Reserva):</strong> Racks pesados de varios niveles (paletización convencional o Drive-In) donde se guardan las tarimas completas que alimentarán las zonas de preparación.</li>
        <li><strong>Zona de Picking / Preparación de Pedidos:</strong> Estanterías bajas o dinámicas de fácil acceso peatonal donde los operarios recogen unidades sueltas para armar los pedidos de los clientes.</li>
        <li><strong>Zona de Consolidación, Embalaje y Despacho:</strong> Mesas de packing donde se verifican los pedidos con lectores láser, se embalan en cajas, se paletizan con film y se colocan en los andenes de salida listos para el camión de ruta.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-arrow-repeat text-primary me-2""></i>2. Flujo en 'U' vs Flujo en Línea Recta ('I')</h4>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h5 class=""fw-bold text-primary mb-2"">Flujo en Forma de 'U' (El Más Extendido)</h5>
                <p class=""small text-muted mb-0"">Los muelles de recepción y despacho se ubican en el <strong>mismo frente del edificio</strong>. Permite compartir el patio de maniobras de camiones, reutilizar los equipos de carga (montacargas) en ambas labores y facilita la supervisión centralizada de las operaciones.</p>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h5 class=""fw-bold text-success mb-2"">Flujo en Línea Recta ('I')</h5>
                <p class=""small text-muted mb-0"">La recepción está en un extremo del almacén y el despacho en el extremo opuesto. Se utiliza en plantas de producción o empresas con volúmenes gigantescos para evitar cualquier cruce o congestión de mercancía en un solo patio.</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-geo-alt-fill text-primary me-2""></i>3. Nomenclatura Estándar de Ubicaciones en Racks</h4>
    <p>Para que cualquier operario nuevo encuentre un tornillo en una bodega de 10.000 artículos en menos de 20 segundos, cada hueco del rack cuenta con una coordenada alfanumérica única (ej: <code>P04-M08-N03-P02</code>):</p>
    <ul>
        <li><code>P04</code> ➔ Pasillo número 4.</li>
        <li><code>M08</code> ➔ Módulo o tramo número 8 dentro de ese pasillo.</li>
        <li><code>N03</code> ➔ Nivel o altura 3 de la estantería (contando de abajo hacia arriba).</li>
        <li><code>P02</code> ➔ Posición 2 en la bandeja.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Ubicar productos de altísima rotación en el fondo del almacén:</strong> Los productos de mayor venta (Categoría A) deben ubicarse obligatoriamente lo más cerca posible de la zona de despacho para acortar los viajes diarios de los operarios.</li>
        <li><strong>Obstruir los pasillos de tránsito con mercancía 'temporal':</strong> Dejar tarimas apoyadas en los pasillos principales bloquea el paso de los montacargas y es la causa principal de accidentes por colisión y caídas de mercancía.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Están los pasillos y zonas operativas claramente señalizados con líneas amarillas en el piso?</li>
            <li>¿Ubicaste los productos de mayor rotación cerca de las zonas de consolidación y despacho?</li>
            <li>¿Cada ubicación en los racks cuenta con su etiqueta de código de barras visible y legible?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Técnicas de Picking y Packing: Preparación y Embalaje",
                            LessonTitle = "Picking por Olas, Lotes, Embalaje Seguro y Paletizado con Film",
                            Summary = "Domina la operativa de despacho: métodos de picking (pedido a pedido, por lotes, por zonas), uso de terminales de radiofrecuencia (RFID), técnicas de embalaje (packing) y paletizado con film estirable.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-box2-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Picking y Packing: El Corazón Operativo de la Logística</h5>
            <p class=""mb-0 small"">El picking representa más del 55% de los costos operativos totales de un almacén. Dominar las rutas de recolección y las técnicas de embalaje profesional evita roturas en el transporte y reclamos de clientes insatisfechos.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/C4VwS2_GtOc"" title=""¿Qué es el Picking y el Packing? Guía de Almacén"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Modalidades Avanzadas de Picking</h4>
    <p>Dependiendo del volumen de pedidos de la empresa, el jefe de almacén asigna la modalidad de recolección más eficiente:</p>
    <ul>
        <li><strong>Picking Pedido a Pedido (Discreto):</strong> El operario toma una sola orden de cliente, recorre el almacén recogiendo los artículos y regresa a la mesa de empaque. Es sencillo pero ineficiente para comercio electrónico de alta demanda.</li>
        <li><strong>Picking por Lotes (Batch Picking):</strong> El operario recoge simultáneamente los artículos de 10 o 15 pedidos distintos en un solo viaje por el pasillo (por ejemplo, recoge 40 unidades del artículo A en una sola parada). Posteriormente, en la mesa de consolidación, clasifica las unidades en los casilleros de cada cliente.</li>
        <li><strong>Picking por Zonas (Zone Picking):</strong> El almacén se divide en sectores (ej: Zona Refrigerada, Zona Químicos, Zona Secos). Cada operario permanece en su zona y recolecta únicamente los artículos de su área, pasando la caja al siguiente sector mediante fajas transportadoras (método <em>Pick and Pass</em>).</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-archive-fill text-primary me-2""></i>2. La Técnica Profesional del Packing y Paletizado con Film</h4>
    <p>Un mal embalaje provoca que el producto llegue aplastado o roto a manos del cliente. El auxiliar logístico debe aplicar las reglas de protección física:</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <h6 class=""fw-bold text-dark mb-2"">Protocolo de Paletizado Seguro (Pallet Wrapping)</h6>
        <ol class=""small mb-0"">
            <li><strong>Distribución del Peso:</strong> Colocar las cajas más pesadas y rígidas en la base de la tarima (pallet). Las cajas livianas y frágiles van arriba del todo. Nunca apilar mercancía en forma de pirámide; la carga debe formar un cubo perfecto.</li>
            <li><strong>Traba de Cajas (Patrón Entrelazado):</strong> Alternar el sentido de las cajas entre capa y capa (como los ladrillos de una pared) para que la tarima tenga estabilidad estructural y no se abra en las curvas del camión.</li>
            <li><strong>Aplicación de Film Estirable (Stretch Film):</strong> Amarrar el plástico a la base de madera de la tarima, dar 3 o 4 vueltas de tensión firme en la base, subir traslapando el plástico al 50% ejerciendo tensión constante, y rematar con 3 vueltas en la corona superior para blindar la carga contra humedad y polvo.</li>
        </ol>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-upc-scan text-success me-2""></i>3. Verificación con Lectores Láser de Radiofrecuencia (RF)</h4>
    <p>Para erradicar el error humano de entregar una talla equivocada o un producto diferente, el operario escanea con la terminal móvil (colector de datos) el código de barras de la ubicación en el rack, y luego el código EAN del producto. Si el operario toma el SKU incorrecto, el lector emite un pitido de advertencia en rojo bloqueando la pantalla hasta que tome el artículo correcto.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar espacios vacíos dentro de las cajas de despacho sin material de relleno:</strong> Si envías una caja con huecos de aire, al apilar otra caja encima durante el transporte, la caja inferior se aplastará dañando el producto. Rellena siempre los huecos con papel kraft, bolsas de aire o plástico de burbujas.</li>
        <li><strong>Permitir que las cajas sobresalgan del borde de la tarima de madera:</strong> Si las cajas sobresalen 5 cm fuera del borde del pallet (overhang), pierden más del 30% de su resistencia al apilamiento y sufrirán rasgaduras al rozar con otros pallets en el camión.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Escanéaste cada código de barras con el colector para validar SKU y cantidad?</li>
            <li>¿Apilaste las cajas pesadas abajo y trabaste las capas para evitar derrumbes?</li>
            <li>¿Aseguraste la carga con film estirable amarrado firmemente a la base de madera del pallet?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Seguridad Industrial, Ergonomía y Manejo de Cargas",
                            LessonTitle = "Uso de EPP, Levantamiento Seguro de Pesos y Convivencia con Montacargas",
                            Summary = "Protege tu salud y tu vida en el almacén: técnica ergonómica de levantamiento de cargas sin lesiones lumbares, uso obligatorio de EPP (casco, botas, chaleco) y normas de tránsito seguro con montacargas.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-shield-fill-exclamation fs-2 text-danger""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Seguridad Industrial: En el Almacén, el Cero Accidente es la Prioridad Absoluta</h5>
            <p class=""mb-0 small"">Un montacargas de 3 toneladas cargado con mercancía no frena en seco como un automóvil. La convivencia entre maquinaria pesada y operarios a pie exige respeto absoluto a las normas de tránsito, señalización y equipo de protección personal.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/mWyEEykWeTY"" title=""MANEJO MANUAL DE CARGAS Y SEGURIDAD INDUSTRIAL"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Equipo de Protección Personal (E.P.P.) Obligatorio</h4>
    <p>El ingreso a cualquier almacén formal exige portar el kit de bioseguridad y protección mecánica desde el primer minuto:</p>
    <ul>
        <li><strong>Botas de Seguridad con Puntera de Acero o Composite:</strong> Protegen los dedos de los pies ante la caída accidental de cajas pesadas o el impacto de transpaletas manuales. Suela antideslizante resistente a aceites.</li>
        <li><strong>Chaleco Reflectivo de Alta Visibilidad:</strong> Permite que los conductores de montacargas distingan a los peatones en pasillos oscuros o en cruces de muelle a más de 50 metros de distancia.</li>
        <li><strong>Casco de Seguridad (en zonas de racks de altura):</strong> Protege la cabeza contra la caída de objetos desprendidos desde niveles superiores de la estantería.</li>
        <li><strong>Guantes de Nitrilo o Descarne:</strong> Evitan cortes con bordes afilados de cartón, astillas de tarimas de madera y quemaduras por fricción con cuerdas.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-person-walking text-primary me-2""></i>2. Ergonomía: La Técnica del Levantamiento Seguro de Cargas</h4>
    <p>Las lesiones lumbares y hernias discales son la principal causa de incapacidad laboral en logística. Ocurren por doblar la cintura manteniendo las piernas rectas para levantar una caja del suelo (lo que multiplica la presión en las vértebras por diez):</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <h6 class=""fw-bold text-dark mb-2"">Los 5 Pasos del Levantamiento Ergonómico</h6>
        <ol class=""small mb-0"">
            <li><strong>Separar los pies:</strong> Colocar los pies a la anchura de los hombros, con un pie ligeramente adelantado para mantener una base de apoyo sólida.</li>
            <li><strong>Flexionar las rodillas:</strong> Bajar el cuerpo doblando las rodillas en cuclillas, manteniendo la <strong>espalda recta</strong> en todo momento.</li>
            <li><strong>Pegar la carga al cuerpo:</strong> Abrazar la caja y mantenerla pegada al pecho; cuanto más alejes la carga del cuerpo, más se multiplica el esfuerzo en los lumbares.</li>
            <li><strong>Levantar con la fuerza de las piernas:</strong> Levantarse estirando las piernas (los músculos de los muslos y glúteos son los más fuertes del cuerpo humano; ellos deben hacer el trabajo, no tu columna).</li>
            <li><strong>Girar con los pies, nunca con la cintura:</strong> Si necesitas cambiar de dirección con la carga en brazos, mueve los pies; nunca tuerzas el torso mientras sostienes peso.</li>
        </ol>
    </div>
    <p class=""small text-muted""><em>Límites de Carga de la OIT (Organización Internacional del Trabajo):</em> Un operario varón no debe levantar manualmente más de <strong>25 kg</strong> de forma individual (15 kg para mujeres o trabajadores jóvenes). Cualquier bulto que supere ese peso exige levantamiento entre dos personas o el uso de ayudas mecánicas (transpaleta o carretilla).</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-truck-front text-danger me-2""></i>3. Reglas de Convivencia con Montacargas (Forklifts)</h4>
    <ul>
        <li><strong>Regla de los 3 Metros:</strong> Todo peatón debe mantener una distancia de seguridad de al menos 3 metros alrededor de un montacargas en movimiento.</li>
        <li><strong>Contacto Visual Obligatorio:</strong> Nunca asumas que el montacarguista te ha visto. Establece contacto visual directo y espera a que el operador detenga el vehículo y te haga una señal con la mano antes de cruzar su pasillo.</li>
        <li><strong>Uso Exclusivo de Pasarelas Peatonales:</strong> Caminar estrictamente por los pasillos peatonales demarcados en verde o amarillo, respetando los espejos parabólicos ciegos en los cruces de esquinas.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Utilizar tarimas de madera rotas o rajadas:</strong> Una tarima con tablas fracturadas puede colapsar al levantarla con el montacargas a 6 metros de altura, arrojando una tonelada de peso sobre el pasillo. Las tarimas en mal estado deben desecharse de inmediato.</li>
        <li><strong>Subirse a las uñas de un montacargas o a una transpaleta para alcanzar cajas altas:</strong> Está terminantemente prohibido por las normas internacionales OSHA. Para trabajos en altura se deben utilizar escaleras con barandas de seguridad o plataformas elevadoras certificadas.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Portas tu equipo de protección personal (botas de seguridad y chaleco reflectivo)?</li>
            <li>¿Flexionas las rodillas y mantienes la espalda recta al levantar cajas del piso?</li>
            <li>¿Respetas los límites de peso de 25 kg y pides ayuda para cargas voluminosas?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Metodología 5S en Almacenes y Control de Merma",
                            LessonTitle = "Clasificar, Ordenar, Limpiar, Estandarizar y Disciplina en Bodega",
                            Summary = "Aplica la metodología japonesa de calidad total 5S en la bodega: Seiri (Descarte), Seiton (Orden), Seiso (Limpieza), Seiketsu (Estandarización) y Shitsuke (Disciplina y Auditorías periódicas).",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-check-circle-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Metodología 5S: La Base de la Productividad Japonesa</h5>
            <p class=""mb-0 small"">Un almacén desordenado, sucio y con herramientas tiradas en el piso es la antesala de pérdidas millonarias y accidentes laborales. Las 5S transforman el caos en un entorno de trabajo limpio, seguro y ultraeficiente.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/7qLRjtCFpig"" title=""METODOLOGIA 5S - EXPLICADA EN 1 MINUTO"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Los Cinco Pilares de las 5S en la Bodega</h4>
    <p>Desarrollada por Toyota en Japón, la metodología <strong>5S</strong> se implementa en secuencia rigurosa:</p>
    <div class=""row g-2 mb-4"">
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>1. Seiri (Clasificar)</strong><br /><span class=""text-muted"">Separar lo necesario de lo innecesario y desechar lo inservible.</span></div></div>
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>2. Seiton (Ordenar)</strong><br /><span class=""text-muted"">Un lugar para cada cosa y cada cosa en su lugar.</span></div></div>
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>3. Seiso (Limpiar)</strong><br /><span class=""text-muted"">Limpiar e inspeccionar para detectar fugas y daños a tiempo.</span></div></div>
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>4. Seiketsu (Estandarizar)</strong><br /><span class=""text-muted"">Crear protocolos visuales y listas de chequeo diarias.</span></div></div>
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>5. Shitsuke (Disciplina)</strong><br /><span class=""text-muted"">Hacer del orden un hábito voluntario mediante auditorías.</span></div></div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-tag-fill text-danger me-2""></i>2. La Campaña de Tarjetas Rojas (Red Tag Campaign)</h4>
    <p>Para iniciar la primera S (Seiri), el equipo recorre el almacén pegando una <strong>Tarjeta Roja</strong> a cualquier objeto sospechoso de ser inútil (cajas rotas, herramientas viejas, tarimas rajadas, repuestos obsoletos de máquinas dadas de baja):</p>
    <ul>
        <li>Todo objeto marcado se traslada a la <em>'Zona de Cuarentena de Tarjetas Rojas'</em> durante 15 días.</li>
        <li>Si en ese lapso ningún departamento reclama el objeto con justificación técnica, se procede a su descarte formal, donación o venta como chatarra, liberando valiosos metros cuadrados en la bodega.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-tools text-primary me-2""></i>3. Gestión Visual y Paneles Sombra (Shadow Boards)</h4>
    <p>Para la segunda S (Seiton), el almacén aplica el principio de <strong>Gestión Visual</strong>:</p>
    <ul>
        <li><strong>Paneles Sombra:</strong> Paneles metálicos de herramientas donde está pintada la silueta exacta de cada llave, cutter o cinta. Si falta un instrumento, el hueco vacío avisa de inmediato a todo el equipo qué herramienta no ha sido devuelta a su sitio.</li>
        <li><strong>Líneas de Aparcamiento para Maquinaria:</strong> Zonas delimitadas en el suelo para estacionar transpaletas y cargadores de baterías al final del turno.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir Limpieza con una Jornada de Aseo Aislada:</strong> Hacer una limpieza profunda una vez al año antes de la auditoría y dejar que el desorden regrese a la semana siguiente no es aplicar 5S. Las 5S son un estándar diario que se mantiene dedicando los últimos 10 minutos de cada turno a dejar el puesto impecable.</li>
        <li><strong>Falta de Auditorías Periódicas con Puntaje:</strong> Si no se realizan auditorías semanales con una lista de chequeo y un puntaje público exhibido en la cartelera del almacén, el personal perderá el compromiso con el mantenimiento del orden.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Eliminaste del almacén objetos obsoletos mediante la campaña de tarjetas rojas?</li>
            <li>¿Regresas las herramientas a su silueta designada en el panel sombra al finalizar la tarea?</li>
            <li>¿Dedicas los últimos 10 minutos del turno a limpiar y ordenar tu estación de trabajo?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = 
'@ + $qAlmacen + @'
                },

                // =========================================================================
                // 4. GESTIÓN DE PROYECTOS CON AGILE Y SCRUM
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "gestion-proyectos-agile",
                    Title = "Gestión de Proyectos con Agile y Scrum: Sprints, Roles y Tableros Kanban",
                    CategorySlug = "administracion-procesos-reportes",
                    ShortDescription = "Domina la gestión moderna de proyectos: Manifiesto Ágil, el Framework Scrum (Sprints, ceremonias y artefactos), roles (PO, SM) y tableros visuales Kanban con límites WIP.",
                    FullDescription = "Capacitación integral en metodologías ágiles demandada en industrias tecnológicas, financieras y de consultoría. Comprende la superación del modelo tradicional en Cascada (Waterfall); domina los roles en Scrum (Product Owner, Scrum Master y Desarrolladores); lidera las cuatro ceremonias (Sprint Planning, Daily, Sprint Review y Retrospectiva); gestiona el Product Backlog; e implementa tableros Kanban controlando el trabajo en curso (WIP).",
                    Level = "Intermedio",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Fundamentos de Agilidad y el Manifiesto Ágil",
                            LessonTitle = "De la Rigidez de Cascada (Waterfall) a la Flexibilidad Adaptativa",
                            Summary = "Comprende la evolución de la gestión de proyectos: por qué fracasa el modelo tradicional en Cascada en entornos volátiles, los 4 valores y 12 principios del Manifiesto Ágil de 2001.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-arrow-repeat fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Agile: Responder al Cambio por Encima de Seguir un Plan Ciego</h5>
            <p class=""mb-0 small"">En el mundo moderno (entorno VICA: Volátil, Incierto, Complejo y Ambiguo), intentar planificar al milímetro un proyecto de dos años en un diagrama de Gantt estático garantiza entregar un producto que el cliente ya no necesita. La agilidad permite entregar valor incremental cada dos semanas.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/PozisugkXto"" title=""¿Qué es Scrum y Metodologías Ágiles? La mejor explicación"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. El Fracaso del Modelo en Cascada (Waterfall) en Proyectos Complejos</h4>
    <p>El enfoque tradicional de gestión de proyectos (<strong>Waterfall o Cascada</strong>) fue heredado de la industria de la construcción pesada: primero se redactan 500 páginas de requisitos durante 4 meses, luego se diseña durante 6 meses, luego se construye durante un año, y solo al final de los dos años el cliente puede ver el producto terminado.</p>
    <p>Si durante esos dos años la competencia lanzó una tecnología mejor, o las leyes cambiaron, o las necesidades del usuario variaron, el proyecto fracasa por completo tras haber quemado millones de dólares. Por el contrario, las <strong>Metodologías Ágiles</strong> descomponen el proyecto en iteraciones cortas de 1 a 4 semanas, entregando un <em>Incremento de Producto Funcional</em> al final de cada ciclo para recibir retroalimentación inmediata del mercado.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-file-text-fill text-primary me-2""></i>2. Los 4 Valores Fundamentales del Manifiesto Ágil (2001)</h4>
    <p>Firmado por 17 líderes del desarrollo de software en Snowbird, Utah, el <strong>Manifiesto Ágil</strong> declara que, aunque valoramos los elementos de la derecha, valoramos mucho más los elementos de la izquierda:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-primary mb-2"">Valor 1</span>
                <h6 class=""fw-bold text-dark mb-1"">Individuos e Interacciones sobre Procesos y Herramientas</h6>
                <p class=""small text-muted mb-0"">Tener el software de gestión de proyectos más caro del mundo no sirve de nada si las personas del equipo no conversan abierta y transparentemente todos los días.</p>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-success mb-2"">Valor 2</span>
                <h6 class=""fw-bold text-dark mb-1"">Software Funcional sobre Documentación Exhaustiva</h6>
                <p class=""small text-muted mb-0"">Es infinitamente más valioso entregar una versión funcional que el cliente pueda probar hoy, que entregar manuales de especificaciones teóricas de 200 páginas que nadie leerá.</p>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-warning text-dark mb-2"">Valor 3</span>
                <h6 class=""fw-bold text-dark mb-1"">Colaboración con el Cliente sobre Negociación Contractual</h6>
                <p class=""small text-muted mb-0"">En lugar de pelear en tribunales por cláusulas rígidas pactadas hace un año, trabajamos como socios con el cliente para adaptar el producto a su verdadero éxito comercial.</p>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-danger mb-2"">Valor 4</span>
                <h6 class=""fw-bold text-dark mb-1"">Respuesta ante el Cambio sobre Seguir un Plan</h6>
                <p class=""small text-muted mb-0"">El plan es una guía inicial, no una camisa de fuerza. La capacidad de pivotar y ajustar la dirección con agilidad es la mayor ventaja competitiva moderna.</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir Agilidad con Falta de Planificación o Desorden:</strong> Ser ágil no significa 'no planificar nada e ir improvisando sobre la marcha'. Scrum es un marco extremadamente disciplinado con reglas, ceremonias y métricas de rendimiento rigurosas.</li>
        <li><strong>'Hacer' Agile sin 'Ser' Agile (Agile Cosmético):</strong> Pintar tableros con notas adhesivas de colores en la pared pero seguir manteniendo una cultura autoritaria donde los jefes imponen plazos irreales sin escuchar al equipo técnico es una simulación inútil.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Priorizas la entrega de incrementos funcionales periódicos para recibir retroalimentación temprana?</li>
            <li>¿Fomentas la conversación directa y la colaboración por encima de la burocracia documental?</li>
            <li>¿Aceptas los cambios en los requisitos del cliente como una oportunidad de mejora competitiva?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: El Framework Scrum: Sprints, Ceremonias y Artefactos",
                            LessonTitle = "La Cadencia del Sprint: Planning, Daily, Review y Retrospectiva",
                            Summary = "Domina el ciclo de vida de Scrum: la caja de tiempo del Sprint (1 a 4 semanas), el Product Backlog, Sprint Backlog, la reunión diaria (Daily de 15 minutos), la Review con stakeholders y la Retrospectiva.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-stopwatch-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Scrum: El Ritmo Cardíaco del Desarrollo Ágil</h5>
            <p class=""mb-0 small"">Scrum no es un proceso pesado; es un marco liviano que ayuda a personas, equipos y organizaciones a generar valor a través de soluciones adaptativas para problemas complejos mediante inspección y adaptación constante.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/X7gh07V6aKo"" title=""El Framework Scrum: Sprints, Ceremonias y Artefactos"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. El Sprint como Contenedor Temporal (Timebox)</h4>
    <p>En Scrum, todo el trabajo ocurre dentro de un <strong>Sprint</strong>: una caja de tiempo de duración fija (generalmente de <strong>2 semanas</strong>) que se repite de forma ininterrumpida. Un nuevo Sprint comienza inmediatamente después de la conclusión del Sprint anterior.</p>
    <p>Durante el Sprint no se realizan cambios que pongan en peligro el <em>Sprint Goal (Objetivo del Sprint)</em>, asegurando que el equipo pueda concentrarse sin interrupciones externas.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-calendar-event text-primary me-2""></i>2. Las 4 Ceremonias Oficiales de Scrum</h4>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Evento / Ceremonia</th>
                    <th>¿Cuándo ocurre y Duración?</th>
                    <th>Propósito Central</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-primary"">1. Sprint Planning</td>
                    <td>Al inicio del Sprint (máximo 4 horas para un Sprint de 2 semanas).</td>
                    <td>Responder: ¿Por qué es valioso este Sprint (Sprint Goal)? ¿Qué se puede entregar? y ¿Cómo se realizará el trabajo técnico?</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-success"">2. Daily Scrum (Reunión Diaria)</td>
                    <td>Todos los días a la misma hora (estrictamente <strong>15 minutos</strong> de pie).</td>
                    <td>Inspeccionar el progreso hacia el Sprint Goal y coordinar el plan del día respondiendo los 3 puntos: Qué hice ayer, qué haré hoy y qué impedimentos bloquean mi trabajo.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-warning text-dark"">3. Sprint Review</td>
                    <td>Al final del Sprint con los clientes e interesados (Stakeholders).</td>
                    <td>Demostrar en vivo el Incremento de producto terminado funcional y recibir retroalimentación para adaptar el Product Backlog.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-danger"">4. Sprint Retrospective</td>
                    <td>Al concluir la Review, antes de iniciar el nuevo Sprint.</td>
                    <td><strong>Inspección interna del equipo:</strong> ¿Qué funcionó bien? ¿Qué falló en nuestros procesos o relaciones? y ¿Qué mejora concreta implementaremos en el próximo Sprint?</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-box text-primary me-2""></i>3. Los 3 Artefactos de Scrum y sus Compromisos</h4>
    <ul>
        <li><strong>Product Backlog:</strong> La lista ordenada y viva de todo lo que se necesita en el producto. Su compromiso es el <strong>Product Goal (Objetivo del Producto)</strong>.</li>
        <li><strong>Sprint Backlog:</strong> El conjunto de elementos del Product Backlog seleccionados para el Sprint actual junto con el plan para entregarlos. Su compromiso es el <strong>Sprint Goal</strong>.</li>
        <li><strong>Incremento:</strong> El peldaño concreto hacia el Objetivo del Producto. Debe cumplir estrictamente la <strong>Definición de Terminado (Definition of Done - DoD)</strong>: probado, documentado y listo para ponerse en producción.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Convertir la Daily en una sesión de reporte de estatus al jefe:</strong> La Daily no es para rendir cuentas al Scrum Master o al gerente; es una conversación entre los propios desarrolladores para sincronizar sus tareas y resolver bloqueos mutuos.</li>
        <li><strong>Saltarse la Retrospectiva por 'falta de tiempo':</strong> Omitir la retrospectiva condena al equipo a repetir los mismos errores y frustraciones técnicas Sprint tras Sprint, bloqueando la mejora continua.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Respetas la duración de 15 minutos de la Daily manteniéndola enfocada en bloqueos?</li>
            <li>¿Definiste un Sprint Goal claro que oriente el esfuerzo del equipo durante las dos semanas?</li>
            <li>¿Cumple cada elemento entregado con la Definición de Terminado (Definition of Done)?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Roles en Scrum: Product Owner, Scrum Master y Developers",
                            LessonTitle = "La Tríada de la Responsabilidad sin Jefes Tradicionales",
                            Summary = "Comprende la estructura de roles en Scrum: el Product Owner (maximiza el valor del negocio), el Scrum Master (líder servicial que remueve impedimentos) y los Developers multidisciplinarios y autoorganizados.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-people-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Scrum no tiene Jefes de Proyecto: Tiene Equipos Autoorganizados</h5>
            <p class=""mb-0 small"">En Scrum desaparece la figura autoritaria del 'Project Manager' que microgestiona tareas individuales. La responsabilidad se distribuye en una tríada equilibrada: Negocio (PO), Proceso (SM) y Calidad Técnica (Equipo de Desarrollo).</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/yRmK3iWA_r0"" title=""Roles en Scrum: Product Owner, Scrum Master y Developers"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Tríada Oficial de Roles en el Scrum Team</h4>
    <p>Un <strong>Scrum Team</strong> está conformado por un máximo recomendado de 10 personas para mantener la comunicación fluida, y consta de tres responsabilidades específicas:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-primary mb-2"">Product Owner (PO)</span>
                <h6 class=""fw-bold text-dark mb-1"">La Voz del Negocio y del Cliente</h6>
                <p class=""small text-muted mb-0"">Responsable de <strong>maximizar el valor del producto</strong> resultante del trabajo del equipo. Gestiona, prioriza y ordena el Product Backlog. Decide qué se construye primero según el impacto financiero y comercial.</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-success mb-2"">Scrum Master (SM)</span>
                <h6 class=""fw-bold text-dark mb-1"">El Líder Servicial y Facilitador</h6>
                <p class=""small text-muted mb-0"">Responsable de <strong>establecer Scrum según la Guía oficial</strong>. Ayuda al equipo a enfocarse en la entrega de valor, facilita las ceremonias y actúa como un escudo protector eliminando impedimentos externos que bloqueen al equipo.</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-warning text-dark mb-2"">Developers (Desarrolladores)</span>
                <h6 class=""fw-bold text-dark mb-1"">Los Creadores del Incremento</h6>
                <p class=""small text-muted mb-0"">Los profesionales técnicos (programadores, diseñadores UX, evaluadores QA, analistas) que ejecutan el trabajo. Son <strong>autoorganizados y multifuncionales</strong>: nadie les dice técnicamente cómo construir las soluciones.</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shield-check text-primary me-2""></i>2. La Remoción de Impedimentos por el Scrum Master</h4>
    <p>Si durante la reunión diaria un desarrollador reporta: <em>'No puedo probar el módulo porque el departamento de redes no me ha dado acceso al servidor de pruebas y llevo dos días esperando'</em>:</p>
    <ul>
        <li>El desarrollador no debe perder su tiempo lidiando con la burocracia de la empresa.</li>
        <li>El <strong>Scrum Master</strong> asume de inmediato la gestión del impedimento: se reúne con el gerente de redes, gestiona los permisos y desbloquea el camino para que el equipo pueda continuar trabajando sin demoras.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>El Product Owner que actúa como Scrum Master a la vez:</strong> Ambos roles tienen un conflicto de interés intrínseco. El PO empuja por maximizar el alcance y la velocidad para el negocio; el SM cuida el ritmo sostenible de trabajo y la salud mental del equipo. Fusionar ambos roles provoca sobreexplotación y código de mala calidad.</li>
        <li><strong>Un Product Owner sin autoridad real para tomar decisiones:</strong> Si para cada cambio de prioridad el PO debe pedir permiso a un comité superior de 5 directores, el equipo se paralizará y se perderá toda la velocidad ágil.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Tiene el Product Owner autonomía total para ordenar el Backlog según el valor de negocio?</li>
            <li>¿Actúa el Scrum Master como líder servicial removiendo impedimentos burocráticos?</li>
            <li>¿Es el equipo de desarrollo multifuncional capaz de llevar una tarea desde el diseño hasta producción?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Tableros Kanban, Límites WIP y Métricas de Flujo",
                            LessonTitle = "Gestión Visual del Flujo: To Do, In Progress, Done y Límites WIP",
                            Summary = "Optimiza la entrega continua con Kanban: las 6 prácticas esenciales, configuración de columnas de flujo, establecimiento de límites de trabajo en curso (WIP Limits), y medición de Lead Time y Cycle Time.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-kanban-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Kanban: Dejar de Empezar y Comenzar a Terminar</h5>
            <p class=""mb-0 small"">El mal endémico de los equipos de oficina es la multitarea descontrolada: tener 20 proyectos empezados al mismo tiempo y ninguno terminado. Kanban limita el trabajo en curso (WIP) para destrabar el flujo y acelerar las entregas.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/B-uwQg7RgH8"" title=""Tableros Kanban y Límites WIP explicados fácil"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. ¿Qué es Kanban y Cuáles son sus Prácticas Clave?</h4>
    <p>Originado en las fábricas de manufactura de Toyota y adaptado al trabajo de oficina por David J. Anderson, <strong>Kanban</strong> (que en japonés significa <em>'tarjeta visual'</em>) es un método para gestionar el flujo de trabajo respetando 6 prácticas fundamentales:</p>
    <ol>
        <li><strong>Visualizar el Flujo de Trabajo:</strong> Mapear en un tablero físico o digital (Jira, Trello, Asana) las etapas por las que atraviesa una tarea.</li>
        <li><strong>Limitar el Trabajo en Curso (WIP - Work In Progress):</strong> Fijar un límite máximo estricto de tarjetas permitidas simultáneamente en cada columna.</li>
        <li><strong>Gestionar el Flujo:</strong> Monitorear cuellos de botella donde las tareas se acumulan atascadas.</li>
        <li><strong>Hacer Explícitas las Políticas del Proceso:</strong> Dejar claro bajo qué criterios exactos una tarea puede moverse a la columna siguiente (Definition of Done).</li>
        <li><strong>Implementar Bucles de Retroalimentación:</strong> Reuniones breves de sincronización frente al tablero.</li>
        <li><strong>Mejorar Colaborativamente (Kaizen):</strong> Optimizar el proceso continuamente mediante datos empíricos.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-slash-circle-fill text-danger me-2""></i>2. El Poder de los Límites WIP (Work In Progress)</h4>
    <p>El corazón de Kanban reside en colocar un número encima de las columnas activas (ej: <code>En Progreso [WIP: 3]</code>):</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <p class=""small mb-0"">
            Si el límite de la columna <em>'En Revisión'</em> es <strong>2</strong> y ya hay dos tareas allí, <strong>está terminantemente prohibido que nadie empiece una tarea nueva</strong> del Backlog. Los miembros del equipo deben abocarse a ayudar al compañero a destrabar y revisar las dos tareas acumuladas para que pasen a <em>'Terminado'</em> antes de poder tomar trabajo nuevo.<br />
            <strong>El principio supremo:</strong> <em>'Stop Starting, Start Finishing' (Deja de empezar cosas nuevas y empieza a terminar las que ya están en curso).</em>
        </p>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-speedometer2 text-primary me-2""></i>3. Métricas de Rendimiento en Kanban: Lead Time vs Cycle Time</h4>
    <p>Para medir la agilidad del equipo de forma científica se utilizan dos cronómetros:</p>
    <ul>
        <li><strong>Lead Time (Tiempo de Entrega):</strong> El tiempo total transcurrido desde que el cliente solicita el requerimiento hasta que el producto está terminado y funcionando en sus manos. Mide la experiencia del cliente.</li>
        <li><strong>Cycle Time (Tiempo de Ciclo):</strong> El tiempo que el equipo tarda efectivamente trabajando en la tarea desde que pasa de 'Por Hacer' a 'En Progreso' hasta que llega a 'Terminado'. Mide la eficiencia interna del equipo técnico.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Tratar el tablero Kanban como un simple adorno sin respetar los límites WIP:</strong> Si tienes 15 tareas en la columna 'En Progreso' con un equipo de 4 personas, no estás usando Kanban; solo tienes un tablero de desorden visual. Los límites WIP deben respetarse con rigor absoluto.</li>
        <li><strong>Mover tareas hacia atrás en el tablero:</strong> En Kanban el flujo siempre se mueve hacia adelante de izquierda a derecha. Si una tarea en revisión tiene un error, no se devuelve a 'Por Hacer'; se le coloca una etiqueta roja de bloqueo y se resuelve prioritariamente en la misma columna.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Configuraste límites de trabajo en curso (WIP) en tus columnas activas?</li>
            <li>¿Priorizas destrabar cuellos de botella antes de iniciar tareas nuevas?</li>
            <li>¿Mides periódicamente el Lead Time y Cycle Time para optimizar tus tiempos de entrega?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = 
'@ + $qAgile + @'
                },

                // =========================================================================
                // 5. PLANIFICACIÓN ESTRATÉGICA CON FODA Y OKRs
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "planificacion-estrategica",
                    Title = "Planificación Estratégica: De la Visión a la Ejecución con OKRs y Cuadro de Mando",
                    CategorySlug = "administracion-procesos-reportes",
                    ShortDescription = "El puente entre la teoría y los resultados: Diagnóstico FODA y PESTEL, diseño de Objetivos y Resultados Clave (OKRs), Cuadro de Mando Integral (BSC) y cadencia de ejecución.",
                    FullDescription = "Capacitación de nivel directivo para gerentes, supervisores y emprendedores. Domina el diagnóstico estratégico mediante matrices FODA cruzadas y análisis del macroentorno PESTEL; implementa la metodología OKR (Objectives and Key Results) utilizada por Google e Intel para alinear a toda la empresa hacia metas ambiciosas; estructura el Cuadro de Mando Integral (Balanced Scorecard) en sus 4 perspectivas; y lidera revisiones periódicas de rendición de cuentas.",
                    Level = "Avanzado",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Diagnóstico Estratégico: Matrices FODA y Análisis PESTEL",
                            LessonTitle = "Auditoría Interna y del Macroentorno para Identificar Oportunidades Reales",
                            Summary = "Domina el diagnóstico de negocio: matriz FODA cruzada (estrategias FO, FA, DO, DA) y análisis del macroentorno PESTEL (Político, Económico, Social, Tecnológico, Ecológico y Legal).",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-compass-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Estrategia es el Arte de Elegir qué NO Hacer</h5>
            <p class=""mb-0 small"">Toda empresa dispone de recursos limitados (tiempo, talento y capital financiero). La planificación estratégica analiza con frialdad el entorno para apostar los recursos en las batallas comerciales donde la organización tiene ventajas competitivas reales.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/PHWo40WdzZo"" title=""¿Qué es el Análisis FODA y cómo realizarlo? Economía de la Empresa"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Matriz F.O.D.A. (SWOT) Cruzada</h4>
    <p>El error más habitual es llenar una cuadrícula de FODA con cuatro listas de palabras y archivarla en una gaveta. Una <strong>Matriz FODA Cruzada</strong> conecta los factores internos con los factores externos para generar planes de acción estratégicos concretos:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Estrategia Cruzada</th>
                    <th>Cruce de Factores</th>
                    <th>Objetivo Estratégico</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-success"">Estrategias FO (Ofensivas)</td>
                    <td>Fortalezas Internas + Oportunidades Externas</td>
                    <td><strong>Atacar y Crecer:</strong> Utilizar las ventajas competitivas de la empresa para conquistar nuevos mercados o lanzar productos aprovechando la coyuntura favorable.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-primary"">Estrategias DO (Reorientación)</td>
                    <td>Debilidades Internas + Oportunidades Externas</td>
                    <td><strong>Superar Limitaciones:</strong> Aprovechar una oportunidad de mercado para corregir una debilidad interna (ej: asociarse con un socio logístico para suplir la falta de flota propia).</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-warning text-dark"">Estrategias FA (Defensivas)</td>
                    <td>Fortalezas Internas + Amenazas Externas</td>
                    <td><strong>Blindarse:</strong> Utilizar la solidez de la marca o la liquidez financiera para resistir la llegada de un competidor extranjero agresivo.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-danger"">Estrategias DA (Supervivencia)</td>
                    <td>Debilidades Internas + Amenazas Externas</td>
                    <td><strong>Minimizar Daños:</strong> Reducir costos, fusionar áreas o abandonar líneas de producto no rentables para evitar la quiebra en un entorno de crisis.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-globe-americas text-primary me-2""></i>2. El Marco PESTEL para Analizar el Macroentorno</h4>
    <p>Una empresa no opera en el vacío. El análisis <strong>P.E.S.T.E.L.</strong> evalúa las 6 fuerzas externas que la organización no puede controlar pero a las que debe adaptarse obligatoriamente:</p>
    <ul>
        <li><strong>Político:</strong> Estabilidad gubernamental, políticas arancelarias y acuerdos comerciales internacionales.</li>
        <li><strong>Económico:</strong> Tasas de inflación, paridad cambiaria de divisas, tasas de interés bancarias y poder adquisitivo real del consumidor.</li>
        <li><strong>Social:</strong> Cambios demográficos, hábitos de consumo saludable y preferencias culturales de las nuevas generaciones.</li>
        <li><strong>Tecnológico:</strong> Avances en inteligencia artificial, penetración del comercio electrónico y automatización de procesos.</li>
        <li><strong>Ecológico / Ambiental:</strong> Regulaciones de huella de carbono, cambio climático y reciclaje de empaques.</li>
        <li><strong>Legal:</strong> Normativas laborales, leyes de protección al consumidor y reformas tributarias.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir Factores Internos con Externos:</strong> Las Fortalezas y Debilidades son 100% <em>internas</em> (la empresa puede cambiarlas: equipo humano, calidad del producto, tecnología). Las Oportunidades y Amenazas son 100% <em>externas</em> (el mercado las impone: inflación, leyes, competencia).</li>
        <li><strong>Redactar un FODA basado en ilusiones en lugar de datos auditados:</strong> Poner como fortaleza 'tenemos excelente servicio al cliente' cuando las encuestas reales de satisfacción muestran un 30% de quejas es un autoengaño que destruye la validez del plan.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Construiste la matriz cruzada (FO, DO, FA, DA) con acciones concretas?</li>
            <li>¿Auditaste las 6 dimensiones del análisis PESTEL para anticipar riesgos externos?</li>
            <li>¿Respaldaste cada fortaleza y debilidad con métricas cuantitativas auditadas?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: De la Visión a los Objetivos: El Framework OKR (Objectives and Key Results)",
                            LessonTitle = "Cómo Google, Intel y las Empresas Líderes Alinean sus Metas Ambiciosas",
                            Summary = "Domina el sistema de metas OKR de Andy Grove y John Doerr: diferencia entre Objetivos cualitativos inspiradores y Resultados Clave (KR) cuantitativos, cadencia trimestral y alineación vertical.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-bullseye fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">OKRs: La Metodología que Hizo Escalar a Google de 40 a 100.000 Empleados</h5>
            <p class=""mb-0 small"">Los objetivos tradicionales de año nuevo quedan en el olvido en febrero. El framework OKR (Objectives and Key Results) conecta la visión a largo plazo con resultados medibles trimestrales que alinean a toda la empresa hacia el mismo norte.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/kNOfOmjgOik"" title=""Qué son los OKRs y cómo usarlos en tu negocio"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Fórmula Sagrada de un OKR: John Doerr</h4>
    <p>Creado por Andy Grove en Intel y popularizado por John Doerr en Google, un <strong>OKR</strong> se redacta siguiendo una fórmula estricta:</p>
    <div class=""p-3 bg-light rounded border text-center my-3"">
        <span class=""fs-6 fw-bold text-primary"">""Nosotros lograremos [OBJETIVO CUALITATIVO], medido por [RESULTADOS CLAVE CUANTITATIVOS].""</span>
    </div>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h5 class=""fw-bold text-primary mb-2"">El Objetivo (Objective - O)</h5>
                <p class=""small text-muted mb-0""><strong>¿Hacia dónde queremos ir?</strong> Debe ser cualitativo, inspirador, ambicioso y fácil de memorizar por cualquier empleado. No contiene números ni porcentajes (ej: <em>'Convertirnos en la plataforma de compras online preferida por su velocidad de entrega en Caracas'</em>).</p>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h5 class=""fw-bold text-success mb-2"">Los Resultados Clave (Key Results - KRs)</h5>
                <p class=""small text-muted mb-0""><strong>¿Cómo sabemos si estamos llegando?</strong> Son estrictamente cuantitativos, numéricos y con fecha límite. Cada Objetivo debe tener entre <strong>3 y 5 Resultados Clave</strong> medibles.</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-card-checklist text-primary me-2""></i>2. Ejemplo Real de un OKR Corporativo Trimestral</h4>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3 font-monospace small"">
        <strong>Objetivo (O):</strong> Lograr un nivel de excelencia y velocidad en atención postventa que enamore a los clientes.<br /><br />
        <strong>Resultados Clave (KRs):</strong><br />
        - <strong>KR 1:</strong> Reducir el tiempo promedio de respuesta inicial en WhatsApp de 45 minutos a <strong>menos de 3 minutos</strong>.<br />
        - <strong>KR 2:</strong> Aumentar el índice de satisfacción del cliente (CSAT) del 74% a más del <strong>92%</strong>.<br />
        - <strong>KR 3:</strong> Publicar un centro de ayuda en video resolviendo el 100% de las 10 preguntas más frecuentes de garantías.<br />
        - <strong>KR 4:</strong> Disminuir la tasa de reclamos por despacho tardío del 5% a <strong>menos del 1%</strong>.
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-arrow-down-up text-primary me-2""></i>3. Alineación Bidireccional: 50% Top-Down y 50% Bottom-Up</h4>
    <p>A diferencia de los viejos sistemas autoritarios donde la dirección imponía todas las metas desde arriba, en OKR:</p>
    <ul>
        <li>La Gerencia define los 2 o 3 <strong>OKRs de la Compañía</strong> para el año.</li>
        <li>Los equipos y departamentos proponen sus propios <strong>OKRs de Equipo</strong> trimestrales, decidiendo autónomamente cómo ellos van a contribuir a empujar los resultados clave de la empresa.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir Resultados Clave con Tareas o Pendientes (To-Do Lists):</strong> Un KR no es una actividad (ej: 'asistir a una reunión' no es un KR); un KR es un <em>impacto medible</em> (ej: 'aumentar las ventas en $20.000 USD' sí es un KR).</li>
        <li><strong>Vincular directamente los OKRs al bono salarial:</strong> Si el bono salarial del empleado depende al 100% de cumplir el OKR, el empleado elegirá metas fáciles y mediocres para no arriesgar su dinero. Los OKRs deben ser ambiciosos (Moonshots) donde alcanzar un 70% u 80% ya representa un éxito extraordinario.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Es tu Objetivo cualitativo, inspirador y retador para todo el equipo?</li>
            <li>¿Contiene cada Resultado Clave (KR) un número medible de partida y de meta final?</li>
            <li>¿Limitas los OKRs a máximo 3 objetivos por trimestre para asegurar enfoque y foco?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: El Cuadro de Mando Integral (Balanced Scorecard - BSC)",
                            LessonTitle = "Las Cuatro Perspectivas del Éxito Sostenible según Kaplan y Norton",
                            Summary = "Supera la visión puramente contable. Domina las 4 perspectivas del Balanced Scorecard: Financiera, Clientes, Procesos Internos, y Aprendizaje y Crecimiento, con mapas estratégicos de causa-efecto.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-pie-chart fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Balanced Scorecard: Mirar Hacia Adelante, no por el Espejo Retrovisor</h5>
            <p class=""mb-0 small"">Evaluar una empresa únicamente por sus balances contables es como conducir un automóvil mirando solo por el espejo retrovisor: ves por dónde pasaste en el pasado, pero no ves los obstáculos del camino que tienes enfrente. El Cuadro de Mando Integral mide los inductores del éxito futuro.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/rf0inv6xeAo"" title=""El Cuadro de Mando Integral - Balanced Scorecard"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Las Cuatro Perspectivas del Balanced Scorecard</h4>
    <p>Formulado por Robert Kaplan y David Norton en Harvard Business School, el <strong>Cuadro de Mando Integral (BSC)</strong> equilibra los resultados financieros de corto plazo con las capacidades humanas y de procesos que aseguran el futuro del negocio:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Perspectiva</th>
                    <th>Pregunta Estratégica Fundamental</th>
                    <th>Métricas e Indicadores Típicos (KPIs)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-danger"">1. Financiera</td>
                    <td>¿Cómo debemos aparecer ante nuestros accionistas para tener éxito financiero?</td>
                    <td>Retorno sobre la Inversión (ROI), Margen Operativo EBITDA, Crecimiento de Ingresos y Flujo de Caja Libre.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-primary"">2. Clientes / Mercado</td>
                    <td>¿Cómo debemos ser percibidos por los clientes para alcanzar nuestra visión?</td>
                    <td>Cuota de Mercado (Market Share), Índice de Recomendación Neta (NPS), Tasa de Retención y Costo de Adquisición.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-success"">3. Procesos Internos</td>
                    <td>¿En qué procesos de la cadena de valor debemos ser excelentes?</td>
                    <td>Tiempos de Ciclo de Fabricación/Despacho, Tasa de Defectos y Mermas, y Rotación de Inventarios.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-warning text-dark"">4. Aprendizaje y Crecimiento</td>
                    <td>¿Cómo mantendremos y desarrollaremos nuestra capacidad de cambio y mejora?</td>
                    <td>Horas de Capacitación por Empleado, Clima Laboral, Tasa de Rotación de Talento y Adopción de Nuevas Tecnologías.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-diagram-3 text-primary me-2""></i>2. El Mapa Estratégico de Causa y Efecto</h4>
    <p>El mayor aporte del BSC es demostrar que las 4 perspectivas están encadenadas lógicamente de abajo hacia arriba en una relación de <strong>Causa y Efecto</strong>:</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3 font-monospace small"">
        1. <strong>Si capacitamos al personal en el sistema ERP</strong> (Aprendizaje y Crecimiento)...<br />
        2. ➔ <strong>Los operarios cometerán menos errores y despacharán más rápido</strong> (Procesos Internos)...<br />
        3. ➔ <strong>Los clientes recibirán sus pedidos perfectos a tiempo y estarán felices</strong> (Clientes)...<br />
        4. ➔ <strong>Las ventas aumentarán y las utilidades para los accionistas se multiplicarán</strong> (Financiera).
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Tener más de 25 indicadores en el cuadro de mando:</strong> Un tablero con 80 métricas genera 'parálisis por análisis'. La metodología recomienda seleccionar entre 3 y 5 indicadores vitales por perspectiva (máximo 15 a 20 KPIs en total).</li>
        <li><strong>Redactar indicadores sin metas cuantitativas ni responsables asignados:</strong> Todo KPI debe tener una meta numérica concreta, un plazo límite y el nombre del líder de área responsable de su cumplimiento.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Equilibraste tus metas en las 4 perspectivas (Financiera, Clientes, Procesos y Talento)?</li>
            <li>¿Diseñaste el Mapa Estratégico mostrando las relaciones de causa-efecto entre áreas?</li>
            <li>¿Tiene cada indicador un valor actual, una meta esperada y un responsable con nombre?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Ejecución Estratégica, Gestión de Riesgos y Cadencia de Rendición de Cuentas",
                            LessonTitle = "Las 4 Disciplinas de la Ejecución (4DX) y Revisiones WBR/MBR",
                            Summary = "Supera el 'torbellino' del día a día: aplica el método 4DX (Metas Crucialmente Importantes, Medidas Predictivas, Tablero Conmovedor y Cadencia de Rendición de Cuentas) con reuniones WBR y MBR.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-fire fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Torbellino del Día a Día: El Asesino Número Uno de la Estrategia</h5>
            <p class=""mb-0 small"">El 90% de los planes estratégicos fracasan no porque la idea fuera mala, sino porque la urgencia cotidiana de apagar fuegos operativos, llamadas de clientes y correos urgentes absorbe el 100% de la energía del equipo, devorando la ejecución.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/dErErlA0hXU"" title=""Las 4 Disciplinas de la Ejecución (4DX) - Resumen Animado"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Las 4 Disciplinas de la Ejecución (Metodología 4DX)</h4>
    <p>Desarrollada por FranklinCovey (McChesney, Covey y Huling), la metodología <strong>4DX</strong> provee las cuatro reglas científicas para ejecutar la estrategia en medio del torbellino:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-primary mb-2"">Disciplina 1</span>
                <h6 class=""fw-bold text-dark mb-1"">Enfocarse en lo Crucialmente Importante (MCI)</h6>
                <p class=""small text-muted mb-0"">Identificar una o máximo dos metas donde el fracaso no es una opción. Fórmula: <em>'Llevar el indicador X de A hacia B para la fecha Z'</em>.</p>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-success mb-2"">Disciplina 2</span>
                <h6 class=""fw-bold text-dark mb-1"">Actuar sobre Medidas Predictivas (Lead Measures)</h6>
                <p class=""small text-muted mb-0"">Diferenciar medidas históricas (Lag: las ventas pasadas que ya no puedes cambiar) de medidas predictivas que el equipo puede controlar diariamente (Lead: llamadas comerciales y cotizaciones emitidas hoy).</p>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-warning text-dark mb-2"">Disciplina 3</span>
                <h6 class=""fw-bold text-dark mb-1"">Mantener un Tablero Conmovedor de Resultados</h6>
                <p class=""small text-muted mb-0"">Un marcador visual simple y público donde cualquier operario entienda en 5 segundos si el equipo está ganando o perdiendo el partido esta semana.</p>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-danger mb-2"">Disciplina 4</span>
                <h6 class=""fw-bold text-dark mb-1"">Crear una Cadencia de Rendición de Cuentas</h6>
                <p class=""small text-muted mb-0"">Una reunión semanal obligatoria de 20 minutos donde cada miembro del equipo rinde cuentas de los compromisos de la semana anterior y asume uno nuevo para la próxima.</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-calendar2-week-fill text-primary me-2""></i>2. Las Revisiones Operativas WBR y MBR</h4>
    <p>Las organizaciones globales como Amazon o Mercado Libre estructuran su gobierno corporativo mediante dos reuniones rítmicas:</p>
    <ul>
        <li><strong>WBR (Weekly Business Review):</strong> Reunión semanal de 60 minutos enfocada estrictamente en métricas operativas y medidas predictivas. Se analizan desviaciones y se corrigen antes de que termine el mes.</li>
        <li><strong>MBR (Monthly Business Review):</strong> Reunión mensual profunda con la dirección para revisar el estado financiero consolidado (EBITDA), el avance de los OKRs y el reajuste de inversiones.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Intentar cambiar 10 metas estratégicas a la vez:</strong> Si tienes 10 prioridades, en realidad no tienes ninguna. El cerebro humano y las organizaciones solo pueden mantener el enfoque de alto rendimiento en una o dos metas cruciales simultáneamente.</li>
        <li><strong>Permitir que la reunión semanal de rendición de cuentas se convierta en una sesión de quejas:</strong> La reunión semanal 4DX dura estrictamente 20 minutos y solo tiene tres partes: Rendir cuentas del compromiso pasado, revisar el tablero, y asumir el nuevo compromiso para la semana siguiente.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Definiste claramente tu Meta Crucialmente Importante (MCI) con la fórmula de A hacia B para Z?</li>
            <li>¿Mides semanalmente medidas predictivas que tu equipo puede influir directamente?</li>
            <li>¿Mantienes una cadencia semanal estricta de rendición de cuentas de 20 minutos?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = 
'@ + $qEstrategia + @'
                }
            };
        }
    }
}
'@

[System.IO.File]::WriteAllText($opsFile, $newCode, [System.Text.Encoding]::UTF8)
Write-Host "Updated CurriculumUpgrade.OperationsAdmin.cs successfully!"
