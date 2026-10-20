using CursosCertificadosApp.Models.Entities;

namespace CursosCertificadosApp.Data
{
    public static class CurriculumUpgradeCommercialRetail
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
                // 1. SAP BUSINESS ONE (SAP B1)
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "sap-business-one-b1-gestion-operativa",
                    Title = "SAP Business One (SAP B1): Gestión Operativa de Ventas, Compras e Inventarios",
                    CategorySlug = "ventas-comercio-retail",
                    ShortDescription = "Domina el ERP estándar mundial de las PYMES y medianas empresas: datos maestros, circuito completo de ventas (Order to Cash), compras (Procure to Pay) y control de stock.",
                    FullDescription = "Capacitación práctica orientada al manejo real de SAP Business One. Aprende a crear Socios de Negocios y Artículos; procesar ofertas de ventas, órdenes y entregas; gestionar solicitudes de compra, pedidos y entradas de mercancías (GRPO); emitir facturas legales y realizar recuentos físicos de inventario con análisis de diferencias.",
                    Level = "Intermedio",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Introducción a la Arquitectura SAP B1 y Datos Maestros",
                            LessonTitle = "Navegación en el Sistema, Socios de Negocios y Artículos",
                            Summary = "Conoce la arquitectura cliente-servidor de SAP B1, el menú de módulos, la barra de herramientas, la creación de Socios de Negocios (Clientes y Proveedores) y la configuración de Artículos con sus tres casillas maestras.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-database-fill-check fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">SAP Business One: El ERP Líder en las Empresas Medianas y Grandes</h5>
            <p class=""mb-0 small"">Aprender SAP B1 te abre las puertas a los mejores puestos administrativos y contables del mercado laboral. En SAP, la precisión de los datos maestros es la base que garantiza que las ventas, compras e inventarios fluyan sin descuadres.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/xSrstKkVhE0"" title=""Curso rápido de Navegación para SAP Business One"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Interfaz y Filosofía Operativa de SAP B1</h4>
    <p>A diferencia de programas contables básicos aislados, <strong>SAP Business One</strong> es un sistema ERP totalmente integrado. Cuando un usuario realiza una acción en un documento de ventas o compras, el sistema actualiza automáticamente el inventario en los almacenes correspondientes y genera el asiento contable en el libro mayor en tiempo real.</p>
    <p>Para navegar con agilidad en el sistema, todo operador debe dominar tres elementos clave:</p>
    <ul>
        <li><strong>La Flecha Amarilla de Enlace (Golden Arrow):</strong> Al lado de cualquier código de cliente, proveedor, artículo o número de documento contable, aparece una pequeña flecha naranja/amarilla. Al hacer clic sobre ella, SAP abre instantáneamente la ficha maestra o el documento original sin necesidad de salir al menú principal.</li>
        <li><strong>Modo Buscar vs Modo Crear:</strong> En SAP, las ventanas tienen dos modos. Al presionar <code>Ctrl + F</code> (o hacer clic en los prismáticos), la ventana se pone en modo <em>Buscar</em> (campos en amarillo suave) para filtrar registros existentes. Al presionar <code>Ctrl + A</code>, la ventana pasa a modo <em>Crear / Añadir</em> (campos en blanco) para ingresar una transacción nueva.</li>
        <li><strong>El Mapa de Relaciones:</strong> Al hacer clic derecho sobre cualquier documento comercial y seleccionar <em>'Mapa de relaciones'</em>, SAP despliega un diagrama interactivo con todo el árbol documental conectado (Cotización ➔ Orden ➔ Entrega ➔ Factura ➔ Pago recibido).</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-person-vcard-fill text-primary me-2""></i>2. Datos Maestros de Socios de Negocios (Business Partners - BP)</h4>
    <p>En SAP B1 no existen tablas separadas de 'clientes' y 'proveedores'; todos se gestionan bajo el concepto unificado de <strong>Socio de Negocios</strong> (módulo <em>Socios de Negocios ➔ Datos Maestros de Socio de Negocios</em>). Existen tres tipos:</p>
    <ol>
        <li><strong>Cliente:</strong> Empresas o personas a las que les vendemos productos o servicios.</li>
        <li><strong>Proveedor:</strong> Quienes nos suministran materias primas, mercancía para reventa o servicios operativos.</li>
        <li><strong>Lead (Prospecto):</strong> Potenciales clientes en etapa de cotización previa antes de formalizar ventas reales.</li>
    </ol>
    <p class=""small text-muted"">Campos críticos obligatorios: Código de SN (ej: <code>CLI-J-3049281</code>), RIF o Cédula fiscal, Grupo de Clientes, Moneda de transacción (Moneda local o multidivisa en USD), Lista de Precios asignada y Condiciones de Pago (ej: Contado o Crédito 30 días con límite crediticio).</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-box-seam-fill text-success me-2""></i>3. Datos Maestros de Artículos y las Tres Casillas Sagradas</h4>
    <p>Al dar de alta un producto o servicio en el módulo de Inventario, existen tres casillas de verificación en la esquina superior derecha que determinan su comportamiento en todo el sistema:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Casilla</th>
                    <th>¿Qué habilita en SAP B1?</th>
                    <th>Ejemplo de Aplicación Real</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-primary"">Artículo de Inventario</td>
                    <td>Controla stock físico en almacenes, valorización de inventario y genera movimientos en recuentos.</td>
                    <td>Productos físicos tangibles para venta o materia prima en almacén.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-success"">Artículo de Venta</td>
                    <td>Permite que el SKU pueda seleccionarse en cotizaciones, órdenes de venta y facturas a clientes.</td>
                    <td>Todo producto que la empresa comercializa.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-danger"">Artículo de Compra</td>
                    <td>Permite que el SKU pueda incluirse en órdenes de compra y facturas de proveedores.</td>
                    <td>Mercancía de reposición o suministros de oficina.</td>
                </tr>
            </tbody>
        </table>
    </div>
    <p class=""small text-muted""><em>Caso especial:</em> Un servicio intangible (como un flete de transporte o una hora de consultoría) se marca como 'Artículo de Venta' y 'Artículo de Compra', pero <strong>NO</strong> como 'Artículo de Inventario', porque los servicios no se almacenan en bodegas físicas.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Crear artículos duplicados con descripciones ligeramente diferentes:</strong> Genera descuadres contables y saldos falsos en almacén. Antes de crear un artículo, siempre busca por el código de barras o código de parte del fabricante en modo Buscar (Ctrl + F).</li>
        <li><strong>Asignar una lista de precios incorrecta al Socio de Negocios:</strong> Provoca que el sistema cargue precios de mayorista a clientes minoristas o viceversa durante la facturación rápida en mostrador.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Verificaste el RIF o identificación fiscal antes de crear un nuevo Socio de Negocios?</li>
            <li>¿Marcaste correctamente las tres casillas maestras según la naturaleza del artículo?</li>
            <li>¿Comprobaste la Lista de Precios y las Condiciones de Pago asignadas al cliente?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Circuito de Ventas (Order to Cash) en SAP B1",
                            LessonTitle = "De la Cotización a la Factura de Deudores y Cobro",
                            Summary = "Domina el circuito comercial completo: Oferta de Ventas, Orden de Venta (Sales Order), Entrega (Delivery), Factura de Clientes y Pagos Recibidos. Comprende el impacto en el Stock Comprometido y disponible.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-cash-stack fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Circuito 'Order to Cash': El Flujo de Ingresos de la Empresa</h5>
            <p class=""mb-0 small"">En SAP B1, vender no es simplemente escribir una factura. Cada paso del circuito comercial cumple una función de control operativo, reserva de existencias y devengo contable inalterable.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/zA9f721dDj0"" title=""Fundamentos SAP Business One - Crear circuito de ventas"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. El Flujo Documental Estandarizado de Ventas</h4>
    <p>El ciclo comercial completo en SAP B1 se compone de 5 documentos encadenados mediante el botón <strong>'Copiar a' (Copy To)</strong> o <strong>'Copiar de' (Copy From)</strong>:</p>
    <div class=""row g-2 mb-4"">
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>1. Oferta de Venta</strong><br /><span class=""text-muted"">Cotización previa al cliente (no mueve stock ni genera contabilidad).</span></div></div>
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>2. Orden de Venta</strong><br /><span class=""text-muted"">Formaliza el pedido. <strong>Aumenta el Stock Comprometido</strong>.</span></div></div>
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>3. Entrega</strong><br /><span class=""text-muted"">Albarán de despacho. <strong>Rebaja el stock físico</strong> del almacén.</span></div></div>
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>4. Factura de Clientes</strong><br /><span class=""text-muted"">Genera el asiento contable de cobro, IVA y costo de venta.</span></div></div>
        <div class=""col-md""><div class=""p-2 bg-light border rounded text-center small""><strong>5. Pago Recibido</strong><br /><span class=""text-muted"">Entrada de dinero a caja o banco, cancelando la deuda del cliente.</span></div></div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-calculator text-primary me-2""></i>2. La Ecuación Sagrada de Inventario en SAP</h4>
    <p>Para no prometer mercancía que ya está comprometida con otros clientes, SAP calcula tres cifras en tiempo real para cada artículo:</p>
    <div class=""p-3 bg-light rounded border text-center my-3"">
        <code class=""fs-6 fw-bold"">Stock Disponible = En Stock Físico - Comprometido (Órdenes de Venta) + Solicitado (Órdenes de Compra)</code>
    </div>
    <p class=""small text-muted"">Si tienes 100 unidades físicas en la estantería del almacén pero tienes 3 Órdenes de Venta abiertas por 80 unidades en total, tu stock disponible para nuevos clientes es de apenas <strong>20 unidades</strong>. Si intentas emitir una orden por 30 unidades, SAP emitirá una advertencia de déficit de inventario.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-link-45deg text-primary me-2""></i>3. Uso de 'Copiar a' y Trazabilidad Documental</h4>
    <p>En SAP nunca se digita un documento desde cero si ya existe el documento anterior. Desde la Orden de Venta aprobada, el operador hace clic en el botón inferior <strong>Copiar a ➔ Entrega</strong>:</p>
    <ul>
        <li>SAP transfiere automáticamente los códigos de artículos, cantidades, precios unitarios, descuentos autorizados y datos de despacho sin ningún error de transcripción.</li>
        <li>Si el cliente solo recibe una entrega parcial (ej: 60 de las 100 unidades solicitadas), se modifica la cantidad en la Entrega a 60. La Orden de Venta original permanecerá con estado <em>Abierto</em> por las 40 unidades restantes hasta que se realice el segundo despacho.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Crear la Factura de Clientes directamente sin emitir la Entrega previa:</strong> En empresas de retail o manufactura con almacenes físicos, saltarse la Entrega provoca que el departamento de logística no reciba la orden de picking para armar el bulto, generando retrasos y discordancias entre lo facturado y lo despachado.</li>
        <li><strong>Cancelar una Entrega una vez que ya ha sido facturada:</strong> No es posible cancelar una entrega cerrada. Si el cliente devuelve la mercancía después de facturada, el procedimiento legal en SAP es emitir una <strong>Nota de Crédito de Clientes (Credit Memo)</strong> que rebaja la deuda contable y reingresa el producto al inventario.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Verificaste el saldo de Stock Disponible antes de confirmar la Orden de Venta al cliente?</li>
            <li>¿Utilizaste la función 'Copiar a' para preservar la trazabilidad y alimentar el Mapa de Relaciones?</li>
            <li>¿Comprobaste que la Factura de Clientes refleje la lista de precios y la alícuota de impuesto correcta?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Circuito de Compras (Procure to Pay) y Recepción de Mercancía",
                            LessonTitle = "Solicitud, Pedido de Compra, Entrada de Mercancías y Factura de Proveedores",
                            Summary = "Domina el circuito de abastecimiento empresarial: de la Solicitud interna de Compra a la Orden de Compra (PO), la Entrada de Mercancías por Compras (GRPO) con aumento de existencias físicas y la Factura de Proveedores.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-cart-check-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Circuito 'Procure to Pay': Abastecer sin Quiebres de Existencia</h5>
            <p class=""mb-0 small"">Un departamento de compras profesional no espera a que el inventario se agote en el almacén. En SAP B1, el circuito de compras asegura que cada reposición cuente con autorización presupuestaria, recepción física rigurosa y conciliación de facturas.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/GMPXAHxoozs"" title=""¿En qué consiste el proceso Purchase to pay (P2P)? SERES"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Las 4 Etapas del Circuito de Compras</h4>
    <p>El flujo formal de abastecimiento en SAP B1 consta de cuatro documentos encadenados:</p>
    <ol>
        <li><strong>Solicitud de Compra (Purchase Request):</strong> Documento interno emitido por un departamento (ej: Mantenimiento o Almacén) solicitando materiales. No tiene impacto financiero ni fiscal externo.</li>
        <li><strong>Pedido de Compra / Orden de Compra (Purchase Order - PO):</strong> Contrato comercial formal enviado al proveedor con los precios y plazos pactados. En SAP <strong>aumenta el valor del 'Stock Solicitado'</strong>.</li>
        <li><strong>Entrada de Mercancías por Compras (Goods Receipt PO - GRPO):</strong> Es el documento emitido en el muelle de descarga del almacén cuando llega el camión del proveedor. <strong>Aquí es donde se incrementa el Stock Físico en los almacenes</strong> y se genera un asiento de pasivo transitorio de provisión.</li>
        <li><strong>Factura de Proveedores (A/P Invoice):</strong> Registro legal de la factura fiscal recibida del proveedor. Liquida el pasivo transitorio, registra el crédito fiscal de IVA y genera la cuenta por pagar definitiva.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shield-check text-primary me-2""></i>2. La Conciliación a Tres Bandas (Three-Way Matching)</h4>
    <p>Para evitar pagar facturas por mercancía que nunca llegó a la empresa o con sobreprecios no acordados, SAP aplica el principio de control interno de <strong>Confrontación a Tres Bandas</strong>:</p>
    <ul>
        <li>Verifica que los artículos y precios de la <strong>Factura del Proveedor</strong> coincidan exactamente con la <strong>Orden de Compra (PO)</strong> aprobada.</li>
        <li>Verifica que las cantidades facturadas coincidan con la <strong>Entrada de Mercancías (GRPO)</strong> firmada por el jefe de almacén.</li>
        <li>Si existe una discrepancia en cantidad o precio superior a la tolerancia permitida, SAP bloquea automáticamente el documento impidiendo su pago hasta que el comprador aclare la diferencia.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-truck text-primary me-2""></i>3. Costes de Importación y Gastos en Aduana (Landed Costs)</h4>
    <p>Cuando la empresa importa mercancía del extranjero, el costo real del producto no es solo el valor de compra FOB en puerto de origen. Incluye flete marítimo, seguro internacional, aranceles aduaneros e impuestos de nacionalización.</p>
    <p>Mediante el módulo de <strong>Precios de Entrega (Landed Costs)</strong> en SAP B1, el analista asigna estos costos adicionales a la Entrada de Mercancías original (prorrateándolos por peso, volumen o valor comercial). SAP recalcula automáticamente el costo unitario de cada producto en el almacén, asegurando que la empresa conozca su margen de ganancia real.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Registrar la Factura de Proveedores sin vincularla a la Entrada de Mercancías (GRPO):</strong> Si creas la factura directamente sin 'Copiar de' la GRPO, provocarás que el stock físico se duplique en el sistema o que quede un pasivo transitorio abierto eternamente en la contabilidad.</li>
        <li><strong>No inspeccionar la mercancía antes de firmar la GRPO:</strong> Una vez que la Entrada de Mercancías se añade a SAP, el sistema asume que los artículos están aptos y disponibles para la venta. Si detectas productos rotos o caducados, debes registrar una <em>Devolución de Mercancías</em> de inmediato.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Verificaste que la cantidad recibida en almacén coincida con la Orden de Compra aprobada?</li>
            <li>¿Utilizaste 'Copiar a' desde la GRPO hacia la Factura de Proveedores para asegurar el cruce a tres bandas?</li>
            <li>¿Registraste los costos de flete e impuestos aduaneros a través del asistente de Landed Costs?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Gestión de Inventarios, Almacenes y Traslados",
                            LessonTitle = "Transferencias de Stock, Ajustes de Inventario y Recuentos Físicos",
                            Summary = "Gestiona múltiples almacenes en SAP B1. Domina las Solicitudes y Traslados de Inventario entre sucursales, el registro de mermas y el Asistente de Recuento de Inventario (Toma Física Ciega) con ajustes de stock.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-boxes fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Control de Inventarios: El Activo Más Valioso de la Empresa</h5>
            <p class=""mb-0 small"">El dinero de una empresa de comercio no está en el banco; está acumulado en las estanterías del almacén. Gestionar traslados entre sucursales y ejecutar tomas físicas ciegas en SAP garantiza cero pérdidas y cero descuadres contables.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/N4FbW5yrrY8"" title=""Mejora tu Almacén con el módulo de INVENTARIO"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Gestión Multialmacén y Traslados de Stock</h4>
    <p>En organizaciones con múltiples puntos de venta, SAP B1 permite definir depósitos diferenciados (ej: Almacén Principal 01, Almacén Tienda Centro 02, Almacén de Merma/Averías 99). Para mover existencias entre depósitos se utilizan dos documentos:</p>
    <ul>
        <li><strong>Solicitud de Traslado:</strong> Documento previo donde la tienda solicita reposición a la bodega central. Reserva el stock en el almacén emisor pero no lo descarga físicamente todavía.</li>
        <li><strong>Traslado de Inventario (Inventory Transfer):</strong> Ejecuta el movimiento real. Descarga el inventario del Almacén Origen y lo acredita en el Almacén Destino. Es una transacción puramente logística que <strong>no genera pérdidas ni ganancias</strong>, solo traslada el valor del activo entre cuentas de inventario de cada centro de costo.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-clipboard-data-fill text-primary me-2""></i>2. Ajustes de Entrada y Salida por Merma o Donación</h4>
    <p>Cuando un artículo se deteriora, vence o sufre un accidente en la bodega, no puede venderse a clientes. Para darlo de baja legalmente en SAP se utiliza:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Documento en SAP B1</th>
                    <th>Efecto Físico en Stock</th>
                    <th>Efecto Contable</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-danger"">Salida de Mercancías (Goods Issue)</td>
                    <td>Disminuye las existencias en el almacén seleccionado.</td>
                    <td>Imputa el valor monetario a una cuenta de <strong>Gasto por Merma, Deterioro u Obsolescencia</strong>.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-success"">Entrada de Mercancías (Goods Receipt)</td>
                    <td>Aumenta las existencias en el almacén seleccionado.</td>
                    <td>Acredita una cuenta de <strong>Ajuste de Inventario / Sobrante Operativo</strong>.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-check2-circle text-primary me-2""></i>3. El Asistente de Recuento de Inventario (Toma Física Ciega)</h4>
    <p>Al finalizar el mes o trimestre, la empresa debe auditar que las existencias teóricas del sistema coincidan con los bultos reales en estantería:</p>
    <ol>
        <li>Abrir el <strong>Documento de Recuento de Inventario</strong> en SAP y seleccionar los almacenes o pasillos a auditar.</li>
        <li><strong>Congelar Artículos (Freeze Items):</strong> Al marcar la casilla 'Fijar', SAP bloquea temporalmente los artículos seleccionados impidiendo que se emitan facturas o traslados sobre ellos mientras los operarios cuentan en el almacén.</li>
        <li><strong>Conteo Ciego:</strong> Se imprime la hoja de recuento para los auditores <em>sin mostrar las cantidades teóricas</em>, obligándolos a contar físicamente cada unidad sin sesgos.</li>
        <li><strong>Carga de Conteo y Contabilización de Diferencias:</strong> Se ingresan las cifras contadas en SAP. El sistema resalta en rojo las discrepancias y genera automáticamente un documento de <em>Contabilización de Inventario</em> que ajusta el stock contable igualándolo a la realidad física de una sola vez.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Mover mercancía entre tiendas físicamente sin registrar el Traslado en SAP:</strong> Provoca que el sistema muestre stock disponible en una tienda donde no hay nada, haciendo que los vendedores pierdan ventas o vendan productos inexistentes.</li>
        <li><strong>Hacer ajustes de inventario manuales sin código de motivo ni autorización gerencial:</strong> En empresas auditadas, cada salida de mercancía por merma debe llevar adjunto el número de acta de auditoría firmado por el jefe de prevención de pérdidas.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Congelaste los artículos en SAP antes de iniciar la toma física de inventario en la bodega?</li>
            <li>¿Registraste las mermas mediante 'Salida de Mercancías' imputadas a la cuenta contable correcta?</li>
            <li>¿Verificaste que los traslados entre tiendas reflejen el almacén emisor y receptor exactos?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es el impacto en SAP B1 cuando se crea una Orden de Venta (Sales Order)?",
                            OptionA = @"Disminuye de inmediato las existencias físicas en el almacén.",
                            OptionB = @"Incrementa la cantidad en el campo 'Comprometido', reservando el stock sin mover existencias físicas todavía.",
                            OptionC = @"Genera de forma obligatoria el asiento contable de cuentas por cobrar e IVA.",
                            OptionD = @"Factura automáticamente al cliente sin necesidad de emitir albarán ni entrega.",
                            CorrectAnswer = "B",
                            Explanation = @"La Orden de Venta formaliza el pedido comercial y aumenta el 'Stock Comprometido' para evitar que se venda a otros clientes, pero la salida física real ocurre en la Entrega (Delivery)."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué casillas de verificación definen que un artículo pueda ser comprado, vendido y almacenado en SAP B1?",
                            OptionA = @"Solo la casilla de 'Artículo General'.",
                            OptionB = @"'Artículo de Inventario', 'Artículo de Venta' y 'Artículo de Compra'.",
                            OptionC = @"'Artículo Fijo', 'Artículo Variable' y 'Artículo Contable'.",
                            OptionD = @"'Activo Corriente', 'Pasivo' y 'Patrimonio'.",
                            CorrectAnswer = "B",
                            Explanation = @"En Datos Maestros de Artículos, estas tres casillas gobiernan en qué módulos y documentos puede participar el SKU respectivo."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿En qué documento del circuito de compras de SAP B1 se produce el ingreso físico real de los productos al almacén?",
                            OptionA = @"En la Solicitud de Compra interna.",
                            OptionB = @"En el Pedido de Compra (Purchase Order).",
                            OptionC = @"En la Entrada de Mercancías por Compras (Goods Receipt PO - GRPO).",
                            OptionD = @"En el Pago Efectuado bancario.",
                            CorrectAnswer = "C",
                            Explanation = @"La Entrada de Mercancías (GRPO) es el documento que aumenta el stock disponible en almacén y registra el pasivo transitorio con el proveedor."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué herramienta interactiva de SAP B1 permite visualizar el árbol documental completo desde la cotización hasta el cobro?",
                            OptionA = @"Asistente de Consultas Rápidas.",
                            OptionB = @"Mapa de Relaciones (Relationship Map).",
                            OptionC = @"Explorador de Archivos de Windows.",
                            OptionD = @"Historial de Impresión de Facturas.",
                            CorrectAnswer = "B",
                            Explanation = @"El Mapa de Relaciones muestra visualmente todas las ramas documentales vinculadas con sus estados (abierto, cerrado, cancelado)."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"Si un producto se daña de forma irreparable en el depósito, ¿cuál es el documento correcto para rebajar el stock en SAP?",
                            OptionA = @"Factura de Clientes con costo cero.",
                            OptionB = @"Salida de Mercancías (Goods Issue) imputada a cuenta contable de merma/pérdida.",
                            OptionC = @"Entrada de Mercancías negativa.",
                            OptionD = @"Orden de Venta en estado cancelado.",
                            CorrectAnswer = "B",
                            Explanation = @"La Salida de Mercancías extrae las unidades físicas de almacén y refleja la pérdida económica en la cuenta de resultados asignada."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué tipo de Socio de Negocios (BP) se debe registrar para gestionar las compras a fábricas o mayoristas?",
                            OptionA = @"Cliente (Customer).",
                            OptionB = @"Prospecto (Lead).",
                            OptionC = @"Proveedor (Vendor).",
                            OptionD = @"Empleado de Ventas.",
                            CorrectAnswer = "C",
                            Explanation = @"Los Socios de Negocios de tipo 'Proveedor' son los únicos habilitados para órdenes de compra y facturas de acreedores."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué ocurre financieramente al registrar una Factura de Clientes (A/R Invoice)?",
                            OptionA = @"Se debita la cuenta de efectivo y se borra el inventario.",
                            OptionB = @"Se genera la cuenta por cobrar al deudor (Débito) y se reconoce el ingreso por ventas e impuestos (Crédito).",
                            OptionC = @"No se genera ningún asiento contable hasta que el cliente decida pagar.",
                            OptionD = @"Se descuenta el saldo bancario de la empresa compradora.",
                            CorrectAnswer = "B",
                            Explanation = @"La factura fiscal genera el derecho de cobro formal en cuentas por cobrar y acredita el ingreso por ventas en el balance."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué función cumple el 'Stock Solicitado' (Ordered) en la ficha de inventario de SAP B1?",
                            OptionA = @"Indica las unidades que los clientes pidieron por internet.",
                            OptionB = @"Indica la cantidad pedida a proveedores que aún está pendiente por ingresar al almacén.",
                            OptionC = @"Indica los artículos devueltos por garantía.",
                            OptionD = @"Indica los productos que han sido desechados en auditoría.",
                            CorrectAnswer = "B",
                            Explanation = @"El stock solicitado refleja los pedidos de compra en tránsito que aún no han sido descargados en almacén."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es el cálculo exacto del 'Stock Disponible' en SAP Business One?",
                            OptionA = @"Stock En Stock - Comprometido + Solicitado.",
                            OptionB = @"Stock Físico / 2.",
                            OptionC = @"Stock Solicitado - Comprometido.",
                            OptionD = @"Stock En Stock * Costo Promedio.",
                            CorrectAnswer = "A",
                            Explanation = @"Disponible = En Stock (físico actual) - Comprometido (vendido no entregado) + Solicitado (comprado en camino)."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Para qué sirve el documento 'Traslado de Inventario' entre dos almacenes de la misma empresa?",
                            OptionA = @"Para vender mercancía a una sucursal con cobro de comisión.",
                            OptionB = @"Para mover existencias entre centros de costo sin afectar cuentas de resultados de pérdidas o ingresos.",
                            OptionC = @"Para liquidar el inventario de fin de año fiscal.",
                            OptionD = @"Para anular facturas de compras erróneas.",
                            CorrectAnswer = "B",
                            Explanation = @"Un traslado reubica físicamente los bienes entre depósitos manteniendo intacto el valor patrimonial total de la compañía."
                        }
                    }                },

                // =========================================================================
                // 2. SHOPIFY E-COMMERCE
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "shopify-comercio-electronico-tiendas-online",
                    Title = "Shopify Básico: Creación, Configuración y Gestión de Tiendas Online",
                    CategorySlug = "ventas-comercio-retail",
                    ShortDescription = "Aprende a montar y operar una tienda virtual profesional con Shopify: arquitectura, catálogo con variantes, pasarelas de pago, logística de envíos y retención de carritos abandonados.",
                    FullDescription = "Capacitación práctica y completa en comercio electrónico con la plataforma líder mundial. Domina la configuración de monedas, impuestos y dominios personalizados; crea fichas de producto optimizadas para la venta con variantes de talla y color; organiza colecciones automatizadas con etiquetas; configura checkouts y métodos de pago; y gestiona pedidos diarios y automatizaciones de email marketing para recuperar carritos abandonados.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Arquitectura de Shopify y Configuración Inicial de la Tienda",
                            LessonTitle = "Panel de Control, Dominios, Moneda e Información Legal de la Empresa",
                            Summary = "Conoce el backend de Shopify: configuración regional (monedas, huso horario), vinculación de dominio propio .com, políticas legales obligatorias (términos, reembolsos, privacidad) y personalización del tema visual.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-shop fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Shopify: La Plataforma que Democratizó el Comercio Electrónico Global</h5>
            <p class=""mb-0 small"">Vender por internet ya no requiere contratar un equipo de ingenieros para programar servidores durante seis meses. Con Shopify, cualquier negocio puede tener una tienda online de clase mundial funcionando en menos de una semana.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/9m-2pxDlkqU"" title=""Tutorial de Shopify para Principiantes - Crea Tu Primera Tienda Online"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Arquitectura Cloud de Shopify (SaaS)</h4>
    <p>A diferencia de soluciones autoalojadas como WooCommerce o Magento donde la empresa debe pagar por hosting, actualizar servidores y parchar vulnerabilidades de seguridad manualmente, <strong>Shopify</strong> opera como un servicio SaaS totalmente administrado:</p>
    <ul>
        <li><strong>Infraestructura Elástica:</strong> Soporta millones de visitas simultáneas durante eventos masivos de compras (como Black Friday) sin que la página web caiga.</li>
        <li><strong>Certificado SSL Gratuito y Cumplimiento PCI-DSS Nivel 1:</strong> La máxima certificación bancaria para el procesamiento seguro de tarjetas de crédito sin riesgo legal para el comerciante.</li>
        <li><strong>Ecosistema de Aplicaciones:</strong> Acceso a miles de extensiones en la Shopify App Store para conectar WhatsApp, programas de fidelización y logística local de despachos.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-gear-fill text-primary me-2""></i>2. Configuración Esencial de la Tienda</h4>
    <p>Antes de diseñar banners o subir productos, se deben configurar los cimientos operativos en el menú <em>Configuración</em> de la esquina inferior izquierda:</p>
    <ol>
        <li><strong>Detalles de la Tienda:</strong> Nombre legal de la empresa, RIF / Cédula jurídica, dirección física y moneda de la tienda (ej: USD o moneda local). <em>(Nota crítica: Cambiar la moneda principal tras recibir la primera venta requiere soporte técnico de Shopify, elígela con cuidado).</em></li>
        <li><strong>Dominio Personalizado:</strong> Conectar un dominio propio profesional (ej: <code>mitienda.com</code>) en lugar de utilizar el subdominio genérico <code>mitienda.myshopify.com</code> que resta confianza institucional a los compradores.</li>
        <li><strong>Páginas de Políticas Legales Obligatorias:</strong>
            <ul>
                <li>Política de Reembolso y Devolución (plazos, quién paga el flete de retorno, condiciones del producto).</li>
                <li>Política de Privacidad y Tratamiento de Datos Personales.</li>
                <li>Términos y Condiciones del Servicio.</li>
                <li>Información de Envíos y Tiempos Estimados de Entrega.</li>
            </ul>
        </li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-palette text-primary me-2""></i>3. Selección y Personalización del Tema (Editor de Temas)</h4>
    <p>Shopify ofrece temas gratuitos de alto rendimiento optimizados para celulares (como <strong>Dawn</strong> o <strong>Sense</strong>):</p>
    <ul>
        <li>El 80% de las ventas por internet en América Latina se realizan desde teléfonos móviles; diseña siempre pensando primero en la experiencia móvil (Mobile First).</li>
        <li>Configura una paleta de colores limpia (máximo 3 colores), tipografías legibles y un encabezado fijo con barra de búsqueda rápida y carrito de compras visible.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Lanzar la tienda sin retirar la contraseña de acceso:</strong> Durante la etapa de construcción, la tienda está protegida por una contraseña de desarrollo. Antes del lanzamiento público, debes entrar en <em>Tienda online ➔ Preferencias</em> y desmarcar la casilla 'Habilitar contraseña'.</li>
        <li><strong>Ignorar las páginas de contacto e información legal:</strong> Las pasarelas de pago (Stripe, PayPal, bancos locales) rechazan tiendas que no muestran claramente un teléfono, correo corporativo y dirección física de atención al cliente.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Vinculaste un dominio propio .com con certificado SSL activo?</li>
            <li>¿Publicaste las cuatro políticas legales obligatorias en el pie de página de la tienda?</li>
            <li>¿Comprobaste la velocidad y legibilidad del diseño en dispositivos móviles?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Catálogo de Productos, Variantes, Inventario y Colecciones",
                            LessonTitle = "Creación de Fichas de Producto Vendedoras y Colecciones Automatizadas",
                            Summary = "Domina la gestión del catálogo: redacción persuasiva de fichas, fotografía de producto, configuración de variantes complejas (tallas, colores), SKU/códigos de barra y colecciones automáticas por etiquetas.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-tag-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Ficha de Producto es tu Vendedor Virtual 24/7</h5>
            <p class=""mb-0 small"">En una tienda física el cliente puede tocar la tela o probarse el zapato. En internet, la decisión de compra depende 100% de la claridad visual de las fotos, la precisión de las tallas y la descripción persuasiva orientada a resolver dudas.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/RHoDJhFzAyA"" title=""Cómo crear variantes de productos | Tallas, colores, precios y stock"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Anatomía de una Ficha de Producto de Alta Conversión</h4>
    <p>Para que un producto se venda con fluidez sin generar una avalancha de dudas por WhatsApp, la ficha debe estructurarse con rigor profesional:</p>
    <ul>
        <li><strong>Título Claro y Descriptivo:</strong> Marca + Tipo de Producto + Característica Principal (ej: <em>'Zapato Deportivo Ergonómico Transpirable para Correr - Modelo Sprint 2026'</em>).</li>
        <li><strong>Fotografía Profesional con Fondo Neutro y en Uso:</strong> Al menos 4 a 6 fotos de alta resolución con fondo blanco o gris claro, mostrando diferentes ángulos, primer plano de costuras/materiales y al menos una foto de la prenda puesta en una persona real.</li>
        <li><strong>Descripción Orientada a Beneficios (no solo características técnicas):</strong> En lugar de decir 'fabricado en poliéster 100%', explica: <em>'Tejido ligero de secado rápido que disipa el calor corporal manteniéndote fresco durante todo el entrenamiento'</em>.</li>
        <li><strong>Tabla de Medidas Exactas:</strong> En calzado o ropa, incluir una guía de tallas en centímetros para erradicar las devoluciones por error de medida.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-layers-fill text-primary me-2""></i>2. Configuración de Variantes Complejas y Control de Stock por SKU</h4>
    <p>Si vendes una camiseta en 3 colores (Blanco, Negro, Azul) y 4 tallas (S, M, L, XL), tienes una matriz de <strong>12 variantes individuales</strong>. En Shopify:</p>
    <ol>
        <li>En la sección 'Variantes', agregar la opción <em>Color</em> y luego la opción <em>Talla</em>.</li>
        <li>Shopify generará la matriz de 12 combinaciones. A cada variante debes asignarle su propio <strong>SKU único</strong> (ej: <code>CAM-BLA-M</code>) y su propio saldo de inventario independiente.</li>
        <li><strong>Vincular fotos a variantes:</strong> Asigna la foto de la camiseta azul a la variante 'Azul'. Cuando el cliente haga clic en el botón 'Azul', la imagen principal de la tienda cambiará automáticamente al color seleccionado.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-folder-check text-success me-2""></i>3. Colecciones Manuales vs Colecciones Automatizadas con Etiquetas</h4>
    <p>Organizar los productos por categorías (ej: 'Hombres', 'Novedades', 'Ofertas de Verano') se puede hacer de dos formas:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Tipo de Colección</th>
                    <th>Mecanismo</th>
                    <th>Ventaja Operativa</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Manual</td>
                    <td>El operador selecciona producto por producto y los agrega a la categoría a mano.</td>
                    <td>Útil para selecciones editoriales pequeñas o productos destacados temporales.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-success"">Automatizada (Recomendada)</td>
                    <td>Se define una regla condicional basada en <strong>Etiquetas (Tags)</strong> o precio (ej: <em>'Etiqueta es igual a Calzado_Dama'</em>).</td>
                    <td><strong>Cero Mantenimiento:</strong> Cada vez que des de alta un zapato nuevo con la etiqueta <code>Calzado_Dama</code>, se publicará automáticamente en la categoría de la web sin necesidad de editar la colección.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Marcar la casilla 'Continuar vendiendo cuando se agote el stock' sin control:</strong> Si dejas esta casilla marcada y no tienes stock garantizado de reposición inmediata, los clientes comprarán productos que no tienes en el depósito, provocando reclamos y cancelaciones obligadas.</li>
        <li><strong>Subir fotos pesadas de más de 5 MB cada una:</strong> Ralentiza la carga de la tienda en teléfonos móviles; cada segundo extra de carga reduce las ventas en un 20%. Utiliza formatos modernos como <code>WebP</code> o comprime las imágenes antes de subirlas.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Asignaste SKUs únicos e independientes a cada combinación de talla y color?</li>
            <li>¿Vinculaste las imágenes específicas a cada variante de color?</li>
            <li>¿Organizaste tus categorías mediante Colecciones Automatizadas usando etiquetas consistentes?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Pasarelas de Pago, Tarifas de Envío y Logística",
                            LessonTitle = "Configuración de Checkouts, Métodos de Pago Locales y Envíos",
                            Summary = "Configura la pasarela de pagos: tarjetas internacionales (Shopify Payments, Stripe, PayPal), pagos móviles/transferencias manuales, configuración de zonas de envío (tarifas planas y envío gratis).",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-credit-card-2-front-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Checkout: Donde el Interés se Convierte en Dinero Real</h5>
            <p class=""mb-0 small"">Si un cliente llega al final del proceso de compra y no encuentra su medio de pago preferido o descubre costos de envío sorpresa que no esperaba, abandonará la compra de inmediato. Diseñar un checkout fluido es vital para la rentabilidad.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/t7uXibObexI"" title=""Micro Curso: Pasarelas de Pago - Todo lo que debes saber"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Métodos de Pago: Pasarelas Automáticas vs Pagos Manuales</h4>
    <p>En el comercio electrónico actual de América Latina y mercados mixtos, se debe ofrecer un abanico balanceado de opciones de pago:</p>
    <ul>
        <li><strong>Pasarelas Automáticas (Stripe, Shopify Payments, Mercado Pago, PayPal):</strong> Procesan tarjetas de crédito y débito de forma instantánea. El dinero se acredita en la cuenta del comerciante y el pedido pasa automáticamente a estado <em>'Pagado'</em>, activando el despacho en almacén sin intervención humana. Cobran una comisión por transacción (típicamente entre 2.9% y 4.5% + $0.30 USD).</li>
        <li><strong>Métodos de Pago Manuales (Transferencias Bancarias Locales, Pago Móvil, Zelle):</strong> El cliente finaliza el pedido y la pantalla le muestra los datos bancarios de la empresa con instrucciones para enviar el comprobante de pago por WhatsApp o correo. El pedido queda en estado <em>'Pago Pendiente'</em> hasta que un operador administrativo verifica los fondos en la cuenta bancaria y marca manualmente el pedido como pagado.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-truck text-primary me-2""></i>2. Configuración Estratégica de Zonas y Tarifas de Envío</h4>
    <p>En el menú <em>Configuración ➔ Envío y entrega</em>, se deben estructurar las tarifas para no perder dinero en fletes ni espantar a los clientes:</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <h6 class=""fw-bold text-dark mb-2"">Las 3 Estrategias de Flete Más Exitosas</h6>
        <ol class=""small mb-0"">
            <li><strong>Envío Gratis Condicional (Free Shipping Threshold):</strong> Establecer envío gratuito para compras superiores a cierto monto (ej: <em>'Envío Gratis en compras mayores a $50 USD'</em>). Esta estrategia eleva el Ticket Promedio de compra porque los clientes agregan un producto adicional para no pagar el envío.</li>
            <li><strong>Tarifa Plana Simple (Flat Rate):</strong> Cobrar una tarifa fija estándar (ej: $4 USD a toda la ciudad), sin importar el peso. Fácil de entender para el comprador.</li>
            <li><strong>Tarifas Calculadas por Transportista:</strong> Conectar servicios de encomiendas (MRW, Zoom, Tealca, DHL, FedEx) para que el sistema calcule el costo exacto según el código postal y peso volumétrico del paquete.</li>
        </ol>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shield-lock-fill text-primary me-2""></i>3. Optimización del Proceso de Checkout (Cero Fricción)</h4>
    <p>Para reducir el abandono en la pantalla de pago:</p>
    <ul>
        <li>Activar la opción de <strong>Comprar como invitado</strong>: No obligues al cliente a crear una cuenta con contraseña antes de comprar; permite que compre ingresando únicamente su correo o teléfono.</li>
        <li>Reducir campos innecesarios: Desactiva el campo 'Segunda línea de dirección' o 'Nombre de la empresa' si vendes a consumidores finales (B2C).</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Despachar mercancía con comprobantes de pago manuales falsos:</strong> En pagos manuales (Zelle o Pago Móvil), los ciberdelincuentes editan capturas de pantalla con Photoshop. La regla de oro es: <em>'NUNCA despachar un pedido basándose en una captura de pantalla enviada por el cliente; despachar ÚNICAMENTE cuando el dinero esté efectivamente disponible en el portal bancario oficial de la empresa'</em>.</li>
        <li><strong>Costos ocultos sorpresa en el último paso:</strong> Si el cliente ve un producto por $20 y en el último paso del checkout le agregas $15 de impuestos y envíos imprevistos, el 70% de los usuarios abandonará la cesta enfadado. Sé transparente con las tarifas desde la página de inicio.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Probaste el flujo completo de compra realizando un pedido de prueba en modo test?</li>
            <li>¿Definiste claramente los datos bancarios e instrucciones para pedidos con pago manual?</li>
            <li>¿Configuraste la regla de Envío Gratis sobre un monto mínimo para elevar el ticket promedio?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Gestión de Pedidos, Carritos Abandonados y Retención",
                            LessonTitle = "Procesamiento de Órdenes, Embalaje, Despacho y Automatizaciones",
                            Summary = "Domina la operativa diaria de la tienda: preparación de pedidos, impresión de albaranes, emisión de códigos de seguimiento, automatización de recuperación de carritos y fidelización de clientes recurrentes.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-cart-x-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Carritos Abandonados: Recuperar Dinero que ya Estaba en la Mesa</h5>
            <p class=""mb-0 small"">En el comercio electrónico mundial, el 70% de los usuarios agregan productos al carrito y se van sin pagar. Con una secuencia automatizada de correos y mensajes de recuperación, es posible rescatar entre un 15% y un 25% de esas ventas perdidas.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/MWMR1EBeVB4"" title=""Recuperación de Carritos Abandonados : Recupera Ventas en tu Tienda Online"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. El Ciclo de Vida de un Pedido en el Almacén de E-Commerce</h4>
    <p>Desde que el cliente presiona 'Pagar' hasta que el paquete llega a sus manos, el pedido atraviesa cuatro estados operativos:</p>
    <ol>
        <li><strong>No Preparado (Unfulfilled):</strong> El pago está confirmado y el pedido entra a la cola de trabajo del almacén.</li>
        <li><strong>Picking y Packing:</strong> El operario toma la hoja de empaque (Packing Slip) impresa desde Shopify, recoge los artículos de las estanterías y los embala en cajas seguras con cinta de seguridad.</li>
        <li><strong>Preparado (Fulfilled):</strong> Se entrega el bulto a la empresa de transporte (MRW, DHL, Tealca) y se ingresa el <strong>Número de Rastreo (Tracking Number)</strong> en Shopify. Al presionar 'Marcar como preparado', Shopify le envía automáticamente un correo y SMS al cliente con el enlace de seguimiento en vivo.</li>
        <li><strong>Entregado (Delivered):</strong> La transportadora confirma la entrega física y concluye el ciclo logístico.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-arrow-repeat text-primary me-2""></i>2. La Secuencia de Oro de Recuperación de Carritos Abandonados</h4>
    <p>Shopify cuenta con un motor nativo de automatización de correos para carritos abandonados (ubicado en <em>Marketing ➔ Automatizaciones ➔ Pago abandonado</em>). La mejor práctica internacional es configurar una secuencia de dos pasos:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-primary mb-2"">Mensaje 1: A las 2 Horas del Abandono</span>
                <p class=""small text-muted mb-0""><strong>Enfoque de Asistencia y Servicio:</strong> <em>'¿Tuviste algún problema con tu pago? Notamos que dejaste tu pedido sin finalizar. Guardamos tu carrito para que puedas completarlo con un clic.'</em> (Muchos clientes abandonan simplemente porque el banco les pidió una clave de confirmación que no tenían a mano).</p>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-success mb-2"">Mensaje 2: A las 24 Horas del Abandono</span>
                <p class=""small text-muted mb-0""><strong>Incentivo Económico y Urgencia:</strong> <em>'Tu carrito está a punto de liberarse. Completa tu compra en las próximas 4 horas y disfruta de un 10% de descuento exclusivo usando el cupón: REGRESO10.'</em></p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-star-fill text-warning me-2""></i>3. Fidelización y Retención: Convertir Compradores de 1 Sola Vez en Clientes Recurrentes</h4>
    <p>Adquirir un cliente nuevo mediante publicidad en redes sociales es hasta 7 veces más costoso que retener a un cliente que ya confía en tu marca. Estrategias de retención obligatorias:</p>
    <ul>
        <li><strong>Experiencia de Desempaque (Unboxing Experience):</strong> Incluir dentro del paquete una tarjeta de agradecimiento personalizada con un código de descuento para su próxima compra.</li>
        <li><strong>Email Postventa de Satisfacción:</strong> Enviar un correo automático a los 7 días de entregado el paquete consultando: <em>'¿Cómo te quedó tu producto? Califícanos con 5 estrellas y déjanos tu opinión'</em>.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Tardar más de 24 horas en enviar el número de rastreo:</strong> La ansiedad de compra en internet es alta. Si no le envías el comprobante de despacho con su guía de seguimiento rápidamente, el cliente comenzará a escribir quejas por redes sociales creyendo que fue estafado.</li>
        <li><strong>Enviar correos de carrito abandonado a clientes que ya pagaron por otro medio:</strong> Si un cliente pagó manualmente por transferencia bancaria y no marcas el pedido como pagado en Shopify, el sistema le enviará un correo diciéndole que su carrito fue abandonado, generando confusión y molestia.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Ingresas siempre el número de rastreo y seleccionas la empresa de transporte al preparar cada orden?</li>
            <li>¿Tienes activada la secuencia automática de recuperación de pagos abandonados?</li>
            <li>¿Incluyes tarjetas de fidelización con incentivo de recompra en el embalaje físico del paquete?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la principal ventaja de utilizar Colecciones Automatizadas en Shopify?",
                            OptionA = @"Que los productos son más económicos para los compradores.",
                            OptionB = @"Que los productos se agrupan automáticamente según condiciones y etiquetas sin intervención manual diaria.",
                            OptionC = @"Que traduce automáticamente la tienda a 50 idiomas.",
                            OptionD = @"Que elimina la necesidad de pagar comisiones por pasarela.",
                            CorrectAnswer = "B",
                            Explanation = @"Las colecciones automatizadas usan condiciones predefinidas (tipo de producto, etiquetas, precio) para clasificar el catálogo dinámicamente."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"Para conectar un dominio web propio (.com) a una tienda de Shopify, ¿qué registros DNS deben configurarse?",
                            OptionA = @"Solo un archivo TXT con el nombre del propietario.",
                            OptionB = @"El Registro A apuntando a la IP oficial de Shopify y el CNAME 'shops.myshopify.com'.",
                            OptionC = @"Un registro MX bancario.",
                            OptionD = @"Una redirección HTTP 301 en WhatsApp.",
                            CorrectAnswer = "B",
                            Explanation = @"La configuración técnica oficial de Shopify requiere el Registro A en su IP fija y el CNAME apuntando a shops.myshopify.com."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cómo se denomina la opción en Shopify que permite recibir pedidos mediante Transferencia Bancaria o Pago Móvil sin pasarela de tarjetas?",
                            OptionA = @"Checkout Criptográfico.",
                            OptionB = @"Métodos de Pago Manuales (Manual Payment Methods).",
                            OptionC = @"Shopify Direct Wire.",
                            OptionD = @"Billetera Virtual Externa.",
                            CorrectAnswer = "B",
                            Explanation = @"Los Métodos de Pago Manuales permiten al cliente finalizar el pedido y mostrarle los datos de cuenta bancaria para verificación posterior."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué acción realiza la función de 'Fulfillment' en el panel de pedidos de Shopify?",
                            OptionA = @"Devuelve el dinero al cliente de forma automática.",
                            OptionB = @"Marca el pedido como preparado y despachado, notificando al cliente con su número de rastreo si aplica.",
                            OptionC = @"Elimina permanentemente la cuenta del comprador.",
                            OptionD = @"Aumenta el precio del producto vendido.",
                            CorrectAnswer = "B",
                            Explanation = @"Fulfillment significa cumplimiento/preparación del despacho, cambiando el estado del pedido a 'Preparado' y alertando al cliente."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la estrategia recomendada para recuperar carritos abandonados de manera sistemática en Shopify?",
                            OptionA = @"Llamar por teléfono al cliente cada 15 minutos.",
                            OptionB = @"Activar la automatización nativa de correos de recuperación de carritos con incentivos oportunos.",
                            OptionC = @"Borrar los carritos abandonados cada noche para que no hagan peso en la base de datos.",
                            OptionD = @"Aumentar el precio de los productos en el carrito.",
                            CorrectAnswer = "B",
                            Explanation = @"Shopify permite configurar envíos automáticos de correos con el enlace directo al checkout, recuperando entre un 10% y 25% de las ventas perdidas."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué es una variante de producto en Shopify?",
                            OptionA = @"Un producto de la competencia que se muestra en tu web.",
                            OptionB = @"Una opción específica de un artículo, como talla, color o material, que puede tener su propio precio y stock.",
                            OptionC = @"Una imagen rota en el banner principal.",
                            OptionD = @"Un descuento del 50% para amigos.",
                            CorrectAnswer = "B",
                            Explanation = @"Las variantes permiten que un mismo producto (ej. Camiseta Polo) ofrezca combinaciones de tallas (S, M, L) y colores con control de inventario independiente."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué impacto tiene no configurar políticas legales (Privacidad, Reembolsos, Términos) en una tienda online?",
                            OptionA = @"Ninguno, las tiendas online no necesitan textos legales.",
                            OptionB = @"Desconfianza en los usuarios y posible suspensión de cuentas publicitarias en Meta Ads y Google Merchant Center.",
                            OptionC = @"Shopify cobra el triple de comisión de suscripción.",
                            OptionD = @"Los productos se borran del inventario a las 48 horas.",
                            CorrectAnswer = "B",
                            Explanation = @"Las políticas legales son requisito mandatorio de las plataformas publicitarias para verificar la legitimidad del negocio."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué herramienta del editor de temas de Shopify permite agregar secciones interactivas sin necesidad de tocar código?",
                            OptionA = @"El editor visual Online Store 2.0 con bloques dinámicos.",
                            OptionB = @"El compilador C++ de Shopify.",
                            OptionC = @"La consola de comandos de Linux.",
                            OptionD = @"El bloc de notas de Windows.",
                            CorrectAnswer = "A",
                            Explanation = @"La arquitectura Online Store 2.0 introdujo secciones y bloques modulares que cualquier usuario puede personalizar visualmente."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué métrica clave de e-commerce representa el porcentaje de visitantes que completan una compra respecto al total de visitas?",
                            OptionA = @"Tasa de Rebote (Bounce Rate).",
                            OptionB = @"Tasa de Conversión (Conversion Rate).",
                            OptionC = @"Retorno del Gasto Publicitario (ROAS).",
                            OptionD = @"Costo por Clic (CPC).",
                            CorrectAnswer = "B",
                            Explanation = @"La Tasa de Conversión (generalmente entre 1% y 3% en e-commerce) mide la eficacia de la tienda para transformar visitas en ventas reales."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué es fundamental asignar un código SKU único a cada producto y variante en Shopify?",
                            OptionA = @"Para que la tienda se vea de color verde.",
                            OptionB = @"Para mantener un control riguroso de inventario y facilitar la sincronización con almacenes y software ERP.",
                            OptionC = @"Porque la ley prohíbe vender sin SKU en internet.",
                            OptionD = @"Para ocultar los precios a los clientes mayoristas.",
                            CorrectAnswer = "B",
                            Explanation = @"El SKU (Stock Keeping Unit) es el identificador único indispensable para el control de inventarios, despachos y conciliaciones multicanal."
                        }
                    }                },

                // =========================================================================
                // 3. ASISTENTE DE VENTAS Y ATENCIÓN COMERCIAL
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "asistente-de-ventas-comercial-supervision",
                    Title = "Asistente de Ventas Comercial: Gestión Administrativa, Atención y Supervisión en Piso",
                    CategorySlug = "ventas-comercio-retail",
                    ShortDescription = "Formación práctica para asistentes comerciales y líderes de salón: manejo de caja y arqueos diarios sin faltantes, venta consultiva, control de merma y resolución de quejas.",
                    FullDescription = "Capacitación orientada al trabajo diario en tiendas de retail, supermercados, ferreterías y comercios. Aprende el protocolo riguroso de apertura y cierre de caja; domina las técnicas de Cross-Selling (Venta Cruzada) y Up-Selling para elevar el ticket promedio; aplica protocolos de prevención de pérdidas y control de farderos; y lidera la gestión de cambios y reclamos con máxima asertividad comercial.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Operaciones de Caja, POS y Arqueo Diario",
                            LessonTitle = "Apertura de Caja, Medios de Pago y Procedimiento de Cierre sin Descuadres",
                            Summary = "Domina el manejo de la estación de caja: recepción del fondo fijo inicial (sencillo/cambio), operación de puntos de venta (POS), detección de billetes falsos y elaboración del acta de arqueo ciego.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-cash-coin fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Caja es el Punto Neurálgico de la Confianza Comercial</h5>
            <p class=""mb-0 small"">Un cajero o asistente comercial competente no solo cobra con rapidez; es un auditor en primera línea que custodia los ingresos del negocio, detecta billetes adulterados y entrega cuentas claras al centavo en cada turno.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/pdBbhMfaqf4"" title=""Cómo hacer un ARQUEO DE CAJA | Asientos contables por Ajuste"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Protocolo de Apertura: El Fondo Fijo de Caja (Caja Chica / Sencillo)</h4>
    <p>Antes de abrir las puertas al público, el asistente de caja debe recibir y verificar el <strong>Fondo Fijo Inicial</strong> destinado exclusivamente a dar cambio a los primeros clientes de la mañana:</p>
    <ul>
        <li>Contar físicamente cada billete y moneda en presencia del supervisor antes de firmar el acta de entrega.</li>
        <li>Verificar la denominación del sencillo: una caja con puros billetes grandes no podrá operar con los primeros clientes que paguen compras pequeñas.</li>
        <li>Organizar la gaveta de caja de menor a mayor denominación y con todos los billetes orientados hacia el mismo lado para acelerar el cobro y evitar confusiones en horas pico.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-credit-card-2-back-fill text-primary me-2""></i>2. Operación de Medios de Pago y Verificación de Seguridad</h4>
    <p>Durante la jornada comercial se manejan múltiples canales de cobro con protocolos específicos:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Medio de Pago</th>
                    <th>Protocolo Operativo Obligatorio</th>
                    <th>Punto Crítico de Control</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold"">Puntos de Venta (POS)</td>
                    <td>Digitar el monto en el datáfono, verificar que coincida con la pantalla de la caja y esperar el váucher de <em>'Aprobado'</em>.</td>
                    <td><strong>Guardar el váucher firmado:</strong> Si la máquina no emite váucher o dice 'Rechazada', la venta no se ha cobrado aunque el cliente afirme que le llegó el mensaje bancario.</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">Efectivo en Divisas / Moneda Local</td>
                    <td>Verificar medidas de seguridad: marca de agua a contraluz, hilo de seguridad magnético y tinta de color variable al inclinar el billete.</td>
                    <td>Nunca guardar el billete en la gaveta hasta haber entregado el cambio completo al cliente (para evitar disputas sobre si entregó un billete de $20 o de $50).</td>
                </tr>
                <tr>
                    <td class=""fw-bold"">Pago Móvil / Transferencias</td>
                    <td>Verificar en el portal bancario institucional el número de referencia y la disponibilidad efectiva de los fondos.</td>
                    <td>Desconfiar de capturas de pantalla de teléfonos móviles ajenos; solo vale la confirmación interna en pantalla de caja.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-calculator text-success me-2""></i>3. Procedimiento Oficial de Arqueo y Cierre de Caja (Corte Z / X)</h4>
    <p>Al finalizar el turno se realiza el <strong>Arqueo Ciego de Caja</strong>:</p>
    <ol>
        <li>Cerrar la sesión de cobro y emitir el reporte del datáfono (Lote / Cierre de Terminal POS).</li>
        <li>Separar el monto exacto del Fondo Fijo Inicial para guardarlo en la bolsa del día siguiente.</li>
        <li>Contar el dinero restante en efectivo por denominación y sumar los váuchers físicos de tarjetas de crédito/débito.</li>
        <li>Imprimir el <em>Corte Z</em> del software de facturación y confrontar la fórmula universal: <code>Total Contado Físico - Ventas Registradas en Sistema = Diferencia (Sobrante o Faltante)</code>.</li>
        <li>Firmar el acta junto al supervisor de turno documentando cualquier novedad.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar la gaveta de dinero abierta mientras se atiende a otro cliente:</strong> La gaveta de caja debe cerrarse con traba metálica después de cada transacción para prevenir hurtos por distracción.</li>
        <li><strong>Mezclar dinero personal con el dinero de la caja:</strong> Guardar el teléfono o billetera personal dentro de la gaveta de la empresa está terminantemente prohibido por las normas de auditoría interna de retail.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Contaste físicamente el fondo inicial de caja antes de iniciar el turno de ventas?</li>
            <li>¿Verificaste la emisión exitosa del váucher del datáfono antes de entregar la mercancía?</li>
            <li>¿Mantienes los billetes ordenados por denominación con la gaveta de caja siempre trabada?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Técnicas de Venta en Piso: Venta Cruzada y Elevación del Ticket",
                            LessonTitle = "Cross-Selling, Upselling y Asesoría Consultiva en el Salón de Ventas",
                            Summary = "Pasa de despachador pasivo a asesor comercial de alto impacto. Domina la técnica del Up-selling (versión superior), Cross-selling (productos complementarios) y preguntas de sondeo abiertas.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-bag-plus-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">De Despachar Productos a Elevar la Rentabilidad de la Tienda</h5>
            <p class=""mb-0 small"">Un despachador entrega únicamente lo que el cliente le pide en el mostrador. Un asesor de ventas profesional identifica necesidades no verbalizadas y sugiere complementos que aumentan el valor de la compra y la satisfacción del comprador.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/5DKWyV21R0U"" title=""Cómo potenciar las ventas cruzadas en tu farmacia o tienda"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Diferencia Estratégica entre Upselling y Cross-Selling</h4>
    <p>En el comercio minorista existen dos palancas maestras para incrementar la facturación sin necesidad de traer más clientes a la tienda:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h5 class=""fw-bold text-primary mb-2""><i class=""bi bi-arrow-up-circle-fill me-2""></i>Up-Selling (Venta Escalonada Superior)</h5>
                <p class=""small text-muted mb-2"">Invitar al cliente a adquirir una <strong>versión superior, de mayor calidad o de mayor capacidad</strong> del mismo producto que ya decidió comprar.</p>
                <p class=""small mb-0""><strong>Ejemplo en piso:</strong> Si el cliente pide una pintura básica para su casa, el asesor le explica: <em>'Por solo un 15% más de inversión, esta versión lavable y antihongos le evitará tener que volver a pintar el año que viene, ahorrándole mano de obra'</em>.</p>
            </div>
        </div>
        <div class=""col-md-6"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h5 class=""fw-bold text-success mb-2""><i class=""bi bi-plus-circle-fill me-2""></i>Cross-Selling (Venta Cruzada de Complementos)</h5>
                <p class=""small text-muted mb-2"">Ofrecer <strong>productos accesorios o complementarios indispensables</strong> que el cliente necesitará para usar correctamente el artículo principal.</p>
                <p class=""small mb-0""><strong>Ejemplo en piso:</strong> Si compra la pintura, ofrecer la brocha profesional, la cinta de enmascarar, la bandeja plástica y la lija. Si no se los ofreces, el cliente llegará a casa y no podrá pintar, generándole frustración.</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-chat-quote-fill text-primary me-2""></i>2. Las Preguntas de Sondeo Abiertas</h4>
    <p>La peor forma de abordar a un cliente en el piso de venta es preguntar: <em>'¿Le puedo ayudar en algo?'</em> (el 95% responderá automáticamente: <em>'No gracias, solo estoy mirando'</em>). El estándar consultivo exige preguntas abiertas con interés genuino:</p>
    <ul>
        <li><em>'Buenos días, bienvenido. ¿Qué proyecto o arreglo está realizando en casa el día de hoy?'</em></li>
        <li><em>'¿Para qué tipo de ocasión o uso específico necesita este calzado?'</em></li>
        <li><em>'¿Ha probado anteriormente este tipo de material o le gustaría comparar dos opciones de rendimiento?'</em></li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-briefcase-fill text-primary me-2""></i>3. La Métrica del Ticket Promedio (UPT y ATV)</h4>
    <p>Los supervisores de tienda evalúan a su equipo bajo dos métricas de productividad comercial:</p>
    <ul>
        <li><strong>UPT (Units Per Transaction - Unidades por Ticket):</strong> La cantidad promedio de artículos que el cliente se lleva en cada compra. Si un vendedor tiene un UPT de 1.1 y otro tiene un UPT de 2.4, este último está aplicando venta cruzada de accesorios de forma sobresaliente.</li>
        <li><strong>ATV (Average Transaction Value - Ticket Promedio Monetario):</strong> El monto promedio en dólares de cada compra (Ventas Totales / Cantidad de Clientes atendidos).</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Ofrecer venta cruzada de productos más caros que el artículo principal:</strong> Si el cliente está comprando un par de calcetines de $5, no le ofrezcas una chaqueta de cuero de $150 en la fila de caja; los productos cruzados en mostrador deben representar entre el 10% y el 25% del valor de la compra principal para que la decisión sea casi automática.</li>
        <li><strong>Insistir agresivamente cuando el cliente ya dijo que no:</strong> La venta cruzada es una sugerencia de servicio orientada a evitar olvidos, no un acoso. Si el cliente declina amablemente, agradécele y procede al cobro rápido con una sonrisa.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Sustituiste '¿Le ayudo en algo?' por preguntas abiertas de diagnóstico de necesidades?</li>
            <li>¿Ofreciste siempre el producto complementario indispensable antes de cerrar la cuenta?</li>
            <li>¿Monitoreas semanalmente tus unidades por ticket (UPT) para medir tu eficacia comercial?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Supervisión de Piso de Venta y Prevención de Pérdidas (Merma)",
                            LessonTitle = "Control Visual, Reposición Oportuna y Detección de Farderos y Hurtos",
                            Summary = "Custodia la rentabilidad de la sucursal: técnicas de zonificación visual, detección de modus operandi de farderos y bandas de hurto, control de mermas internas y mantenimiento de pasillos despejados.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-shield-shaded fs-2 text-danger""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Prevención de Pérdidas: Cuidar las Ganancias que se Escapan en Silencio</h5>
            <p class=""mb-0 small"">La merma por hurto externo, hurto interno y deterioro por manipulación inadecuada puede consumir hasta el 3% o 4% de las ventas totales de una cadena de retail, borrando el margen neto de utilidad del negocio.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/Sl0iAuy_Dto"" title=""Diseño de sistema de control de merma sección fruver"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Las 3 Fuentes Principales de Merma en Comercio</h4>
    <p>Para combatir las pérdidas en piso de venta, se debe entender su origen estadístico:</p>
    <ul>
        <li><strong>Hurto Externo (Farderos y Ocasionales - ~38% de la merma):</strong> Sustracción de productos por parte de supuestos clientes que ocultan artículos entre sus ropas, bolsos forrados de aluminio o carritos de bebés.</li>
        <li><strong>Hurto Interno y Colusión de Empleados (~35% de la merma):</strong> Complicidad entre cajeros y clientes amigos para pasar artículos sin escanear (<em>Sweethearting</em>), consumo no pagado de mercancía en bodegas o sustracción en basuras.</li>
        <li><strong>Merma Operativa y Averías (~27% de la merma):</strong> Productos que se caen de las góndolas por apilamiento inestable, cajas que se abren con cutters de forma torpe cortando la mercancía interna o productos vencidos por no rotar las fechas de caducidad.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-eye-fill text-primary me-2""></i>2. Detección de Modus Operandi y Disuasión con Servicio al Cliente</h4>
    <p>El arma preventiva más poderosa contra el hurto en tiendas minoristas no son las cámaras ocultas, sino la <strong>Atención al Cliente Activa</strong>. El ladrón busca anonimato y rincones ciegos sin supervisión. Cuando un empleado se acerca amablemente y le dice con contacto visual firme:</p>
    <div class=""p-3 bg-light rounded border text-center my-3"">
        <span class=""fw-bold text-primary fs-6"">""Buenos días, veo que le interesan nuestros productos de perfumería. Cualquier consulta estoy aquí al lado para atenderle.""</span>
    </div>
    <p class=""small text-muted"">Esta simple intervención desmantela la oportunidad del fardero sin confrontaciones agresivas, haciéndole saber que está siendo observado activamente por el personal del piso.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-octagon-fill text-danger me-2""></i>3. Señales de Alerta de Comportamiento Sospechoso</h4>
    <ul>
        <li>Personas con ropa excesivamente abrigada o chaquetas gruesas en días calurosos.</li>
        <li>Individuos que miran constantemente al personal y a las cámaras de seguridad en lugar de mirar los productos en los estantes.</li>
        <li>Llevar bolsas grandes de compras de otras tiendas con sellos rotos o mochilas entreabiertas apoyadas en el suelo.</li>
        <li>Tomar productos de alto valor y desplazarse hacia pasillos solitarios o zonas de artículos de bajo costo (ej: llevarse cosméticos caros al pasillo de escobas para esconderlos).</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Acusar o retener físicamente a un sospechoso sin protocolo legal:</strong> Acusar a alguien de hurto antes de que cruce la línea de caja sin haber pagado puede acarrear demandas judiciales por difamación y privación ilegítima de libertad. Siempre notifica al personal de seguridad autorizado para que actúe fuera de la línea de cobro.</li>
        <li><strong>Cortar cajas de mercancía nueva con cutters profundos:</strong> Introducir la cuchilla del cutter al máximo al abrir cajas maestras de cartón corta las etiquetas y empaques de los productos internos, generando merma evitable antes de que el artículo llegue a la góndola.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Mantienes contacto visual y saludo activo con todos los clientes en tu zona de pasillo?</li>
            <li>¿Ajustas las cuchillas de corte para no dañar los productos al abrir cajas en bodega?</li>
            <li>¿Revisas periódicamente los puntos ciegos y verificas que los sensores antihurto estén colocados?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Gestión de Cambios, Devoluciones y Manejo de Clientes Difíciles",
                            LessonTitle = "Procedimientos de Garantía, Libro de Reclamaciones y Resolución Positiva",
                            Summary = "Transforma quejas en fidelidad: política legal de cambios y garantías, auditoría física de productos devueltos, emisión de notas de crédito y la técnica LAST para desescalar clientes irritados.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-heart-pulse-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Paradoja de la Recuperación del Servicio</h5>
            <p class=""mb-0 small"">Los estudios de retención en retail demuestran que un cliente que tuvo un problema con un producto y fue atendido con rapidez, empatía y solución inmediata se vuelve más leal a la marca que un cliente que nunca tuvo ningún inconveniente.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/4heWWZvAut0"" title=""Administración de Devoluciones y Cambios"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. El Método L.A.S.T. para Desescalar Situaciones Tensas</h4>
    <p>Cuando un cliente llega al mostrador furioso, alzando la voz por un producto defectuoso, el peor error del asistente es ponerse a la defensiva o discutir. Los entrenadores de servicio al cliente enseñan la técnica <strong>L.A.S.T.</strong>:</p>
    <div class=""row g-2 mb-4"">
        <div class=""col-md-3"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-primary mb-2"">L - Listen (Escuchar)</span>
                <p class=""small mb-0 text-muted"">Dejar que el cliente exprese toda su frustración sin interrumpir. El cliente necesita desahogar su energía emocional antes de estar listo para escuchar soluciones lógicas.</p>
            </div>
        </div>
        <div class=""col-md-3"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-success mb-2"">A - Apologize (Disculparse)</span>
                <p class=""small mb-0 text-muted"">Disculparse por la molestia o inconveniente ocasionado (no significa aceptar culpa personal): <em>'Lamento mucho el tiempo que ha perdido por este inconveniente, entiendo perfectamente su molestia'</em>.</p>
            </div>
        </div>
        <div class=""col-md-3"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-warning text-dark mb-2"">S - Solve (Resolver)</span>
                <p class=""small mb-0 text-muted"">Proponer una solución concreta e inmediata dentro de las políticas de la empresa: cambio por un producto nuevo probado en el momento o emisión de nota de crédito.</p>
            </div>
        </div>
        <div class=""col-md-3"">
            <div class=""p-3 bg-light rounded border h-100"">
                <span class=""badge bg-secondary mb-2"">T - Thank (Agradecer)</span>
                <p class=""small mb-0 text-muted"">Agradecer por señalar el fallo: <em>'Gracias por informarnos sobre este lote, nos ayuda a revisar con el fabricante y asegurar la calidad de nuestros productos'</em>.</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-clipboard-check-fill text-primary me-2""></i>2. Protocolo de Inspección Física del Producto Devuelto</h4>
    <p>Antes de autorizar un cambio o devolución, el asistente debe realizar la verificación técnica de los 4 puntos:</p>
    <ol>
        <li><strong>Comprobante Fiscal de Compra:</strong> Factura original, ticket de caja o registro digital del cliente en el sistema.</li>
        <li><strong>Plazo de Garantía Vigente:</strong> Comprobar que la solicitud esté dentro de los días estipulados por la política de la empresa (ej: 7 días para cambio directo en tienda y 30 a 90 días por garantía de fábrica).</li>
        <li><strong>Estado Físico del Empaque y Accesorios:</strong> Verificar que contenga el manual, cables, cargadores originales y que la caja no esté destrozada.</li>
        <li><strong>Descarte de Mal Uso o Manipulación Indebida:</strong> Constatar que el equipo no presente golpes por caída, humedad (sensores de líquido mojados en electrónicos) o sellos de garantía violados por talleres no autorizados.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-file-earmark-text-fill text-primary me-2""></i>3. Emisión de Notas de Crédito y Manejo del Libro de Reclamaciones</h4>
    <p>Si el cliente no desea cambiar el artículo por otro en ese momento, el procedimiento contable correcto es emitir una <strong>Nota de Crédito</strong> en el software de facturación:</p>
    <ul>
        <li>La nota de crédito reingresa el artículo devuelto al stock (o lo envía al almacén de averías si está dañado) y genera un saldo a favor que el cliente puede utilizar en compras futuras.</li>
        <li>Si el cliente exige plasmar su reclamo en el <strong>Libro de Reclamaciones formal</strong>, entrega el formato con amabilidad y serenidad. Registrar un reclamo es un derecho legal del consumidor; atenderlo con respeto previene sanciones de los organismos de protección al consumidor.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Tomarse los reclamos como ataques personales:</strong> El cliente está molesto con el producto o con el servicio de la empresa, no contigo. Mantén el tono de voz calmado, pausado y profesional; nunca respondas con sarcasmo o agresividad.</li>
        <li><strong>Reintegrar productos defectuosos a la góndola de venta regular:</strong> Si aceptas la devolución de un producto con falla y lo vuelves a colocar en el estante de venta, otro cliente lo comprará al día siguiente y el problema se multiplicará por dos. Los productos dañados deben enviarse de inmediato al área de merma/garantías con su etiqueta de fallo.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Aplicaste la técnica LAST de escucha activa y empatía ante clientes enojados?</li>
            <li>¿Inspeccionaste accesorios, empaque y sellos de garantía antes de procesar el cambio?</li>
            <li>¿Etiquetaste y aislaste el producto defectuoso para que no regrese a las estanterías de venta?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es el primer paso obligatorio que debe realizar un cajero al recibir el turno de trabajo?",
                            OptionA = @"Encender el televisor de la tienda.",
                            OptionB = @"Realizar el conteo físico del fondo inicial de caja (sencillo) en presencia de un supervisor y firmar la entrega.",
                            OptionC = @"Realizar un retiro de remesa a la bóveda.",
                            OptionD = @"Cambiar las contraseñas del sistema POS.",
                            CorrectAnswer = "B",
                            Explanation = @"Contar el fondo inicial garantiza que el cajero inicie su jornada con el dinero exacto para dar cambio y sin faltantes previos heredados."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿En qué consiste la técnica comercial de 'Venta Cruzada' (Cross-Selling)?",
                            OptionA = @"En cobrar dos veces el mismo producto por error.",
                            OptionB = @"En sugerir un producto complementario útil que se relacione directamente con el artículo principal que el cliente ya eligió.",
                            OptionC = @"En convencer al cliente de que no compre nada.",
                            OptionD = @"En vender artículos de la tienda vecina.",
                            CorrectAnswer = "B",
                            Explanation = @"La venta cruzada eleva el ticket ofreciendo accesorios o insumos directamente vinculados a la necesidad del cliente."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la forma más profesional y efectiva de disuadir intentos de hurto en el piso de venta sin generar conflictos?",
                            OptionA = @"Gritar por el altavoz el nombre de la persona sospechosa.",
                            OptionB = @"Brindar un saludo y atención al cliente activa, amable y cercana ('¡Buenas tardes! ¿En qué puedo asesorarle hoy?').",
                            OptionC = @"Cerrar las puertas con llave para que nadie pueda salir.",
                            OptionD = @"Seguir a la persona a 10 centímetros de distancia con cara de enojo.",
                            CorrectAnswer = "B",
                            Explanation = @"La presencia de servicio y el contacto visual le demuestran a la persona que el personal está atento, disuadiendo el hurto de manera cordial."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué documento emitido por el punto de venta (POS) resume las operaciones de tarjetas de crédito/débito al cerrar el turno?",
                            OptionA = @"El catálogo de precios.",
                            OptionB = @"El reporte de Cierre de Lote o Reporte Z del terminal financiero.",
                            OptionC = @"La lista de asistencia del personal.",
                            OptionD = @"El contrato de trabajo del cajero.",
                            CorrectAnswer = "B",
                            Explanation = @"El cierre de lote liquida electrónicamente las transacciones del día y emite el total consolidado para el cuadre contable."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué se debe verificar antes de procesar una devolución o cambio de producto en tienda?",
                            OptionA = @"El comprobante o factura fiscal de compra dentro del plazo vigente y el estado físico impecable del artículo y empaque.",
                            OptionB = @"Que el cliente tenga más de 30 años de edad.",
                            OptionC = @"Que el producto esté abierto y usado por varias semanas.",
                            OptionD = @"Que el supervisor no se encuentre en la tienda.",
                            CorrectAnswer = "A",
                            Explanation = @"La política de cambios exige constancia legal de compra y que el producto no presente maltrato ni uso indebido para volver al stock."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué significa hacer un 'Arqueo Ciego' de caja?",
                            OptionA = @"Contar el dinero con los ojos cerrados.",
                            OptionB = @"Que el cajero cuenta todo el dinero y comprobantes sin ver previamente el saldo que el sistema informático dice que debería haber.",
                            OptionC = @"Apagar las luces del local para contar las monedas.",
                            OptionD = @"Entregar la gaveta de dinero sin contar nada.",
                            CorrectAnswer = "B",
                            Explanation = @"El arqueo ciego evita manipulaciones deliberadas para 'cuadrar a la fuerza' diferencias o faltantes de dinero."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"Si un cliente llega al mostrador furioso porque un artículo que compró no funciona, ¿cuál debe ser la primera reacción del asistente?",
                            OptionA = @"Discutir fuertemente y decirle que la culpa es de él por no saber usarlo.",
                            OptionB = @"Mantener la calma, escuchar activamente sin interrumpir, mostrar empatía y proceder a la revisión según la política de garantías.",
                            OptionC = @"Ignorarlo y llamar a la policía inmediatamente.",
                            OptionD = @"Darse la vuelta y marcharse a la bodega.",
                            CorrectAnswer = "B",
                            Explanation = @"La contención empática y la escucha activa desarman la hostilidad y canalizan la solución de forma profesional."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué es importante realizar 'Retiros de Efectivo' o remesas periódicas de la caja a lo largo del turno?",
                            OptionA = @"Para gastar el dinero en compras personales.",
                            OptionB = @"Por seguridad operativa, para minimizar la cantidad de dinero expuesta en gaveta ante posibles robos o emergencias.",
                            OptionC = @"Porque la gaveta de caja se rompe si tiene más de 10 billetes.",
                            OptionD = @"Para pagarle a los proveedores en efectivo sin factura.",
                            CorrectAnswer = "B",
                            Explanation = @"Mantener montos bajos en la caja minimiza el riesgo financiero y patrimonial del negocio."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué es el 'Upselling' en una conversación de venta?",
                            OptionA = @"Ofrecer una versión de mayor gama o con prestaciones superiores demostrando el valor y beneficio añadido.",
                            OptionB = @"Obligar al cliente a llevar tres unidades del mismo artículo.",
                            OptionC = @"Rebajar el precio a la mitad sin permiso de la gerencia.",
                            OptionD = @"Vender productos vencidos con descuento.",
                            CorrectAnswer = "A",
                            Explanation = @"El upselling orienta al cliente hacia una alternativa superior que satisface mejor su necesidad a cambio de un valor justo."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué elemento de seguridad básica en un billete de curso legal suele verificarse con luz ultravioleta o al trasluz?",
                            OptionA = @"La marca de agua nítida, la cinta de seguridad incrustada y los hilos fluorescentes.",
                            OptionB = @"El aroma del papel moneda.",
                            OptionC = @"El grosor de la tinta de bolígrafo.",
                            OptionD = @"El sello de la tienda de la esquina.",
                            CorrectAnswer = "A",
                            Explanation = @"Las marcas de agua, fibras fluorescentes y cintas de seguridad son elementos intrínsecos de alta seguridad imposibles de fotocopiar."
                        }
                    }                },

                // =========================================================================
                // 4. MERCADERISTA Y TRADE MERCHANDISING
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "mercaderista-trade-merchandising-punto-venta",
                    Title = "Mercaderista y Trade Merchandising: Exhibición, Rotación y Gestión en Punto de Venta",
                    CategorySlug = "ventas-comercio-retail",
                    ShortDescription = "El arte de vender en el anaquel: Trade Marketing, planogramas, niveles visuales de exhibición, rotación estricta FEFO/PEPS contra caducidades y material publicitario POP.",
                    FullDescription = "Capacitación especializada para mercaderistas, promotores y supervisores de canal moderno (supermercados, farmacias, tiendas de conveniencia). Aprende a conquistar la 'Zona Caliente' de la góndola (a la altura de los ojos y de las manos); ejecuta planogramas con criterio de Share of Shelf; aplica rotación estricta de fechas de vencimiento (FEFO); negocia espacios adicionales con el jefe de piso; e instala material POP de alto impacto.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Fundamentos de Trade Marketing y Niveles de Exhibición",
                            LessonTitle = "La Batalla por el Anaquel: De la Zona Caliente a la Zona Fría",
                            Summary = "Comprende el comportamiento del comprador (Shopper) frente a la góndola: los 4 niveles de exhibición (ojos, manos, cintura, suelo), cabeceras de góndola e islas promocionales.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-display fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Lo que no se ve, no se vende: La Ciencia del Anaquel</h5>
            <p class=""mb-0 small"">El 70% de las decisiones de compra de bienes de consumo masivo se toman en el pasillo del supermercado en menos de 5 segundos. La posición que ocupa tu producto en la estantería determina si el cliente lo echa al carrito o si lo ignora por completo.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/FfDLSM_bHiw"" title=""Trade Marketing - Qué es y Claves para Triunfar"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. ¿Qué es el Trade Marketing y Qué Rol Cumple el Mercaderista?</h4>
    <p>Mientras que el marketing tradicional busca seducir al consumidor a través de anuncios de televisión o redes sociales, el <strong>Trade Marketing</strong> se enfoca en seducir al <em>comprador (Shopper)</em> en el punto de venta físico y en lograr la colaboración estratégica con el canal distribuidor (supermercados, cadenas de farmacias, mayoristas).</p>
    <p>El <strong>Mercaderista</strong> es el embajador de la marca en el terreno. Su misión no es solo reponer cajas vacías; es asegurar que los productos de la empresa tengan la mayor visibilidad, estén limpios, exhiban el precio correcto y ocupen el espacio pactado en los contratos comerciales.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-bar-chart-steps text-primary me-2""></i>2. Los Cuatro Niveles Verticales de la Góndola</h4>
    <p>La altura en la que se coloca un producto en la estantería tiene un impacto directo comprobado en su velocidad de rotación:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Nivel de Góndola</th>
                    <th>Altura Promedio</th>
                    <th>Eficacia Comercial</th>
                    <th>Tipo de Producto Ideal</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-danger"">Nivel de los Ojos (Eye Level)</td>
                    <td>1.40 m - 1.70 m</td>
                    <td><strong>Zona Caliente Máxima:</strong> Concentra más del 50% de las ventas espontáneas.</td>
                    <td>Productos estrella de alta rentabilidad, marcas premium y lanzamientos de temporada.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-success"">Nivel de las Manos (Touch Level)</td>
                    <td>0.80 m - 1.40 m</td>
                    <td><strong>Zona Caliente Secundaria:</strong> Muy alta accesibilidad y compra por impulso sin esfuerzo físico.</td>
                    <td>Productos de alta rotación y consumo frecuente que complementan la compra.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-warning text-dark"">Nivel de la Cintura</td>
                    <td>0.50 m - 0.80 m</td>
                    <td><strong>Zona Neutra:</strong> Requiere inclinarse levemente para tomar el producto.</td>
                    <td>Marcas secundarias o empaques medianos.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-secondary"">Nivel del Suelo (Floor Level)</td>
                    <td>0.00 m - 0.50 m</td>
                    <td><strong>Zona Fría:</strong> Requiere agacharse por completo; baja visibilidad.</td>
                    <td>Productos de primera necesidad y gran volumen (sacos de arroz de 10 kg, botellones de detergente o productos pesados que el cliente busca obligatoriamente).</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-star-fill text-warning me-2""></i>3. Puntos de Exhibición Adicionales (Puntos Calientes de la Tienda)</h4>
    <p>Además de la góndola regular de pasillo, los mercaderistas profesionales negocian espacios privilegiados:</p>
    <ul>
        <li><strong>Cabeceras de Góndola (Endcaps):</strong> Los extremos frontales de los pasillos principales por donde circula el 100% de los clientes. Multiplican las ventas hasta en un 300% durante promociones.</li>
        <li><strong>Islas y Racks Promocionales:</strong> Muebles independientes colocados en los pasillos centrales anchos para capturar la atención en eventos de temporada (Navidad, Regreso a Clases).</li>
        <li><strong>Check-out / Zona de Cajas (Línea de Espera):</strong> La meca de la compra por impulso (chicles, baterías, chocolates, bebidas frías), donde los clientes esperan en fila con dinero en mano listos para gastar el sencillo.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar productos sin fleje de precio:</strong> Un producto en el estante sin etiqueta de precio es un producto que no se vende; el 60% de los compradores no se arriesga a llevar un artículo si desconoce cuánto cuesta por temor a pasar vergüenza en caja.</li>
        <li><strong>Permitir que la competencia 'canibalice' el espacio pactado:</strong> Si la empresa pagó por 4 frentes (facings) de exhibición y el mercaderista de la marca rival corre tus productos para meter los suyos, estás perdiendo ventas que tu empresa financió.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Ubicaste los productos de mayor margen en el nivel de los ojos y de las manos?</li>
            <li>¿Verificaste que cada producto tenga su fleje de precio visible y actualizado?</li>
            <li>¿Defendiste los frentes de anaquel pactados en el contrato comercial con la tienda?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Interpretación y Ejecución de Planogramas",
                            LessonTitle = "Diseño Modular, Participación en Anaquel (Share of Shelf) y Facings",
                            Summary = "Domina la lectura técnica de planogramas: cálculo de frentes visuales (facings), participación de espacio según cuota de mercado (Share of Shelf) y respeto a la distribución por bloques de marca.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-grid-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Planograma: El Plano Arquitectónico de las Ventas en Retail</h5>
            <p class=""mb-0 small"">En las grandes cadenas de supermercados, el orden de los productos no se decide al gusto del reponedor. Cada centímetro de estantería está matemáticamente diseñado en un diagrama técnico llamado planograma para maximizar la rentabilidad por metro cuadrado.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/5dBEjzExOu0"" title=""Visual Merchandising - TUTORIAL COMO EXPORTAR UN PLANOGRAMA"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. ¿Qué es un Planograma y Cómo se Interpreta?</h4>
    <p>Un <strong>Planograma (POG)</strong> es una representación gráfica bidimensional detallada que especifica la ubicación exacta, el número de estantes, la altura de cada bandeja y la cantidad de caras visibles que debe tener cada SKU en la góndola.</p>
    <p>Para ejecutarlo en piso, el mercaderista debe interpretar su simbología técnica:</p>
    <ul>
        <li><strong>Módulo / Tramo:</strong> Sección vertical estándar de góndola (generalmente de 0.90 m o 1.20 m de ancho). Un planograma puede abarcar 3 o 4 tramos continuos.</li>
        <li><strong>Bandeja / Nivel:</strong> Cada una de las baldas horizontales numeradas de arriba hacia abajo (Nivel 1 es el superior, Nivel 5 es la base).</li>
        <li><strong>Facing (Frente Visual):</strong> La cantidad de unidades de un mismo producto que se colocan en primera fila mirando directamente al consumidor. Si un champú tiene 3 facings, significa que se ven 3 botellas una al lado de la otra de frente, con sus respectivos bultos apilados detrás en profundidad.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-pie-chart-fill text-primary me-2""></i>2. El Principio del Share of Shelf (Participación en Anaquel)</h4>
    <p>La regla de oro del Trade Marketing establece que <strong>la participación de una marca en el anaquel debe ser proporcional a su participación de mercado real (Share of Market)</strong>:</p>
    <div class=""p-3 bg-light rounded border font-monospace small mb-3 text-dark text-center"">
        <code>Si tu marca tiene el 30% de las ventas de la categoría ➔ Debe ocupar al menos el 30% del espacio físico en centímetros de la góndola.</code>
    </div>
    <p class=""small text-muted"">Si tu marca vende el 40% del mercado pero solo tiene el 15% del anaquel, se producirán constantes <em>Quiebres de Stock (Out of Stock)</em>, obligando al consumidor a comprar la marca competidora por falta de producto visible.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-columns text-success me-2""></i>3. Estrategias de Bloque: Bloqueo Horizontal vs Bloqueo Vertical</h4>
    <p>Al acomodar los productos según el planograma, se aplican dos técnicas de agrupación:</p>
    <ul>
        <li><strong>Bloqueo Vertical (Recomendado):</strong> Agrupar toda la familia de la marca verticalmente atravesando todos los niveles (desde los ojos hasta el suelo). Esto permite que el comprador, al caminar por el pasillo, vea la marca completa de un solo vistazo sin tener que desplazarse horizontalmente.</li>
        <li><strong>Bloqueo Horizontal:</strong> Colocar toda la línea en una sola bandeja larga. Es menos visible y suele provocar que los productos ubicados en los extremos pasen desapercibidos.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>'Tapar huecos' con productos equivocados cuando hay quiebre de stock:</strong> Si se agotó el jugo de naranja, rellenar ese espacio con jugo de manzana altera el planograma y confunde el sistema de reposición automática de la tienda, haciendo que el sistema crea que hay stock de naranja cuando en realidad está quebrado.</li>
        <li><strong>Colocar productos con las etiquetas hacia atrás o ladeadas:</strong> Todos los productos deben colocarse estrictamente con el logotipo frontal visible, alineados milimétricamente al borde frontal de la bandeja (técnica de <em>Fronting o Frenteo</em>).</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Respetaste la cantidad exacta de facings asignados en el planograma técnico oficial?</li>
            <li>¿Realizaste el 'frenteo' alineando todos los productos al borde de la balda con el logo de frente?</li>
            <li>¿Comprobaste que los productos no estén ocultos detrás de postes estructurales de la tienda?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Rotación FEFO/FIFO y Cero Vencimientos",
                            LessonTitle = "Gestión de Caducidades: Primero que Vence, Primero que Sale",
                            Summary = "Elimina pérdidas por vencimiento en alimentos, farmacia y cosméticos. Domina la metodología FEFO (First Expired, First Out), el protocolo de semaforización de caducidades y el retiro oportuno de mermas.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-hourglass-bottom fs-2 text-danger""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Vencimientos Cero: La Regla de Oro en Alimentos y Medicinas</h5>
            <p class=""mb-0 small"">Dejar un producto vencido en la góndola no es solo una pérdida económica por merma; es un delito contra la salud pública que acarrea multas sanitarias devastadoras, cierres de tiendas y demandas para la empresa.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/nneseq7x5CY"" title=""Método FIFO (Primera Entrada, Primera Salida). Valoración de inventarios"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. La Diferencia Fundamental entre FIFO y FEFO</h4>
    <p>En el control de inventarios de consumo masivo, existen dos metodologías de rotación:</p>
    <ul>
        <li><strong>FIFO / PEPS (First In, First Out - Primero en Entrar, Primero en Salir):</strong> Basado en la fecha de llegada al almacén. El lote que entró primero al depósito es el que primero se despacha. Es útil para artículos que no se vencen (como ferretería, repuestos o cuadernos).</li>
        <li><strong>FEFO / PVPS (First Expired, First Out - Primero en Vencer, Primero en Salir):</strong> Basado en la <strong>Fecha de Caducidad Real impresa en el empaque</strong>. Aunque un lote haya llegado ayer, si vence antes que el lote recibido la semana pasada, ese producto DEBE colocarse en primera fila para venderse primero. Es la regla obligatoria en alimentos, lácteos, carnes, bebidas, medicamentos y cosméticos.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shuffle text-primary me-2""></i>2. El Procedimiento Físico de Rotación en la Góndola</h4>
    <p>El error de los mercaderistas perezosos es colocar la mercancía nueva que viene de la bodega directamente encima o delante de los productos que ya estaban en el estante. Esto condena a los productos del fondo a envejecer y pudrirse en la sombra.</p>
    <p>El procedimiento profesional inquebrantable consta de 4 pasos:</p>
    <ol>
        <li><strong>Bajar o correr hacia adelante:</strong> Retirar temporalmente los productos que ya están en la góndola.</li>
        <li><strong>Limpiar la bandeja:</strong> Pasar un paño con desinfectante para retirar polvo o manchas.</li>
        <li><strong>Ingresar la mercancía nueva al fondo:</strong> Colocar los productos con fecha de vencimiento más lejana en la parte trasera de la estantería.</li>
        <li><strong>Colocar la mercancía anterior al frente:</strong> Ubicar los productos con fecha más próxima al vencimiento en primera fila, listos para que el cliente los tome primero.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-stoplights-fill text-warning me-2""></i>3. Matriz de Semaforización de Caducidades</h4>
    <p>Para no ser sorprendidos por productos vencidos, los mercaderistas auditan sus góndolas clasificando los artículos con una plantilla semáforo:</p>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Estado Semáforo</th>
                    <th>Tiempo Restante de Vida Útil</th>
                    <th>Acción Operativa Obligatoria</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-success"">Verde (Normal)</td>
                    <td>Más de 90 días de vigencia.</td>
                    <td>Rotación estándar FEFO sin alertas.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-warning text-dark"">Amarillo (Alerta Preventiva)</td>
                    <td>Entre 30 y 60 días para vencer.</td>
                    <td>Priorizar facings delanteros y evaluar con el supervisor la colocación de un sticker promocional o descuento comercial.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-danger"">Rojo (Crítico / Retiro)</td>
                    <td>Menos de 15 días (o según política de la cadena).</td>
                    <td><strong>Retiro inmediato de la góndola:</strong> Trasladar a bodega para devolución a proveedor o destrucción formal con acta de merma antes de la fecha límite.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir Fecha de Elaboración con Fecha de Caducidad:</strong> Muchos productos importados muestran dos fechas en formato anglosajón (<code>MM/DD/AAAA</code> en lugar de <code>DD/MM/AAAA</code>). Interpretar mal el mes puede llevar a desechar productos buenos o exhibir productos vencidos.</li>
        <li><strong>No revisar productos con empaque abollado o hinchado:</strong> Latas con golpes en las costuras o envases tetra-brik hinchados pueden contener bacterias peligrosas (como Clostridium botulinum). Deben retirarse de la venta inmediatamente aunque su fecha de caducidad esté vigente.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Aplicaste la rotación FEFO poniendo siempre los productos próximos a vencer en primera fila?</li>
            <li>¿Revisaste el formato de fecha (día/mes/año) de cada lote que ingresó de la bodega?</li>
            <li>¿Retiraste de inmediato cualquier producto con empaque deteriorado o abollado?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Material POP, Exhibiciones Adicionales y Relación con el Jefe de Piso",
                            LessonTitle = "Tácticas de Visibilidad: Stoppers, Cenefas, Racks y Negociación en Tienda",
                            Summary = "Conquista el punto de venta con material publicitario POP (Point of Purchase): stoppers, cenefas, floor prints y cabezales. Aprende a negociar espacios adicionales con el Gerente de Tienda.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-badge-ad-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Material POP: Romper la Monotonía del Pasillo</h5>
            <p class=""mb-0 small"">Una góndola llena de botellas idénticas es invisible para el cliente que camina distraído mirando su teléfono celular. El material POP rompe la línea visual, resalta promociones y detiene el paso del comprador en seco.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/uf8lW2dan1A"" title=""Producción y Montaje de Material POP en Retail"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Tipos de Material P.O.P. (Point of Purchase)</h4>
    <p>El material POP se compone de todos los elementos publicitarios visuales temporales colocados en el punto de contacto con el cliente:</p>
    <ul>
        <li><strong>Stoppers / Rompetráficos:</strong> Carteles plásticos perpendiculares a la góndola que sobresalen hacia el centro del pasillo. Obligan al cliente a ver la marca mientras camina de frente.</li>
        <li><strong>Cenefas (Shelf Strips):</strong> Tiras adhesivas o plásticas que se insertan a lo largo del fleje metálico de la bandeja, destacando los colores de la marca, el slogan o el precio de oferta.</li>
        <li><strong>Dangler / Wobbler:</strong> Cartelitos suspendidos por una tira plástica flexible que se mueven y vibran con las corrientes de aire del pasillo, atrayendo el reflejo visual periférico del ojo.</li>
        <li><strong>Floor Prints (Viniles de Suelo):</strong> Adhesivos de alta resistencia pegados en el piso que guían las pisadas del cliente hacia la sección de la marca.</li>
        <li><strong>Racks y Exhibidores de Cartón (Displays):</strong> Muebles independientes colocados en cabeceras o esquinas estratégicas para campañas específicas.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-people-fill text-primary me-2""></i>2. La Relación Estratégica con el Jefe de Piso y Gerente de Tienda</h4>
    <p>El éxito de un mercaderista depende en un 50% de su técnica y en un 50% de sus relaciones interpersonales con el personal de la tienda (jefe de pasillo, jefe de almacén y gerente de sucursal). Un buen mercaderista aplica las siguientes normas de conducta:</p>
    <ol>
        <li><strong>Puntualidad y Respeto a las Normas de Recepción:</strong> Llegar en los horarios permitidos de reposición, utilizar uniforme impecable y portar carnet de identificación y calzado de seguridad en bodega.</li>
        <li><strong>Colaboración y Orden:</strong> Nunca dejar cajas vacías tiradas en el pasillo que obstaculicen el paso de los clientes o causen tropiezos. El pasillo debe quedar más limpio de lo que estaba antes de la reposición.</li>
        <li><strong>Argumentar con Datos de Venta para Ganar Espacios:</strong> Para pedirle al jefe de tienda un espacio adicional en cabecera de góndola, no digas: <em>'Póngame aquí porque se ve bonito'</em>; argumenta con números: <em>'Jefe, este producto creció un 25% en ventas el mes pasado y si le colocamos una cabecera este fin de semana, la tienda aumentará la facturación de esta categoría en $800 USD'</em>.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-camera-fill text-primary me-2""></i>3. El Reporte Fotográfico de Auditoría (Antes y Después)</h4>
    <p>Las marcas exigen a sus mercaderistas documentar su trabajo diario mediante aplicaciones móviles de Trade Marketing:</p>
    <ul>
        <li><strong>Foto 'Antes':</strong> Muestra el estado del anaquel al llegar (desordenado, con huecos o sin precios) para evidenciar el trabajo pendiente.</li>
        <li><strong>Foto 'Después':</strong> Muestra la góndola 100% frenteada, limpia, con planograma cumplido, precios colocados y material POP instalado.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar material POP deteriorado, roto o desteñido:</strong> Un stopper sucio, doblado o con cinta pegante manchada transmite una imagen de abandono y mala calidad de la marca. Si el material POP está roto, retíralo o cámbialo por uno nuevo.</li>
        <li><strong>Tapar productos con el material publicitario:</strong> Instalar un wobbler o un stopper de tal manera que oculte la etiqueta o el precio de otro producto genera el enfado del jefe de tienda y de las marcas competidoras.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Instalaste el material POP en los puntos autorizados sin tapar otros productos ni precios?</li>
            <li>¿Dejaste el pasillo y el área de góndola totalmente despejados de cajas vacías y basura?</li>
            <li>¿Tomaste y enviaste tu reporte fotográfico del 'Antes y Después' a tu supervisor de zona?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál de los siguientes niveles de exhibición en góndola concentra históricamente el mayor volumen de ventas espontáneas?",
                            OptionA = @"Nivel Suelo (por debajo de 80 cm).",
                            OptionB = @"Nivel Ojos (entre 1.30 m y 1.70 m).",
                            OptionC = @"Nivel Techo (por encima de 2 metros).",
                            OptionD = @"La trastienda de descarga.",
                            CorrectAnswer = "B",
                            Explanation = @"El nivel de los ojos es la primera zona de contacto visual directo y capta la mayor cantidad de decisiones impulsivas."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué indica el principio de rotación FEFO en la reposición de productos de consumo masivo?",
                            OptionA = @"First In, First Out (Primero en Entrar, Primero en Salir).",
                            OptionB = @"First Expired, First Out (El producto con fecha de vencimiento más próxima debe colocarse al frente para venderse primero).",
                            OptionC = @"Fast Entry, Fast Output (Venta ultra rápida sin control de fechas).",
                            OptionD = @"Free Exchange For Others (Cambios gratis sin factura).",
                            CorrectAnswer = "B",
                            Explanation = @"FEFO prioriza la fecha de caducidad real del empaque frente al orden de llegada al almacén para impedir que queden productos viejos atrapados al fondo."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué es un 'Facing' en el ámbito del trade merchandising?",
                            OptionA = @"Una foto carnet del mercaderista.",
                            OptionB = @"La cantidad de unidades frontales o caras de un mismo producto que se exhiben en la primera fila del estante.",
                            OptionC = @"El precio de oferta colocado con plumón.",
                            OptionD = @"Un tipo de detergente industrial.",
                            CorrectAnswer = "B",
                            Explanation = @"El facing mide la visibilidad horizontal directa del producto hacia el comprador en el anaquel."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué documento técnico visual detalla con precisión matemática la ubicación, cantidad de caras y orden de los productos en góndola?",
                            OptionA = @"El Planograma.",
                            OptionB = @"El Balance General de la empresa.",
                            OptionC = @"El Recibo de Sueldo.",
                            OptionD = @"El Cronograma de Vacaciones.",
                            CorrectAnswer = "A",
                            Explanation = @"El planograma es el plano formal diseñado por trade marketing que indica cómo montar exactamente cada sección."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué acción debe tomar el mercaderista si detecta un lote de productos a menos de 30 días de su fecha de vencimiento en góndola?",
                            OptionA = @"Ocultar los productos detrás de otras cajas para no tener problemas.",
                            OptionB = @"Avisar de inmediato al supervisor comercial y jefe de sección para activar protocolo de liquidación, promoción o canje oportuno.",
                            OptionC = @"Tirar los productos a la basura sin reportar a nadie.",
                            OptionD = @"Modificar la fecha de vencimiento con una etiqueta falsa.",
                            CorrectAnswer = "B",
                            Explanation = @"Reportar a tiempo permite activar promociones comerciales de salida o devoluciones al fabricante antes de que se convierta en pérdida total."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué es el 'Material POP' (Point of Purchase)?",
                            OptionA = @"Música bailable que suena en los altavoces de la tienda.",
                            OptionB = @"Elementos gráficos y publicitarios (cenefas, stoppers, afiches, bandejas) colocados en el punto de venta para llamar la atención del shopper.",
                            OptionC = @"El uniforme de tela que usan los cajeros.",
                            OptionD = @"El sistema contable de emisión de facturas.",
                            CorrectAnswer = "B",
                            Explanation = @"El material POP busca destacar visualmente una promoción o mensaje de marca en el lugar exacto de compra."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué las 'Cabeceras de Góndola' (puntas de pasillo) son consideradas zonas calientes de venta en un supermercado?",
                            OptionA = @"Porque están cerca del sol o de hornos de panadería.",
                            OptionB = @"Porque reciben el flujo constante de clientes que transitan por los pasillos principales, multiplicando la visibilidad.",
                            OptionC = @"Porque son los lugares más oscuros de la tienda.",
                            OptionD = @"Porque no requieren que nadie las limpie.",
                            CorrectAnswer = "B",
                            Explanation = @"El tráfico obligatorio en los extremos de pasillo garantiza que casi la totalidad de los compradores pasen frente a las cabeceras."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué significa el término 'Agotado' o 'Quiebre de Stock' (Out of Stock) en el anaquel?",
                            OptionA = @"Que el mercaderista está cansado tras su turno.",
                            OptionB = @"La ausencia total del producto en la góndola para la venta, impidiendo que el cliente lo compre.",
                            OptionC = @"Que el producto se vendió con 100% de descuento.",
                            OptionD = @"Que el producto cambió de empaque en la fábrica.",
                            CorrectAnswer = "B",
                            Explanation = @"Un quiebre de stock frustra la compra del cliente y entrega la venta directamente a la marca competidora."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es el beneficio de agrupar los productos formando 'Bloques de Marca' en la góndola?",
                            OptionA = @"Facilita apagar las luces del pasillo.",
                            OptionB = @"Crea un impacto visual cromático uniforme que ayuda al cliente a identificar rápidamente la marca a distancia.",
                            OptionC = @"Reduce el precio de costo del producto.",
                            OptionD = @"Evita tener que limpiar el polvo de los estantes.",
                            CorrectAnswer = "B",
                            Explanation = @"El bloque de marca consolida la presencia de la compañía y genera una mancha visual imposible de ignorar para el consumidor."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué los productos pesados o de gran volumen (como bolsas de 15 kg de comida para perros) se ubican en el nivel suelo?",
                            OptionA = @"Por ergonomía y seguridad: evita accidentes graves por caídas y facilita que el cliente los arrastre al carrito.",
                            OptionB = @"Porque a los perros les gusta mirar el suelo.",
                            OptionC = @"Porque están hechos de materiales que no se pueden mojar.",
                            OptionD = @"Para que nadie los encuentre.",
                            CorrectAnswer = "A",
                            Explanation = @"La ergonomía y prevención de riesgos laborales y del consumidor exigen ubicar cargas pesadas en las baldas inferiores."
                        }
                    }                },

                // =========================================================================
                // 5. VENTAS EN LÍNEA Y SOCIAL SELLING
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "ventas-en-linea",
                    Title = "Ventas en Línea: Estrategia Digital, Social Selling y Embudos de Conversión",
                    CategorySlug = "ventas-comercio-retail",
                    ShortDescription = "Domina el comercio conversacional y digital: ventas de alto impacto por WhatsApp Business, catálogos en Marketplaces (Mercado Libre, Facebook) y optimización de embudos.",
                    FullDescription = "Capacitación orientada a vendedores, emprendedores y asesores de comercio moderno. Aprende a convertir chats de WhatsApp Business en cierres de venta reales; domina las respuestas rápidas, etiquetas de seguimiento y catálogos de bolsillo; optimiza publicaciones en Marketplaces con palabras clave y reputación positiva; y calcula métricas clave del embudo digital como el Costo de Adquisición de Clientes (CAC) y el Retorno de Inversión Publicitaria (ROAS).",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: WhatsApp Business como Motor de Ventas y CRM de Bolsillo",
                            LessonTitle = "Configuración Profesional, Catálogo de Productos, Respuestas Rápidas y Etiquetas",
                            Summary = "Configura WhatsApp Business como una herramienta comercial de élite: perfil verificado de empresa, catálogo interactivo con enlaces directos, automatización de mensajes y organización con etiquetas de color.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-whatsapp fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">WhatsApp: El Canal con Mayor Tasa de Apertura del Mundo</h5>
            <p class=""mb-0 small"">Mientras que los correos electrónicos tienen una tasa de apertura de apenas el 18% al 22%, los mensajes de WhatsApp alcanzan un asombroso 98% de lectura en los primeros 15 minutos. Usar una cuenta personal en lugar de una cuenta Business le cuesta miles de dólares en ventas perdidas a cualquier empresa.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/ZyIFFFc6odc"" title=""WhatsApp Business - Potencia Tu Negocio con Brevo"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. WhatsApp Estándar vs WhatsApp Business</h4>
    <p>Utilizar una cuenta personal para atender clientes transmite informalidad y dificulta la gestión de prospectos. <strong>WhatsApp Business</strong> es una aplicación gratuita diseñada para empresas que incorpora herramientas comerciales ausentes en la versión estándar:</p>
    <ul>
        <li><strong>Perfil de Empresa Institucional:</strong> Muestra el logotipo de la marca, horarios de atención presencial, dirección física con enlace directo a Google Maps, correo electrónico corporativo y catálogo de productos.</li>
        <li><strong>Mensaje de Bienvenida Automático:</strong> Saluda al cliente en el milisegundo en que escribe por primera vez, transmitiendo atención inmediata 24/7.</li>
        <li><strong>Mensaje de Ausencia Programable:</strong> Informa cortésmente si el cliente escribe fuera del horario de oficina, indicándole a qué hora se le responderá y ofreciéndole consultar el catálogo mientras tanto.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-lightning-charge-fill text-warning me-2""></i>2. Respuestas Rápidas (Atajos de Teclado con '/')</h4>
    <p>Uno de los mayores sumideros de tiempo para los asesores comerciales es escribir 50 veces al día la misma información bancaria, los precios de envío o la dirección de la tienda. En WhatsApp Business se programan <strong>Respuestas Rápidas</strong> activadas con una barra inclinada (<code>/</code>):</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3"">
        <div class=""row g-2 font-monospace small"">
            <div class=""col-md-4""><code>/bancos</code> ➔ Datos de cuenta bancaria y Pago Móvil.</div>
            <div class=""col-md-4""><code>/envios</code> ➔ Tarifas de encomiendas y tiempos de entrega.</div>
            <div class=""col-md-4""><code>/horario</code> ➔ Horario de apertura de las sucursales.</div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-tags-fill text-success me-2""></i>3. El Embudo de Etiquetas de Color (Funnel de Clientes)</h4>
    <p>WhatsApp Business permite clasificar las conversaciones hasta con 20 <strong>Etiquetas de Colores</strong> personalizadas, funcionando como un CRM visual en la palma de la mano:</p>
    <ol>
        <li><span class=""badge bg-primary"">Azul</span> <strong>Nuevo Prospecto:</strong> Cliente que preguntó por primera vez y aún no ha cotizado.</li>
        <li><span class=""badge bg-warning text-dark"">Amarillo</span> <strong>Cotización Enviada:</strong> Ya se le enviaron precios; requiere seguimiento a las 24 horas.</li>
        <li><span class=""badge bg-danger"">Rojo</span> <strong>Pago Pendiente:</strong> Confirmó que va a comprar pero aún no ha transferido.</li>
        <li><span class=""badge bg-success"">Verde</span> <strong>Pagado / Por Despachar:</strong> Pago verificado en banco listo para empaque.</li>
        <li><span class=""badge bg-secondary"">Gris</span> <strong>Cliente Cerrado / Fidelizado:</strong> Venta completada para futuras ofertas.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Enviar mensajes masivos no solicitados a personas que no tienen tu número guardado:</strong> WhatsApp tiene políticas estrictas contra el SPAM. Si envías el mismo mensaje comercial a 100 personas desconocidas y varios marcan tu chat como 'Bloquear y Reportar', WhatsApp suspenderá tu número de teléfono de forma permanente en menos de 2 horas.</li>
        <li><strong>Tardar más de 15 minutos en responder en horario de oficina:</strong> En ventas digitales, la velocidad de respuesta es el factor número uno de cierre. Si tardas 2 horas en contestar '¿cuánto cuesta?', el cliente ya le habrá comprado a tu competidor por internet.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Configuraste tu perfil de empresa con dirección física, horarios y logo en alta resolución?</li>
            <li>¿Programaste respuestas rápidas (/) para tus datos de pago, envíos y preguntas frecuentes?</li>
            <li>¿Clasificas cada chat entrante con etiquetas de color según su etapa de compra?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Técnicas de Comercio Conversacional y Cierre por Chat",
                            LessonTitle = "Guiones de Venta, Manejo de '¿Cuánto Cuesta?' y Técnicas de Urgencia Ética",
                            Summary = "Domina el arte de vender por chat: responde al temido 'precio por favor' sin ahuyentar al cliente, utiliza notas de voz estratégicas de menos de 45 segundos y aplica cierres de alternativa doble.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-chat-heart-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Comercio Conversacional: La Venta Ocurre en el Diálogo, no en el Monólogo</h5>
            <p class=""mb-0 small"">Enviar un PDF gigante de 20 páginas sin saludar o responder con un precio seco sin contexto espanta a los compradores. El comercio conversacional guía al cliente a través de preguntas inteligentes hasta el momento natural del pago.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/v_QIJirOrmA"" title=""Más allá de un chatbot - Comercio Conversacional"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. Cómo Responder al Clásico: '¿Precio?'</h4>
    <p>El error más común de los vendedores digitales es soltar el precio sin más: <em>'$45'</em>. El cliente lee el número, no percibe el valor, y desaparece dejando la conversación en visto. El método profesional de respuesta en 3 pasos es:</p>
    <ol>
        <li><strong>Saludar por su nombre y validar la elección:</strong> <em>'¡Hola Juan! Excelente opción, ese modelo es uno de nuestros favoritos por su alta durabilidad...'</em></li>
        <li><strong>Aportar valor inmediato y entregar el precio claro:</strong> <em>'Incluye el kit de accesorios completo y garantía de 6 meses por un valor de $45 USD (o su equivalente en bolívares a tasa oficial).'</em></li>
        <li><strong>Cerrar SIEMPRE con una pregunta abierta de control:</strong> <em>'¿Lo necesitas para envío a domicilio en tu ciudad o prefieres retirarlo personalmente en nuestra tienda hoy mismo?'</em></li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-mic-fill text-danger me-2""></i>2. El Uso Estratégico de las Notas de Voz</h4>
    <p>El texto escrito puede sonar frío o impersonal. Una nota de voz transmite calidez, seguridad y profesionalismo, pero debe usarse bajo reglas estrictas:</p>
    <ul>
        <li><strong>Duración Máxima de 30 a 45 segundos:</strong> Nadie en internet tiene tiempo para escuchar un podcast de 3 minutos de un vendedor desconocido.</li>
        <li><strong>Nunca enviar un audio como primer mensaje:</strong> El primer contacto siempre debe ser en texto. Solo envía un audio cuando ya exista un intercambio previo o para explicar un detalle técnico complejo.</li>
        <li><strong>Modular la voz:</strong> Tono entusiasta, claro y seguro, sin ruidos molestos de fondo de televisión o tránsito vehicular.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-check2-all text-success me-2""></i>3. La Técnica del Cierre de Doble Alternativa</h4>
    <p>Nunca le preguntes a un cliente: <em>'¿Va a comprar?'</em> (le estás dando la oportunidad fácil de decir 'No'). En su lugar, utiliza el <strong>Cierre de Doble Alternativa</strong>, donde ambas opciones llevan al cierre de la venta:</p>
    <div class=""card border-0 bg-light p-3 mb-4 rounded-3 font-monospace small"">
        - <em>'¿Prefieres que te lo despachemos en color Negro o en color Azul marino?'</em><br />
        - <em>'¿Deseas cancelar mediante Pago Móvil o prefieres transferencia bancaria en divisas?'</em><br />
        - <em>'¿Te queda mejor recibir el paquete en la mañana o en la tarde?'</em>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Enviar el temido '¿Sigue interesado?':</strong> Escribir a los dos días '¿Hola, sigue interesado?' es una frase pasivo-agresiva que genera rechazo. En su lugar, reactiva el chat aportando valor nuevo: <em>'¡Hola María! Justo me acordé de tu consulta y nos acaban de llegar dos unidades adicionales con flete bonificado, ¿deseas que te reserve una?'</em>.</li>
        <li><strong>Respuestas frías con mala ortografía y abreviaturas callejeras:</strong> Escribir 'q', 'xq' o ignorar mayúsculas resta seriedad a la empresa. Escribe siempre con ortografía y puntuación impecable.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Terminas cada mensaje de cotización con una pregunta orientada a la acción?</li>
            <li>¿Mantienes tus audios explicativos en menos de 45 segundos con excelente modulación?</li>
            <li>¿Utilizas cierres de doble alternativa para facilitar la toma de decisión del cliente?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Venta en Marketplaces (Mercado Libre y Facebook Marketplace)",
                            LessonTitle = "Posicionamiento Orgánico, Reputación de Vendedor y Logística de Envíos",
                            Summary = "Domina las plataformas de mayor tráfico de Latinoamérica: algoritmo de búsqueda en Mercado Libre, títulos SEO optimizados, reputación MercadoLíder, seguridad contra estafas y envíos con Mercado Envíos.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-cart4 fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Marketplaces: Aprovechar el Tráfico Masivo de Millones de Compradores</h5>
            <p class=""mb-0 small"">Crear una tienda online propia requiere invertir dinero en publicidad para atraer visitas. En plataformas como Mercado Libre y Facebook Marketplace, los millones de compradores ya están ahí buscando con la tarjeta de crédito en la mano.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/kImOYBjqtK8"" title=""COMO VENDER MAS EN MARKETPLACE DE FACEBOOK"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-book-half text-primary me-2""></i>1. El Algoritmo de Búsqueda de Mercado Libre</h4>
    <p>Para aparecer en las primeras posiciones cuando un cliente busca un producto, se deben optimizar los factores que alimentan el algoritmo de indexación de Mercado Libre:</p>
    <ul>
        <li><strong>Estructura del Título (SEO):</strong> Máximo 60 caracteres. Producto + Marca + Modelo + Característica Principal (ej: <em>'Taladro Percutor Inalámbrico Bosch 18V Con 2 Baterías y Maletín'</em>). Nunca uses adjetivos vacíos como 'Lindo', 'Barato' u 'Original', ya que nadie busca esas palabras en la barra de búsqueda.</li>
        <li><strong>Ficha Técnica Completa al 100%:</strong> Rellenar todos los atributos específicos (voltaje, dimensiones, peso, material, código universal EAN/UPC). Las publicaciones con ficha técnica completa reciben hasta un 40% más de visibilidad en los filtros de la izquierda.</li>
        <li><strong>Foto Principal con Fondo Blanco Puro:</strong> Mercado Libre exige imágenes de mínimo 1200x1200 píxeles con fondo blanco digital (RGB 255,255,255) sin marcas de agua, bordes ni textos promocionales.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-star-fill text-warning me-2""></i>2. El Termómetro de Reputación: La Obsesión del Color Verde</h4>
    <p>En Mercado Libre, tener el termómetro en <strong>Verde Oscuro (MercadoLíder)</strong> es la diferencia entre vender todos los días o no vender nada. El sistema mide tres métricas implacables:</p>
    <div class=""row g-3 mb-4"">
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h6 class=""fw-bold text-danger mb-1"">Reclamos del Comprador</h6>
                <p class=""small text-muted mb-0"">Menos del <strong>1.5% al 2%</strong> de tus ventas pueden tener reclamos abiertos. Un reclamo por producto defectuoso o retraso impacta negativamente tu visibilidad.</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h6 class=""fw-bold text-warning text-dark mb-1"">Tiempo de Despacho</h6>
                <p class=""small text-muted mb-0"">Entregar el paquete a la agencia de envíos dentro de las primeras <strong>24 horas hábiles</strong>. Si entregas con retraso, el termómetro se pone amarillo de inmediato.</p>
            </div>
        </div>
        <div class=""col-md-4"">
            <div class=""p-3 bg-light rounded border h-100"">
                <h6 class=""fw-bold text-primary mb-1"">Cancelaciones por el Vendedor</h6>
                <p class=""small text-muted mb-0"">Menos del <strong>0.5% al 1%</strong> de cancelaciones por falta de stock. Si vendes algo que no tienes en bodega y cancelas la venta, la penalización es severa.</p>
            </div>
        </div>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shield-x text-danger me-2""></i>3. Prevención de Estafas en Facebook Marketplace y Entregas Personales</h4>
    <p>A diferencia de Mercado Libre que cuenta con pasarela integrada (Mercado Pago), Facebook Marketplace opera como un tablón de anuncios clasificados donde el riesgo de fraude es mayor:</p>
    <ul>
        <li><strong>NUNCA entregar productos con comprobantes de transferencia diferida o cheques en tránsito:</strong> La estafa más común consiste en depositar un cheque sin fondos en un cajero un viernes en la tarde; el banco muestra el saldo 'en tránsito o diferido', el comprador exige la entrega, y el lunes el cheque rebota sin fondos. Solo entrega cuando el dinero esté como <strong>Saldo Disponible</strong>.</li>
        <li><strong>Puntos de Encuentro Seguros:</strong> Si realizas entregas personales, cítate siempre en lugares públicos concurridos a plena luz del día (centros comerciales con vigilancia, estaciones de metro o frente a comandos policiales). Nunca acudas a zonas solitarias o desconocidas.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Tardar en responder las preguntas de los clientes en Mercado Libre:</strong> Responder en menos de 5 minutos multiplica la probabilidad de compra en un 300%. El comprador está comparando tres pestañas abiertas a la vez; el que contesta primero y con amabilidad se lleva la venta.</li>
        <li><strong>Vender en Marketplace sin sincronizar el inventario físico:</strong> Publicar productos sin verificar existencias te obligará a cancelar ventas, destruyendo tu reputación en la plataforma.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Estructuraste los títulos de tus publicaciones con palabras clave de búsqueda sin adjetivos vacíos?</li>
            <li>¿Mantienes tu termómetro de reputación en Verde Oscuro entregando los envíos en menos de 24 horas?</li>
            <li>¿Verificas el saldo disponible real en tu cuenta bancaria antes de entregar productos en persona?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Embudos Digitales y Métricas Financieras (CAC, LTV, ROAS)",
                            LessonTitle = "Análisis de Rentabilidad y Optimización de la Conversión Digital",
                            Summary = "Domina la matemática del comercio digital: etapas del embudo de conversión (TOFU, MOFU, BOFU), cálculo del Costo de Adquisición de Clientes (CAC), Lifetime Value (LTV) y Retorno de Inversión Publicitaria (ROAS).",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-cash-stack fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Matemática Detrás del Éxito en E-Commerce</h5>
            <p class=""mb-0 small"">Vender mucho por internet no garantiza tener ganancias. Si gastas $20 en publicidad digital para vender un producto que te deja $15 de margen de ganancia, estás perdiendo $5 en cada venta. Aprender a calcular el CAC y el ROAS es vital para no quebrar.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/ABRqXRMLt-8"" title=""Qué es el Embudo de Ventas en Marketing Digital"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-funnel-fill text-primary me-2""></i>1. Las 3 Etapas del Embudo de Ventas (Marketing Funnel)</h4>
    <p>Los clientes atraviesan un proceso psicológico antes de comprar. Se divide en tres fases:</p>
    <ul>
        <li><strong>TOFU (Top of the Funnel - Consciencia / Atracción):</strong> El usuario descubre que tiene un problema o deseo gracias a un video o publicación en redes sociales. El objetivo aquí es atraer atención con contenido educativo o inspirador.</li>
        <li><strong>MOFU (Middle of the Funnel - Consideración / Evaluación):</strong> El cliente compara opciones, lee opiniones, consulta fichas técnicas y evalúa marcas competidoras. Aquí se comparten testimonios y comparativas.</li>
        <li><strong>BOFU (Bottom of the Funnel - Decisión / Conversión):</strong> El cliente está listo para comprar. Requiere ofertas concretas, facilidades de pago, garantías claras y un botón de compra sin fricción.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-calculator-fill text-primary me-2""></i>2. Las Tres Métricas Financieras Críticas del Comercio Digital</h4>
    <div class=""table-responsive mb-4"">
        <table class=""table table-bordered table-sm small align-middle"">
            <thead class=""table-light"">
                <tr>
                    <th>Métrica Financiera</th>
                    <th>Fórmula de Cálculo</th>
                    <th>Interpretación de Negocio</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class=""fw-bold text-danger"">CAC (Customer Acquisition Cost)</td>
                    <td><code>Gasto Total en Publicidad / Clientes Nuevos Conseguidos</code></td>
                    <td>Cuánto dinero en pauta publicitaria te cuesta conseguir un cliente que pague. Si gastaste $500 en Meta Ads y conseguiste 50 clientes, tu CAC es de $10 USD por cliente.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-success"">LTV (Lifetime Value)</td>
                    <td><code>Ticket Promedio × Frecuencia de Compra al Año × Años de Retención</code></td>
                    <td>La cantidad total de dinero que un cliente dejará en la empresa a lo largo de toda su relación comercial. Si tu LTV es de $80 y tu CAC es de $10, tu negocio es altamente rentable.</td>
                </tr>
                <tr>
                    <td class=""fw-bold text-primary"">ROAS (Return on Ad Spend)</td>
                    <td><code>Ingresos Generados por Publicidad / Inversión Publicitaria</code></td>
                    <td>El multiplicador de retorno de la pauta. Un ROAS de 4x significa que por cada dólar invertido en anuncios de Facebook/Google, la tienda facturó 4 dólares en ventas.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-percent text-success me-2""></i>3. La Tasa de Conversión (Conversion Rate - CR)</h4>
    <p>En el comercio electrónico mundial, la <strong>Tasa de Conversión promedio oscila entre el 1% y el 3%</strong>:</p>
    <div class=""p-3 bg-light rounded border text-center my-3"">
        <code class=""fs-6 fw-bold"">Tasa de Conversión = (Número de Compras / Total de Visitas a la Web) × 100</code>
    </div>
    <p class=""small text-muted"">De cada 100 personas que entran a tu tienda online o te escriben al WhatsApp, típicamente entre 1 y 3 terminarán comprando. Si tu tasa de conversión es inferior al 0.5%, el problema no es la publicidad; es tu página web (precios poco competitivos, fotos de mala calidad, dudas sobre el envío o métodos de pago engorrosos).</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Escalar la inversión en publicidad cuando el embudo está roto:</strong> Si tu tienda tiene una tasa de conversión pésima porque el checkout falla, meterle $1.000 USD más de publicidad en Instagram solo aumentará las pérdidas. Primero optimiza la página y la atención por chat, y luego escala la pauta.</li>
        <li><strong>Tener un CAC superior al margen bruto del producto:</strong> Si tu producto deja $8 de ganancia y te cuesta $12 en publicidad conseguir una venta, estás quemando capital en cada pedido. Debes aumentar el ticket promedio con venta cruzada o mejorar los creativos de tus anuncios.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Calculas semanalmente tu CAC y tu ROAS para evaluar la rentabilidad de tus anuncios?</li>
            <li>¿La relación entre tu LTV y tu CAC es de al menos 3 a 1 para asegurar la sostenibilidad del negocio?</li>
            <li>¿Optimizas periódicamente las fichas de producto para elevar la tasa de conversión global?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la principal ventaja de utilizar 'Respuestas Rápidas' en WhatsApp Business?",
                            OptionA = @"Que WhatsApp regala crédito publicitario gratis.",
                            OptionB = @"Permite enviar información predefinida (catálogo, cuentas de pago, políticas) en segundos usando atajos como '/pago'.",
                            OptionC = @"Que bloquea a los clientes molestos automáticamente.",
                            OptionD = @"Que apaga el teléfono automáticamente al llegar la noche.",
                            CorrectAnswer = "B",
                            Explanation = @"Las respuestas rápidas estandarizan la calidad de atención y reducen el tiempo de espera drásticamente durante picos de consultas."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"Si un cliente potencial pregunta '¿Precio?' por chat, ¿cuál es el error más grave que cometen los vendedores principiantes?",
                            OptionA = @"Contestar amablemente con un saludo cordial.",
                            OptionB = @"Enviar únicamente el número del precio aislado sin explicar el valor ni rematar con una pregunta de cierre.",
                            OptionC = @"Confirmar que hay stock disponible en bodega.",
                            OptionD = @"Ofrecer opciones de entrega a domicilio.",
                            CorrectAnswer = "B",
                            Explanation = @"Dar solo el número sin propuesta de valor reduce la conversación a una comparación fría de precios y propicia el abandono del chat."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cómo se denomina la métrica que calcula cuánto dinero le cuesta a la empresa conseguir un nuevo cliente comprador?",
                            OptionA = @"ROAS (Return on Ad Spend).",
                            OptionB = @"CAC (Costo de Adquisición de Clientes).",
                            OptionC = @"CTR (Click-Through Rate).",
                            OptionD = @"EBITDA.",
                            CorrectAnswer = "B",
                            Explanation = @"CAC (Customer Acquisition Cost) divide todo el presupuesto de publicidad y ventas entre el número total de nuevos clientes logrados."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué es crucial responder preguntas en Marketplaces (como Mercado Libre) en menos de 10 minutos?",
                            OptionA = @"Porque el algoritmo premia el tiempo de respuesta y los compradores online suelen comprar a la primera tienda que les resuelve la duda.",
                            OptionB = @"Porque si tardas más de 10 minutos, el banco cancela tu cuenta.",
                            OptionC = @"Porque la aplicación se desinstala del teléfono.",
                            OptionD = @"Porque es obligatorio por ley constitucional.",
                            CorrectAnswer = "A",
                            Explanation = @"La inmediatez en marketplaces es el factor determinante de cierre antes de que el usuario haga clic en la publicación del competidor."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué representa la métrica LTV (Customer Lifetime Value)?",
                            OptionA = @"El límite de tarjetas virtuales en el banco.",
                            OptionB = @"El beneficio económico total neto que un cliente aporta a la empresa a lo largo de toda su relación comercial.",
                            OptionC = @"La longitud total del texto de un anuncio.",
                            OptionD = @"El tiempo que la persona pasa conectada a internet al día.",
                            CorrectAnswer = "B",
                            Explanation = @"LTV mide los ingresos proyectados que un cliente repetitivo generará en el tiempo, justificando la inversión para captarlo."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué técnica de cierre por chat consiste en ofrecer dos opciones afirmativas en lugar de una pregunta abierta que admita un 'no'?",
                            OptionA = @"Cierre por agotamiento.",
                            OptionB = @"Técnica de la alternativa doble (ej. '¿Prefieres envío a oficina o a tu casa?').",
                            OptionC = @"Cierre con descuento no autorizado.",
                            OptionD = @"Silencio absoluto de 24 horas.",
                            CorrectAnswer = "B",
                            Explanation = @"La alternativa doble asume la compra y le facilita al comprador decidir únicamente sobre la logística o el color."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Para qué sirve el sistema de 'Etiquetas' en WhatsApp Business?",
                            OptionA = @"Para ponerle stickers graciosos a los clientes.",
                            OptionB = @"Para clasificar visualmente a los prospectos según la etapa de su embudo (nuevo lead, esperando pago, despachado).",
                            OptionC = @"Para cobrarles un impuesto extra por mensaje.",
                            OptionD = @"Para cambiar el color de la aplicación.",
                            CorrectAnswer = "B",
                            Explanation = @"Las etiquetas funcionan como un CRM ágil para hacer seguimiento ordenado y no olvidar pedidos pendientes de pago o despacho."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"Si invertiste $100 en publicidad digital y esa campaña generó directamente $500 en ventas, ¿cuál fue tu ROAS?",
                            OptionA = @"1x.",
                            OptionB = @"5x.",
                            OptionC = @"50x.",
                            OptionD = @"0.5x.",
                            CorrectAnswer = "B",
                            Explanation = @"ROAS = Ingresos / Inversión ($500 / $100 = 5x). Por cada dólar gastado en anuncios, volvieron 5 dólares en ventas."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la estructura recomendada para el título de un producto en un Marketplace para ganar visibilidad orgánica?",
                            OptionA = @"Oferta imperdible compra ya barato 123.",
                            OptionB = @"Producto principal + Marca + Modelo + Característica o especificación clave.",
                            OptionC = @"Solo emojis de fueguitos y estrellas.",
                            OptionD = @"El nombre del dueño del negocio.",
                            CorrectAnswer = "B",
                            Explanation = @"Los motores de búsqueda interna de los marketplaces indexan palabras clave precisas que los usuarios escriben en la barra de búsqueda."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la relación saludable recomendada entre LTV (Valor de Vida) y CAC (Costo de Adquisición)?",
                            OptionA = @"CAC debe ser el triple que LTV.",
                            OptionB = @"LTV debe ser al menos 3 veces mayor que el CAC (LTV : CAC >= 3:1).",
                            OptionC = @"Deben ser exactamente iguales a cero.",
                            OptionD = @"No tiene ninguna importancia medir la relación entre ambos.",
                            CorrectAnswer = "B",
                            Explanation = @"Una relación 3:1 o superior garantiza que el modelo de captación sea rentable y deje margen operativo suficiente para crecer."
                        }
                    }                }
            };
        }
    }
}