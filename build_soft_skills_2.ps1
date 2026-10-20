# Courses 5-8 generator for SoftSkillsHR
function Get-Course-Liderazgo ($qData) {
    return @'
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
                    QuizQuestions = 
'@ + $qData + @'
                },
'@
}

Write-Host "Liderazgo helper loaded successfully!"

function Get-Course-Negociacion ($qData) {
    return @'
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
                    QuizQuestions = 
'@ + $qData + @'
                },
'@
}

Write-Host "Negociacion helper loaded successfully!"

function Get-Course-GestionTiempo ($qData) {
    return @'
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
                    QuizQuestions = 
'@ + $qData + @'
                },
'@
}

Write-Host "Gestion del Tiempo helper loaded successfully!"

function Get-Course-PrimerosAuxilios ($qData) {
    return @'
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
                    QuizQuestions = 
'@ + $qData + @'
                }
            };
        }
    }
}
'@
}

Write-Host "Primeros Auxilios helper loaded successfully!"
