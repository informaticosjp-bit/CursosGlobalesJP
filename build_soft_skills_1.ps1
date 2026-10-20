# Courses 1-4 generator for SoftSkillsHR
function Get-Course-Filosofia ($qData) {
    return @'
                // =========================================================================
                // 1. FILOSOFÍA EMPRESARIAL Y ÉTICA LABORAL
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "filosofia-empresarial-etica-laboral",
                    Title = "Filosofía Empresarial, Cultura Organizacional y Ética Laboral",
                    CategorySlug = "administracion-procesos-reportes",
                    ShortDescription = "Comprende el ADN corporativo: valores, código de ética, prevención de conflictos de interés, cumplimiento normativo y cultura de integridad.",
                    FullDescription = "Formación fundamental para todo profesional y líder en el entorno empresarial. Aprende cómo se construye la identidad corporativa a través de la misión, visión y valores, cómo aplicar el código de conducta en dilemas éticos reales, prevención del soborno y fraude, manejo de información confidencial y canales de denuncia protegidos (Whistleblowing).",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Identidad Corporativa: Misión, Visión y Valores en Acción",
                            LessonTitle = "La Brújula Moral y Operativa de la Organización",
                            Summary = "Conoce cómo los valores declarados se transforman en conductas medibles del día a día, guiando las decisiones desde el operario hasta la alta dirección.",
                            DurationMinutes = 40,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-award-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Cultura se Demuestra con Hechos, No con Palabras</h5>
            <p class=""mb-0 small"">Los valores corporativos no son un póster decorativo en la recepción; son los principios rectores que determinan cómo una empresa trata a sus empleados, clientes y proveedores ante cualquier encrucijada financiera o moral.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/RV9YrstWny0"" title=""Cómo definir MISIÓN, VISIÓN y VALORES organizacionales PASO a PASO 🎯 +EJEMPLOS prácticos"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-compass text-primary me-2""></i>1. Fundamentos: Misión, Visión y Valores Operativos</h4>
    <p>Toda organización exitosa y sostenible en el tiempo se fundamenta en un marco de identidad estratégica claro:</p>
    <ul>
        <li><strong>Propósito Supremo y Misión:</strong> La misión define qué hace la empresa hoy, para quién trabaja y cuál es el valor diferencial que entrega. Responde a preguntas vitales: <em>¿Qué necesidad humana resolvemos? ¿Cuál es nuestro estándar innegociable de servicio?</em>.</li>
        <li><strong>Visión de Futuro:</strong> Representa el destino aspiracional a mediano y largo plazo (habitualmente 3 a 5 años). No es una fantasía irreal, sino una meta inspiradora pero alcanzable que moviliza el esfuerzo de todas las áreas de la compañía.</li>
        <li><strong>Valores Corporativos en Acción:</strong> Los valores son el filtro moral de la toma de decisiones. Un valor como 'Honestidad' debe traducirse en comportamientos observables: nunca facturar productos no entregados, reportar mermas reales y no mentir a los clientes sobre fechas de despacho.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-diagram-3 text-primary me-2""></i>2. Cómo se Manifiesta la Cultura Organizacional</h4>
    <p>Peter Drucker popularizó la célebre frase: <em>'La cultura se come a la estrategia en el desayuno'</em>. Una empresa puede tener la mejor tecnología y la estrategia financiera más sofisticada, pero si su cultura es tóxica, caracterizada por la desconfianza, el secretismo y el individualismo, los resultados inevitablemente colapsarán:</p>
    <ol>
        <li><strong>Ritos y Comunicación Interna:</strong> La forma en que los líderes reconocen los logros, transmiten las malas noticias y celebran el trabajo en equipo define el clima emocional de la oficina.</li>
        <li><strong>Coherencia del Liderazgo:</strong> Si los directores exigen puntualidad pero llegan tarde, o exigen austeridad mientras despilfarran en lujos personales, la moral de los colaboradores se destruye. El ejemplo visible de los jefes es el principal transmisor de valores.</li>
        <li><strong>Alineación de Compensación y Reconocimiento:</strong> Lo que una empresa realmente premia con aumentos o ascensos es lo que los empleados aprenden a valorar. Si se premia al vendedor estrella aunque falsifique reportes, la empresa está enviando el mensaje de que la ética es secundaria.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-building-check text-primary me-2""></i>3. Caso de Estudio Empresarial: Johnson & Johnson y la Crisis de Tylenol</h4>
    <p>En 1982, cápsulas de Tylenol adulteradas con cianuro por un saboteador externo provocaron la muerte de siete personas en Chicago. En lugar de encubrir el incidente o minimizar el riesgo para salvar sus utilidades inmediatas, el CEO de Johnson & Johnson, James Burke, apeló al <em>'Credo'</em> de la empresa (su declaración de valores escrita en 1943):</p>
    <div class=""card bg-light border-start border-primary border-4 p-3 mb-3"">
        <p class=""mb-1 fst-italic"">""Creemos que nuestra primera responsabilidad es ante los médicos, enfermeras y pacientes; las madres y padres y todos los que usan nuestros productos...""</p>
        <span class=""small text-muted"">— Credo Corporativo de Johnson & Johnson</span>
    </div>
    <p>Siguiendo este principio, la compañía retiró de inmediato 31 millones de botellas de Tylenol de los estantes en todo Estados Unidos con un costo directo de más de $100 millones de dólares, colaboró abiertamente con el FBI e inventó el primer sello de seguridad triple inviolable de la industria farmacéutica. Como resultado, la marca recuperó la confianza total del público y sigue siendo líder mundial indiscutible.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Redactar valores abstractos e inaplicables:</strong> Colocar palabras como 'Sinergia holística' o 'Perfección paradigmática' sin explicar qué significan en el trabajo diario crea cinismo entre los empleados.</li>
        <li><strong>Incoherencia entre discurso y práctica (Doble Moral):</strong> Exigir servicio al cliente mientras se reduce deliberadamente la calidad del producto vendido para abaratar costos sin avisar.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Conoces de memoria la misión y visión de tu empresa para orientar tus decisiones laborales diarias?</li>
            <li>¿Tus acciones de esta semana fueron coherentes con los valores declarados de tu organización?</li>
            <li>¿Priorizas la integridad y la reputación a largo plazo por encima de atajos oportunistas a corto plazo?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: El Código de Ética y Conducta Profesional",
                            LessonTitle = "Dilemas Morales en la Oficina y Prevención de Conflictos de Interés",
                            Summary = "Aprende a identificar y gestionar situaciones donde los intereses personales chocan con los deberes laborales: regalos de proveedores, favoritismo y pluriempleo.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-shield-lock-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Integridad en los Momentos Decisivos</h5>
            <p class=""mb-0 small"">La ética consiste en hacer lo correcto incluso cuando nadie nos está observando. Conoce los límites formales del código de conducta y cómo blindar tu reputación profesional.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/v97WAu3ZW7Q"" title=""Consejos de Ética Profesional y Valores | Sociedad San José"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-journal-text text-primary me-2""></i>1. ¿Qué es un Código de Conducta y Por Qué Existe?</h4>
    <p>El Código de Conducta es el documento jurídico e institucional vinculante que traduce la filosofía moral de la empresa en normativas concretas sobre lo que está permitido y lo que está estrictamente prohibido para todos los colaboradores:</p>
    <ul>
        <li><strong>Fronteras Claras:</strong> Establece regulaciones explícitas sobre el uso de recursos empresariales, relaciones interpersonales, acoso laboral o sexual y honestidad en los informes contables.</li>
        <li><strong>Carácter Vinculante:</strong> En la mayoría de las legislaciones laborales, la firma de recepción del Código de Ética al momento de la contratación faculta a la empresa a rescindir el contrato con justa causa ante infracciones graves.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-person-x text-primary me-2""></i>2. Detección y Gestión de Conflictos de Interés</h4>
    <p>Un conflicto de interés surge cuando los intereses personales, familiares o económicos de un colaborador interfieren (o aparentan interferir) con el juicio objetivo que debe ejercer en beneficio exclusivo de su empleador:</p>
    <ol>
        <li><strong>Regalos, Comisiones y Hospitalidad de Proveedores:</strong> Aceptar obsequios de valor significativo, cenas de lujo o viajes pagados por proveedores que concursan en licitaciones de compras compromete la imparcialidad. La regla de oro corporativa establece rechazar regalos superiores a montos simbólicos (ej. lápices promocionales o calendarios) y reportarlos de inmediato al oficial de cumplimiento.</li>
        <li><strong>Contratación de Familiares y Amigos (Nepotismo):</strong> Contratar empresas de cónyuges, hermanos o amigos cercanos sin una licitación abierta y sin declarar el parentesco es una falta grave que perjudica las finanzas corporativas.</li>
        <li><strong>Uso Indebido de Activos de la Empresa:</strong> Utilizar vehículos corporativos, impresoras, software bajo licencia empresarial o el horario de trabajo pagado para actividades comerciales privadas o negocios particulares.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shield-check text-primary me-2""></i>3. El Test de la Primera Plana (The Front Page Test)</h4>
    <p>Cuando te encuentres frente a una decisión en una 'zona gris' donde la ley no es totalmente explícita, los expertos en ética aplicada recomiendan someter la decisión al Test de Warren Buffett:</p>
    <div class=""card bg-light border-0 p-3 rounded-3 mb-3"">
        <p class=""mb-0 fst-italic"">""Nunca hagas nada en los negocios que no te sentirías completamente cómodo y orgulloso de ver publicado mañana en la primera plana de tu periódico local, para que lo lean tu cónyuge, tus hijos, tus padres y tus vecinos.""</p>
    </div>
    <p>Si la respuesta te genera incomodidad, vergüenza o el deseo de ocultar los detalles, la acción es éticamente inaceptable y debes abstenerte de realizarla.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>La falacia de 'Todos lo hacen':</strong> Justificar pequeñas desviaciones éticas (llevarse papelería a casa, adulterar viáticos o registrar horas extras falsas) alegando que otros colegas también lo hacen.</li>
        <li><strong>No declarar un conflicto de interés a tiempo:</strong> Si tu hermano tiene una empresa de suministros que compite legítimamente por una orden de compra, no declararlo por escrito a Recursos Humanos antes del proceso invalida la licitación y genera sospechas de corrupción.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Has leído completamente el Código de Conducta de tu organización este año?</li>
            <li>¿Declaras por escrito cualquier parentesco o interés económico con proveedores o clientes?</li>
            <li>¿Rechazas cortesías costosas de proveedores que puedan comprometer tu criterio profesional?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Confidencialidad, Manejo de Información y Whistleblowing",
                            LessonTitle = "Protección de Secretos Comerciales y Canales de Denuncia Segura",
                            Summary = "Domina las obligaciones legales de no divulgación (NDA), el manejo de datos de clientes y el funcionamiento de las líneas éticas anónimas para denunciar fraudes.",
                            DurationMinutes = 50,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-incognito fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Información es el Activo Más Valioso de la Empresa</h5>
            <p class=""mb-0 small"">La fuga de datos confidenciales o la complicidad ante fraudes corporativos acarrean responsabilidades civiles y penales directas. Aprende a resguardar la información y usar canales de denuncia seguros.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/iiNkZWuht2s"" title=""Protección de datos personales y confidencialidad de la información"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-file-earmark-lock text-primary me-2""></i>1. Acuerdos de Confidencialidad (NDA) y Secretos Industriales</h4>
    <p>En la era digital, la ventaja competitiva de una compañía reside en sus algoritmos, bases de datos de clientes, estructuras de costos y planes de expansión:</p>
    <ul>
        <li><strong>Información Confidencial:</strong> Todo dato contable, técnico, comercial o personal al que se tiene acceso en razón del cargo y que no es de dominio público general.</li>
        <li><strong>Vigencia Post-Laboral:</strong> Los acuerdos de confidencialidad y la legislación mercantil establecen que el deber de secreto industrial se mantiene vigente incluso años después de haber renunciado o finalizado la relación laboral con la empresa.</li>
        <li><strong>Prohibición del Uso de Información Privilegiada (Insider Trading):</strong> Utilizar datos no públicos (ej. saber antes del anuncio oficial que la empresa será vendida o que cerrará un contrato multimillonario) para beneficio financiero propio o de terceros es un delito grave.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-megaphone text-primary me-2""></i>2. Canales de Denuncia Ética y Protección al Denunciante (Whistleblowing)</h4>
    <p>Los canales de denuncia ética son herramientas institucionales confidenciales que permiten a los colaboradores reportar malas prácticas corporativas sin temor a represalias laborales:</p>
    <ol>
        <li><strong>Anonimato y Confidencialidad Garantizada:</strong> Las líneas éticas modernas suelen ser operadas por firmas auditoras independientes externas a la empresa para asegurar que la identidad del denunciante esté técnicamente blindada.</li>
        <li><strong>Conductas Denunciables:</strong> Fraude financiero, malversación de fondos, sobornos a funcionarios públicos o clientes, acoso sexual o laboral, robo continuado de inventario y falsificación de balances.</li>
        <li><strong>Política de Cero Represalias (Non-Retaliation Policy):</strong> Las corporaciones serias penalizan con despido inmediato a cualquier supervisor que intente degradar, aislar o despedir a un empleado por haber presentado una denuncia de buena fe.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Compartir datos sensibles por chats informales:</strong> Enviar listas de clientes con números de cédula, correos y tarjetas por grupos personales de WhatsApp viola normativas internacionales de protección de datos (RGPD / Habeas Data).</li>
        <li><strong>Utilizar el canal ético para vendettas personales:</strong> Presentar denuncias falsas o maliciosas por enemistad personal satura el sistema de cumplimiento y puede generar sanciones disciplinarias contra el difamador.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Bloqueas tu pantalla cada vez que te levantas de tu estación de trabajo en la oficina?</li>
            <li>¿Mantienes absoluta discreción sobre costos, sueldos y clientes en conversaciones fuera del trabajo?</li>
            <li>¿Conoces el enlace o número de la línea ética confidencial de tu empresa?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Responsabilidad Social Empresarial (RSE) y Sostenibilidad",
                            LessonTitle = "La Empresa como Agente de Impacto Positivo Comunitario y Ambiental",
                            Summary = "Descubre el modelo del Triple Impacto (Personas, Planeta y Beneficios) y cómo las políticas ESG influyen en la valoración y reputación corporativa moderna.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-globe-americas fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Éxito Empresarial Debe Beneficiar a la Sociedad</h5>
            <p class=""mb-0 small"">Una empresa próspera no puede subsistir en una sociedad que fracasa. Conoce cómo la sostenibilidad ecológica, la equidad laboral y el compromiso con la comunidad generan valor sostenible a largo plazo.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/CU5CP_JKcfw"" title=""Responsabilidad social de la empresa y sus ámbitos de actuación ⊛ | Economía de la empresa 29#"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-tree text-success me-2""></i>1. El Modelo de la Triple Cuenta de Resultados (Triple Bottom Line)</h4>
    <p>Atrás quedó la visión del siglo XX donde el único fin de la empresa era maximizar el dividendo a los accionistas sin importar las externalidades causadas. Hoy las organizaciones líderes se evalúan bajo tres dimensiones interconectadas:</p>
    <ul>
        <li><strong>Económica (Profit):</strong> Generación de riqueza, rentabilidad sostenible, pago puntual de salarios justos e impuestos para el desarrollo del país.</li>
        <li><strong>Social (People):</strong> Trato digno a los trabajadores, oportunidades reales de crecimiento profesional, inclusión, seguridad industrial y relaciones de mutuo beneficio con las comunidades locales vecinas.</li>
        <li><strong>Ambiental (Planet):</strong> Reducción de la huella de carbono, eficiencia en el consumo de energía y agua, reciclaje de materiales y gestión responsable de residuos operativos.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-award text-success me-2""></i>2. Criterios ESG (Environmental, Social and Governance)</h4>
    <p>Los fondos de inversión globales y las grandes corporaciones exigen actualmente a sus proveedores el cumplimiento de estándares ESG verificables:</p>
    <ol>
        <li><strong>E (Medio Ambiente):</strong> Programas de economía circular, transición a fuentes de energía limpia y eliminación progresiva de plásticos de un solo uso en las operaciones.</li>
        <li><strong>S (Social):</strong> Derechos humanos en la cadena de suministro, erradicación total del trabajo infantil en proveedores agrícolas o textiles, y capacitación continua de la fuerza laboral.</li>
        <li><strong>G (Gobernanza):</strong> Estructuras de gobierno corporativo transparentes, juntas directivas independientes, auditorías financieras externas y tolerancia cero contra la corrupción.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. El Peligro del 'Greenwashing' (Ecoblanqueo)</h4>
    <p>El greenwashing ocurre cuando una empresa invierte más dinero en publicidad engañosa haciéndose pasar por ecológica que en prácticas reales de mitigación ambiental:</p>
    <div class=""card bg-light border-0 p-3 rounded-3 mb-3"">
        <p class=""mb-0 text-muted small""><strong>Ejemplo Real:</strong> Una cadena hotelera que coloca carteles pidiendo a los huéspedes no lavar las toallas 'para salvar al planeta', cuando su verdadero motivo es reducir la factura de lavandería sin implementar ninguna medida real de tratamiento de aguas residuales ni energía solar.</p>
    </div>
    <p>Los consumidores modernos y las redes sociales descubren rápidamente estas inconsistencias, provocando crisis de reputación masivas y boicots comerciales.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir RSE con Filantropía Asistencialista:</strong> Donar dinero esporádico para caridad mientras se pagan sueldos por debajo de la ley a los empleados no es responsabilidad social; la RSE empieza por casa con el bienestar laboral.</li>
        <li><strong>Ignorar el impacto local de las operaciones:</strong> No coordinar con los líderes comunitarios el tránsito de camiones pesados o ruidos nocturnos de la fábrica, generando hostilidad vecinal.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Apagas las luces y equipos de cómputo al finalizar tu jornada en la oficina?</li>
            <li>¿Participas activamente en los programas de voluntariado y reciclaje de tu organización?</li>
            <li>¿Verificas que tus proveedores cumplan con estándares de dignidad laboral y legalidad?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = 
'@ + $qData + @'
                },
'@
}

Write-Host "Filosofia helper loaded successfully!"

function Get-Course-AtencionPresencial ($qData) {
    return @'
                // =========================================================================
                // 2. ATENCIÓN AL CLIENTE PRESENCIAL Y FIDELIZACIÓN
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "atencion-al-cliente-presencial-fidelizacion",
                    Title = "Atención al Cliente Presencial, Comunicación Asertiva y Fidelización",
                    CategorySlug = "administracion-procesos-reportes",
                    ShortDescription = "Domina el contacto cara a cara: lenguaje corporal, escucha activa, desactivación de clientes molestos, protocolos de servicio y técnicas de fidelización.",
                    FullDescription = "Capacitación de alto impacto orientada a personal de recepción, atención en ventanilla, retail y servicios presenciales. Aprende a causar una primera impresión imborrable en los primeros 7 segundos, aplicar técnicas de modulación de voz y postura abierta, calmar situaciones tensas con el método LAST (Listen, Apologize, Solve, Thank) y construir programas de fidelización duradera.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: La Primera Impresión y Lenguaje Corporal en el Servicio",
                            LessonTitle = "La Regla de los 7 Segundos y la Comunicación No Verbal Cara a Cara",
                            Summary = "Descubre cómo el cerebro del cliente evalúa tu calidez y competencia en cuestión de segundos mediante la postura, la mirada, la distancia interpersonal y la sonrisa profesional.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-person-badge-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Nunca Hay una Segunda Oportunidad para una Primera Impresión</h5>
            <p class=""mb-0 small"">El 93% del impacto comunicativo presencial proviene del tono de voz y el lenguaje corporal. Aprende a proyectar autoridad serena, amabilidad genuina y profesionalismo absoluto desde el primer instante.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/yFIZDfSU6Wo"" title=""COMUNICACIÓN NO VERBAL: Definición, tipos y funciones 😎🤗"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-stopwatch text-primary me-2""></i>1. La Neurociencia de la Primera Impresión</h4>
    <p>Cuando un cliente ingresa a un establecimiento comercial o se acerca a un mostrador de atención, su sistema límbico evalúa al representante en los primeros 7 segundos bajo dos parámetros evolutivos fundamentales descubiertos por la Dra. Amy Cuddy de Harvard:</p>
    <ul>
        <li><strong>Calidez (Warmth):</strong> <em>¿Esta persona tiene intenciones amigables hacia mí? ¿Puedo confiar en ella?</em> Se transmite a través de la sonrisa genuina (sonrisa Duchenne), la mirada directa a los ojos y una expresión facial relajada y receptiva.</li>
        <li><strong>Competencia (Competence):</strong> <em>¿Esta persona tiene la capacidad técnica para resolver mi necesidad?</em> Se proyecta mediante una postura erguida pero no rígida, movimientos seguros y una presencia personal pulcra e impecable.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-person-walking text-primary me-2""></i>2. Desglose del Lenguaje Corporal Profesional</h4>
    <p>El cuerpo habla antes de que pronunciemos la primera palabra de saludo:</p>
    <ol>
        <li><strong>Contacto Visual Equilibrado:</strong> Mantener la mirada entre el 60% y 70% del tiempo de interacción en el triángulo facial (ojos y puente nasal). Mirar al suelo transmite timidez o culpa; mirar fijamente sin parpadear resulta intimidatorio; mirar constantemente la pantalla de la computadora o el teléfono móvil comunica indiferencia total.</li>
        <li><strong>Postura Abierta (Brazos y Manos Visibles):</strong> Cruzar los brazos a la altura del pecho o esconder las manos en los bolsillos crea una barrera física inconsciente que el cliente interpreta como hostilidad o desinterés. Mantener los brazos a los lados con gestos explicativos de palmas abiertas genera apertura y honestidad.</li>
        <li><strong>La Zona Proxémica Adecuada:</strong> Respetar la distancia personal (aproximadamente entre 1 y 1.2 metros en mostradores). Invadir el espacio físico del cliente genera incomodidad y tensión innecesaria.</li>
        <li><strong>La Sonrisa Profesional:</strong> Saludar con una leve inclinación de cabeza y una sonrisa sincera relaja automáticamente al visitante más ansioso.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-chat-quote text-primary me-2""></i>3. El Saludo Protocolar Inmediato</h4>
    <p>Todo visitante debe ser reconocido verbalmente en menos de 10 segundos, incluso si estás atendiendo a otra persona o hablando por teléfono:</p>
    <div class=""card bg-light border-start border-primary border-4 p-3 mb-3"">
        <p class=""mb-1 fw-bold"">Fórmula de Saludo de Excelencia:</p>
        <p class=""mb-0 text-muted""><em>'¡Muy buenos días, bienvenido a [Nombre de Empresa]! Mi nombre es [Tu Nombre], en un momento estoy con usted con el mayor gusto.'</em> (Si estás ocupado, una mirada, una sonrisa y un gesto de cortesía bastan para evitar que la persona se sienta ignorada).</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>El 'Síndrome del Mostrador Invisible':</strong> Estar conversando de temas personales con un compañero o riendo entre risillas mientras el cliente espera de pie frente al mostrador. Destruye instantáneamente la reputación corporativa.</li>
        <li><strong>Uso del teléfono móvil personal en el área de servicio:</strong> Estar chateando o revisando redes sociales detrás del mostrador comunica desidia absoluta y falta de respeto al usuario.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Saludas al cliente con contacto visual directo y una sonrisa dentro de los primeros 10 segundos?</li>
            <li>¿Mantienes una postura erguida y abierta sin cruzar los brazos en el mostrador?</li>
            <li>¿Guardas tu teléfono celular personal fuera de la vista de los usuarios durante tu turno de atención?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Escucha Activa, Preguntas Clave y Sondeo",
                            LessonTitle = "Diagnóstico Preciso de Necesidades y Asertividad Comunicativa",
                            Summary = "Aprende el arte de escuchar el doble de lo que hablas: técnica de parafraseo, preguntas abiertas vs cerradas y cómo empatizar sin perder el control de la conversación.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-ear-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Escuchar para Comprender, No Solo para Responder</h5>
            <p class=""mb-0 small"">La mayoría de los asesores interrumpen al cliente antes de que termine de formular su problema. Quien domina la escucha activa y el sondeo estratégico ahorra tiempo, evita malentendidos y cierra más operaciones.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/la1F2U7YZTY"" title=""La Escucha Activa, ¿En Qué Consiste?"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-filter-circle text-primary me-2""></i>1. La Anatomía de la Escucha Activa</h4>
    <p>Escuchar activamente implica un compromiso mental total con el mensaje del interlocutor, prestando atención no solo a las palabras textuales sino a la carga emocional subyacente:</p>
    <ul>
        <li><strong>Silencio Atento:</strong> Permitir que el cliente exponga su situación completa sin interrupciones abruptas durante al menos 45 a 60 segundos.</li>
        <li><strong>Asentimiento Corporal y Verbal:</strong> Acompañar el relato con sutiles movimientos afirmativos de cabeza e interjecciones breves (<em>'Comprendo perfectamente', 'Ya veo', 'Entendido'</em>) que confirman la recepción del mensaje.</li>
        <li><strong>Toma de Notas:</strong> En solicitudes complejas o reclamos de garantías, anotar datos clave (códigos de factura, fechas, números de modelo) demuestra seriedad profesional y respeto.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-question-diamond text-primary me-2""></i>2. El Embudo de Preguntas (Funnel de Indagación)</h4>
    <p>Para guiar una conversación de servicio con agilidad, los asesores expertos utilizan una secuencia estructurada de preguntas:</p>
    <ol>
        <li><strong>Preguntas Abiertas de Exploración:</strong> Comienzan con <em>Qué, Cómo, Cuándo o Para qué</em>. Sirven para que el usuario exprese libremente su necesidad: <em>'¿Qué tipo de uso diario le dará al equipo?'</em> o <em>'¿Cómo podemos ayudarle el día de hoy?'</em>.</li>
        <li><strong>Preguntas Cerradas de Confirmación:</strong> Se responden con un 'Sí' o un 'No' o seleccionando entre alternativas concretas: <em>'¿Desea facturación a nombre de empresa o persona natural?'</em>, <em>'¿Prefiere entrega en tienda o despacho a domicilio?'</em>.</li>
        <li><strong>La Técnica del Parafraseo Reflejo:</strong> Consiste en repetir con tus propias palabras la esencia de lo planteado por el cliente antes de ofrecer la solución: <em>'Permítame verificar si le he entendido bien, don Carlos: lo que usted requiere es cambiar el repuesto adquirido ayer porque no coincide con las medidas de su vehículo, ¿es correcto?'</em>. Cuando el cliente dice 'Sí, exactamente eso', la tensión emocional desaparece porque se siente 100% comprendido.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Interrumpir al cliente para adelantarle la solución:</strong> Aunque ya sepas la respuesta a los 10 segundos, interrumpirlo le hace sentir menospreciado y eleva su agresividad defensiva.</li>
        <li><strong>Asumir necesidades sin preguntar:</strong> Entregar un producto basándose en suposiciones erróneas genera devoluciones costosas y quejas formales.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Dejas hablar al cliente sin interrumpirlo durante su exposición inicial?</li>
            <li>¿Utilizas el parafraseo reflejo para confirmar requerimientos antes de ejecutar la acción?</li>
            <li>¿Tomas notas escritas en casos complejos para evitar repetir preguntas innecesarias?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Manejo de Situaciones Difíciles y Clientes Conflictivos",
                            LessonTitle = "Desescalada de Conflictos con el Método LAST y Control Emocional",
                            Summary = "Domina el protocolo psicológico para calmar clientes furiosos en el mostrador: cómo aplicar Escuchar, Disculparse, Resolver y Agradecer sin tomar los ataques como algo personal.",
                            DurationMinutes = 50,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-shield-fill-exclamation fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Furia del Cliente No es Personal, es Frustración Operativa</h5>
            <p class=""mb-0 small"">Cuando un cliente grita o reclama airadamente en el mostrador, no te está atacando a ti como individuo; está desahogando su impotencia ante una promesa rota por la empresa. Aprende el método LAST para desactivar la hostilidad en menos de 3 minutos.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/nYEU-ZyfNPg"" title=""Cómo manejar clientes difíciles / Jorge Martínez Felicidad"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-cpu text-primary me-2""></i>1. La Psicología de la Desescalada</h4>
    <p>El cliente enojado se encuentra en 'secuestro amigdalino': su cerebro emocional ha tomado el control y no puede procesar explicaciones lógicas ni normativas burocráticas hasta que haya liberado su adrenalina:</p>
    <ul>
        <li><strong>Nunca digas 'Cálmese' o 'Tranquilícese':</strong> Esta frase tiene el efecto psicológico opuesto; el cliente siente que se está invalidando su molestia y su nivel de ira se multiplica por diez.</li>
        <li><strong>Mantén el Tono de Voz Más Bajo y Pausado:</strong> Cuando una persona grita y la otra responde con voz calmada, grave y a ritmo moderado, se activa el fenómeno neurobiológico del reflejo especular, obligando inconscientemente al agresor a modular su volumen.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-tools text-primary me-2""></i>2. El Protocolo LAST (Listen, Apologize, Solve, Thank)</h4>
    <p>Utilizado por cadenas de hospitalidad mundial como The Ritz-Carlton y Disney:</p>
    <ol>
        <li><strong>L - Listen (Escuchar con Atención Plena):</strong> Deja que descargue todo su desahogo sin discutir. Muestra empatía genuina con el rostro y la postura.</li>
        <li><strong>A - Apologize (Disculparse en Nombre de la Empresa):</strong> No busques culpables internos (<em>'Eso fue culpa del despachador que es un incompetente'</em>). Una disculpa institucional sincera calma la indignación: <em>'Lamento sinceramente los inconvenientes y el retraso que esta falla técnica le ha ocasionado en su jornada de trabajo'</em>.</li>
        <li><strong>S - Solve (Resolver Proactivamente):</strong> Ofrece una solución viable inmediata o alternativas claras con plazos específicos: <em>'Lo que voy a hacer de inmediato por usted es coordinar el reemplazo del equipo hoy mismo antes de las 4:00 pm'</em>.</li>
        <li><strong>T - Thank (Agradecer el Feedback):</strong> Agradece que haya manifestado el problema: <em>'Muchas gracias por hacernos ver este error; nos ayuda a mejorar nuestros procesos para que esto no vuelva a ocurrir'</em>.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Discutir o ponerse a la defensiva con el cliente:</strong> Ganar una discusión técnica a un cliente furioso equivale a perder al cliente y a toda su red de contactos para siempre.</li>
        <li><strong>Escudarse en 'Políticas de la Empresa' sin dar soluciones:</strong> Decirle fríamente <em>'Es política de la casa y no se puede hacer nada'</em> es la mayor causa de escalada de agresiones físicas y quejas legales contra negocios.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Evitas estrictamente la palabra 'Cálmese' ante usuarios alterados?</li>
            <li>¿Modulas tu voz deliberadamente a un tono pausado y sereno durante discusiones?</li>
            <li>¿Aplicas los 4 pasos del método LAST (Escuchar, Disculpar, Resolver, Agradecer)?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Fidelización, Programas de Lealtad y Momentos Wow",
                            LessonTitle = "De Clientes Satisfechos a Promotores Incondicionales de la Marca",
                            Summary = "Aprende a superar expectativas con el efecto Wow, implementar tarjetas de fidelización, calcular el Valor de Vida del Cliente (LTV) y medir la lealtad con el NPS.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-heart-pulse-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Un Cliente Satisfecho Puede Irse; Un Cliente Fidelizado Regresa Siempre</h5>
            <p class=""mb-0 small"">Captar un cliente nuevo cuesta entre 5 y 7 veces más que retener a uno existente. Conoce las estrategias de lealtad, los detalles inesperados y las métricas para blindar la base de clientes de tu empresa.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/-hQNp7xh_8c"" title=""Métricas de Customer Experience | Encuesta.com"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-stars text-primary me-2""></i>1. La Diferencia entre Satisfacción y Fidelización</h4>
    <p>La satisfacción es simplemente cumplir con lo prometido en el contrato básico (entregaste el producto que pagó). La satisfacción no garantiza lealtad: si la competencia ofrece un descuento del 10%, el cliente satisfecho se marchará. La fidelización, en cambio, es un vínculo emocional:</p>
    <ul>
        <li><strong>Fidelidad Afectiva:</strong> El cliente confía ciegamente en la honestidad de la empresa y en el trato humano de su personal, por lo que no cotiza con otros competidores.</li>
        <li><strong>Efecto Embajador de Marca:</strong> Recomienda activamente el negocio a familiares, colegas y socios comerciales de forma espontánea y gratuita.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-magic text-primary me-2""></i>2. La Creación de 'Momentos Wow' (Overdelivering)</h4>
    <p>El Factor Sorpresa consiste en entregar un valor adicional inesperado que no estaba en el acuerdo explícito y que tiene un costo económico mínimo para el negocio pero un valor percibido gigantesco:</p>
    <ol>
        <li><strong>Personalización Extrema:</strong> Recordar el nombre del cliente habitual, su café preferido o el nombre de su mascota al ingresar a la tienda.</li>
        <li><strong>Agilidad de Respuesta Superior:</strong> Resolver una solicitud prometida para dentro de 48 horas en tan solo 3 horas hábiles con una llamada proactiva.</li>
        <li><strong>El 'Regalo de Cortesía Inesperado':</strong> Un bombón fino en el empaque de despacho, una muestra gratis de un producto complementario nuevo o una nota manuscrita de agradecimiento.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-graph-up-arrow text-primary me-2""></i>3. Medición Científica de la Lealtad: El Net Promoter Score (NPS)</h4>
    <p>El NPS fue creado por Fred Reichheld de Bain & Company y se basa en una sola pregunta con escala de 0 a 10: <em>'¿Con qué probabilidad recomendaría nuestros servicios a un amigo o colega?'</em>:</p>
    <ul>
        <li><strong>Promotores (9 - 10):</strong> Clientes apasionados que compran con frecuencia y atraen nuevos prospectos.</li>
        <li><strong>Pasivos (7 - 8):</strong> Clientes satisfechos pero vulnerables a ofertas de la competencia.</li>
        <li><strong>Detractores (0 - 6):</strong> Clientes insatisfechos que dañan la marca con comentarios negativos en redes y boca a boca.</li>
    </ul>
    <div class=""card bg-light border-0 p-3 rounded-3 mb-3 text-center"">
        <code class=""fs-6 fw-bold"">NPS = (% de Promotores) - (% de Detractores)</code>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Descuidar a los clientes antiguos para buscar nuevos:</strong> Ofrecer grandes promociones exclusivas para clientes nuevos mientras a los clientes leales de hace 5 años se les aumentan las tarifas sin ningún beneficio.</li>
        <li><strong>Programas de puntos excesivamente complejos:</strong> Sistemas de acumulación de puntos donde se requieren millones de compras para canjear un premio insignificante, frustrando a la audiencia.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Llamas a tus clientes habituales por su nombre en cada visita?</li>
            <li>¿Entregas pequeños detalles inesperados que superen la expectativa básica contratada?</li>
            <li>¿Mides periódicamente la probabilidad de recomendación de tus clientes con encuestas NPS?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = 
'@ + $qData + @'
                },
'@
}

Write-Host "Atencion Presencial helper loaded successfully!"

function Get-Course-AtencionOmnicanal ($qData) {
    return @'
                // =========================================================================
                // 3. ATENCIÓN AL CLIENTE OMNICANAL
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "atencion-al-cliente",
                    Title = "Atención al Cliente: Excelencia Omnicanal, Protocolos y Resolución de Quejas",
                    CategorySlug = "habilidades-blandas-crecimiento",
                    ShortDescription = "Domina el servicio en todos los canales: telefónico, chat en vivo, correo y redes. Gestión de tickets (SLA), indicadores CSAT y paradoja de recuperación.",
                    FullDescription = "Capacitación integral para agentes de contact center, soporte al usuario y coordinadores de servicio. Aprende a redactar respuestas formales por correo y chat, modular la voz en llamadas telefónicas, cumplir tiempos de respuesta según Acuerdos de Nivel de Servicio (SLA), revertir quejas con la Paradoja de Recuperación del Servicio y medir el CSAT y CES.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: La Experiencia del Cliente (CX) y Omnicanalidad",
                            LessonTitle = "De la Multicanalidad Aislada a la Experiencia Unificada sin Fricciones",
                            Summary = "Descubre cómo integrar canales físicos, telefónicos, WhatsApp, chat web y correo para que el cliente no tenga que repetir su historia en cada interacción.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-shuffle fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Cliente No Ve Canales, Ve una Sola Marca</h5>
            <p class=""mb-0 small"">El 78% de los usuarios modernos utiliza más de dos canales para completar una consulta o reclamo. Conoce cómo conectar sistemas CRM y protocolos para brindar una experiencia continua y homogénea.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/GA2_t6KJCZw"" title=""¿Qué es OMNICANALIDAD? 🤔 Implementa una ESTRATEGIA OMNICANAL exitosa"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-diagram-3-fill text-primary me-2""></i>1. Multicanalidad vs Omnicanalidad: La Gran Diferencia</h4>
    <p>Muchas empresas se jactan de ser modernas porque tienen WhatsApp, redes sociales y correo, pero operan en silos aislados:</p>
    <ul>
        <li><strong>Multicanalidad (Enfoque Tradicional en Silos):</strong> La empresa dispone de varios canales (teléfono, correo, tienda física), pero no están integrados tecnológicamente entre sí. Si un cliente escribe por Instagram, lo mandan a llamar por teléfono, y al llamar, el agente le pide que vuelva a explicar todo desde cero. Esto genera una frustración enorme en el consumidor.</li>
        <li><strong>Omnicanalidad (Enfoque Integrado Moderno):</strong> Todos los canales convergen en una plataforma centralizada (como Zendesk, Freshdesk o Zoho CRM). Si el cliente inició una consulta por WhatsApp a las 9:00 am y a las 2:00 pm llama por teléfono, el agente ve de inmediato en pantalla todo el historial de mensajes previos y puede continuar la conversación sin pedir repeticiones.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-journal-check text-primary me-2""></i>2. Homogeneidad del Tono de Voz de Marca (Tone of Voice)</h4>
    <p>Para construir una imagen corporativa sólida, las pautas de comunicación deben ser consistentes independientemente del canal utilizado:</p>
    <ol>
        <li><strong>Cortesía y Claridad:</strong> Respuestas siempre respetuosas, sin jergas técnicas incomprensibles ni modismos locales confusos.</li>
        <li><strong>Velocidad y Precisión:</strong> Mientras que en el canal telefónico o chat web la expectativa de respuesta es inmediata (menos de 60 segundos), en canales de correo electrónico la respuesta formal no debe exceder las 4 a 8 horas hábiles.</li>
        <li><strong>Manual de Respuestas Tipo (Templates Humanizados):</strong> Utilizar plantillas de respuesta predefinidas para agilizar el trabajo, pero editándolas siempre para incluir el nombre del cliente y detalles específicos de su caso, evitando sonar como un contestador automático frío.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Derivar al cliente de un canal a otro sin resolver:</strong> Decirle por chat <em>'Para eso tiene que llamar al 0800'</em> y cuando llama, decirle <em>'Para eso tiene que enviar un correo'</em>. Esta práctica destruye la reputación corporativa en redes sociales.</li>
        <li><strong>Bots automatizados mal configurados en WhatsApp:</strong> Menús infinitos de 15 opciones numéricas donde nunca se le da la oportunidad al cliente de hablar con un ser humano real para resolver un caso complejo.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Revisas el historial de tickets del cliente antes de responder una llamada o mensaje nuevo?</li>
            <li>¿Mantienes el mismo estándar de calidez y profesionalismo en correo, chat y teléfono?</li>
            <li>¿Personalizas las plantillas predefinidas agregando el nombre y contexto del cliente?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Comunicación Escrita y Atención Telefónica de Alto Impacto",
                            LessonTitle = "La 'Sonrisa Telefónica', Modulación Vocal y Redacción de Correos Profesionales",
                            Summary = "Domina el arte de proyectar empatía a través de la voz sin soporte visual y aprende a redactar correos ejecutivos claros, estructurados y asertivos.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-telephone-outbound-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Voz y la Escritura Son los Espejos de la Calidad Institucional</h5>
            <p class=""mb-0 small"">Al hablar por teléfono, la entonación y el ritmo transmiten el 85% de la intención del mensaje. Por escrito, la puntuación y la estructura determinan la confianza del lector. Domina ambas disciplinas técnicas.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/Fa-ERJaIGvs"" title=""Que es la Sonrisa telefónica en la comunicación"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-mic text-primary me-2""></i>1. La Sonrisa Telefónica y la Calibración Vocal</h4>
    <p>Aunque el usuario al otro lado de la línea no pueda vernos, la postura corporal y la expresión facial modifican de manera física la apertura de la faringe y la tensión de las cuerdas vocales:</p>
    <ul>
        <li><strong>El Fenómeno de la Sonrisa Auditiva:</strong> Hablar mientras se sonríe físicamente eleva el tono haciéndolo más brillante, cálido y acogedor. Quien atiende encorvado o con la boca apoyada en el escritorio suena fatigado y desinteresado.</li>
        <li><strong>Ritmo y Velocidad de Articulación:</strong> Lo ideal en atención telefónica es hablar a una velocidad promedio de 130 a 150 palabras por minuto. Hablar demasiado rápido genera ansiedad e incomprensión; hablar con lentitud excesiva desespera al usuario.</li>
        <li><strong>Gestión de las Esperas Telefónicas (Mute vs Hold):</strong> Nunca dejes al cliente en espera prolongada sin avisarle. El protocolo estándar exige solicitar permiso antes de poner la llamada en pausa: <em>'¿Me permite un minuto en línea mientras consulto con el área técnica su requerimiento, Sr. Gómez?'</em>, y retomar la llamada cada 45 segundos para agradecer la espera.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-envelope-check text-primary me-2""></i>2. Estructura de un Correo Electrónico de Servicio Profesional</h4>
    <p>Un correo corporativo impecable debe tener una arquitectura limpia de 4 bloques:</p>
    <ol>
        <li><strong>Asunto Específico y Accionable:</strong> Incluir siempre el motivo y el número de caso (ej: <em>'Respuesta a Consulta #4592 - Actualización de Datos de Facturación'</em>). Evitar asuntos genéricos como 'Consulta' o 'Ayuda'.</li>
        <li><strong>Saludo Personalizado y Apertura Cortés:</strong> <em>'Estimada Sra. Morales, reciba un cordial saludo de parte de [Empresa]'</em>.</li>
        <li><strong>Cuerpo del Mensaje Estructurado con Viñetas:</strong> Ir al grano de inmediato. En lugar de párrafos densos de 10 líneas, utilizar listas con viñetas para explicar los pasos a seguir o los requisitos a enviar.</li>
        <li><strong>Cierre Claro y Datos de Contacto:</strong> Despedida formal, nombre completo del agente, cargo y canales directos de seguimiento.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Escribir en mayúsculas sostenidas:</strong> En la etiqueta digital (Netiquette), redactar un correo o mensaje en MAYÚSCULAS equivale a estar GRITANDO con agresividad al cliente.</li>
        <li><strong>Uso excesivo de diminutivos informales:</strong> Usar expresiones como <em>'un momentico', 'la facturita', 'su dinerito'</em> le resta seriedad institucional y autoridad profesional a la empresa.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Sonríes conscientemente antes de descolgar o iniciar una llamada telefónica?</li>
            <li>¿Revisas la ortografía, gramática y nombres propios antes de hacer clic en enviar un correo?</li>
            <li>¿Retomas al cliente cada 45 segundos cuando debes poner la llamada en espera?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Gestión de Tickets, Acuerdos de Nivel de Servicio (SLA) e Incidencias",
                            LessonTitle = "Métricas de Mesa de Ayuda: Tiempos de Primera Respuesta y Resolución",
                            Summary = "Domina el ciclo de vida del ticket en herramientas como Zendesk/Jira: priorización (P1 a P4), cumplimiento de SLAs y escalamiento jerárquico eficiente.",
                            DurationMinutes = 50,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-ticket-perforated-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Medición del Tiempo es el Corazón del Soporte Técnico</h5>
            <p class=""mb-0 small"">Un buen servicio que llega demasiado tarde ya no es un buen servicio. Conoce los Acuerdos de Nivel de Servicio (SLA) y la administración profesional del ciclo de vida de incidencias.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/yl-i5jXsZBw"" title=""Osticket v 1.11+ - Niveles de servicio (SLA), gestión de tiempos de respuesta"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-clock-history text-primary me-2""></i>1. ¿Qué es un SLA (Service Level Agreement)?</h4>
    <p>Un Acuerdo de Nivel de Servicio es un compromiso formal entre el proveedor del servicio y el cliente que estipula con precisión matemática los tiempos de atención garantizados:</p>
    <ul>
        <li><strong>Tiempo de Primera Respuesta (FRT - First Response Time):</strong> Los minutos u horas que transcurren desde que el cliente registra el ticket hasta que un agente humano calificado emite la primera respuesta personalizada.</li>
        <li><strong>Tiempo Total de Resolución (TTR - Time to Resolution):</strong> El tiempo total acumulado hasta que la falla queda 100% resuelta y el ticket pasa a estado 'Cerrado' con la conformidad del usuario.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-layers text-primary me-2""></i>2. Matriz de Priorización de Tickets (P1 a P4)</h4>
    <p>En mesas de ayuda corporativas, las incidencias no se atienden por orden de llegada, sino evaluando el impacto operativo y la urgencia del problema:</p>
    <ol>
        <li><strong>P1 - Crítico (Bloqueo Total del Negocio):</strong> El sistema central de facturación o la pasarela de pagos se cayó; ningún cliente puede comprar. Requiere atención inmediata (FRT &lt; 15 minutos, resolución en &lt; 2 a 4 horas con movilización de ingenieros senior).</li>
        <li><strong>P2 - Alto (Impacto Severo con Alternativa Parcial):</strong> Una sucursal entera no tiene acceso a reportes, pero puede seguir vendiendo manualmente. (Resolución en &lt; 8 horas).</li>
        <li><strong>P3 - Medio (Incidencia Menor / Usuario Individual):</strong> A un usuario específico se le cerró la sesión de su correo o la impresora no responde. (Resolución en 24 a 48 horas).</li>
        <li><strong>P4 - Bajo (Consultas Generales o Mejoras Menores):</strong> Solicitud de cambio de tipografía o dudas sobre una funcionalidad futura. (Resolución programada en sprint ordinario).</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Cerrar tickets unilateralmente sin validación:</strong> Marcar un ticket como 'Resuelto' en el sistema solo para cumplir las metas del SLA sin haber verificado con el cliente si su problema realmente se solucionó. Genera reaperturas de tickets y enfado mayúsculo.</li>
        <li><strong>No categorizar ni etiquetar las incidencias (Tags):</strong> Si no se etiquetan los tickets por causas (ej: #ErrorFactura, #FallaInternet, #ClaveBloqueada), la gerencia no puede identificar los problemas raíz para eliminarlos definitivamente.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Supervisas tu cola de tickets dando estricta prioridad a incidencias P1 y P2?</li>
            <li>¿Verificas con el usuario antes de cerrar formalmente cualquier ticket de servicio?</li>
            <li>¿Cumples con el Acuerdo de Nivel de Servicio (SLA) fijado para tu departamento?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Manejo de Objeciones, Resolución de Reclamos y Métricas CSAT/NPS",
                            LessonTitle = "La Paradoja de Recuperación del Servicio y Métricas de Experiencia",
                            Summary = "Descubre cómo un cliente que experimentó una falla y fue compensado de manera magistral puede volverse más leal que quien nunca tuvo ningún problema.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-graph-up text-success fs-2""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Un Reclamo Bien Resuelto es la Mayor Oportunidad de Fidelización</h5>
            <p class=""mb-0 small"">Las fallas operativas son inevitables; lo imperdonable es la indiferencia corporativa. Conoce la Paradoja de Recuperación del Servicio y los tres indicadores clave: CSAT, CES y FCR.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/2hrbyXdMmqs"" title=""Si te interesan tus clientes, mide el FCR, CSAT y NPS"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-arrow-repeat text-primary me-2""></i>1. La Paradoja de Recuperación del Servicio (Service Recovery Paradox)</h4>
    <p>Comprobada empíricamente en múltiples investigaciones de Harvard Business Review: cuando una empresa comete un error (ej: demora en un pedido o entrega de un artículo defectuoso), pero reacciona con velocidad fulminante, empatía total y una compensación generosa, el nivel de satisfacción y lealtad final de ese cliente resulta ser significativamente superior al de un cliente que nunca experimentó ninguna falla:</p>
    <ul>
        <li><strong>Empoderamiento en Primera Línea:</strong> Para que la paradoja funcione, los colaboradores de atención deben tener autonomía de decisión económica (ej: potestad de otorgar un descuento del 15% o un mes gratis sin tener que pedir autorización a tres gerentes durante una semana).</li>
        <li><strong>Compensación Justa y Oportuna:</strong> Si el error costó tiempo al cliente, la compensación debe reparar no solo el valor monetario del bien, sino el mal rato emocional vivido.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-speedometer2 text-primary me-2""></i>2. Las Tres Métricas Esenciales de Atención al Cliente</h4>
    <p>Un centro de servicio moderno se administra evaluando tres pilares de rendimiento:</p>
    <ol>
        <li><strong>CSAT (Customer Satisfaction Score):</strong> Mide la satisfacción puntual con una transacción concreta: <em>'¿Cómo califica la atención recibida hoy?'</em> (escala de 1 a 5 estrellas). Una meta corporativa saludable debe superar el 85% de satisfacción.</li>
        <li><strong>CES (Customer Effort Score - Puntuación de Esfuerzo):</strong> Mide qué tan fácil o difícil fue para el cliente resolver su problema: <em>'La empresa facilitó la solución de mi solicitud'</em> (escala de totalmente en desacuerdo a totalmente de acuerdo). Cuanto menor sea el esfuerzo exigido al cliente, mayor será su retención futura.</li>
        <li><strong>FCR (First Contact Resolution - Resolución en el Primer Contacto):</strong> El porcentaje de consultas o reclamos que se resolvieron en la primera interacción, sin necesidad de que el usuario tenga que volver a llamar o escribir. Un FCR elevado reduce costos drásticamente.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Culpabilizar al cliente:</strong> Decirle <em>'Usted no leyó la letra pequeña del contrato'</em> o <em>'Eso le pasa por no saber usar el programa'</em> genera un resentimiento irreconciliable.</li>
        <li><strong>Medir solo la rapidez y no la calidad:</strong> Presionar a los agentes para que corten las llamadas en menos de 2 minutos para inflar las estadísticas, provocando que los casos queden mal resueltos y los clientes tengan que llamar 5 veces más.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Ofreces compensaciones rápidas y proporcionadas cuando la empresa comete un error?</li>
            <li>¿Mides tu indicador de Resolución en el Primer Contacto (FCR) semanalmente?</li>
            <li>¿Evalúas el esfuerzo que le exiges hacer a tus clientes para resolver sus trámites?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = 
'@ + $qData + @'
                },
'@
}

Write-Host "Atencion Omnicanal helper loaded successfully!"

function Get-Course-TrabajoEquipo ($qData) {
    return @'
                // =========================================================================
                // 4. TRABAJO EN EQUIPO Y PRODUCTIVIDAD
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "trabajo-en-equipo-habilidades-blandas-productividad",
                    Title = "Trabajo en Equipo, Liderazgo Personal y Productividad Laboral",
                    CategorySlug = "administracion-procesos-reportes",
                    ShortDescription = "Potencia tu perfil profesional: inteligencia emocional (Goleman), roles de equipo Belbin, comunicación no violenta, seguridad psicológica y hábitos de alto rendimiento.",
                    FullDescription = "Capacitación práctica para profesionales que buscan destacar y prosperar en organizaciones modernas. Desarrolla las habilidades blandas (power skills) más buscadas por los reclutadores: autoconocimiento, autorregulación ante la frustración, empatía activa, roles complementarios en el trabajo colaborativo, técnicas para dar y recibir feedback constructivo y erradicación de la procrastinación laboral.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Inteligencia Emocional y Autoliderazgo en el Trabajo",
                            LessonTitle = "El Modelo de Daniel Goleman: Autoconocimiento, Autorregulación y Empatía",
                            Summary = "Descubre por qué el Coeficiente Emocional (EQ) predice el éxito profesional y los ascensos directivos con el doble de precisión que el Coeficiente Intelectual (IQ).",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-heart-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Talento Técnico Abre Puertas; la Inteligencia Emocional las Mantiene Abiertas</h5>
            <p class=""mb-0 small"">Los profesionales técnicamente brillantes pero emocionalmente inestables o conflictivos terminan estancados o despedidos. Aprende a dominar tus respuestas bajo presión y construir relaciones laborales sólidas.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/LoHw4BkmROY"" title=""La inteligencia emocional en el trabajo  | Gabriel Rodríguez González | TEDxBUAP"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-brain text-primary me-2""></i>1. Los 5 Pilares de la Inteligencia Emocional según Daniel Goleman</h4>
    <p>La inteligencia emocional no consiste en reprimir las emociones, sino en reconocerlas, comprender su origen y gestionarlas de forma constructiva para alcanzar objetivos:</p>
    <ul>
        <li><strong>1. Autoconciencia (Self-Awareness):</strong> La capacidad de identificar en tiempo real lo que sientes y cómo influye en tu rendimiento. Conocer con precisión tus fortalezas y debilidades sin autoengaño.</li>
        <li><strong>2. Autorregulación (Self-Regulation):</strong> La habilidad de pausar antes de reaccionar. No actuar impulsivamente por ira, pánico o frustración. Mantener el autocontrol ante provocaciones o crisis.</li>
        <li><strong>3. Motivación Intrínseca:</strong> El impulso interno por superarse, aprender y hacer un trabajo de calidad por orgullo profesional y autorrealización, más allá del dinero o la presión externa.</li>
        <li><strong>4. Empatía Activa:</strong> La capacidad de sintonizar con los sentimientos, perspectivas y preocupaciones de los compañeros de equipo, adaptando la comunicación a sus realidades.</li>
        <li><strong>5. Habilidades Sociales:</strong> Liderazgo, influencia positiva, gestión constructiva del conflicto y capacidad de inspirar colaboración armónica entre personas con personalidades distintas.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shield-check text-primary me-2""></i>2. La Técnica del 'Espacio de Pausa' ante la Frustración</h4>
    <p>Viktor Frankl escribió: <em>'Entre el estímulo y la respuesta hay un espacio. En ese espacio reside nuestro poder para elegir nuestra respuesta'</em>:</p>
    <div class=""card bg-light border-0 p-3 rounded-3 mb-3"">
        <p class=""mb-0 text-muted small""><strong>Protocolo de Autorregulación en 3 Pasos:</strong> Cuando recibas un correo agresivo o un reclamo injusto: <strong>1. Pausa:</strong> No respondas de inmediato (espera 20 minutos). <strong>2. Respira diafragmáticamente:</strong> Inhala en 4 segundos, mantén 4 y exhala en 4 para oxigenar la corteza prefrontal. <strong>3. Responde con hechos:</strong> Elimina adjetivos emocionales y enfócate en datos objetivos y soluciones prácticas.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Confundir asertividad con agresividad:</strong> Creer que 'ser sincero y directo' justifica hablar con arrogancia, humillar o gritar a los colegas.</li>
        <li><strong>El secuestro emocional en reuniones públicas:</strong> Perder los estribos, levantar la voz o abandonar una sala de juntas airadamente arruina la credibilidad profesional de años en 30 segundos.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Reconoces tus detonantes emocionales de estrés antes de perder la calma?</li>
            <li>¿Evitas enviar correos o mensajes importantes cuando sientes enojo o indignación?</li>
            <li>¿Te esfuerzas por entender el punto de vista del otro antes de juzgar sus acciones?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Dinámicas de Grupo, Sinergia y Roles de Belbin",
                            LessonTitle = "La Complementariedad de Talentos y las Fases de Desarrollo del Equipo",
                            Summary = "Aprende cómo estructurar equipos de alto rendimiento utilizando los 9 roles de Belbin y comprende el modelo de Tuckman (Forming, Storming, Norming, Performing).",
                            DurationMinutes = 50,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-people-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Nadie es Perfecto, Pero un Equipo Sí Puede Serlo</h5>
            <p class=""mb-0 small"">Un grupo de personas trabajando en el mismo lugar no es un equipo. Conoce los roles de Belbin y cómo combinar perfiles analíticos, creativos y ejecutores para lograr sinergia multiplicadora.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/XeCtsvIg5Eo"" title=""Trabajo en equipo: roles de BELBIN"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-puzzle text-primary me-2""></i>1. Los 9 Roles de Equipo según Meredith Belbin</h4>
    <p>El Dr. Belbin de la Universidad de Cambridge demostró que los equipos exitosos no están formados por personas idénticas, sino por una mezcla equilibrada de tres categorías de roles complementarios:</p>
    <ul>
        <li><strong>Roles de Acción:</strong>
            <ul>
                <li><em>Impulsor (Shaper):</em> Dinámico y retador, empuja al equipo a superar obstáculos y cumplir plazos.</li>
                <li><em>Implementador (Implementer):</em> Práctico y disciplinado, convierte las ideas abstractas en tareas operativas concretas.</li>
                <li><em>Finalizador (Completer Finisher):</em> Meticuloso y detallista, busca errores, pule la calidad y asegura que nada quede a medias.</li>
            </ul>
        </li>
        <li><strong>Roles Mentales y Creativos:</strong>
            <ul>
                <li><em>Cerebro (Plant):</em> Altamente creativo e innovador, resuelve problemas complejos con soluciones fuera de la caja.</li>
                <li><em>Monitor Evaluador:</em> Analítico, frío y objetivo, sopesa pros y contras antes de tomar decisiones arriesgadas.</li>
                <li><em>Especialista:</em> Aporta conocimientos técnicos profundos y específicos indispensables para el proyecto.</li>
            </ul>
        </li>
        <li><strong>Roles Sociales e Interpersonales:</strong>
            <ul>
                <li><em>Coordinador:</em> Clarifica metas, promueve la toma de decisiones y delega eficazmente.</li>
                <li><em>Investigador de Recursos:</em> Extrovertido y sociable, busca contactos, financiamiento y oportunidades externas.</li>
                <li><em>Cohesionador (Teamworker):</em> Diplomático y empático, calma tensiones y fomenta el buen clima de trabajo.</li>
            </ul>
        </li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-diagram-2 text-primary me-2""></i>2. Las 4 Fases de Evolución del Equipo (Modelo Tuckman)</h4>
    <p>Todo equipo de trabajo atraviesa obligatoriamente por cuatro etapas antes de alcanzar la madurez operativa:</p>
    <ol>
        <li><strong>Formación (Forming):</strong> Cortesía inicial, incertidumbre sobre roles y búsqueda de aprobación del líder.</li>
        <li><strong>Conflicto (Storming):</strong> Chocan las personalidades, surgen disputas por el liderazgo y diferencias en el ritmo de trabajo. Es una fase natural y necesaria; superarla fortalece al grupo.</li>
        <li><strong>Normalización (Norming):</strong> Se acuerdan reglas claras, se aceptan las diferencias y se consolida la confianza mutua.</li>
        <li><strong>Desempeño (Performing):</strong> Sinergia total, alta productividad, autonomía y enfoque unificado en resultados excepcionales.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Armar equipos homogéneos (El sesgo del espejo):</strong> Contratar personas que piensen exactamente igual al líder genera puntos ciegos gigantescos y falta de espíritu crítico.</li>
        <li><strong>Tolerar el parasitismo social (Efecto Ringelmann):</strong> Permitir que algunos miembros no aporten nada escudándose en el esfuerzo de los demás colaboradores.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Conoces tu rol natural de Belbin y cómo complementa las debilidades del resto del equipo?</li>
            <li>¿Comprendes que la fase de conflicto es natural y debe resolverse con acuerdos formales?</li>
            <li>¿Asumes la responsabilidad individual de tus tareas asignadas sin depender del empuje ajeno?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Comunicación No Violenta, Asertividad y Feedback Constructivo",
                            LessonTitle = "El Modelo de Marshall Rosenberg y la Técnica del Feedback SBI (Situación, Conducta, Impacto)",
                            Summary = "Aprende a expresar desacuerdos con firmeza y elegancia: observación vs juicio, necesidades insatisfechas y la estructura SBI para corregir errores sin humillar.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-chat-heart-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Asertividad es el Puente entre la Sumisión y la Agresividad</h5>
            <p class=""mb-0 small"">El 60% de los problemas en las empresas se originan por una mala comunicación interna. Aprende a decir que no con respeto, plantear quejas con elegancia y retroalimentar con el método SBI.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/Gqod-kdSOJk"" title=""Mapa mental: La Comunicación No Violenta de Marshall Rosenberg"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-flower1 text-primary me-2""></i>1. Los 4 Pasos de la Comunicación No Violenta (CNV)</h4>
    <p>Desarrollada por el psicólogo Marshall Rosenberg, la CNV transforma conversaciones potencialmente destructivas en puentes de colaboración mutua:</p>
    <ul>
        <li><strong>1. Hechos Observables (Sin Juicios ni Etiquetas):</strong> Describir lo que ocurrió como una cámara de video, sin interpretaciones ofensivas. (<em>'En las últimas dos semanas has llegado 25 minutos tarde a tres reuniones'</em> en lugar de <em>'Eres un irresponsable y no te importa el proyecto'</em>).</li>
        <li><strong>2. Expresión del Sentimiento Propio:</strong> Expresar cómo te afecta la situación en primera persona, sin acusaciones (<em>'Me siento preocupado y presionado con los plazos de entrega'</em>).</li>
        <li><strong>3. Identificación de la Necesidad:</strong> Explicar el valor subyacente que está en juego (<em>'Porque necesitamos coordinar los cambios antes de que el cliente revise la plataforma'</em>).</li>
        <li><strong>4. Petición Concreta y Accionable:</strong> Solicitar una acción específica en positivo (<em>'¿Podrías comprometerte a conectarte 5 minutos antes en las reuniones de los martes y jueves?'</em>).</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-arrow-left-right text-primary me-2""></i>2. El Modelo SBI para Dar Feedback Profesional (Situación - Conducta - Impacto)</h4>
    <p>Desarrollado por el Center for Creative Leadership (CCL), es el estándar de oro en corporaciones multinacionales:</p>
    <ol>
        <li><strong>Situation (Situación Temporal y Espacial):</strong> <em>'Ayer durante la presentación del informe comercial ante la gerencia...'</em></li>
        <li><strong>Behavior (Conducta Específica):</strong> <em>'...interrumpiste al analista en tres ocasiones antes de que pudiera mostrar las gráficas de rentabilidad...'</em></li>
        <li><strong>Impact (Impacto Medible):</strong> <em>'...lo cual hizo que la gerencia percibiera descoordinación interna y el analista se sintiera desvalorizado frente a los directores'</em>.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>La trampa del 'Elogio Sandwich' mal ejecutado:</strong> Dar un halago falso, meter una crítica devastadora en el medio y cerrar con otro halago vacío. Hace que los colaboradores sientan desconfianza permanente hacia los cumplidos.</li>
        <li><strong>Dar retroalimentación correctiva en público:</strong> La regla sagrada del liderazgo es: <em>Felicita en público, corrige siempre en estricto privado</em>.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Separas los hechos objetivos de tus interpretaciones emocionales al hacer una crítica?</li>
            <li>¿Corriges a tus compañeros o subordinados en privado y nunca frente a clientes o colegas?</li>
            <li>¿Estructuras tus conversaciones difíciles siguiendo el modelo Situación - Conducta - Impacto?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Hábitos de Productividad, Disciplina y Superación de la Procrastinación",
                            LessonTitle = "La Neurociencia del Enfoque, la Regla de los 2 Minutos y Hábitos Atómicos",
                            Summary = "Descubre por qué tu cerebro pospone tareas difíciles y cómo reprogramar tus hábitos con la regla de los dos minutos, la fricción ambiental y el apilamiento de hábitos.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-alarm-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">La Procrastinación No es Pereza; es Mala Regulación Emocional</h5>
            <p class=""mb-0 small"">No procrastinas porque no tengas tiempo; procrastinas para evitar el malestar emocional (miedo al fracaso, aburrimiento o perfeccionismo paralizante) que te produce iniciar una tarea difícil. Aprende a hackear tu cerebro para rendir al máximo.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/wExgu4I0jQA"" title=""Así Funciona la Mente de un PROCRASTINADOR (y Cómo Resolverlo)"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-lightning-charge text-primary me-2""></i>1. La Batalla Cerebral: Sistema Límbico vs Corteza Prefrontal</h4>
    <p>En el cerebro humano compiten dos estructuras biológicas con prioridades radicalmente opuestas:</p>
    <ul>
        <li><strong>El Sistema Límbico (El 'Mono de la Gratificación Inmediata'):</strong> Primitivo, veloz e instintivo. Busca placer a corto plazo, dopamina rápida (redes sociales, videos cortos) y huir de cualquier esfuerzo que genere incomodidad.</li>
        <li><strong>La Corteza Prefrontal (El 'Adulto Racional'):</strong> Evolutivamente moderna, reflexiva y analítica. Planifica a largo plazo, visualiza las consecuencias futuras de no trabajar y busca la autorrealización profesional.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-check-circle text-primary me-2""></i>2. Estrategias Basadas en Evidencia para Vencer la Procrastinación</h4>
    <p>Para desactivar la resistencia mental al inicio de una tarea pesada:</p>
    <ol>
        <li><strong>La Regla de los 2 Minutos (David Allen & James Clear):</strong> Reduce la tarea a una versión minúscula que tome menos de 120 segundos. Si tienes que redactar un informe de 40 páginas, tu único objetivo inicial es: <em>'Abrir el archivo de Word y escribir el título'</em>. Una vez que el cerebro supera la inercia del arranque, la fricción mental desaparece y el estado de flujo (Flow) se activa por sí solo.</li>
        <li><strong>Aumentar la Fricción de las Distracciones:</strong> Cada clic o segundo extra que te tome acceder a una distracción reduce en un 80% la probabilidad de caer en ella. Pon el teléfono móvil en otra habitación o utiliza bloqueadores de sitios web durante tus bloques de trabajo importante.</li>
        <li><strong>Apilamiento de Hábitos (Habit Stacking):</strong> Anclar una rutina productiva nueva a un hábito automático que ya realizas todos los días: <em>'Después de servirme mi primera taza de café de la mañana, revisaré y priorizaré mis tres tareas críticas del día antes de abrir el correo'</em>.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>La ilusión del Multitasking (Multitarea):</strong> Intentar hacer tres cosas a la vez reduce el coeficiente intelectual funcional en 10 puntos y triplica la tasa de errores. El cerebro no procesa en paralelo; cambia de foco velozmente con un costo cognitivo altísimo.</li>
        <li><strong>El Perfeccionismo Paralizante:</strong> No entregar proyectos a tiempo alegando que 'todavía no están perfectos'. En el mundo laboral moderno: <em>'Mejor hecho que perfecto'</em>.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Aplicas la regla de los dos minutos para vencer la inercia de iniciar tareas pesadas?</li>
            <li>¿Eliminas notificaciones y guardas el teléfono durante tus bloques de trabajo importante?</li>
            <li>¿Trabajas en una sola tarea a la vez evitando la trampa del multitasking?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = 
'@ + $qData + @'
                },
'@
}

Write-Host "Trabajo en Equipo helper loaded successfully!"
