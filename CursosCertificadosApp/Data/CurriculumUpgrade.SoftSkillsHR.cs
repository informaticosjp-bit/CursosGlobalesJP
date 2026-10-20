using CursosCertificadosApp.Models.Entities;

namespace CursosCertificadosApp.Data
{
    public static class CurriculumUpgradeSoftSkillsHR
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
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la principal diferencia entre la Misión y los Valores de una empresa?",
                            OptionA = @"La misión es para los accionistas y los valores para el gobierno.",
                            OptionB = @"La Misión define la actividad y propósito comercial actual de la organización, mientras que los Valores son los principios éticos no negociables que rigen la conducta.",
                            OptionC = @"No existe ninguna diferencia; son términos sinónimos.",
                            OptionD = @"La misión es un eslogan publicitario que se cambia cada semana.",
                            CorrectAnswer = "B",
                            Explanation = @"La misión responde al propósito operativo (qué hace la empresa), mientras los valores rigen cómo se comporta la organización para lograrlo."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué constituye un 'Conflicto de Interés' en el puesto de trabajo?",
                            OptionA = @"Tener una discusión acalorada sobre fútbol en el almuerzo.",
                            OptionB = @"Una situación donde los intereses personales, familiares o económicos de un empleado interfieren o pueden influir indebidamente en su juicio profesional y decisiones laborales.",
                            OptionC = @"Llegar 5 minutos tarde debido al tráfico vehicular.",
                            OptionD = @"Pedir un aumento de salario anual.",
                            CorrectAnswer = "B",
                            Explanation = @"El conflicto de interés compromete la objetividad y lealtad hacia la compañía en favor de un beneficio particular."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"Si un proveedor habitual envía un regalo costoso de fin de año (ej. un teléfono móvil de última generación) al encargado de compras, ¿cuál es la conducta ética correcta?",
                            OptionA = @"Aceptarlo en secreto y guardarlo en la mochila sin decir nada a nadie.",
                            OptionB = @"Declararlo de inmediato al comité de ética o recursos humanos conforme a la política de regalos de la compañía y proceder a su devolución o donación institucional.",
                            OptionC = @"Exigirle al proveedor que también le regale otro teléfono a su cónyuge.",
                            OptionD = @"Vender el teléfono por internet para ganar dinero extra.",
                            CorrectAnswer = "B",
                            Explanation = @"Los regalos costosos comprometen la imparcialidad del comprador; deben declararse y canalizarse bajo la política oficial de regalos."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es el propósito fundamental de una 'Línea Ética' o canal de denuncias anónimo (Whistleblowing) en una corporación?",
                            OptionA = @"Publicar rumores sobre la vida personal de los compañeros de trabajo.",
                            OptionB = @"Permitir a los colaboradores reportar infracciones legales, acoso o fraudes de forma confidencial y protegida sin temor a represalias laborales.",
                            OptionC = @"Pedir comida a domicilio sin pagar.",
                            OptionD = @"Calificar los uniformes del personal.",
                            CorrectAnswer = "B",
                            Explanation = @"La línea ética garantiza confidencialidad y no represalias, permitiendo detectar irregularidades a tiempo para corregirlas."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué implica la firma de un 'Acuerdo de Confidencialidad' (NDA - Non-Disclosure Agreement)?",
                            OptionA = @"El compromiso legal de no revelar ni utilizar secretos comerciales, datos de clientes o información financiera sensible de la empresa fuera de las labores autorizadas.",
                            OptionB = @"La obligación de no hablar con nadie durante las 8 horas de la jornada.",
                            OptionC = @"Que el empleado renuncia a cobrar su sueldo.",
                            OptionD = @"Que el trabajador no puede cambiarse de ropa.",
                            CorrectAnswer = "A",
                            Explanation = @"El NDA protege los activos intangibles y datos privados de la organización ante divulgaciones no autorizadas."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"En el marco de la Responsabilidad Social Empresarial, ¿a qué se refiere el enfoque de 'Triple Impacto'?",
                            OptionA = @"Pagar el triple de sueldo a los directores.",
                            OptionB = @"Generar valor equilibrado en tres dimensiones: rentabilidad económica, justicia social y sostenibilidad ambiental.",
                            OptionC = @"Abrir tres sucursales nuevas al año.",
                            OptionD = @"Lanzar tres campañas de publicidad por televisión.",
                            CorrectAnswer = "B",
                            Explanation = @"El triple impacto evalúa el éxito corporativo integrando beneficios financieros, bienestar de la comunidad y protección ecológica."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué es el 'Compliance' (Cumplimiento Normativo) en una organización?",
                            OptionA = @"El sistema para obligar a los clientes a comprar más productos.",
                            OptionB = @"El conjunto de procedimientos y buenas prácticas para identificar y prevenir riesgos legales y regulatorios que puedan afectar a la empresa.",
                            OptionC = @"La fiesta de aniversario de la compañía.",
                            OptionD = @"El software de diseño gráfico de la empresa.",
                            CorrectAnswer = "B",
                            Explanation = @"Compliance asegura que todas las actividades de la compañía se apeguen estrictamente al marco legal vigente y a estándares éticos internacionales."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"Si un colaborador presencia una conducta reiterada de acoso laboral (mobbing) hacia un compañero, ¿cuál debe ser su postura según la ética profesional?",
                            OptionA = @"Unirse a las burlas para no ser el siguiente blanco.",
                            OptionB = @"No ser cómplice con el silencio y reportar la situación de forma objetiva a través de los canales institucionales de Recursos Humanos o Comité de Convivencia.",
                            OptionC = @"Grabar vídeos para subirlos a TikTok con burlas.",
                            OptionD = @"Fingir que no se dio cuenta de nada.",
                            CorrectAnswer = "B",
                            Explanation = @"La pasividad ante el acoso vulnera la dignidad humana; el deber ético es reportar los hechos por las vías institucionales establecidas."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué la 'Transparencia' es considerada un valor estratégico fundamental para las empresas modernas?",
                            OptionA = @"Porque ahorra dinero en paredes de concreto.",
                            OptionB = @"Porque construye confianza sólida con clientes, inversionistas y la sociedad, blindando la reputación ante crisis de mercado.",
                            OptionC = @"Porque la ley prohíbe tener puertas cerradas en las oficinas.",
                            OptionD = @"Para que los competidores copien los productos más fácilmente.",
                            CorrectAnswer = "B",
                            Explanation = @"La transparencia informativa y contable genera credibilidad, lealtad de marca y facilita el acceso a financiamiento internacional."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué acción representa una violación directa al uso ético de los recursos materiales de la empresa?",
                            OptionA = @"Utilizar la impresora de la oficina para fotocopiar e imprimir volúmenes masivos de libros personales o para un negocio privado ajeno a la compañía.",
                            OptionB = @"Apagar la computadora al terminar el turno de trabajo.",
                            OptionC = @"Solicitar un bolígrafo nuevo cuando se agota la tinta del anterior.",
                            OptionD = @"Lavarse las manos en los sanitarios del personal.",
                            CorrectAnswer = "A",
                            Explanation = @"Los activos y suministros de la empresa están destinados exclusivamente para las actividades laborales asignadas."
                        }
                    }                },
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
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la recomendación clave sobre el contacto visual durante una atención presencial con un cliente?",
                            OptionA = @"Mirar fijamente al suelo para mostrar sumisión.",
                            OptionB = @"Mantener contacto visual directo entre el 60% y 70% del tiempo para proyectar seguridad, empatía e interés genuino.",
                            OptionC = @"Mirar la pantalla del teléfono celular todo el tiempo.",
                            OptionD = @"Mirar fijamente a los ojos sin pestañear durante 15 minutos continuos.",
                            CorrectAnswer = "B",
                            Explanation = @"Un contacto visual equilibrado transmite calidez y escucha atenta sin incomodar al interlocutor."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"En el método LAST para gestionar clientes difíciles, ¿qué significa la letra 'A' (Apologize)?",
                            OptionA = @"Amenazar al cliente con llamar a la policía.",
                            OptionB = @"Ofrecer una disculpa empática e institucional por el inconveniente ocasionado sin tomárselo como un ataque personal.",
                            OptionC = @"Aceptar que el empleado es culpable de todos los males del mundo.",
                            OptionD = @"Anotar el nombre del cliente en una lista negra.",
                            CorrectAnswer = "B",
                            Explanation = @"La disculpa institucional valida las emociones del cliente y desarma la hostilidad inicial."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué la frase '¡Cálmese!' suele empeorar el enojo de un cliente molesto?",
                            OptionA = @"Porque es una palabra en otro idioma.",
                            OptionB = @"Porque descalifica sus emociones, suena condescendiente y le hace sentir incomprendido y minimizado.",
                            OptionC = @"Porque es ilegal decirla en oficinas públicas.",
                            OptionD = @"Porque provoca que el cliente hable más rápido.",
                            CorrectAnswer = "B",
                            Explanation = @"Decirle 'cálmese' a una persona enfadada invalida su frustración y suele desatar mayor agresividad verbal."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué es el 'Parafraseo' en la técnica de escucha activa?",
                            OptionA = @"Repetir con nuestras propias palabras la necesidad expresada por el cliente para confirmar que la hemos entendido con exactitud.",
                            OptionB = @"Cantar una canción para calmar el ambiente.",
                            OptionC = @"Hablar con palabras técnicas complejas para impresionar al usuario.",
                            OptionD = @"Inventar respuestas que no existen.",
                            CorrectAnswer = "A",
                            Explanation = @"El parafraseo demuestra que se estaba prestando atención y alinea las expectativas de solución de forma cristalina."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"En la métrica de Net Promoter Score (NPS), ¿cómo se clasifican los clientes que califican con puntuación 9 o 10?",
                            OptionA = @"Detractores.",
                            OptionB = @"Promotores.",
                            OptionC = @"Pasivos.",
                            OptionD = @"Cancelados.",
                            CorrectAnswer = "B",
                            Explanation = @"Las puntuaciones 9 y 10 corresponden a Promotores: clientes altamente satisfechos que impulsan el crecimiento recomendando la marca."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué postura corporal transmite desinterés o rechazo hacia un cliente que se acerca al mostrador?",
                            OptionA = @"Mantener una sonrisa amable y erguida.",
                            OptionB = @"Estar recostado desganado, con los brazos cruzados y la mirada fija en el teléfono móvil.",
                            OptionC = @"Saludar con un tono de voz cordial y enérgico.",
                            OptionD = @"Asentir con la cabeza mientras el cliente explica su problema.",
                            CorrectAnswer = "B",
                            Explanation = @"Los brazos cruzados y la distracción con el móvil emiten una señal tajante de desinterés y mala educación."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué es fundamental dejar que un cliente enojado hable sin interrupciones durante los primeros 45 segundos?",
                            OptionA = @"Para que el empleado pueda ir al baño.",
                            OptionB = @"Para permitir que libere la carga emocional inicial, tras lo cual la persona estará mucho más receptiva para escuchar una solución racional.",
                            OptionC = @"Porque la ley exige no hablar los primeros 2 minutos.",
                            OptionD = @"Para memorizar su tono de voz.",
                            CorrectAnswer = "B",
                            Explanation = @"Interrumpir en pleno pico emocional aumenta la furia; escuchar en silencio drena la energía de confrontación."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué alternativa asertiva reemplaza profesionalmente a la frase 'Ese no es mi problema ni mi departamento'?",
                            OptionA = @"'No sé de qué me habla'.",
                            OptionB = @"'Con mucho gusto le acompaño o le comunico con el área especializada para que le atiendan de inmediato'.",
                            OptionC = @"'Vuelva la próxima semana a ver si hay alguien'.",
                            OptionD = @"'Vaya a quejarse con el gerente si no le gusta'.",
                            CorrectAnswer = "B",
                            Explanation = @"La orientación y el acompañamiento proactivo demuestran espíritu de servicio y compromiso con la solución."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué significa el concepto de 'Efecto WOW' en la experiencia del cliente?",
                            OptionA = @"Gritar muy fuerte cuando entra una persona al local.",
                            OptionB = @"Superar gratamente las expectativas del cliente con un detalle de servicio inesperado y memorable.",
                            OptionC = @"Cobrar el doble de lo acordado.",
                            OptionD = @"Apagar las luces del local por sorpresa.",
                            CorrectAnswer = "B",
                            Explanation = @"El efecto WOW va más allá de cumplir el servicio básico: añade un toque humano o de valor que deja una huella emocional positiva."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué retener a un cliente existente es considerablemente más rentable que captar uno nuevo?",
                            OptionA = @"Porque no cuesta nada fabricar productos para clientes viejos.",
                            OptionB = @"Porque captar un nuevo cliente exige cuantiosas inversiones en publicidad y prospección, mientras que el cliente fiel ya confía y recompra a menor costo.",
                            OptionC = @"Porque los clientes nuevos siempre pagan con billetes rotos.",
                            OptionD = @"Porque las leyes impiden buscar clientes nuevos.",
                            CorrectAnswer = "B",
                            Explanation = @"La fidelización maximiza el valor de vida del cliente (LTV) y reduce drásticamente los gastos de captación comercial."
                        }
                    }                },
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
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué es la 'Paradoja de Recuperación del Servicio' (Service Recovery Paradox)?",
                            OptionA = @"Que nunca se debe pedir perdón a los clientes bajo ninguna circunstancia.",
                            OptionB = @"El fenómeno en el que un cliente que sufrió una falla, al recibir una solución excepcionalmente rápida y empática, termina teniendo un nivel de lealtad mayor que un cliente que nunca tuvo problemas.",
                            OptionC = @"Que las máquinas de café en la oficina siempre se descomponen.",
                            OptionD = @"Que los clientes que no se quejan nunca vuelven a comprar.",
                            CorrectAnswer = "B",
                            Explanation = @"Una resolución brillante transforma una crisis en una demostración indiscutible de compromiso que forja fidelidad a largo plazo."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué significa el indicador FCR (First Contact Resolution) en un centro de atención o soporte?",
                            OptionA = @"Facturación de Crédito Rápida.",
                            OptionB = @"Resolución en el Primer Contacto: el porcentaje de casos solucionados en la primera interacción sin requerir llamadas o trámites posteriores.",
                            OptionC = @"Firma de Contratos de Redes.",
                            OptionD = @"Filtro de Correos Rechazados.",
                            CorrectAnswer = "B",
                            Explanation = @"FCR es la métrica más ligada a la satisfacción del cliente, ya que a nadie le gusta llamar múltiples veces por el mismo problema."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿En qué consiste una 'Transferencia Cálida' de llamada telefónica?",
                            OptionA = @"Dejar caer el auricular sobre la mesa caliente.",
                            OptionB = @"Poner al cliente en espera, explicarle al compañero receptor quién llama y cuál es su caso, y luego conectar la comunicación para que el cliente no tenga que repetir todo.",
                            OptionC = @"Gritarle al compañero a través de toda la oficina.",
                            OptionD = @"Colgarle al cliente y pedirle que vuelva a marcar otra extensión.",
                            CorrectAnswer = "B",
                            Explanation = @"La transferencia cálida traspasa el contexto del problema al colega, evitando que el cliente deba narrar su queja desde el inicio."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué mide el indicador CES (Customer Effort Score)?",
                            OptionA = @"La cantidad de calorías que gasta el cliente al caminar hasta la tienda.",
                            OptionB = @"El grado de facilidad o esfuerzo que tuvo que hacer el cliente para que la empresa resolviera su solicitud o reclamo.",
                            OptionC = @"El precio de compra del producto.",
                            OptionD = @"La cantidad de años que tiene la empresa funcionando.",
                            CorrectAnswer = "B",
                            Explanation = @"El esfuerzo del cliente es el predictor principal de deserción: entre más fácil y fluido sea resolver un trámite, más fiel es el cliente."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué define un Acuerdo de Nivel de Servicio (SLA - Service Level Agreement)?",
                            OptionA = @"El sueldo que cobrará el agente de soporte.",
                            OptionB = @"El compromiso formal y medible de tiempos de respuesta y solución pactados entre el proveedor del servicio y el cliente.",
                            OptionC = @"El manual de instalación del sistema operativo.",
                            OptionD = @"La lista de días festivos del año.",
                            CorrectAnswer = "B",
                            Explanation = @"El SLA formaliza los plazos máximos tolerados para atender y resolver tickets según su nivel de severidad e impacto."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué es una mala práctica debatir o confrontar públicamente a un cliente que deja una queja en redes sociales abiertas?",
                            OptionA = @"Porque las redes sociales cobran dinero por debatir.",
                            OptionB = @"Porque expone negativamente a la marca frente a miles de espectadores; lo profesional es dar una respuesta inicial empática y canalizar el caso por mensaje privado.",
                            OptionC = @"Porque el cliente siempre tiene poderes mágicos.",
                            OptionD = @"Porque las computadoras se sobrecalientan.",
                            CorrectAnswer = "B",
                            Explanation = @"Pelear en público arruina la imagen corporativa; la contención debe ser rápida para luego gestionar la solución de forma privada y documentada."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué efecto produce la 'Sonrisa Telefónica' al atender una llamada de un cliente?",
                            OptionA = @"Ninguno, porque el teléfono solo transmite imágenes.",
                            OptionB = @"Modifica físicamente la posición de los músculos faciales y resonadores bucales, haciendo que el tono de voz suene naturalmente más cálido, amable y acogedor.",
                            OptionC = @"Hace que la llamada se corte de inmediato.",
                            OptionD = @"Aumenta el costo por minuto de la llamada.",
                            CorrectAnswer = "B",
                            Explanation = @"La biomecánica facial altera el timbre y resonancia vocal, permitiendo que el cerebro humano detecte la amabilidad auditivamente."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la forma correcta de redactar una respuesta por correo electrónico a un cliente que reporta un error?",
                            OptionA = @"Escribir en mayúsculas sostenidas y sin signos de puntuación.",
                            OptionB = @"Saludar cordialmente con su nombre, agradecer el reporte, explicar con claridad la causa y solución paso a paso, y dejar abierta la vía de contacto.",
                            OptionC = @"Enviar solo un enlace sin texto explicativo.",
                            OptionD = @"Copiar a todos los empleados de la empresa para que se burlen.",
                            CorrectAnswer = "B",
                            Explanation = @"La correspondencia profesional exige estructura limpia, claridad de pasos y cortesía formal para proyectar seriedad y confiabilidad."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"En la métrica CSAT (Customer Satisfaction), ¿cómo se calcula habitualmente el porcentaje final de satisfacción?",
                            OptionA = @"Sumando todas las quejas del mes.",
                            OptionB = @"Dividiendo el número de respuestas positivas (calificaciones 4 y 5) entre el total de encuestas respondidas y multiplicando por 100.",
                            OptionC = @"Contando los clics en el botón de salida.",
                            OptionD = @"Multiplicando las horas trabajadas por el número de agentes.",
                            CorrectAnswer = "B",
                            Explanation = @"CSAT expresa el porcentaje directo de clientes que calificaron su experiencia como buena o excelente."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es el tiempo máximo prudente para mantener a un cliente en 'Música de Espera' (Hold) sin retomar la llamada para informarle el avance?",
                            OptionA = @"45 minutos.",
                            OptionB = @"No más de 60 a 90 segundos sin regresar para agradecer su paciencia e informarle que se sigue gestionando su consulta.",
                            OptionC = @"Todo el día hasta que se canse y cuelgue.",
                            OptionD = @"Exactamente 10 milisegundos.",
                            CorrectAnswer = "B",
                            Explanation = @"Dejar al cliente en silencio o música prolongada genera angustia y sensación de abandono; debe refrescarse el contacto periódicamente."
                        }
                    }                },
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
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"Según la investigación de Daniel Goleman, ¿qué componente de la Inteligencia Emocional permite resistir impulsos destructivos y mantener la compostura en crisis?",
                            OptionA = @"La Autorregulación emocional.",
                            OptionB = @"La memoria fotográfica.",
                            OptionC = @"El cálculo aritmético veloz.",
                            OptionD = @"La ambición desmedida de poder.",
                            CorrectAnswer = "A",
                            Explanation = @"La autorregulación permite frenar reacciones viscerales y canalizar las emociones de forma productiva y serena."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"En el Proyecto Aristóteles de Google, ¿cuál fue el factor número uno que distinguió a los equipos de trabajo más exitosos y de alto rendimiento?",
                            OptionA = @"Que todos los miembros fueran egresados de las mismas universidades de élite.",
                            OptionB = @"La Seguridad Psicológica: la confianza de que el equipo es un entorno seguro para asumir riesgos, admitir dudas y cometer errores sin ser juzgado.",
                            OptionC = @"Tener la oficina con los muebles más caros y mesas de billar.",
                            OptionD = @"Trabajar 16 horas diarias sin descansar.",
                            CorrectAnswer = "B",
                            Explanation = @"La seguridad psicológica desata la innovación, la honestidad y el aprendizaje acelerado en los equipos colaborativos."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué estructura sigue el modelo de retroalimentación profesional SBI?",
                            OptionA = @"Sueldo, Bonificación, Impuestos.",
                            OptionB = @"Situación (el momento concreto), Conducta (el hecho observable sin juicios) e Impacto (la consecuencia que provocó).",
                            OptionC = @"Saludos, Burlas, Insultos.",
                            OptionD = @"Sanción, Boicot, Indemnización.",
                            CorrectAnswer = "B",
                            Explanation = @"El modelo SBI (Situation-Behavior-Impact) despersonaliza la crítica basándose en conductas objetivas y resultados verificables."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál de las siguientes afirmaciones describe la metodología de Roles de Equipo de Meredith Belbin?",
                            OptionA = @"Todos los miembros del equipo deben tener la misma personalidad para no discutir jamás.",
                            OptionB = @"Los equipos de alto desempeño requieren una combinación equilibrada de roles orientados a la acción, a las personas y al pensamiento cerebral.",
                            OptionC = @"El equipo solo debe tener un líder que trabaje y los demás observen.",
                            OptionD = @"Los roles se asignan por sorteo de lotería.",
                            CorrectAnswer = "B",
                            Explanation = @"La complementariedad de talentos (ej. generadores de ideas, impulsores de acción y finalizadores detallistas) genera equilibrio operativo."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué establece la 'Regla de los 2 Minutos' para vencer la procrastinación en el trabajo?",
                            OptionA = @"Trabajar solo 2 minutos al día.",
                            OptionB = @"Si una tarea pendiente te toma menos de dos minutos en completarse, realízala de inmediato en lugar de agendarla o posponerla.",
                            OptionC = @"Tomar una siesta de dos minutos en la oficina.",
                            OptionD = @"Llegar a las reuniones dos minutos tarde.",
                            CorrectAnswer = "B",
                            Explanation = @"Ejecutar al instante tareas diminutas evita la acumulación de pendientes que saturan la memoria de trabajo y generan estrés."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es el error más común al momento de brindar retroalimentación constructiva a un compañero?",
                            OptionA = @"Hablar en privado de forma respetuosa.",
                            OptionB = @"Atacar la personalidad o carácter de la persona (ej. 'Eres un irresponsable') en lugar de describir el hecho específico objetivo.",
                            OptionC = @"Agradecer sus contribuciones positivas.",
                            OptionD = @"Proponer acciones de mejora conjunta.",
                            CorrectAnswer = "B",
                            Explanation = @"Los juicios sobre la identidad generan actitudes defensivas y hostilidad; el feedback eficaz se enfoca en conductas modificables."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué es el 'Secuestro de la Amígdala' (Amygdala Hijack)?",
                            OptionA = @"Una operación quirúrgica de garganta.",
                            OptionB = @"Una reacción emocional instintiva e intensa desencadenada por el cerebro límbico que anula temporalmente la lógica racional ante una amenaza percibida.",
                            OptionC = @"Un virus informático que borra hojas de cálculo.",
                            OptionD = @"Una técnica de meditación zen.",
                            CorrectAnswer = "B",
                            Explanation = @"La amígdala cerebral reacciona con impulsos de lucha o huida ante el estrés; la inteligencia emocional permite respirar y pausar la respuesta."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"En la Comunicación No Violenta (CNV), ¿cuál es el paso que sigue a la observación objetiva de los hechos?",
                            OptionA = @"Gritar con furia.",
                            OptionB = @"Identificar y expresar los sentimientos y necesidades reales no satisfechas.",
                            OptionC = @"Amenazar con una demanda judicial.",
                            OptionD = @"Guardar rencor durante años.",
                            CorrectAnswer = "B",
                            Explanation = @"La CNV busca conectar con las necesidades humanas universales subyacentes antes de realizar una petición concreta y negociable."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué un equipo de trabajo compuesto únicamente por perfiles creativos y visionarios suele tener problemas en la práctica?",
                            OptionA = @"Porque son demasiado inteligentes para trabajar.",
                            OptionB = @"Porque abundan las ideas pero carecen de roles ejecutores, finalizadores y organizadores que aterricen los proyectos a la realidad concreta.",
                            OptionC = @"Porque la creatividad está prohibida en las empresas.",
                            OptionD = @"Porque las computadoras no soportan tantas ideas.",
                            CorrectAnswer = "B",
                            Explanation = @"Sin perfiles metódicos y enfocados en el detalle y los plazos, las ideas visionarias se disipan sin materializarse en resultados."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la premisa central del libro 'Hábitos Atómicos' de James Clear?",
                            OptionA = @"Que los grandes cambios solo ocurren de golpe mediante sacrificios sobrehumanos.",
                            OptionB = @"Que pequeñas mejoras del 1% sostenidas con consistencia diaria generan transformaciones masivas acumuladas a lo largo del tiempo.",
                            OptionC = @"Que hay que trabajar de noche para ser exitoso.",
                            OptionD = @"Que los hábitos no tienen ninguna influencia en la productividad.",
                            CorrectAnswer = "B",
                            Explanation = @"El efecto compuesto de los microhábitos diarios transforma la identidad y la productividad personal de manera perdurable."
                        }
                    }                },
                // =========================================================================
                // 5. LIDERAZGO EFECTIVO Y GESTIÓN DE EQUIPOS
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "liderazgo-efectivo",
                    Title = "Liderazgo Efectivo: Inteligencia Emocional, Coaching y Gestión de Equipos",
                    CategorySlug = "liderazgo-gestion-empresarial",
                    ShortDescription = "Pasa de jefe a líder inspirador: modelo situacional de Hersey-Blanchard, reuniones 1 a 1, delegación efectiva sin micromanagement y liderazgo en crisis.",
                    FullDescription = "Capacitación directiva orientada a supervisores, jefes de área, gerentes y coordinadores. Aprende a adaptar tu estilo de liderazgo según la madurez y competencia de cada colaborador (Liderazgo Situacional), liderar reuniones individuales de coaching (One-on-One) de alto impacto, delegar tareas con niveles de autonomía claros y mantener la cohesión en momentos de incertidumbre y crisis.",
                    Level = "Intermedio",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: De Jefe a Líder: Estilos de Liderazgo y Modelo Situacional",
                            LessonTitle = "El Modelo Hersey-Blanchard: Dirigir, Guiar, Apoyar y Delegar",
                            Summary = "Descubre por qué no existe un único estilo de liderazgo perfecto y aprende a calibrar tu nivel de dirección y apoyo según la competencia y motivación del colaborador.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-compass-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Liderazgo No es un Rango de Poder; es un Acto de Servicio y Facilitación</h5>
            <p class=""mb-0 small"">Los jefes tradicionales mandan e infunden temor; los líderes modernos inspiran, desarrollan talento y eliminan obstáculos para que sus equipos alcancen resultados extraordinarios.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/XVNpyCENMyY"" title=""Modelo de Liderazgo Situacional  Modelo de Hersey Blanchard C.O. Orientación a la tarea la Relación👍"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-diagram-3 text-primary me-2""></i>1. El Modelo de Liderazgo Situacional (Hersey-Blanchard)</h4>
    <p>El error más habitual de los líderes inexpertos es tratar a todos los colaboradores exactamente de la misma manera. El modelo situacional postula que el estilo directivo debe adaptarse a la 'Madurez Operativa' (combinación de competencia técnica y motivación intrínseca):</p>
    <ul>
        <li><strong>E1 - Dirigir (M1: Baja Competencia / Alta Motivación):</strong> Típico del nuevo empleado entusiasta pero sin experiencia técnica. Requiere instrucciones paso a paso detalladas, supervisión cercana y retroalimentación frecuente.</li>
        <li><strong>E2 - Guiar / Entrenar (M2: Cierta Competencia / Baja Motivación):</strong> El colaborador se da cuenta de que la labor es más difícil de lo esperado y se desanima. El líder debe explicar los 'porqués', escuchar sus dudas y reanimar su confianza sin descuidar el control técnico.</li>
        <li><strong>E3 - Apoyar / Facilitar (M3: Alta Competencia / Motivación Variable):</strong> El profesional domina técnicamente el trabajo pero duda de su criterio o sufre de síndrome del impostor. El líder debe actuar como facilitador, escuchando sus propuestas y empoderándolo a tomar decisiones.</li>
        <li><strong>E4 - Delegar (M4: Alta Competencia / Alta Motivación):</strong> El colaborador estrella senior. Requiere máxima autonomía, fijación de metas estratégicas y mínima intervención operativa en el 'cómo'.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-heart-pulse text-primary me-2""></i>2. La Seguridad Psicológica como Cimiento del Alto Desempeño</h4>
    <p>El Proyecto Aristóteles de Google analizó cientos de equipos durante años para descubrir qué los hacía excepcionales. La conclusión indiscutible fue la <strong>Seguridad Psicológica</strong> (Psychological Safety):</p>
    <div class=""card bg-light border-0 p-3 rounded-3 mb-3"">
        <p class=""mb-0 text-muted small"">La creencia compartida por todos los miembros del equipo de que nadie será humillado, ridiculizado o castigado por admitir un error, hacer preguntas sinceras o proponer ideas arriesgadas pero innovadoras.</p>
    </div>
    <p>Cuando el líder castiga públicamente los errores honestos, la gente oculta las fallas, se paraliza la innovación y la empresa entra en decadencia silenciosa.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>El Micromanagement asfixiante:</strong> Querer revisar cada punto y coma del trabajo de profesionales senior (M4), destruyendo su motivación y creando cuellos de botella permanentes.</li>
        <li><strong>El 'Abandono por Delegación':</strong> Tirarle una tarea compleja a un novato (M1) sin acompañamiento ni capacitación y luego enojarse cuando comete un error elemental.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Diagnosticas el nivel de madurez técnica de cada miembro antes de asignarle tareas?</li>
            <li>¿Fomentas la seguridad psicológica admitiendo tus propios errores abiertamente ante tu equipo?</li>
            <li>¿Evitas el micromanagement con colaboradores que han demostrado competencia y confiabilidad?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Conversaciones Difíciles, Feedback y Coaching 1 a 1",
                            LessonTitle = "La Estructura de las Sesiones One-on-One y el Modelo GROW",
                            Summary = "Domina las reuniones individuales periódicas de 30 minutos que retienen al talento clave y utiliza el modelo GROW para desbloquear el potencial de tus colaboradores.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-chat-quote-fill fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Las Reuniones 1 a 1 Son la Herramienta Más Rentable del Liderazgo</h5>
            <p class=""mb-0 small"">Invertir 30 minutos quincenales en escuchar a cada colaborador a solas previene renuncias imprevistas, destapa bloqueos invisibles y alinea expectativas sin la presión del grupo.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/DKPb5U13xhA"" title=""El poder de las reuniones one to one | Liderazgo | César Piqueras"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-calendar-event text-primary me-2""></i>1. ¿Cómo se Estructura una Reunión One-on-One Exitosa?</h4>
    <p>Una sesión 1 a 1 (1:1) NO es una revisión del estado de las tareas del día; para eso están los tableros Kanban y las reuniones de seguimiento. Una 1:1 es el espacio del colaborador para hablar de desarrollo profesional, bienestar y relaciones internas:</p>
    <ul>
        <li><strong>Frecuencia y Sagrada Prioridad:</strong> Debe realizarse cada 1 o 2 semanas con una duración fija de 30 a 45 minutos. Cancelarla o posponerla constantemente envía el mensaje tácito de que el colaborador no es importante para el líder.</li>
        <li><strong>Distribución del Tiempo (Regla 10-10-10):</strong>
            <ul>
                <li><em>Primeros 10 minutos:</em> Tema del colaborador (sus inquietudes personales, proyectos, desafíos que enfrenta).</li>
                <li><em>Siguientes 10 minutos:</em> Tema del líder (alineación de prioridades, coaching y retroalimentación).</li>
                <li><em>Últimos 10 minutos:</em> Futuro y crecimiento profesional (planes de carrera, capacitaciones y compromisos mutuos de cara a la próxima reunión).</li>
            </ul>
        </li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-graph-up-arrow text-primary me-2""></i>2. El Modelo de Coaching GROW (Sir John Whitmore)</h4>
    <p>En lugar de darle la respuesta hecha al colaborador, el líder-coach hace preguntas poderosas para que el colaborador descubra la solución por sí mismo:</p>
    <ol>
        <li><strong>G - Goal (Meta):</strong> <em>'¿Qué resultado específico deseas alcanzar con este proyecto en las próximas 3 semanas?'</em></li>
        <li><strong>R - Reality (Realidad Actual):</strong> <em>'¿Cuál es la situación hoy? ¿Qué pasos has intentado y qué obstáculos has encontrado?'</em></li>
        <li><strong>O - Options (Opciones Viables):</strong> <em>'Si tuvieras recursos ilimitados, ¿qué harías? ¿Qué otras alternativas no hemos considerado todavía?'</em></li>
        <li><strong>W - Will / Way Forward (Compromiso de Acción):</strong> <em>'De todas estas opciones, ¿cuál ejecutarás primero? ¿Cuándo lo harás y cómo puedo apoyarte?'</em></li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Monopolizar la reunión 1 a 1 hablando solo el jefe:</strong> Si el líder habla más del 30% del tiempo durante la sesión, la reunión ha fracasado en su propósito de escucha activa.</li>
        <li><strong>No tomar notas de los compromisos asumidos:</strong> Llegar a la siguiente 1:1 sin acordarse de lo que se habló dos semanas atrás destruye la confianza y la continuidad.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Mantienes un espacio fijo e inamovible de reunión 1:1 con tus colaboradores directos?</li>
            <li>¿Utilizas preguntas reflexivas del modelo GROW antes de imponer tu criterio propio?</li>
            <li>¿Dedicas al menos un tercio de la conversación al plan de desarrollo y crecimiento personal?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Delegación Efectiva, Autonomía y Empoderamiento",
                            LessonTitle = "El Proceso de Delegación en 5 Pasos y los 7 Niveles de Delegación de Jurgen Appelo",
                            Summary = "Aprende a delegar resultados en lugar de métodos: cómo definir criterios de aceptación claros, evitar el retrabajo y liberar tiempo para el trabajo estratégico.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-share-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Si No Sabes Delegar, Te Convertirás en el Cuello de Botella de Tu Empresa</h5>
            <p class=""mb-0 small"">Muchos supervisores trabajan 14 horas al día agotados mientras sus colaboradores esperan de brazos cruzados porque 'nadie lo hace como yo'. Aprende a delegar con control y a formar líderes autónomos.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/SweH787f9bM"" title=""¿Cómo DELEGAR sin perder el control? El proceso en 5 pasos para soltar tareas"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-arrow-repeat text-primary me-2""></i>1. El Ciclo de Delegación en 5 Pasos</h4>
    <p>Delegar no es 'deshacerse de trabajo aburrido'; es un proceso pedagógico estructurado para transferir responsabilidad y poder de decisión:</p>
    <ul>
        <li><strong>Paso 1: Definir con Claridad el Resultado Esperado (El 'Qué' y 'Para Qué'):</strong> Explicar el objetivo final tangible y el impacto en el negocio, dejando libertad en el 'cómo' se ejecuta siempre que se respeten los estándares éticos y de calidad.</li>
        <li><strong>Paso 2: Asignar al Colaborador Adecuado:</strong> Evaluar las habilidades previas y la carga de trabajo actual de la persona seleccionada.</li>
        <li><strong>Paso 3: Otorgar los Recursos y la Autoridad Formal Necesaria:</strong> No puedes exigir resultados si no le das al colaborador acceso a los presupuestos, software, claves y el respaldo formal ante otros departamentos.</li>
        <li><strong>Paso 4: Establecer Hitos de Revisión Periódicos (Checkpoints):</strong> Fijar fechas intermedias de revisión para corregir desviaciones a tiempo sin caer en la asfixia del control diario.</li>
        <li><strong>Paso 5: Evaluación Final y Reconocimiento Público:</strong> Analizar las lecciones aprendidas y otorgar todo el crédito del éxito al colaborador que ejecutó la tarea.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-sliders text-primary me-2""></i>2. Los 7 Niveles de Delegación (Management 3.0)</h4>
    <p>Jurgen Appelo demostró que la delegación no es blanco o negro, sino un dial gradual de 7 niveles de empoderamiento:</p>
    <ol>
        <li><strong>1. Decir (Tell):</strong> El líder decide y comunica la decisión al equipo.</li>
        <li><strong>2. Vender (Sell):</strong> El líder decide, pero explica las razones para convencer al equipo.</li>
        <li><strong>3. Consultar (Consult):</strong> El líder pide opiniones antes de tomar la decisión final.</li>
        <li><strong>4. Acordar (Agree):</strong> Líder y equipo toman una decisión conjunta por consenso.</li>
        <li><strong>5. Aconsejar (Advise):</strong> El equipo decide, pero el líder da sugerencias si se las solicitan.</li>
        <li><strong>6. Preguntar (Inquire):</strong> El equipo decide de forma autónoma y luego informa al líder.</li>
        <li><strong>7. Delegar Plenamente (Delegate):</strong> El equipo tiene autonomía absoluta sin necesidad de reportar detalles.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Delegación Inversa (El Mono en la Espalda):</strong> Permitir que un colaborador te devuelva un problema diciendo <em>'Jefe, no sé cómo resolver esto, dígame usted qué hago'</em>. El líder debe responder: <em>'Analízalo y tráeme dos opciones viables con sus pros y contras a las 3:00 pm para revisarlas juntos'</em>.</li>
        <li><strong>Quitar la tarea ante la primera dificultad:</strong> Arrebatarle el trabajo al empleado diciendo <em>'Quítate que es más rápido si lo hago yo mismo'</em> destruye para siempre su iniciativa profesional.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Aclaras el nivel de autonomía concedido según los 7 niveles de Management 3.0?</li>
            <li>¿Rechazas la delegación inversa exigiendo propuestas de solución antes de responder?</li>
            <li>¿Fijas fechas intermedias de revisión para no enterarte de los desvíos el día de entrega?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Liderazgo en Tiempos de Crisis, Resiliencia y Gestión del Cambio",
                            LessonTitle = "La Curva del Cambio de Kübler-Ross y Comunicación Transparente en Incertidumbre",
                            Summary = "Aprende a guiar a tu equipo en momentos de reestructuración, crisis económicas y cambios tecnológicos imprevistos, gestionando el miedo y la resistencia al cambio.",
                            DurationMinutes = 50,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-shield-slash-fill fs-2 text-danger""></i>
        <div>
            <h5 class=""fw-bold mb-1"">En la Calma Cualquiera Puede Ser Capitán; en la Tempestad se Mide al Líder</h5>
            <p class=""mb-0 small"">En momentos de crisis o fusiones corporativas, el vacío de información es llenado de inmediato por el pánico, el rumor y la parálisis. Aprende a liderar con templanza, transparencia y claridad estratégica.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/3KBFyFD-TfI"" title=""Liderazgo Ágil en Tiempos de Crisis y Cambio"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-activity text-primary me-2""></i>1. La Curva Emocional del Cambio en las Organizaciones</h4>
    <p>Adaptada del modelo de la Dra. Elisabeth Kübler-Ross, todo cambio estructural o crisis despierta fases emocionales predecibles en los colaboradores:</p>
    <ul>
        <li><strong>Fase 1: Negación y Shock:</strong> <em>'Esto es solo una moda pasajera, no van a cambiar el sistema realmente'</em>. El líder debe comunicar la realidad objetiva con empatía pero con firmeza incontrovertible.</li>
        <li><strong>Fase 2: Resistencia y Enojo:</strong> <em>'¡Esto es injusto, el método anterior funcionaba mucho mejor!'</em>. El líder no debe combatir la frustración con autoritarismo; debe escuchar las preocupaciones legítimas y validar las emociones del equipo.</li>
        <li><strong>Fase 3: Exploración y Ensayo:</strong> El equipo comienza a probar las nuevas herramientas y a ver los primeros beneficios prácticos. Es el momento clave para brindar capacitaciones intensivas y reconocer los pequeños avances.</li>
        <li><strong>Fase 4: Compromiso e Integración:</strong> El nuevo proceso se convierte en la forma habitual y natural de trabajar, consolidando una cultura más resiliente.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-megaphone-fill text-primary me-2""></i>2. Protocolos de Comunicación en Tiempos de Crisis</h4>
    <p>Para frenar la desinformación interna durante situaciones de incertidumbre severa:</p>
    <ol>
        <li><strong>Sobrecumunicar con Frecuencia Fija:</strong> Si los líderes no informan a diario, los rumores de pasillo multiplicarán la ansiedad. Es mejor dar actualizaciones breves de 10 minutos cada mañana aunque no haya novedades definitivas que guardar silencio absoluto durante semanas.</li>
        <li><strong>Honestidad Radical (La Paradoja de Stockdale):</strong> Mantener la fe inquebrantable en que saldrán adelante como equipo, pero confrontando al mismo tiempo con crudeza los hechos más brutales de la realidad presente. Nunca prometer cosas que no se pueden garantizar.</li>
        <li><strong>Enfoque en lo Controlable:</strong> Ante una crisis macroeconómica o devaluación imprevista, reorientar el foco del equipo hacia lo que sí está en sus manos: <em>'No podemos controlar la inflación del país, pero sí podemos controlar la velocidad de atención al cliente y cuidar cada inventario para evitar mermas'</em>.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Encerrarse en la oficina gerencial a puerta cerrada:</strong> Desaparecer de la vista del personal durante una crisis genera la impresión de abandono o quiebra inminente.</li>
        <li><strong>Transmitir pánico y desesperación descontrolada:</strong> Si el líder entra gritando o mostrándose desbordado por el estrés, desmoraliza por completo a sus seguidores.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Mantienes presencia física o virtual visible y cercana durante momentos de turbulencia?</li>
            <li>¿Comunicas con regularidad y transparencia para erradicar rumores malintencionados?</li>
            <li>¿Enfocas la energía de tus colaboradores en las variables que sí pueden controlar?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"En el modelo de Liderazgo Situacional de Hersey y Blanchard, ¿qué estilo de liderazgo corresponde aplicar con un colaborador recién contratado que tiene mucho entusiasmo pero escasa competencia técnica (M1)?",
                            OptionA = @"Delegación total sin supervisión.",
                            OptionB = @"Estilo Directivo / Ordenar (E1), con instrucciones concretas paso a paso y seguimiento cercano.",
                            OptionC = @"Ignorarlo hasta que aprenda por sí solo.",
                            OptionD = @"Nombrarlo de inmediato gerente general.",
                            CorrectAnswer = "B",
                            Explanation = @"El colaborador novato pero motivado necesita dirección clara y parámetros técnicos precisos para aprender con seguridad."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es el propósito central de una reunión individual 'One-on-One' (1 a 1) entre un líder y su colaborador?",
                            OptionA = @"Revisar cada tarea minuciosa de la lista de pendientes del día.",
                            OptionB = @"Crear un espacio seguro centrado en el desarrollo profesional del empleado, su bienestar, motivación y eliminación de bloqueos en el trabajo.",
                            OptionC = @"Amonestar formalmente al colaborador por llegar tarde.",
                            OptionD = @"Hacerle firmar renuncias en blanco.",
                            CorrectAnswer = "B",
                            Explanation = @"Los One-on-Ones priorizan la escucha y el crecimiento del colaborador, fortaleciendo el vínculo de confianza con su líder."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué es el 'Micromanagement' y qué efecto negativo produce en los equipos?",
                            OptionA = @"La fabricación de microchips para computadoras.",
                            OptionB = @"El control excesivo y obsesivo de cada detalle y paso que da el empleado, destruyendo su autonomía, creatividad y motivación.",
                            OptionC = @"El pago puntual de los sueldos en quincena.",
                            OptionD = @"La entrega de reconocimientos públicos a los empleados destacados.",
                            CorrectAnswer = "B",
                            Explanation = @"El micromanagement transmite desconfianza y satura al líder con tareas menores, atrofiando la iniciativa del equipo."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la diferencia fundamental entre 'Delegar' y simplemente 'Desentenderse' (abdicar) de una tarea?",
                            OptionA = @"No hay diferencia, significan lo mismo.",
                            OptionB = @"Delegar define claramente el resultado esperado, otorga autonomía con criterios claros y establece fechas fijas de control y rendición de cuentas compartida.",
                            OptionC = @"Delegar es gratis y abdicar tiene costo bancario.",
                            OptionD = @"Delegar solo se puede hacer con parientes.",
                            CorrectAnswer = "B",
                            Explanation = @"Delegar mantiene la responsabilidad última en el líder y provee el marco y los recursos para que el colaborador tenga éxito."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué principio describe la 'Paradoja de Stockdale' aplicada al liderazgo en crisis?",
                            OptionA = @"Ignorar las malas noticias y fingir que todo es maravilloso.",
                            OptionB = @"Mantener una fe inquebrantable en el triunfo final y, al mismo tiempo, encarar con total honestidad los hechos más crudos de la realidad presente.",
                            OptionC = @"Abandonar el barco al primer signo de dificultad.",
                            OptionD = @"Culpar a la economía de todos los fracasos.",
                            CorrectAnswer = "B",
                            Explanation = @"Equilibra el realismo radical ante las dificultades con el optimismo firme en la capacidad del equipo para salir adelante."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué actitud debe asumir un líder cuando un colaborador autónomo y experimentado comete un error no intencional?",
                            OptionA = @"Humillarlo en público ante toda la empresa para que aprenda.",
                            OptionB = @"Analizar conjuntamente el fallo como una oportunidad de aprendizaje, identificando la causa raíz y medidas correctivas sin cacería de brujas.",
                            OptionC = @"Retirarle toda su autonomía para siempre.",
                            OptionD = @"Despedirlo de inmediato sin liquidación.",
                            CorrectAnswer = "B",
                            Explanation = @"Fomentar una cultura donde los errores honestos se conviertan en mejoras sistémicas consolida la seguridad psicológica del equipo."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué el estilo de 'Liderazgo Autoritario' (hacer las cosas únicamente porque yo lo mando) es insostenible en el mercado laboral contemporáneo?",
                            OptionA = @"Porque los empleados son más inteligentes que los jefes.",
                            OptionB = @"Porque genera fuga de talento cualificado, resentimiento, desmotivación profunda y cumplimiento mediocre por mero miedo.",
                            OptionC = @"Porque está prohibido por las normas ISO 9001.",
                            OptionD = @"Porque las computadoras no obedecen órdenes autoritarias.",
                            CorrectAnswer = "B",
                            Explanation = @"El talento actual exige propósito, autonomía y respeto; el autoritarismo anula el compromiso e incrementa la rotación de personal."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué pregunta abierta es ideal para que un líder solicite retroalimentación sobre su propia gestión en un One-on-One?",
                            OptionA = @"'¿Verdad que soy el mejor jefe que has tenido en tu vida?'",
                            OptionB = @"'¿Hay algo que yo esté haciendo que obstaculice tu trabajo o algo que te gustaría que hiciera de manera diferente para apoyarte mejor?'",
                            OptionC = @"'¿Por qué no trabajas más horas?'",
                            OptionD = @"'¿Qué chisme me tienes de tus compañeros?'",
                            CorrectAnswer = "B",
                            Explanation = @"Invitar genuinamente a la crítica constructiva modela la vulnerabilidad y abre la puerta a un crecimiento bidireccional."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"En la delegación por niveles, ¿qué caracteriza al nivel de 'Autonomía Completa'?",
                            OptionA = @"Que el colaborador renuncia a su contrato.",
                            OptionB = @"Que el colaborador tiene plena facultad para decidir y actuar según su criterio profesional, rindiendo cuentas solo de los resultados consolidados o contingencias mayores.",
                            OptionC = @"Que el líder tiene que firmar cada hoja de papel que se usa.",
                            OptionD = @"Que nadie sabe qué hace esa persona en la oficina.",
                            CorrectAnswer = "B",
                            Explanation = @"Se reserva para colaboradores de probada competencia y alineación de criterio con los objetivos estratégicos."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué un líder efectivo debe ser el primero en asumir la responsabilidad cuando su equipo falla frente a terceros o a la junta directiva?",
                            OptionA = @"Para recibir una multa económica.",
                            OptionB = @"Porque el liderazgo ético implica proteger al equipo hacia afuera y corregir con firmeza y pedagogía hacia adentro, ganando respeto y lealtad absoluta.",
                            OptionC = @"Para que lo despidan en lugar de sus compañeros.",
                            OptionD = @"Porque las leyes lo obligan por contrato notariado.",
                            CorrectAnswer = "B",
                            Explanation = @"Un líder que culpa a sus subordinados pierde el respeto al instante; asumir el escudo exterior forja una lealtad indestructible."
                        }
                    }                },
                // =========================================================================
                // 6. TÁCTICAS DE NEGOCIACIÓN EFECTIVA (MÉTODO HARVARD)
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "tacticas-de-negociacion-efectiva",
                    Title = "Tácticas de Negociación Efectiva: El Método Harvard y Acuerdos Ganar-Ganar",
                    CategorySlug = "habilidades-blandas-crecimiento",
                    ShortDescription = "Domina el modelo de negociación más prestigioso del mundo: intereses vs. posiciones, MAAN (BATNA), ZOPA, criterios objetivos y gestión de concesiones.",
                    FullDescription = "Capacitación práctica en el Proyecto de Negociación de Harvard (Fisher, Ury y Patton). Aprende a separar a las personas del problema, identificar los intereses reales ocultos detrás de posiciones inflexibles, calcular tu Mejor Alternativa a un Acuerdo Negociado (MAAN / BATNA), mapear la Zona de Posible Acuerdo (ZOPA) y neutralizar tácticas sucias de negociación.",
                    Level = "Intermedio",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Fundamentos de la Negociación: Modelo de Harvard y Enfoque Ganar-Ganar",
                            LessonTitle = "Los 4 Principios de la Negociación por Principios de Harvard",
                            Summary = "Supera la negociación posicional destructiva (regateo duro o blando) y aprende los 4 principios de Roger Fisher y William Ury para crear valor mutuo.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-handshake-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Negociar No es Vencer; es Construir un Acuerdo Sostenible y Rentable</h5>
            <p class=""mb-0 small"">En una negociación destructiva de regateo, una parte gana a costa de aplastar a la otra, generando resentimiento y acuerdos incumplidos. Conoce el método científico de Harvard para agrandar el pastel antes de repartirlo.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/3IzqALUN0Do"" title=""Curso 011 - Los 4 principios de la técnica Harvard de Negociación"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-award text-primary me-2""></i>1. Los 4 Pilares del Proyecto de Negociación de Harvard</h4>
    <p>Desarrollados en la Escuela de Leyes de Harvard por Roger Fisher y William Ury, revolucionaron la diplomacia internacional y los negocios corporativos:</p>
    <ul>
        <li><strong>1. Separar a las Personas del Problema:</strong> Ser suave con las personas pero extraordinariamente firme con el problema técnico o financiero. No atacar el honor ni el orgullo de la contraparte; construir una relación de confianza mutua mientras se resuelven las discrepancias objetivas de fondo.</li>
        <li><strong>2. Concentrarse en Intereses, No en Posiciones:</strong> La posición es lo que la persona dice explícitamente que quiere (<em>'No pagaré más de $500 por este servicio'</em>); el interés es la motivación oculta, el miedo o la necesidad real detrás de esa exigencia (<em>'Tengo un presupuesto trimestral cerrado y temo que el proyecto se atrase'</em>). Resolver el interés desbloquea la negociación.</li>
        <li><strong>3. Inventar Opciones de Mutuo Beneficio (Agrandar el Pastel):</strong> Antes de decidir, generar una lluvia de ideas creativa con múltiples variables (plazos de entrega, garantías extendidas, volúmenes futuros, formas de pago) donde ambas partes ganen.</li>
        <li><strong>4. Insistir en Criterios Objetivos e Independientes:</strong> No basar el acuerdo en el capricho o la terquedad de una de las partes, sino en estándares imparciales del mercado (precios de referencia de la industria, tasas de inflación del BCV, costos de reposición o dictámenes periciales).</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-pie-chart text-primary me-2""></i>2. La Parábola Clásica de la Naranja</h4>
    <p>Dos hermanas discuten agriamente por la única naranja que queda en la cocina. Ambas exigen la naranja entera (posiciones rígidas). Si un negociador inexperto interviene, cortará la naranja por la mitad (solución de regateo donde ambas pierden el 50%). Al preguntar a cada una para qué la necesita (intereses reales):</p>
    <div class=""card bg-light border-0 p-3 rounded-3 mb-3"">
        <p class=""mb-0 text-muted small"">Una hermana quería el jugo para beberlo; la otra hermana quería únicamente la cáscara para hornear un pastel de naranja. Al entender los intereses subyacentes, una hermana se quedó con el 100% del jugo y la otra con el 100% de la cáscara: ambas obtuvieron un resultado óptimo perfecto (Ganar-Ganar).</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Atrincherarse en una posición por ego personal:</strong> Negarse a firmar un acuerdo financieramente beneficioso simplemente por no 'dar el brazo a torcer' ante la otra persona.</li>
        <li><strong>Considerar la negociación como un juego de suma cero:</strong> Pensar erróneamente que cada dólar que el otro gana es un dólar que tú pierdes, impidiendo la creación de valor sinérgico.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Distingues con claridad los intereses de fondo detrás de las posiciones rígidas que te plantean?</li>
            <li>¿Sustentas tus ofertas comerciales en criterios objetivos y verificables de mercado?</li>
            <li>¿Propones opciones creativas que beneficien a ambas partes antes de cerrar la negociación?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Preparación Estratégica: MAAN (BATNA) y Zona de Posible Acuerdo (ZOPA)",
                            LessonTitle = "El Verdadero Poder en la Negociación: Tu Mejor Alternativa Fuera de la Mesa",
                            Summary = "Descubre por qué quien tiene la mejor alternativa fuera de la mesa tiene el poder negociador. Aprende a calcular tu BATNA y mapear la ZOPA financiera con precisión.",
                            DurationMinutes = 50,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-shield-shaded fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Tu Poder de Negociación Depende de Tu Habilidad para Decir 'No' y Levantarte de la Mesa</h5>
            <p class=""mb-0 small"">Nunca vayas a una negociación importante sin haber desarrollado previamente tu MAAN. Quien no tiene una alternativa sólida fuera de la mesa está condenado a aceptar condiciones desfavorables o abusivas.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/l5hpmrkIemQ"" title=""Tu ENEMIGO es tu MAYOR FUENTE DE PODER 💀🌩️🌪️"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-crosshair text-primary me-2""></i>1. El MAAN / BATNA (Best Alternative to a Negotiated Agreement)</h4>
    <p>El MAAN es el curso de acción concreto que ejecutarás si las negociaciones actuales fracasan por completo y no se llega a ningún acuerdo formal:</p>
    <ul>
        <li><strong>La Fuente Real del Poder:</strong> El poder en la mesa de negociación no depende de hablar fuerte ni de tener un título rimbombante; reside en la calidad de tu MAAN. Si vas a negociar un aumento de sueldo teniendo ya otra oferta de empleo firme por escrito con un 25% más de sueldo en otra empresa, tu MAAN es fortísimo y negociarás con absoluta serenidad. Si no tienes ahorros ni otra oferta, tu MAAN es débil y serás vulnerable.</li>
        <li><strong>Cómo Fortalecer tu MAAN antes de Negociar:</strong> Antes de sentarte con un proveedor exclusivo, cotiza con tres proveedores alternativos en el mercado, evalúa la posibilidad de fabricar el insumo internamente o contacta importadores internacionales.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-arrows-collapse text-primary me-2""></i>2. La ZOPA (Zona de Posible Acuerdo) y el Punto de Reserva</h4>
    <p>El Punto de Reserva (Walk-away Price) es el límite financiero absoluto más allá del cual prefieres levantarte e irte antes que firmar un mal negocio:</p>
    <div class=""card bg-light border-0 p-3 rounded-3 mb-3 text-center"">
        <p class=""mb-1 fw-bold text-primary"">Diagrama de la ZOPA Financiera:</p>
        <code class=""fs-6"">[Precio Mínimo de Venta del Vendedor] &lt;--- ZOPA (Rango de Acuerdo Viable) ---&gt; [Precio Máximo del Comprador]</code>
    </div>
    <p>Si el precio mínimo aceptable para el vendedor es $1.000 y el presupuesto máximo autorizado del comprador es $1.300, existe una <strong>ZOPA Positiva</strong> de $300 en la cual cualquier acuerdo intermedio generará valor para ambas partes. Si el comprador solo puede pagar $900, la ZOPA es negativa y no debe forzarse ningún acuerdo.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Revelar tu Punto de Reserva al inicio de la reunión:</strong> Decirle al vendedor <em>'Tengo exactamente $1.200 en el bolsillo'</em> elimina toda posibilidad de conseguir una mejor oferta en la negociación.</li>
        <li><strong>Sobreestimar un MAAN irreal o ficticio:</strong> Creer falsamente que tienes otra opción maravillosa sin haber verificado si el otro proveedor realmente tiene inventario disponible.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Tienes redactado y verificado tu MAAN antes de iniciar cualquier negociación clave?</li>
            <li>¿Calculas con anticipación tu punto de reserva numérico para no firmar acuerdos a pérdida?</li>
            <li>¿Estimas el rango de la ZOPA para saber si existe viabilidad económica real de acuerdo?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Tácticas de Negociación, Concesiones y Anclaje",
                            LessonTitle = "El Efecto Anclaje Cognitivo y la Regla Sagrada de las Concesiones Condicionales",
                            Summary = "Domina el sesgo de anclaje de Kahneman y Tversky para posicionar la primera oferta y aprende por qué nunca debes ceder nada sin pedir algo a cambio.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-anchor fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Una Concesión Gratuita No se Agradece; Solo Despierta Mayor Avaricia</h5>
            <p class=""mb-0 small"">Cuando cedes en precio sin exigir nada a cambio, la contraparte no piensa que eres bondadoso; piensa que tu precio inicial era un engaño y te exigirá más rebajas. Domina la gestión táctica de concesiones.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/0AoQBg-q4HQ"" title=""Por qué es importante conocer la ZOPA (Zona de Posible Acuerdo) ?"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-geo-alt-fill text-primary me-2""></i>1. El Efecto Anclaje Psicológico (Anchoring Bias)</h4>
    <p>Descubierto por los premios Nobel Daniel Kahneman y Amos Tversky: la primera cifra que se pone sobre la mesa actúa como un poderoso imán cognitivo que atrae y condiciona todas las contraofertas posteriores:</p>
    <ul>
        <li><strong>¿Cuándo conviene anclar primero?:</strong> Cuando posees información sólida sobre el valor de mercado y los costos. Al colocar una primera oferta ambiciosa pero fundamentada en criterios técnicos creíbles, obligas a la contraparte a negociar dentro de tu terreno.</li>
        <li><strong>¿Cómo neutralizar un ancla ajena agresiva?:</strong> Si la contraparte lanza un ancla absurda (ej: ofrecer un 70% menos de lo presupuestado), nunca hagas una contraoferta inmediata sobre esa cifra. Rechaza el ancla formalmente: <em>'Esa cifra está fuera de todo estándar de mercado y no podemos utilizarla como punto de partida. Hablemos de costos de reposición y tiempos de entrega'</em>.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-sliders2 text-primary me-2""></i>2. La Regla de Oro: La Concesión Condicional ('Si tú... entonces yo...')</h4>
    <p>Toda concesión otorgada en una negociación debe tener un costo explícito para la otra parte:</p>
    <div class=""card bg-light border-start border-primary border-4 p-3 mb-3"">
        <p class=""mb-1 fw-bold"">Estructura Lingüística Innegociable:</p>
        <p class=""mb-0 text-muted""><em>'Si tú estás dispuesto a aumentar el volumen de compra a 500 unidades y pagar de contado en 5 días, entonces yo puedo considerar un descuento del 6% en el precio unitario'</em>.</p>
    </div>
    <p>Al condicionar la rebaja a una contraprestación que beneficie a tu flujo de caja o a tu logística, proteges tu margen de rentabilidad y educas a la contraparte en que cada pedido que haga requerirá reciprocidad.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Hacer concesiones cada vez más grandes a medida que avanza el tiempo:</strong> Las concesiones deben ser decrecientes (ej: si primero cediste $100, la siguiente concesión debe ser de $30 y la última de $10). Si aumentas las concesiones, el rival sabe que todavía tienes mucho margen por entregar.</li>
        <li><strong>Negociar un solo tema a la vez (Negociación Lineal):</strong> Acordar primero el precio de forma aislada te deja desarmado para negociar plazos de entrega o garantías después. Todos los temas deben negociarse en paquetes integrados.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Aplicas la fórmula 'Si tú... entonces yo...' en absolutamente cada concesión?</li>
            <li>¿Planificas concesiones decrecientes para comunicar con claridad la cercanía de tu límite?</li>
            <li>¿Negocias paquetes multidimensionales en lugar de aislar el precio del resto de variables?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Neutralización de Tácticas Duras y Cierre de Acuerdos Sostenibles",
                            LessonTitle = "Manejo del 'Policía Bueno / Policía Malo', Ultimátums y Técnicas de Cierre",
                            Summary = "Aprende a desarticular tácticas sucias de negociación, gestionar la técnica del mordisqueo (Nibbling) y redactar acuerdos claros a prueba de litigios.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-file-earmark-check-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Mejor Cierre de Negociación es Aquel Donde Ambas Partes Duermen Tranquilas</h5>
            <p class=""mb-0 small"">Un acuerdo firmado bajo coacción, engaño o trampas psicológicas terminará en litigios legales o incumplimientos culposos. Conoce cómo desmontar tácticas agresivas y cerrar acuerdos sólidos y duraderos.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/o5tedjYHam8"" title=""Táctica sucia llamada concesiones infladas #negociar #negociación"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-shield-x text-primary me-2""></i>1. Neutralización de Tácticas Psicológicas Sucias</h4>
    <p>En el mundo empresarial te toparás con contrapartes que utilizan estrategias de manipulación deliberadas. La mejor forma de neutralizarlas es hacerlas explícitas con educación y serenidad:</p>
    <ul>
        <li><strong>El 'Policía Bueno / Policía Malo':</strong> Un negociador se muestra agresivo, exigente e intransigente, y luego sale de la sala, mientras su compañero se muestra amable y comprensivo diciendo: <em>'Mi jefe es durísimo, fírmame esto rápido antes de que vuelva'</em>. <strong>Cómo neutralizarlo:</strong> Dirígete al policía bueno y dile con una sonrisa: <em>'Agradezco tu amabilidad, pero reconozco la dinámica. Nosotros negociamos con el fondo del acuerdo y no con presiones emocionales; hablemos de los términos objetivos'</em>.</li>
        <li><strong>El 'Mordisqueo de Última Hora' (Nibbling):</strong> Cuando todo está acordado y los bolígrafos están sobre la mesa, la contraparte lanza: <em>'Ah, por cierto, supongo que el transporte y la instalación están incluidos sin costo adicional, ¿verdad?'</em>. <strong>Cómo neutralizarlo:</strong> No cedas por el apuro de cerrar; responde de inmediato: <em>'Con mucho gusto incluimos transporte e instalación; eso tiene un costo de $150 o podemos mantener el despacho en bodega como acordamos. ¿Cuál de las dos opciones prefieren?'</em>.</li>
        <li><strong>Falsos Ultimátums ('Lo toma o lo deja'):</strong> Responder con calma: <em>'Entiendo que esa es su posición actual. Si esas son las únicas condiciones posibles, lamentablemente no tenemos un acuerdo. Sigamos en contacto para futuros proyectos'</em>. Con frecuencia, el ultimátum es un farol que se desvanece al demostrar que no temes levantarte.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-pen text-primary me-2""></i>2. La Redacción y Blindaje del Memorándum de Entendimiento (MoU)</h4>
    <p>Las palabras se las lleva el viento; el cierre formal requiere un documento escrito que sintetice con precisión milimétrica los compromisos mutuos:</p>
    <ol>
        <li><strong>Resumen Escrito Inmediato:</strong> Al terminar la reunión, enviar un correo formal: <em>'Para consolidar lo conversado hoy y asegurar que todos estemos alineados, adjunto el resumen de los puntos acordados...'</em>.</li>
        <li><strong>Cláusulas de Escalabilidad y Fuerza Mayor:</strong> Prever contingencias como fluctuaciones cambiarias severas, escasez de materias primas o fallas energéticas con fórmulas de ajuste automáticas.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Dejar cabos sueltos 'de palabra':</strong> Acordar temas críticos de manera verbal por amistad o pena de parecer desconfiado. Si no está en el contrato, no existe.</li>
        <li><strong>Celebrar la victoria humillando a la otra parte:</strong> Salir de la reunión diciendo abiertamente que 'les sacaste hasta el último centavo' genera rencor y sabotajes operativos durante la ejecución del contrato.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Neutralizas tácticas sucias señalando la técnica con serenidad y sin perder los estribos?</li>
            <li>¿Cobras las solicitudes adicionales de última hora impidiendo el efecto mordisqueo?</li>
            <li>¿Envías una minuta escrita de compromisos inmediatamente al finalizar la sesión?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"En el Método de Negociación de Harvard, ¿cuál es la diferencia fundamental entre una 'Posición' y un 'Interés'?",
                            OptionA = @"La posición es secreta y el interés es público.",
                            OptionB = @"La Posición es la demanda explícita y concreta que una parte exige ('Quiero un 20% de aumento'), mientras que el Interés es la necesidad profunda subyacente que motiva esa exigencia ('Necesito cubrir el alza de costos familiares').",
                            OptionC = @"Son conceptos idénticos que se usan de forma indistinta.",
                            OptionD = @"La posición solo la tiene el comprador y el interés solo el vendedor.",
                            CorrectAnswer = "B",
                            Explanation = @"Explorar los intereses reales permite encontrar soluciones creativas que satisfagan a ambas partes más allá de posturas inflexibles."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué significan las siglas MAAN (o BATNA en inglés) en una negociación?",
                            OptionA = @"Margen Anual de Activos Netos.",
                            OptionB = @"Mejor Alternativa a un Acuerdo Negociado (Best Alternative to a Negotiated Agreement).",
                            OptionC = @"Matriz de Asignación de Nombres.",
                            OptionD = @"Monto Acordado Antes de Negociar.",
                            CorrectAnswer = "B",
                            Explanation = @"El MAAN es el plan B o curso de acción alternativo que ejecutarás si la negociación actual fracasa sin acuerdo."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué contar con un MAAN (BATNA) sólido otorga gran poder al negociador?",
                            OptionA = @"Porque le permite gritar más fuerte en la reunión.",
                            OptionB = @"Porque le da la libertad y tranquilidad de levantarse de la mesa y rechazar un mal acuerdo si la oferta recibida es inferior a su alternativa externa.",
                            OptionC = @"Porque el banco aprueba préstamos gratis a quienes tienen un MAAN.",
                            OptionD = @"Porque elimina la necesidad de hablar con la contraparte.",
                            CorrectAnswer = "B",
                            Explanation = @"Tener una alternativa atractiva evita negociar desde la desesperación o aceptar condiciones ruinosas."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué es la ZOPA (Zona de Posible Acuerdo)?",
                            OptionA = @"El salón donde se reúnen los diplomáticos de la ONU.",
                            OptionB = @"El rango superpuesto entre el precio de reserva máximo del comprador y el precio de reserva mínimo del vendedor donde un acuerdo es mutuamente ventajoso.",
                            OptionC = @"La distancia física de dos metros entre negociadores.",
                            OptionD = @"Un tipo de contrato de arrendamiento comercial.",
                            CorrectAnswer = "B",
                            Explanation = @"Si existe ZOPA positiva, existe un espacio financiero o de valor donde ambas partes quedan mejor que acudiendo a sus alternativas."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué establece el principio de Harvard de 'Separar a las personas del problema'?",
                            OptionA = @"Despedir a todas las personas antes de empezar a negociar.",
                            OptionB = @"Tratar a los interlocutores con absoluto respeto humano y empatía, mientras se abordan los asuntos técnicos y sustantivos con rigor y firmeza.",
                            OptionC = @"Insultar al rival para intimidarlo desde el inicio.",
                            OptionD = @"Negociar únicamente por correo sin ver caras nunca.",
                            CorrectAnswer = "B",
                            Explanation = @"Ser suave con las personas y duro con el problema evita que los roces de ego o susceptibilidades arruinen una solución mutuamente beneficiosa."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué es un error grave en negociación conceder un descuento o rebaja unilateral sin pedir nada a cambio?",
                            OptionA = @"Porque las leyes tributarias lo sancionan con multas.",
                            OptionB = @"Porque la contraparte asume que la concesión no tenía costo real para ti y que tus precios estaban inflados, motivándola a exigir mayores descuentos.",
                            OptionC = @"Porque la calculadora se desconfigura.",
                            OptionD = @"Porque el banco rechaza la factura.",
                            CorrectAnswer = "B",
                            Explanation = @"Toda concesión debe ser condicionada ('Si tú aceptas X, yo puedo otorgar Y') para preservar el valor de la oferta."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué es el 'Efecto de Anclaje' en una conversación de negociación de precios?",
                            OptionA = @"El peso del contrato en gramos de papel.",
                            OptionB = @"El sesgo cognitivo por el cual la primera cifra propuesta en la mesa sirve como punto de referencia psicológico alrededor del cual gravitarán las ofertas posteriores.",
                            OptionC = @"El ancla de los barcos de carga en aduana.",
                            OptionD = @"La firma manuscrita de un testigo legal.",
                            CorrectAnswer = "B",
                            Explanation = @"La primera oferta fijada con argumentos sólidos ejerce un tirón magnético sobre el rango de contraofertas posibles."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué táctica psicológica se está empleando cuando un negociador se muestra excesivamente agresivo e inflexible mientras su colega interviene fingiendo ser conciliador y amigable?",
                            OptionA = @"La táctica del Salchichón.",
                            OptionB = @"La táctica del Policía Bueno / Policía Malo (Good Cop / Bad Cop).",
                            OptionC = @"La táctica del Anclaje Neutro.",
                            OptionD = @"El método de Ishikawa.",
                            CorrectAnswer = "B",
                            Explanation = @"Busca que la víctima ceda ante el 'policía bueno' por alivio de escapar a la hostilidad del 'policía malo'."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cómo se neutraliza eficazmente una táctica de presión del tipo 'Tómalo o déjalo ahora mismo'?",
                            OptionA = @"Aceptando de inmediato con lágrimas en los ojos.",
                            OptionB = @"Manteniendo la compostura, ignorando el dramatismo del ultimátum y enfocando la conversación en los criterios objetivos de mercado o solicitando un receso para evaluar.",
                            OptionC = @"Golpeando la mesa con un puño.",
                            OptionD = @"Firmando el contrato con un seudónimo.",
                            CorrectAnswer = "B",
                            Explanation = @"Nombrar la táctica o solicitar una pausa estratégica desarma la presión psicológica del ultimátum."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es el rol de los 'Criterios Objetivos' en el método Harvard?",
                            OptionA = @"Determinar quién tiene el auto más moderno en la reunión.",
                            OptionB = @"Apoyar los acuerdos en estándares independientes, profesionales y legales (precios de mercado, peritajes, índices de inflación) en lugar de voluntades caprichosas.",
                            OptionC = @"Garantizar que nadie pueda hablar durante la negociación.",
                            OptionD = @"Redactar contratos en idiomas antiguos.",
                            CorrectAnswer = "B",
                            Explanation = @"Los criterios externos objetivos protegen la legitimidad del acuerdo y evitan que la negociación se degrade a una guerra de voluntades de poder."
                        }
                    }                },
                // =========================================================================
                // 7. GESTIÓN DEL TIEMPO Y PRODUCTIVIDAD
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "gestion-del-tiempo",
                    Title = "Gestión del Tiempo y Productividad: Eisenhower, Pomodoro y Trabajo Profundo",
                    CategorySlug = "habilidades-blandas-crecimiento",
                    ShortDescription = "Domina tu jornada laboral: Matriz de Eisenhower (Urgente vs Importante), técnica Pomodoro, Timeblocking en calendario y Trabajo Profundo (Deep Work).",
                    FullDescription = "Capacitación de alto impacto orientada a profesionales que sufren de dispersión, saturación por correos y sensación de apagar fuegos todo el día. Aprende a clasificar tareas con la Matriz de Eisenhower, implementar bloques de tiempo ininterrumpidos en Google Calendar / Outlook, aplicar la técnica Pomodoro para sesiones de hiperenfoque y gestionar las distracciones digitales de Slack y WhatsApp.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Diagnóstico del Tiempo y la Matriz de Eisenhower",
                            LessonTitle = "La Distinción Crítica entre Urgencia e Importancia en el Trabajo Diario",
                            Summary = "Descubre cómo escapar del cuadrante de las crisis continuas y aprende a priorizar las actividades estratégicas que realmente mueven la aguja del negocio.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-primary border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-grid-1x2-fill fs-2 text-primary""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Lo Urgente Raras Veces es Importante; lo Importante Raras Veces es Urgente</h5>
            <p class=""mb-0 small"">El presidente Dwight D. Eisenhower estructuró uno de los modelos de toma de decisiones más eficaces de la historia. Aprende a distinguir lo que exige atención inmediata de lo que genera impacto estratégico real.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/LHtUrHUPs4E"" title=""LA MATRIZ DE EISENHOWER. PRODUCTIVIDAD Y GESTIÓN DE TIEMPO - RESUMEN ANIMADO"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-diagram-3-fill text-primary me-2""></i>1. Los 4 Cuadrantes de la Matriz de Eisenhower</h4>
    <p>La mayoría de los profesionales pasan el día agotados porque reaccionan a las demandas ajenas en lugar de gobernar su tiempo con base en prioridades reales:</p>
    <ul>
        <li><strong>Cuadrante 1: Urgente e Importante (El Cuadrante del Estrés y las Crisis):</strong> Vencimientos inaplazables de impuestos, caídas de servidores centrales, accidentes laborales o quejas de clientes VIP a punto de rescindir contratos. <strong>Acción: HACER DE INMEDIATO</strong>. Debe mantenerse bajo control para no vivir en burnout constante.</li>
        <li><strong>Cuadrante 2: No Urgente pero Importante (El Cuadrante de la Grandeza y el Liderazgo):</strong> Planificación estratégica, capacitación continua, prevención de fallas mecánicas, creación de relaciones profesionales y diseño de procesos automatizados. Como no tiene una alarma que suene hoy, la gente suele posponerlo semanas o meses. <strong>Acción: PLANIFICAR Y AGENDAR BLOQUES INNEGOCIABLES</strong>. Aquí es donde se construye el éxito profesional a largo plazo.</li>
        <li><strong>Cuadrante 3: Urgente pero No Importante (El Cuadrante del Engaño):</strong> La mayoría de las llamadas telefónicas no programadas, notificaciones de chats grupales de trabajo y solicitudes de favores de última hora de otros departamentos que no aportan a tus metas clave. <strong>Acción: DELEGAR O AUTOMATIZAR</strong>.</li>
        <li><strong>Cuadrante 4: Ni Urgente Ni Importante (El Cuadrante del Desperdicio):</strong> Navegación ociosa en redes sociales durante horas laborales, reuniones interminables sin orden del día o cotilleos de pasillo. <strong>Acción: ELIMINAR SIN CULPA</strong>.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-hourglass-split text-primary me-2""></i>2. Ley de Parkinson y Ley de Carlson</h4>
    <p>Dos principios fundamentales de la psicología del trabajo que debes dominar:</p>
    <ol>
        <li><strong>Ley de Parkinson:</strong> <em>'El trabajo se expande hasta llenar todo el tiempo disponible para su realización'</em>. Si te das 3 semanas para redactar un informe que toma 4 horas, tardarás 3 semanas completas llenas de procrastinación. Ponte plazos artificiales cortos y exigentes (Timeboxing) para forzar el enfoque ejecutivo.</li>
        <li><strong>Ley de Carlson:</strong> <em>'Todo trabajo interrumpido es menos eficaz y toma mucho más tiempo que si se realiza de forma continua'</em>. Cada vez que atiendes una interrupción de 2 minutos, tu cerebro tarda entre 15 y 23 minutos en recuperar la concentración profunda previa.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Vivir atrapado en el Cuadrante 3 confundiéndolo con trabajo productivo:</strong> Responder 80 correos intrascendentes al día y terminar la jornada con la frustrante sensación de que no avanzaste en nada verdaderamente importante.</li>
        <li><strong>No programar tiempo para el Cuadrante 2:</strong> Dejar la planificación estratégica para 'cuando tenga un tiempito libre'. El tiempo libre nunca llegará si no lo bloqueas activamente en tu agenda.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Clasificas tu lista diaria de pendientes según los 4 cuadrantes de Eisenhower?</li>
            <li>¿Dedicas al menos 90 minutos diarios al Cuadrante 2 (planificación y mejora de procesos)?</li>
            <li>¿Fijas plazos de entrega ajustados utilizando la Ley de Parkinson a tu favor?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Planificación Semanal, Bloques de Tiempo (Timeboxing) y Calendarios",
                            LessonTitle = "Dominio de Google Calendar y Outlook: Cómo Blindar tu Día de Interrupciones",
                            Summary = "Aprende el método Timeblocking utilizado por Elon Musk y Bill Gates: agendar resultados en bloques cerrados de calendario en lugar de listas infinitas de tareas pendientes.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-info border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-calendar3 fs-2 text-info""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Si No Está en Tu Calendario, No Existe en Tu Vida Profesional</h5>
            <p class=""mb-0 small"">Las listas tradicionales de pendientes (To-Do Lists) generan ansiedad porque no tienen noción de tiempo real. Aprende la metodología de Bloques de Tiempo (Timeboxing) para recuperar el control de tu agenda.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/AraCTiT9_64"" title=""La mejor técnica para organizar tu día de alta productividad (Bloques de tiempo)"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-calendar-check text-primary me-2""></i>1. ¿Por Qué las To-Do Lists Tradicionales Fracasan?</h4>
    <p>Tener un papel o una nota con 25 tareas pendientes tiene tres graves defectos estructurales:</p>
    <ul>
        <li><strong>Falta de Estimación Temporal:</strong> No indica cuánto tiempo toma cada tarea ni en qué momento específico del día se ejecutará.</li>
        <li><strong>Efecto Zeigarnik Negativo:</strong> El cerebro se siente abrumado por la cantidad de pendientes abiertos y tiende a escoger las tareas más fáciles e irrelevantes para tacharlas rápido y tener una falsa sensación de logro.</li>
        <li><strong>Vulnerabilidad a Interrupciones:</strong> Si tu calendario está vacío, tus compañeros y jefes verán espacio libre y te programarán reuniones innecesarias durante todo el día.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-clock text-primary me-2""></i>2. La Metodología Timeboxing Paso a Paso</h4>
    <p>El Timeboxing consiste en asignar un bloque de tiempo cerrado en tu calendario digital (Google Calendar u Outlook) a una sola actividad prioritaria:</p>
    <ol>
        <li><strong>La Sesión de Planificación Dominical o de Lunes a Primera Hora (30 min):</strong> Antes de revisar correos, analiza tus metas semanales clave y bloquea los espacios de tiempo necesarios para tus entregables críticos.</li>
        <li><strong>Bloques Temáticos (Day Theming & Task Batching):</strong> Agrupa tareas similares para ejecutarlas en un solo tirón y evitar el costo de cambio cognitivo. Por ejemplo: <em>'Lunes de 2:00 pm a 3:30 pm: Pago a Proveedores y Facturación'</em>; <em>'Todos los días de 11:30 am a 12:00 pm y de 4:30 pm a 5:00 pm: Revisión y Respuesta de Correos'</em>. Fuera de esos horarios, la bandeja de entrada permanece cerrada.</li>
        <li><strong>Margen de Amortiguamiento (Buffer Blocks):</strong> Deja un bloque de 45 a 60 minutos al final de la tarde vacío para absorber imprevistos y urgencias reales sin que se descuadre el resto de tu semana.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Sobrecargar el calendario al 100% sin margen:</strong> Programar tareas espalda con espalda sin dejar ni 5 minutos entre reuniones genera estrés severo y atrasos en cascada.</li>
        <li><strong>Mantener las notificaciones del correo abiertas todo el día:</strong> El clásico 'pop-up' que avisa la llegada de un nuevo correo interrumpe el flujo cognitivo y destruye la concentración en tareas complejas.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Planificas tu semana con bloques de tiempo en calendario antes de abrir el correo el lunes?</li>
            <li>¿Agrupas tareas administrativas rutinarias en bloques de procesamiento por lotes (Batching)?</li>
            <li>¿Resguardas al menos un bloque diario libre de reuniones para trabajo de concentración?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Enfoque, Técnica Pomodoro y Eliminación de Ladrones de Tiempo",
                            LessonTitle = "La Técnica Pomodoro Clásica y el Combate Contra las Interrupciones",
                            Summary = "Domina los ciclos de concentración de 25 minutos de Francesco Cirillo: cómo estructurar intervalos de descanso activo y gestionar el inventario de distracciones internas y externas.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-stopwatch-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Trabaja con el Tiempo, No Contra el Tiempo</h5>
            <p class=""mb-0 small"">Francesco Cirillo inventó la Técnica Pomodoro en la universidad usando un reloj de cocina con forma de tomate. Conoce la ciencia neurológica de los ciclos de hiperfoco y pausas de recarga mental.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/3D0-l2O5k8Y"" title=""Técnica poderosa de productividad! - Técnica Pomodoro - animado"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-clock-history text-primary me-2""></i>1. El Ciclo Pomodoro Estándar</h4>
    <p>El cerebro humano no está diseñado para mantener una atención sostenida de alta intensidad durante 8 horas continuas. La técnica Pomodoro optimiza los ritmos ultradianos:</p>
    <ul>
        <li><strong>Paso 1: Seleccionar una Sola Tarea:</strong> Definir con total precisión qué entregable se completará durante el bloque (ej: redactar la sección 3 del informe).</li>
        <li><strong>Paso 2: Ajustar el Temporizador a 25 Minutos:</strong> Durante estos 25 minutos rige una regla inquebrantable: <em>Cero distracciones</em>. No se revisa el teléfono, no se abren pestañas secundarias y no se responden dudas que no sean de vida o muerte.</li>
        <li><strong>Paso 3: Descanso Corto de 5 Minutos:</strong> Al sonar la campana, levantarse obligatoriamente de la silla. Caminar, tomar un vaso de agua, estirar la espalda o mirar por la ventana. <em>(¡Atención!: No revisar el teléfono ni redes sociales, ya que el cerebro no descansa si se le bombardea con nuevos estímulos visuales)</em>.</li>
        <li><strong>Paso 4: Repetir el Ciclo y Descanso Largo:</strong> Al completar cuatro pomodoros (100 minutos de trabajo neto), tomar una pausa prolongada de 20 a 30 minutos para almorzar o despejar la mente por completo.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-clipboard-x text-primary me-2""></i>2. La Hoja de Distracciones y el Manejo de Interrupciones</h4>
    <p>Durante un Pomodoro es natural que el cerebro intente sabotear la concentración con ideas repentinas (<em>'Tengo que comprar pan', '¿Habrá respondido el cliente al correo?'</em>):</p>
    <div class=""card bg-light border-0 p-3 rounded-3 mb-3"">
        <p class=""mb-0 text-muted small""><strong>La Hoja de Descarga Mental:</strong> Ten una libreta en blanco al lado de tu teclado. Cada vez que te asalte un pensamiento parásito, anótalo en una línea en 3 segundos y regresa de inmediato al Pomodoro. Al terminar los 25 minutos, podrás revisar tu lista de descargas y atender lo que sea necesario.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Saltarse los descansos de 5 minutos:</strong> Creer que trabajar 4 horas de corrido sin pausas es más productivo. A partir del minuto 60 la tasa de fatiga mental se dispara y la velocidad de procesamiento cae en picada.</li>
        <li><strong>Usar el descanso para mirar TikTok o Instagram:</strong> Los videos cortos inundan el cerebro de dopamina barata, haciendo que volver al trabajo concentrado sea diez veces más difícil y pesado.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Respetas los 25 minutos de enfoque absoluto sin tocar el teléfono móvil?</li>
            <li>¿Te levantas de la silla y descansas la vista de las pantallas en los 5 minutos de pausa?</li>
            <li>¿Anotas pensamientos parásitos en una libreta de descarga sin romper tu ciclo de concentración?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Trabajo Profundo (Deep Work) y Gestión de la Sobrecarga Digital",
                            LessonTitle = "El Modelo de Cal Newport: El Superpoder del Siglo XXI en la Economía del Conocimiento",
                            Summary = "Descubre por qué la habilidad de concentrarse profundamente sin distracciones en tareas cognitivamente exigentes es la ventaja profesional más escasa y valiosa del mercado.",
                            DurationMinutes = 50,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-success border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-lightning-charge-fill fs-2 text-success""></i>
        <div>
            <h5 class=""fw-bold mb-1"">El Trabajo Profundo es Escaso, Valioso y Altamente Recompensado</h5>
            <p class=""mb-0 small"">El profesor Cal Newport demostró que los profesionales que dominan el Deep Work producen en 4 horas lo que un trabajador disperso no logra en dos semanas completas. Aprende a construir tu fortaleza de concentración.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/CZURxyoeEXg"" title=""Mejorá tu productividad 🤯 | Deep Work (Céntrate) de Cal Newport"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-layers-fill text-primary me-2""></i>1. Trabajo Profundo (Deep Work) vs Trabajo Superficial (Shallow Work)</h4>
    <p>En el libro 'Deep Work', Cal Newport clasifica las actividades laborales en dos universos radicalmente distintos:</p>
    <ul>
        <li><strong>Trabajo Profundo (Deep Work):</strong> Actividades profesionales realizadas en un estado de concentración desprovisto de distracciones que empujan tus capacidades cognitivas al límite. Estas actividades crean valor nuevo y único, mejoran tus habilidades técnicas y son prácticamente imposibles de replicar por inteligencia artificial o mano de obra barata (ej: escribir código complejo, diseñar un modelo financiero en Excel, redactar una propuesta estratégica o aprender un nuevo software empresarial).</li>
        <li><strong>Trabajo Superficial (Shallow Work):</strong> Tareas de tipo logístico o administrativo que no requieren gran esfuerzo intelectual y que a menudo se realizan mientras se está distraído (responder correos rutinarios, asistir a reuniones informativas, archivar facturas o actualizar estados en Slack). Son tareas necesarias para que la oficina funcione, pero no generan una ventaja competitiva duradera ni ascensos de carrera.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-shield-lock text-primary me-2""></i>2. Las 4 Filosofías de Programación del Trabajo Profundo</h4>
    <p>Para integrar bloques de Deep Work en tu realidad profesional cotidiana:</p>
    <ol>
        <li><strong>Filosofía Monástica:</strong> Eliminar de raíz todo trabajo superficial y aislarse del mundo durante semanas (viable solo para autores, investigadores o científicos de élite).</li>
        <li><strong>Filosofía Bimodal:</strong> Dividir el tiempo en dos partes claras: por ejemplo, dedicar lunes y martes a reuniones y trámites administrativos, y miércoles, jueves y viernes exclusivamente a desarrollo técnico a puerta cerrada.</li>
        <li><strong>Filosofía Rítmica (La Más Recomendada para Oficinas):</strong> Fijar un horario inamovible todos los días laborales (ej: de 8:00 am a 10:30 am antes de que la oficina empiece a bullir) dedicado únicamente a tu entregable más difícil, con teléfono apagado y sin correos.</li>
        <li><strong>Filosofía Periodística:</strong> Entrar en modo Deep Work de inmediato en cualquier hueco libre imprevisto del día (requiere un entrenamiento mental muy avanzado).</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>El 'Síndrome de la Hiperconectividad':</strong> Creer que un buen profesional es aquel que responde mensajes de Teams o Slack en menos de 30 segundos a cualquier hora del día y la noche. Esta cultura destruye la capacidad cognitiva de concentración profunda del personal.</li>
        <li><strong>El Residuo de Atención (Attention Residue):</strong> La investigadora Sophie Leroy demostró que al cambiar de una tarea A a una tarea B, una parte sustancial de tu energía cognitiva se queda 'pegada' en la tarea anterior, provocando lentitud y torpeza mental durante los siguientes 20 minutos.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Resguardas al menos 2 horas diarias de trabajo profundo rítmico libre de interrupciones?</li>
            <li>¿Distingues con claridad qué porcentaje de tu jornada dedicas a tareas superficiales vs profundas?</li>
            <li>¿Cierras aplicaciones de mensajería instantánea durante tus bloques de análisis técnico exigente?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"En la Matriz de Eisenhower, ¿qué acción corresponde a las tareas ubicadas en el Cuadrante 2 (Importantes pero NO Urgentes)?",
                            OptionA = @"Eliminarlas inmediatamente de la memoria.",
                            OptionB = @"Programar bloques de tiempo específicos en el calendario para ejecutarlas con enfoque y anticipación.",
                            OptionC = @"Hacerlas corriendo cuando ya se convirtieron en emergencias críticas.",
                            OptionD = @"Delegárselas al empleado más nuevo.",
                            CorrectAnswer = "B",
                            Explanation = @"El Cuadrante 2 agrupa la planificación, la prevención y la estrategia; si no se programan proactivamente, terminan devoradas por las urgencias del día a día."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la duración clásica de una sesión de trabajo de hiperenfoque en la Técnica Pomodoro tradicional?",
                            OptionA = @"10 minutos.",
                            OptionB = @"25 minutos de trabajo ininterrumpido seguidos de 5 minutos de descanso.",
                            OptionC = @"4 horas seguidas sin parpadear.",
                            OptionD = @"60 segundos.",
                            CorrectAnswer = "B",
                            Explanation = @"La técnica Pomodoro utiliza bloques de 25 minutos para maximizar la concentración sostenida sin provocar agotamiento mental."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué establece la famosa 'Ley de Parkinson' en la gestión de tareas?",
                            OptionA = @"Que los empleados siempre tiemblan al ver al jefe.",
                            OptionB = @"Que el trabajo se expande hasta llenar todo el tiempo asignado o disponible para su culminación.",
                            OptionC = @"Que las máquinas de café fallan los lunes.",
                            OptionD = @"Que el tiempo no existe en el cerebro humano.",
                            CorrectAnswer = "B",
                            Explanation = @"Si te das dos semanas para hacer un informe que toma dos horas, el informe tardará dos semanas en completarse."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿En qué consiste la técnica de productividad de 'Timeblocking' (bloques de tiempo)?",
                            OptionA = @"En no mirar el reloj en todo el día.",
                            OptionB = @"En reservar bloques específicos de tiempo en el calendario para dedicarse de forma exclusiva a una tarea o proyecto concreto.",
                            OptionC = @"En apagar las luces de la oficina a las 5:00 pm.",
                            OptionD = @"En bloquear a los compañeros de trabajo en WhatsApp.",
                            CorrectAnswer = "B",
                            Explanation = @"Timeblocking asigna un espacio físico y mental en el calendario, protegiendo las horas clave contra interrupciones espontáneas."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué fenómeno cognitivo perjudicial ocurre cuando una persona salta constantemente entre múltiples tareas (multitarea)?",
                            OptionA = @"Aumento del coeficiente intelectual en un 50%.",
                            OptionB = @"Residuo de atención (Attention Residue): parte de la capacidad mental queda anclada en la tarea anterior, reduciendo la lucidez y duplicando los errores.",
                            OptionC = @"Mejora de la vista a larga distancia.",
                            OptionD = @"Desaparición total del estrés laboral.",
                            CorrectAnswer = "B",
                            Explanation = @"El cambio constante de contexto fatiga el cerebro y deja un 'residuo cognitivo' que degrada la velocidad y precisión mental."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿En qué consiste la técnica de 'Batching' (procesamiento por lotes) aplicada a los correos electrónicos?",
                            OptionA = @"Borrar todos los correos sin leerlos.",
                            OptionB = @"Agrupar la revisión y respuesta de correos en momentos o ventanas horarias específicas y fijas del día en lugar de responder a cada notificación en tiempo real.",
                            OptionC = @"Enviar el mismo correo a 1000 personas por error.",
                            OptionD = @"Imprimir todos los correos en papel bond.",
                            CorrectAnswer = "B",
                            Explanation = @"Procesar en lotes reduce las interrupciones recurrentes y optimiza la concentración para tareas de mayor valor."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"Según Cal Newport en su libro 'Deep Work', ¿qué es el 'Trabajo Superficial' (Shallow Work)?",
                            OptionA = @"Cavar zanjas poco profundas en construcción.",
                            OptionB = @"Tareas logísticas o administrativas de bajo esfuerzo cognitivo (responder mensajes breves, clasificar archivos) que no crean valor duradero ni son difíciles de replicar.",
                            OptionC = @"Trabajar únicamente 2 horas a la semana.",
                            OptionD = @"El trabajo que se realiza en el agua.",
                            CorrectAnswer = "B",
                            Explanation = @"El trabajo superficial es necesario pero no genera ventaja competitiva ni innovación significativa."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál de las siguientes actividades pertenece típicamente al Cuadrante 4 de Eisenhower (Ni urgente ni importante)?",
                            OptionA = @"Una fuga de agua que inunda el almacén principal.",
                            OptionB = @"La preparación de una propuesta comercial para el cliente más grande del año.",
                            OptionC = @"Navegar de manera compulsiva y pasiva por redes sociales o ver vídeos intrascendentes durante horas laborales.",
                            OptionD = @"El pago obligatorio de los impuestos de la empresa antes de las 12:00 pm.",
                            CorrectAnswer = "C",
                            Explanation = @"El Cuadrante 4 constituye puro desperdicio de tiempo que debe ser eliminado para recuperar energía productiva."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué se recomienda hacer durante el descanso de 5 minutos entre bloques de Pomodoro para que sea realmente restaurativo?",
                            OptionA = @"Revisar inmediatamente las noticias de crisis o discutir en Twitter.",
                            OptionB = @"Levantarse de la silla, estirar el cuerpo, hidratarse, caminar unos pasos o descansar la vista lejos de cualquier pantalla.",
                            OptionC = @"Jugar un videojuego de alta intensidad.",
                            OptionD = @"Comenzar a escribir otro informe urgente.",
                            CorrectAnswer = "B",
                            Explanation = @"Desconectar la mirada de pantallas y mover el cuerpo alivia la fatiga ocular y recarga la atención voluntaria."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué la habilidad de 'Saber Decir NO' de forma asertiva es indispensable para una gestión del tiempo exitosa?",
                            OptionA = @"Porque demuestra que la persona es antipática y hostil.",
                            OptionB = @"Porque cada vez que dices 'SÍ' a compromisos ajenos irrelevantes, le estás diciendo 'NO' por defecto a tus metas estratégicas prioritarias.",
                            OptionC = @"Porque está prohibido aceptar favores en el trabajo.",
                            OptionD = @"Para que nadie te vuelva a hablar en la oficina.",
                            CorrectAnswer = "B",
                            Explanation = @"Proteger el tiempo propio requiere poner límites claros y corteses a solicitudes que no se alinean con las responsabilidades centrales."
                        }
                    }                },
                // =========================================================================
                // 8. PRIMEROS AUXILIOS LABORALES Y EMERGENCIAS
                // =========================================================================
                new UpgradeCourseData
                {
                    Slug = "primeros-auxilios",
                    Title = "Primeros Auxilios Laborales y Emergencias: Protocolo PAS, RCP y Bioseguridad",
                    CategorySlug = "habilidades-blandas-crecimiento",
                    ShortDescription = "Salva vidas en el trabajo: protocolo PAS (Proteger, Avisar, Socorrer), RCP básica en adultos, Maniobra de Heimlich, quemaduras y control de hemorragias.",
                    FullDescription = "Capacitación práctica indispensable de seguridad laboral y salud en el trabajo. Aprende a mantener la calma y actuar con rigor científico ante accidentes: aplicación del protocolo PAS, reconocimiento de paros cardiorrespiratorios y compresiones torácicas de alta calidad (RCP), desobstrucción de la vía aérea (Heimlich), vendajes compresivos para hemorragias, quemaduras y botiquín reglamentario.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    BadgeColor = "primary",
                    Modules = new List<UpgradeModuleData>
                    {
                        new UpgradeModuleData
                        {
                            Title = "Módulo 1: Principios Generales y Protocolo PAS (Proteger, Avisar, Socorrer)",
                            LessonTitle = "La Secuencia de Oro ante Emergencias Laborales y la Cadena de Supervivencia",
                            Summary = "Domina el orden inalterable PAS para intervenir en accidentes sin convertirte en una víctima adicional: evaluación de la escena, llamado eficaz a emergencias y triage básico.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-hospital-fill fs-2 text-danger""></i>
        <div>
            <h5 class=""fw-bold mb-1"">En una Emergencia, el Orden de los Factores Sí Altera la Vida</h5>
            <p class=""mb-0 small"">El impulso de correr a ayudar sin evaluar los peligros del entorno causa decenas de muertes cada año de socorristas improvisados. Aprende la regla universal de oro: Proteger, Avisar y Socorrer (PAS).</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/sN7QnnwoMBs"" title=""Conducta PAS: tres palabras que salvan vidas"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-shield-shaded text-primary me-2""></i>1. La Conducta PAS: El Protocolo Universal</h4>
    <p>Ante cualquier accidente en la oficina, fábrica o almacén, los tres pasos deben ejecutarse en este orden cronológico estricto sin saltarse ninguno:</p>
    <ul>
        <li><strong>1. P - PROTEGER (Seguridad de la Escena):</strong> Antes de tocar al accidentado, evalúa si el peligro sigue activo. ¿Hay cables de alta tensión caídos? ¿Hay fuga de gas inflamable? ¿Riesgo de derrumbe de estanterías? ¿Líquidos resbalosos o tráfico vehicular? Si el entorno no es 100% seguro, <em>NO INGRESES</em>. No te conviertas en una segunda víctima que los bomberos deban rescatar.</li>
        <li><strong>2. A - AVISAR (Llamado a los Servicios Médicos y Brigada Interna):</strong> Llama de inmediato al número de emergencia correspondiente (ej: 911 / Bomberos / Paramédicos). Proporciona información estructurada con precisión: <strong>1. Dónde ocurrió:</strong> Dirección exacta, piso y puntos de referencia. <strong>2. Qué ocurrió:</strong> Caída de altura, electrocución, paro cardíaco. <strong>3. Cuántas víctimas hay:</strong> Número aproximado y estado aparente (consciente o inconsciente). <em>(¡Regla de oro: Sé siempre el último en colgar el teléfono por si la operadora necesita más datos!)</em>.</li>
        <li><strong>3. S - SOCORRER (Atención Inicial Basada en Conocimiento):</strong> Aplica maniobras de soporte vital dentro de tus capacidades certificadas. Actúa con serenidad, habla a la víctima con voz tranquilizadora y evita movimientos bruscos si se sospecha lesión en la columna vertebral.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-heart-pulse-fill text-primary me-2""></i>2. Evaluación Primaria del Paciente: La Nemotecnia CAB</h4>
    <p>Siguiendo las guías actualizadas de la Asociación Americana del Corazón (AHA):</p>
    <ol>
        <li><strong>C - Circulation (Circulación y Pulso):</strong> Verificar si hay signos de circulación o hemorragias masivas exanguinantes que deban cohibirse de inmediato con presión directa.</li>
        <li><strong>A - Airway (Apertura de la Vía Aérea):</strong> Maniobra frente-mentón (elevar la barbilla con dos dedos mientras se empuja suavemente la frente hacia atrás para evitar que la base de la lengua obstruya la garganta). En caso de trauma o caída, usar tracción mandibular sin flexionar el cuello.</li>
        <li><strong>B - Breathing (Buena Ventilación):</strong> Ver, oír y sentir la respiración durante un máximo de 10 segundos. Si la persona no respira o solo jadea agónicamente (Gasping), se encuentra en paro cardiorrespiratorio y requiere RCP de inmediato.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>3. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Mover a una víctima de accidente de tránsito o caída de altura:</strong> Mover a una persona con posible fractura de vértebras cervicales sin un collarín rígido puede seccionar la médula espinal y provocar parálisis permanente o la muerte instantánea. Solo debe moverse si hay peligro inminente de explosión o incendio.</li>
        <li><strong>Dar agua o comida a una persona inconsciente o herida grave:</strong> Puede causar broncoaspiración (el líquido va a los pulmones asfixiando al paciente) o complicar una cirugía de emergencia inminente.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Aseguras el entorno y evalúas riesgos antes de aproximarte a una víctima accidentada?</li>
            <li>¿Comunicas con claridad la ubicación exacta y el estado de la víctima al llamar a emergencias?</li>
            <li>¿Evitas dar líquidos, comida o medicamentos a personas inconscientes o traumatizadas?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 2: Reanimación Cardiopulmonar (RCP) Básica y Uso del DEA",
                            LessonTitle = "Compresiones Torácicas de Alta Calidad y el Desfibrilador Externo Automático",
                            Summary = "Aprende la técnica de RCP moderna de la AHA: frecuencia de 100-120 lpm, profundidad de 5 cm, descompresión completa y funcionamiento paso a paso del desfibrilador (DEA).",
                            DurationMinutes = 50,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-heartbreak-fill fs-2 text-danger""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Cada Minuto sin RCP Reduce la Supervivencia en un 10%</h5>
            <p class=""mb-0 small"">El paro cardiorrespiratorio repentino es la principal causa de muerte súbita en el entorno laboral. Tus manos son la bomba mecánica que mantendrá oxigenado el cerebro de tu compañero hasta que llegue la ambulancia.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/lG--e0vGX3w"" title=""Cómo hacer RCP en adultos(2022) | Doctor Negrete"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-activity text-primary me-2""></i>1. ¿Cómo Reconocer un Paro Cardíaco Repentino?</h4>
    <p>No pierdas minutos valiosos buscando pulso con dudas si no eres médico. La AHA establece un criterio de detección inmediata en 3 pasos:</p>
    <ul>
        <li><strong>Inconsciencia Total:</strong> Sacude suavemente a la víctima por los hombros y pregúntale en voz alta: <em>'¿Señor, señor, se encuentra bien?'</em>. Si no responde ni se mueve:</li>
        <li><strong>Ausencia de Respiración Normal:</strong> Observa el pecho durante 5 a 10 segundos. Si no se eleva, o si solo emite jadeos intermitentes y ruidosos (respiración agónica / boqueo), la víctima está en paro cardíaco.</li>
        <li><strong>Acción Fulminante:</strong> Señala a una persona específica de los presentes: <em>'Tú, con camisa azul, llama al 911 y trae el Desfibrilador (DEA) de la recepción ya'</em>. E inicia de inmediato las compresiones.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-lightning-fill text-primary me-2""></i>2. La Técnica de Compresiones Torácicas de Alta Calidad</h4>
    <p>Para bombear sangre oxigenada eficazmente hacia el cerebro:</p>
    <ol>
        <li><strong>Posición del Paciente y Socorrista:</strong> Paciente acostado boca arriba sobre una superficie firme y plana (el suelo, nunca en un colchón blando). El rescatista se arrodilla a un costado a la altura del pecho.</li>
        <li><strong>Colocación de las Manos:</strong> Apoya el talón de una mano en el centro del pecho de la víctima (mitad inferior del esternón). Entrelaza los dedos de la otra mano por encima, manteniendo los dedos levantados sin presionar las costillas.</li>
        <li><strong>Brazos Rectos y Fuerza del Torso:</strong> Bloquea los codos en posición totalmente recta. Tus hombros deben estar verticalmente alineados justo encima del pecho de la víctima. Empuja usando el peso de tu tronco y cadera, no con la fuerza de los brazos.</li>
        <li><strong>Profundidad y Frecuencia:</strong> Comprime con una profundidad de al menos 5 cm (sin exceder 6 cm en adultos) a un ritmo constante de <strong>100 a 120 compresiones por minuto</strong> (el ritmo de la famosa canción <em>'Stayin' Alive'</em> de los Bee Gees).</li>
        <li><strong>Permitir la Expansión Torácica Completa:</strong> Deja que el tórax regrese completamente a su posición original entre compresión y compresión. Si te quedas apoyado sobre el pecho, el corazón no puede llenarse de sangre para el siguiente bombeo.</li>
        <li><strong>Minimizar Interrupciones:</strong> Cada interrupción en las compresiones hace que la presión de perfusión cerebral caiga a cero en 3 segundos. Si no estás entrenado o no dispones de mascarilla de barrera, haz <strong>RCP Solo con las Manos (Hands-Only CPR)</strong> de forma continua sin detenerte para dar ventilaciones boca a boca.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-cpu-fill text-primary me-2""></i>3. El Desfibrilador Externo Automático (DEA)</h4>
    <p>El DEA es un dispositivo inteligente diseñado para que cualquier ciudadano sin conocimientos médicos pueda utilizarlo con total seguridad:</p>
    <div class=""card bg-light border-0 p-3 rounded-3 mb-3"">
        <p class=""mb-0 text-muted small""><strong>Operación del DEA en 3 Pasos:</strong> <strong>1. Encender el equipo:</strong> Al presionar el botón de encendido, el DEA comenzará a dar instrucciones por voz en español. <strong>2. Pegar los parches electrodos:</strong> Uno en la parte superior derecha del pecho (debajo de la clavícula) y otro en el costado izquierdo (debajo de la axila), sobre la piel seca y descubierta. <strong>3. Seguir la voz del equipo:</strong> El DEA analizará el ritmo cardíaco. Si dice <em>'Se recomienda descarga, nadie toque al paciente'</em>, grita enérgicamente: <em>'¡Atrás todos!'</em>, verifica visualmente que nadie esté en contacto con la víctima y presiona el botón de descarga iluminado. Continúa de inmediato con las compresiones torácicas.</p>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Doblar los codos al comprimir:</strong> Hace que el rescatista se agote muscularmente en menos de 90 segundos y las compresiones sean superficiales e inútiles.</li>
        <li><strong>Miedo a usar el DEA pensando que se puede electrocutar por error a alguien:</strong> El software del DEA es infalible: analiza el trazado eléctrico y nunca emitirá una descarga si el paciente no tiene una arritmia mortal desfibrilable (Fibrilación Ventricular o Taquicardia Ventricular sin pulso).</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Mantienes los brazos rectos comprimiendo el tórax a un ritmo de 100-120 latidos por minuto?</li>
            <li>¿Permites que el pecho se expanda por completo entre cada compresión torácica?</li>
            <li>¿Sabes en qué pared o pasillo de tu empresa se encuentra ubicado el botiquín y el DEA?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 3: Maniobra de Heimlich y Asfixia por Atragantamiento",
                            LessonTitle = "Desobstrucción de la Vía Aérea en Adultos Conscientes, Inconscientes y Auto-Heimlich",
                            Summary = "Reconoce el signo universal de asfixia (manos al cuello) y aprende a realizar compresiones abdominales subdiafragmáticas para expulsar cuerpos extraños rápidamente.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-warning border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-lungs-fill fs-2 text-warning""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Una Obstrucción de Vía Aérea Mata por Asfixia en Menos de 4 Minutos</h5>
            <p class=""mb-0 small"">Durante el almuerzo en la cafetería o un evento corporativo, un trozo de comida puede bloquear la tráquea por completo. Conoce el signo universal de atragantamiento y la aplicación precisa de la Maniobra de Heimlich.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/vBvMbXjCA14"" title=""Enfermeras explican cómo realizar la maniobra de Heimlich en caso de atragantamiento"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-exclamation-octagon text-primary me-2""></i>1. Diagnóstico: Obstrucción Parcial vs Obstrucción Total</h4>
    <p>Antes de aplicar cualquier fuerza física, es vital identificar el grado de bloqueo:</p>
    <ul>
        <li><strong>Obstrucción Parcial (Leve):</strong> La persona tose con fuerza, puede emitir sonidos o hablar entrecortadamente. <strong>Acción:</strong> <em>NO golpees la espalda y NO hagas Heimlich</em>. Anima a la persona a seguir tosiendo con fuerza (<em>'Siga tosiendo, expúlselo'</em>). La tos refleja humana es el mecanismo más potente del cuerpo para expulsar objetos. Dar golpes en la espalda en una obstrucción parcial puede mover el objeto y causar un bloqueo total.</li>
        <li><strong>Obstrucción Total (Severa):</strong> La persona se lleva desesperadamente ambas manos al cuello (el <strong>Signo Universal de Asfixia</strong>), no puede hablar, no puede toser, no emite ningún sonido y sus labios comienzan a ponerse morados o azulados (cianosis). <strong>Acción:</strong> Aplicar de inmediato la Maniobra de Heimlich.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-hand-thumbs-up text-primary me-2""></i>2. Paso a Paso de la Maniobra de Heimlich en Adultos Conscientes</h4>
    <p>El objetivo es empujar el diafragma hacia arriba para comprimir el aire residual de los pulmones creando una tos artificial que expulse el objeto como un proyectil:</p>
    <ol>
        <li><strong>Posición de Seguridad:</strong> Colócate de pie detrás de la víctima. Pasa una de tus piernas entre las piernas del paciente para tener una base de apoyo firme en caso de que la persona pierda el conocimiento y caiga desmayada.</li>
        <li><strong>Ubicación de las Manos:</strong> Cierra una mano en puño con el pulgar hacia adentro. Coloca el lado del pulgar de tu puño en el abdomen de la víctima, justo por encima del ombligo y bien por debajo del apéndice xifoides (la punta inferior del esternón). Sujeta firmemente tu puño con tu otra mano.</li>
        <li><strong>El Movimiento en 'J':</strong> Realiza compresiones rápidas, secas y firmes hacia adentro y hacia arriba (en forma de letra 'J'). Repite las compresiones con fuerza hasta que el objeto sea expulsado o la víctima quede inconsciente.</li>
        <li><strong>¿Qué hacer si la víctima queda inconsciente?:</strong> Acuéstala con cuidado en el suelo boca arriba, llama a emergencias e inicia de inmediato ciclos de RCP (compresiones torácicas). Cada vez que abras la vía aérea para ventilar, mira dentro de la boca: solo si el objeto está visible y al alcance de tus dedos, extráelo con un barrido de dedo; nunca metas el dedo a ciegas.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-person-fill text-primary me-2""></i>3. Auto-Heimlich (Si Estás Solo y Nadie Puede Ayudarte)</h4>
    <p>Si te atragantas estando solo en una oficina o en casa: coloca tu propio puño sobre tu ombligo sujetado con la otra mano y apóyate con fuerza sobre el borde superior de una silla de espaldar rígido, una baranda o el borde de una mesa resistente, empujando tu abdomen hacia adentro y hacia arriba repetidamente.</p>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Colocar el puño sobre las costillas o el esternón:</strong> Comprimir sobre el hueso en lugar del abdomen blando subdiafragmático fractura costillas y no genera la presión de aire pulmonar necesaria para expulsar el cuerpo extraño.</li>
        <li><strong>Meter los dedos en la boca de la persona a ciegas:</strong> Intentar 'pescar' el objeto con el dedo sin verlo empuja el trozo de comida más adentro en la laringe, empeorando el bloqueo.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Reconoces el signo universal de asfixia (manos al cuello sin poder emitir sonidos)?</li>
            <li>¿Posicionas tu puño dos dedos por encima del ombligo con empuje firme hacia adentro y arriba?</li>
            <li>¿Conoces la técnica de Auto-Heimlich utilizando el respaldo de una silla sólida?</li>
        </ul>
    </div>
</div>"
                        },
                        new UpgradeModuleData
                        {
                            Title = "Módulo 4: Manejo de Hemorragias, Quemaduras, Fracturas y Botiquín Laboral",
                            LessonTitle = "Control del Sangrado con Presión Directa, Torniquetes y Manejo de Lesiones Comunes",
                            Summary = "Domina el protocolo Stop the Bleed para contener hemorragias graves, el tratamiento del agua fría en quemaduras y la dotación reglamentaria del botiquín empresarial.",
                            DurationMinutes = 45,
                            ContentHtml = @"<div class=""reading-lesson p-3"">
    <div class=""alert alert-danger border-0 rounded-3 d-flex align-items-center gap-3 mb-4"">
        <i class=""bi bi-bandaid-fill fs-2 text-danger""></i>
        <div>
            <h5 class=""fw-bold mb-1"">Una Hemorragia Arterial Masiva Puede Causar la Muerte en Menos de 3 Minutos</h5>
            <p class=""mb-0 small"">Cortes con herramientas industriales, vidrios rotos o caídas en escaleras son accidentes frecuentes en el entorno laboral. Conoce los protocolos científicos para detener sangrados, tratar quemaduras y equipar el botiquín reglamentario.</p>
        </div>
    </div>

    <div class=""ratio ratio-16x9 rounded-3 shadow-sm mb-4"">
        <iframe src=""https://www.youtube.com/embed/yfTdaIkT5YI"" title=""Hemorragias, Fracturas y Quemaduras"" allow=""accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>
    </div>

    <h4 class=""fw-bold text-dark mb-3""><i class=""bi bi-droplet-half text-danger me-2""></i>1. Control Científico de Hemorragias (Campaña 'Stop the Bleed')</h4>
    <p>El sangrado incontrolado es la principal causa prevenible de muerte en traumas laborales:</p>
    <ul>
        <li><strong>Presión Directa Continua:</strong> Coloca un apósito estéril, gasa limpia o paño grueso directamente sobre la herida sangrante y aplica una presión firme y constante con ambas manos utilizando el peso de tu cuerpo durante al menos 5 a 10 minutos sin levantar el apósito para mirar. Si la sangre traspasa el apósito, <em>NO LO RETIRES</em> (destruirías el coágulo que se está formando); coloca más gasas por encima y refuerza la presión.</li>
        <li><strong>Vendaje Compresivo:</strong> Una vez contenido el flujo principal, fijar las gasas con una venda elástica enrollada con firmeza alrededor de la extremidad.</li>
        <li><strong>Torniquetes Comerciales (CAT / SOFTT):</strong> Ante heridas por amputación o desgarros arteriales en brazos o piernas donde la sangre brota a borbotones pulsátiles y la presión directa no es suficiente, aplicar un torniquete táctico entre 5 y 7 cm por encima de la herida (nunca sobre una articulación). Ajustar hasta que el sangrado se detenga por completo y anotar la hora exacta de colocación con marcador en la frente del paciente.</li>
    </ul>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-fire text-primary me-2""></i>2. Protocolo de Atención ante Quemaduras Térmicas y Químicas</h4>
    <p>Las quemaduras se clasifican por su profundidad y requieren enfriamiento inmediato:</p>
    <ol>
        <li><strong>La Regla del Agua Fría:</strong> Enfriar la zona quemada bajo un chorro continuo de agua corriente limpia a temperatura ambiente (no helada) durante al menos 10 a 20 minutos ininterrumpidos. Esto detiene la progresión del calor a través de las capas dérmicas profundas y alivia el dolor.</li>
        <li><strong>Protección Estéril:</strong> Cubrir con una gasa estéril humedecida o film plástico transparente sin apretar para evitar infecciones.</li>
        <li><strong>Quemaduras Químicas (Ácidos o Solventes):</strong> Lavar con agua abundante por más de 20 minutos y retirar la ropa contaminada con guantes protectores.</li>
    </ol>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-briefcase-medical text-primary me-2""></i>3. Dotación Reglamentaria del Botiquín de Primeros Auxilios de Oficina</h4>
    <p>Un botiquín laboral debe estar señalizado, ser de fácil acceso y contener insumos de soporte básico:</p>
    <div class=""card bg-light border-0 p-3 rounded-3 mb-3"">
        <ul class=""mb-0 small"">
            <li>Guantes descartables de nitrilo o látex (indispensables para bioseguridad ante fluidos biológicos).</li>
            <li>Gasas estériles, apósitos absorbentes y vendas elásticas de diversos anchos.</li>
            <li>Solución fisiológica salina al 0.9% (para lavado ocular y limpieza de heridas).</li>
            <li>Cinta adhesiva microporosa (tipo Micropore) y tijera de trauma punta roma.</li>
            <li>Mascarilla de barrera facial para RCP.</li>
            <li><em>(¡Importante: Los botiquines de primeros auxilios NO deben contener medicamentos ingeribles como antibióticos o sedantes por normativas de salud ocupacional!)</em>.</li>
        </ul>
    </div>

    <h4 class=""fw-bold text-dark mb-3 mt-4""><i class=""bi bi-exclamation-triangle-fill text-warning me-2""></i>4. Errores Críticos Comunes</h4>
    <ul>
        <li><strong>Aplicar hielo directo, pasta dental o manteca sobre quemaduras:</strong> El hielo produce vasoconstricción severa y quemadura térmica por congelación agregada; las pastas y pomadas caseras infectan la herida abierta y deben ser raspadas dolorosamente en el hospital.</li>
        <li><strong>Reventar las ampollas (Flictenas):</strong> La ampolla es un vendaje biológico estéril que produce el propio cuerpo para proteger la piel nueva. Reventarla expone los tejidos a infecciones bacterianas graves.</li>
    </ul>

    <div class=""card border-0 bg-primary text-white p-3 rounded-3 mt-4"">
        <h6 class=""fw-bold mb-2""><i class=""bi bi-check2-all me-2""></i>Checklist de Excelencia Profesional</h6>
        <ul class=""mb-0 small"">
            <li>¿Usas guantes protectores antes de tocar sangre o fluidos biológicos de un accidentado?</li>
            <li>¿Enfrías las quemaduras con agua corriente limpia durante al menos 10 a 15 minutos?</li>
            <li>¿Verificas mensualmente que el botiquín de tu área de trabajo esté completo y sin insumos vencidos?</li>
        </ul>
    </div>
</div>"
                        }
                    },
                    QuizQuestions = new List<UpgradeQuizQuestionData>
                    {
                        new UpgradeQuizQuestionData
                        {
                            Question = @"En la secuencia de emergencia PAS de primeros auxilios, ¿cuál es el significado correcto de las siglas y su orden estricto de aplicación?",
                            OptionA = @"Parar, Analizar y Salir.",
                            OptionB = @"Proteger (asegurar el entorno), Avisar (llamar a emergencias) y Socorrer (atender a la víctima).",
                            OptionC = @"Presionar, Aliviar y Sanar.",
                            OptionD = @"Preguntar, Abrigar y Sentar.",
                            CorrectAnswer = "B",
                            Explanation = @"Proteger el lugar evita nuevos accidentes; avisar a los servicios profesionales garantiza la ambulancia; y socorrer estabiliza al herido."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la frecuencia de compresiones torácicas recomendada por las guías internacionales para una RCP de alta calidad en un adulto?",
                            OptionA = @"30 a 50 compresiones por minuto.",
                            OptionB = @"Entre 100 y 120 compresiones por minuto.",
                            OptionC = @"200 a 300 compresiones por minuto.",
                            OptionD = @"Una compresión cada 10 minutos.",
                            CorrectAnswer = "B",
                            Explanation = @"El ritmo de 100-120 lpm (al compás de Stayin' Alive) mantiene la perfusión cerebral y coronaria indispensable."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿En qué posición anatómica exacta se deben colocar las manos para iniciar las compresiones de RCP en un adulto?",
                            OptionA = @"Sobre el lado izquierdo de las costillas bajas.",
                            OptionB = @"En el centro del pecho, en la mitad inferior del hueso esternón.",
                            OptionC = @"En la boca del estómago (abdomen blando).",
                            OptionD = @"En el cuello sobre la carótida.",
                            CorrectAnswer = "B",
                            Explanation = @"El centro del esternón comprime el corazón directamente contra la columna vertebral generando flujo sanguíneo eficiente."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"Si una persona se está atragantando con comida pero tose con fuerza y emite sonidos, ¿qué debe hacer el socorrista?",
                            OptionA = @"Golpearle la espalda fuertemente de inmediato.",
                            OptionB = @"Animarle a seguir tosiendo con fuerza sin interferir físicamente ni darle líquidos.",
                            OptionC = @"Hacerle beber un vaso grande de agua fría.",
                            OptionD = @"Tirarlo al suelo de espaldas.",
                            CorrectAnswer = "B",
                            Explanation = @"La tos espontánea es el mecanismo más potente y natural para desalojar cuerpos extraños; interferir puede encajar aún más la obstrucción."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cómo se ejecuta correctamente la Maniobra de Heimlich en una persona consciente con atragantamiento total que no puede toser ni hablar?",
                            OptionA = @"Compresiones firmes hacia adentro y hacia arriba en la boca del estómago (entre el ombligo y el esternón) colocándose detrás de la persona.",
                            OptionB = @"Apretarle la garganta con ambas manos.",
                            OptionC = @"Levantarle los dos brazos hacia el techo.",
                            OptionD = @"Hacerle cosquillas en las axilas.",
                            CorrectAnswer = "A",
                            Explanation = @"El empuje abdominal ascendente eleva el diafragma y comprime los pulmones, expulsando el objeto como un tapón a presión."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Cuál es la primera acción recomendada ante una quemadura térmica por calor en la piel de un empleado?",
                            OptionA = @"Untarle mantequilla, pasta de dientes o harina de trigo.",
                            OptionB = @"Enfriar la zona inmediatamente con abundante agua corriente limpia a temperatura ambiente durante al menos 15 a 20 minutos.",
                            OptionC = @"Frotarle cubos de hielo de forma enérgica sobre la quemadura.",
                            OptionD = @"Reventar todas las ampollas con una aguja sucia.",
                            CorrectAnswer = "B",
                            Explanation = @"El agua a temperatura ambiente drena el calor residual de los tejidos dérmicos; el hielo y remedios caseros causan quemaduras químicas e infecciones severas."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"Si una herida en el brazo sangra de forma abundante y empapa por completo la primera gasa de tela colocada, ¿qué se debe hacer?",
                            OptionA = @"Retirar la gasa empapada y tirarla para poner una limpia.",
                            OptionB = @"Colocar apósitos o gasas adicionales directamente encima de la primera sin retirarla y continuar ejerciendo presión firme continua.",
                            OptionC = @"Lavar la herida con alcohol puro.",
                            OptionD = @"Pedirle a la persona que mueva el brazo rápidamente.",
                            CorrectAnswer = "B",
                            Explanation = @"Retirar la primera gasa rompe el coágulo plaquetario que el cuerpo está formando, reactivando la hemorragia profusa."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Qué es un DEA (Desfibrilador Externo Automático) y quién puede utilizarlo en una emergencia?",
                            OptionA = @"Un aparato que solo pueden usar neurocirujanos con licencia militar.",
                            OptionB = @"Un dispositivo médico electrónico portátil y seguro que analiza el ritmo cardíaco y emite instrucciones de voz guiadas paso a paso para que cualquier persona pueda usarlo.",
                            OptionC = @"Un medidor de presión arterial casero.",
                            OptionD = @"Un tipo de extintor para apagar incendios eléctricos.",
                            CorrectAnswer = "B",
                            Explanation = @"Los DEAs están diseñados para ser operados por legos con instrucciones audibles claras; solo aplican descarga si detectan un ritmo desfibrilable."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"Si se sospecha que una persona accidentada sufrió una caída grave de altura con posible lesión en la columna vertebral o cuello, ¿cómo debe procederse?",
                            OptionA = @"Sentarla en una silla y girarle la cabeza para ver si tiene dolores.",
                            OptionB = @"No mover a la víctima, mantener alineado el eje cabeza-cuello-tronco y esperar la llegada de los paramédicos con collarín cervical.",
                            OptionC = @"Cargarla en brazos entre dos personas corriendo al hospital.",
                            OptionD = @"Obligarla a ponerse de pie y caminar.",
                            CorrectAnswer = "B",
                            Explanation = @"Cualquier movimiento indebido en una fractura de columna puede seccionar la médula espinal y provocar parálisis permanente o la muerte."
                        },
                        new UpgradeQuizQuestionData
                        {
                            Question = @"¿Por qué NO se debe aplicar alcohol o agua oxigenada directamente dentro de una herida abierta profunda?",
                            OptionA = @"Porque huelen mal.",
                            OptionB = @"Porque son productos citotóxicos que destruyen las células sanas y el tejido de cicatrización, provocando irritación química y retrasando la curación.",
                            OptionC = @"Porque cuesta mucho dinero en las farmacias.",
                            OptionD = @"Porque duerme a la persona.",
                            CorrectAnswer = "B",
                            Explanation = @"El alcohol y agua oxigenada queman las células vivas; las heridas abiertas se limpian con agua limpia y jabón neutro o suero fisiológico estéril."
                        }
                    }                }
            };
        }
    }
}