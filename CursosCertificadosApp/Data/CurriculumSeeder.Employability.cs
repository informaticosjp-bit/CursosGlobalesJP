namespace CursosCertificadosApp.Data
{
    public static partial class CurriculumSeeder
    {
        public static List<CourseSeedData> GetEmployabilityCourses()
        {
            return new List<CourseSeedData>
            {
                // =========================================================================
                // CURSO 6: ELABORACIÓN DE CURRÍCULUMS DE ALTO IMPACTO Y CARTAS DE PRESENTACIÓN
                // =========================================================================
                new CourseSeedData
                {
                    CategorySlug = "empleabilidad-desarrollo-idiomas",
                    Title = "Elaboración de Currículums de Alto Impacto y Cartas de Presentación",
                    Slug = "curriculums-alto-impacto-cartas",
                    ShortDescription = "Diseña un currículum vitae profesional optimizado para sistemas ATS (Applicant Tracking Systems) y cartas de presentación persuasivas que atraigan reclutadores.",
                    Level = "Básico",
                    EstimatedHours = 12,
                    BadgeColor = "primary",
                    Modules = new List<ModuleSeedData>
                    {
                        new ModuleSeedData
                        {
                            Title = "Módulo 1: Anatomía de un CV Moderno y Errores Críticos que Descartan Candidatos",
                            LessonTitle = "Guía de Diseño Estratégico: Estructura, Formato y Jerarquía Visual",
                            Summary = "Conoce las pautas globales de diseño de CV: longitud máxima, tipografías estándar, eliminación de datos personales innecesarios y formato cronológico inverso.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Los 6 Segundos del Reclutador</h4>
<p>Los estudios de selección laboral demuestran que un reclutador dedica un promedio de <strong>6 a 8 segundos</strong> al primer escaneo visual de un CV antes de decidir si pasa a la pila de preseleccionados o al descarte. Una estructura confusa o barroca arruina las oportunidades de un profesional talentoso.</p>

<div class=""card p-3 border-danger bg-light rounded-3 my-3"">
    <h6 class=""fw-bold text-danger mb-2""><i class=""bi bi-x-circle-fill me-1""></i> Elementos que DEBES Eliminar de tu CV Moderno:</h6>
    <ul class=""small mb-0"">
        <li><strong>Dirección Postal Exacta:</strong> Indica únicamente Ciudad y País (ej. <em>Caracas, Venezuela</em>). La dirección exacta es innecesaria y vulnera tu privacidad.</li>
        <li><strong>Estado Civil, Religión o Edad:</strong> No aportan al mérito técnico y pueden generar sesgos inconscientes.</li>
        <li><strong>Gráficos de Barras de Habilidades:</strong> Calificaciones como 'Inglés 80%' o 'Excel 90%' carecen de criterio objetivo y confunden a los evaluadores.</li>
        <li><strong>Referencias Personales 'A Solicitud':</strong> Ocupan espacio valioso; las referencias se entregan cuando la empresa formalmente las solicita.</li>
    </ul>
</div>

<div class=""alert alert-info border-0 p-3 rounded-3"">
    <strong><i class=""bi bi-file-earmark-person me-1""></i> Regla de Extensión:</strong> Máximo 1 página si tienes menos de 5 años de experiencia; máximo 2 páginas para trayectorias de más de 8 años con cargos directivos.
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 2: Optimización para Sistemas ATS y Redacción con el Método STAR",
                            LessonTitle = "Presentación Aplicada: Superar el Filtro del Robot y Cuantificar Logros",
                            Summary = "Aprende cómo los sistemas ATS filtran palabras clave y cómo redactar viñetas de experiencia demostrando resultados con la fórmula STAR.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Qué son los ATS (Applicant Tracking Systems)</h4>
<p>Las plataformas corporativas y portales de empleo utilizan software <strong>ATS</strong> para leer y clasificar los currículums antes de que lleguen a ojos humanos. Para garantizar que tu CV no sea descartado por el algoritmo:</p>
<ul>
    <li>Utiliza formato <code>.docx</code> o <code>.pdf</code> con texto seleccionable (no imágenes ni escaneos).</li>
    <li>Evita tablas complejas, cuadros de texto flotantes o columnas múltiples intrincadas.</li>
    <li>Extrae las <strong>palabras clave exactas</strong> que aparecen en la oferta de empleo (ej. <em>'Conciliación Bancaria', 'Google Workspace', 'Soporte Técnico'</em>) e inclúyelas naturalmente en tu perfil.</li>
</ul>

<h4>2. La Fórmula STAR para Viñetas de Experiencia</h4>
<p>No listes funciones pasivas (<em>'Encargado de inventarios'</em>). Demuestra impacto comercial tangible mediante el método <strong>STAR</strong>:</p>

<div class=""card bg-light border p-3 rounded-3 my-3"">
    <div class=""row g-2 text-dark small"">
        <div class=""col-md-3""><strong>S - Situación:</strong> Contexto del desafío previo.</div>
        <div class=""col-md-3""><strong>T - Tarea:</strong> Tu objetivo específico.</div>
        <div class=""col-md-3""><strong>A - Acción:</strong> Qué herramientas implementaste.</div>
        <div class=""col-md-3""><strong class=""text-success"">R - Resultado:</strong> Cifra o porcentaje de mejora.</div>
    </div>
    <hr class=""my-2"">
    <p class=""small mb-0""><strong>Ejemplo de Alto Impacto:</strong> <em>'Rediseñé el sistema de control de inventarios mediante hojas de cálculo colaborativas en la nube, reduciendo las mermas de almacén en un 24% durante el primer trimestre.'</em></p>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 3: Redacción Persuasiva de Cartas de Presentación y Correos de Contacto",
                            LessonTitle = "Guía Práctica: La Carta de Presentación que Abre Puertas",
                            Summary = "Escribe cartas de presentación personalizadas en 3 párrafos de alto impacto que demuestren afinidad cultural y valor diferencial.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>La Estructura de 3 Párrafos para Cartas y Correos</h4>
<p>Una carta de presentación no debe repetir tu CV cronológico; debe conectar tus mayores fortalezas con las necesidades más urgentes de la organización:</p>

<div class=""row g-3 my-3"">
    <div class=""col-md-4"">
        <div class=""card p-3 border h-100"">
            <h6 class=""fw-bold text-primary"">Párrafo 1: El Gancho</h6>
            <p class=""small text-muted mb-0"">Indica el puesto exacto al que postulas, menciona un logro reciente de la empresa que admires y declara tu propuesta de valor en una frase.</p>
        </div>
    </div>
    <div class=""col-md-4"">
        <div class=""card p-3 border h-100"">
            <h6 class=""fw-bold text-success"">Párrafo 2: El Ajuste Perfecto</h6>
            <p class=""small text-muted mb-0"">Elige 1 o 2 de tus mayores éxitos profesionales que demuestren cómo resolverás sus dolores operativos actuales con evidencia concreta.</p>
        </div>
    </div>
    <div class=""col-md-4"">
        <div class=""card p-3 border h-100"">
            <h6 class=""fw-bold text-warning"">Párrafo 3: Llamada a la Acción</h6>
            <p class=""small text-muted mb-0"">Manifiesta con amabilidad tu disponibilidad para una entrevista breve y agradece su tiempo de lectura profesional.</p>
        </div>
    </div>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 4: Sincronización Estratégica con LinkedIn y Portafolio de Evidencias",
                            LessonTitle = "Guía Digital: Tu Marca Profesional en Internet",
                            Summary = "Optimiza tu titular de LinkedIn, redacta una sección 'Acerca de' atractiva y adjunta tus certificados oficiales verificables.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Optimización del Perfil de LinkedIn</h4>
<p>Tu currículum y tu LinkedIn deben complementarse perfectamente:</p>
<ul>
    <li><strong>Titular Profesional:</strong> No coloques solo <em>'En búsqueda activa de empleo'</em>. Especifica tu área y valor: <em>'Especialista en Ofimática en la Nube y Soporte TI | Optimización de Procesos Administrativos'</em>.</li>
    <li><strong>Sección Acerca De:</strong> Redacta en primera persona tu historia profesional, tus áreas de mayor dominio técnico y tu pasión laboral.</li>
    <li><strong>Licencias y Certificaciones:</strong> Añade tus diplomas oficiales con su código de verificación único y el enlace de validación directa para generar confianza inmediata en reclutadores internacionales.</li>
</ul>"
                        }
                    },
                    Quiz = new QuizSeedData
                    {
                        Title = "Evaluación Sumativa: Elaboración de Currículums y Cartas de Presentación",
                        Questions = new List<QuestionSeedData>
                        {
                            new QuestionSeedData
                            {
                                QuestionText = "¿Qué significa el acrónimo ATS en el contexto del reclutamiento y selección de talento?",
                                Options = new[]
                                {
                                    "Applicant Tracking System (Sistema de Seguimiento de Candidatos).",
                                    "Asociación Técnica de Supervisores.",
                                    "Archivo Temporal de Servidor.",
                                    "Atención Telefónica al Solicitante."
                                },
                                CorrectIndex = 0,
                                Explanation = "Los ATS son sistemas informáticos que filtran y clasifican currículums mediante coincidencia de palabras clave y datos estructurados antes de la revisión humana."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál es la recomendación moderna respecto a la inclusión de barras de porcentaje de habilidades (ej. 'Inglés 80%') en el CV?",
                                Options = new[]
                                {
                                    "Son obligatorias por ley en todos los países.",
                                    "Deben evitarse porque son subjetivas, no demuestran competencia real y confunden a los ATS.",
                                    "Deben pintarse de color dorado para llamar la atención.",
                                    "Solo deben usarse si el porcentaje es superior al 95%."
                                },
                                CorrectIndex = 1,
                                Explanation = "Los gráficos de barras son mediciones arbitrarias sin fundamento objetivo; es mucho más efectivo describir proyectos reales o certificaciones oficiales obtenidas."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "Al aplicar el método STAR para redactar la experiencia laboral, ¿a qué corresponde la letra 'R'?",
                                Options = new[]
                                {
                                    "Remuneración recibida.",
                                    "Resultado obtenido (cuantificado en porcentaje, tiempo o ahorro).",
                                    "Reclamo presentado al supervisor.",
                                    "Referencia familiar del postulante."
                                },
                                CorrectIndex = 1,
                                Explanation = "La 'R' de STAR representa el 'Resultado' concreto, preferiblemente medible en cifras, porcentaje de mejora o tiempo optimizado."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál es la longitud recomendada para un currículum vitae de un profesional con menos de 5 años de trayectoria?",
                                Options = new[]
                                {
                                    "Al menos 4 páginas detallando cada materia cursada en la escuela.",
                                    "1 página concisa y estructurada estratégicamente.",
                                    "No debe tener texto, solo fotografías.",
                                    "10 páginas impresas a doble cara."
                                },
                                CorrectIndex = 1,
                                Explanation = "Para perfiles junior o con menos de 5 años de experiencia, una sola página bien jerarquizada garantiza una lectura completa durante los primeros segundos de evaluación."
                            }
                        }
                    }
                },

                // =========================================================================
                // CURSO 7: CÓMO SUPERAR ENTREVISTAS DE TRABAJO EXITOSAS
                // =========================================================================
                new CourseSeedData
                {
                    CategorySlug = "empleabilidad-desarrollo-idiomas",
                    Title = "Cómo Superar Entrevistas de Trabajo Exitosas y Técnicas de Comunicación con Reclutadores",
                    Slug = "entrevistas-trabajo-exitosas",
                    ShortDescription = "Prepárate para superar cualquier entrevista laboral: control del lenguaje corporal, respuestas a preguntas difíciles, negociación salarial y seguimiento profesional.",
                    Level = "Intermedio",
                    EstimatedHours = 14,
                    BadgeColor = "warning",
                    Modules = new List<ModuleSeedData>
                    {
                        new ModuleSeedData
                        {
                            Title = "Módulo 1: Investigación Corporativa y Preparación Psicológica Previa",
                            LessonTitle = "Guía Estratégica: Radiografía de la Empresa y Control de la Ansiedad",
                            Summary = "Aprende a investigar a fondo la empresa, sus clientes y su modelo de negocio antes de la entrevista, transformando los nervios en entusiasmo enfocado.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. La Regla de los 3 Círculos de Investigación</h4>
<p>Llegar a una entrevista sin saber qué vende la empresa, quiénes son sus competidores o cuáles son sus retos recientes es la garantía de un rechazo fulminante. Investiga:</p>
<ul>
    <li><strong>El Negocio:</strong> ¿Cómo gana dinero la empresa? ¿Cuáles son sus principales productos o líneas de servicio?</li>
    <li><strong>La Cultura y el Equipo:</strong> Revisa el perfil de LinkedIn de los fundadores, del gerente del área y de la persona que te va a entrevistar.</li>
    <li><strong>Las Noticias del Sector:</strong> ¿Se expandieron recientemente? ¿Lanzaron un producto? ¿Enfrentan nuevos marcos regulatorios?</li>
</ul>

<div class=""alert alert-warning border-0 p-3 rounded-3 my-3"">
    <strong><i class=""bi bi-heart-pulse-fill text-danger me-1""></i> Manejo del Estrés Previo:</strong> La respiración diafragmática 4-4-4 (inhalar 4s, retener 4s, exhalar 4s) durante 3 minutos antes de entrar a la sala o conectarte a la videollamada reduce el cortisol y estabiliza el ritmo cardíaco.
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 2: Comunicación No Verbal y Presencia en Entrevistas Presenciales y Virtuales",
                            LessonTitle = "Presentación Aplicada: Lenguaje Corporal, Mirada y Entorno Virtual",
                            Summary = "Domina el contacto visual a la cámara web, la modulación vocal, la postura de escucha activa y la iluminación correcta en llamadas remotas.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Entrevistas por Videollamada (Google Meet / Zoom / Teams)</h4>
<p>En el entorno remoto, pequeños detalles técnicos transmiten o destruyen la credibilidad del candidato:</p>

<div class=""row g-3 my-3"">
    <div class=""col-md-6"">
        <div class=""card p-3 border h-100"">
            <h6 class=""fw-bold text-primary"">La Mirada a la Lente</h6>
            <p class=""small text-muted mb-0"">Mira a la cámara física web, no a la imagen de la persona en la pantalla. Para el entrevistador, mirar a la cámara se percibe como contacto visual directo a sus ojos.</p>
        </div>
    </div>
    <div class=""col-md-6"">
        <div class=""card p-3 border h-100"">
            <h6 class=""fw-bold text-success"">Iluminación Frontal y Audio Limpio</h6>
            <p class=""small text-muted mb-0"">Ubica la fuente de luz frente a tu rostro, nunca a tu espalda (lo cual crea siluetas oscuras). Usa auriculares con micrófono para aislar ruidos ambientales de la calle.</p>
        </div>
    </div>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 3: Respuestas a Preguntas Trampa, Conductuales y Puntos Débiles",
                            LessonTitle = "Guía Táctica: Respuestas Maestras a Preguntas Complejas",
                            Summary = "Aprende a responder con autenticidad y astucia a 'Háblame de ti', '¿Cuál es tu mayor debilidad?' y '¿Por qué saliste de tu último trabajo?'.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>Estrategias para las Preguntas más Temidas</h4>

<div class=""card p-3 border bg-light rounded-3 my-3"">
    <h6 class=""fw-bold text-dark mb-1"">1. '¿Cuál es tu mayor debilidad o defecto?'</h6>
    <p class=""small text-muted mb-2""><strong>Error Común:</strong> Decir <em>'Soy muy perfeccionista'</em> (falsa modestia clichosa) o confesar una falta de competencia crítica para el cargo.</p>
    <p class=""small text-dark mb-0""><strong>Fórmula Correcta:</strong> Elige un área técnica secundaria real y explica de inmediato <strong>qué acción correctiva estás tomando para dominarla</strong>: <em>'Antes me costaba delegar tareas operativas en equipo, por lo que tomé un curso de metodologías ágiles y ahora implemento tableros Trello con asignaciones claras, lo que mejoró un 40% el flujo de trabajo.'</em></p>
</div>

<div class=""card p-3 border bg-light rounded-3 my-3"">
    <h6 class=""fw-bold text-dark mb-1"">2. '¿Por qué saliste (o deseas salir) de tu empresa actual?'</h6>
    <p class=""small text-muted mb-2""><strong>Regla Sagrada:</strong> NUNCA critiques ni hables mal de tus jefes, colegas o de la empresa previa. Eso denota inmadurez y falta de lealtad.</p>
    <p class=""small text-dark mb-0""><strong>Fórmula Correcta:</strong> Enfócate en el crecimiento futuro: <em>'Estoy profundamente agradecido por los aprendizajes en mi rol anterior, pero busco un nuevo reto donde pueda liderar proyectos de digitalización y expandir mi impacto en un equipo en crecimiento como el de ustedes.'</em></p>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 4: Preguntas para el Reclutador, Negociación Salarial y Seguimiento",
                            LessonTitle = "Guía de Cierre: Negociar con Seguridad y Cerrar la Oportunidad",
                            Summary = "Formula preguntas inteligentes al final de la entrevista, negocia tu compensación con argumentos sólidos y redacta el correo de agradecimiento post-entrevista.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Cuando te Dicen: '¿Tienes alguna pregunta para nosotros?'</h4>
<p>Responder <em>'No, todo me quedó muy claro'</em> denota desinterés o falta de iniciativa. Haz preguntas que demuestren visión estratégica:</p>
<ul>
    <li><em>'¿Cómo medirían el éxito de la persona seleccionada durante los primeros 90 días en este cargo?'</em></li>
    <li><em>'¿Cuáles son los mayores retos operativos que el equipo está enfrentando actualmente?'</em></li>
</ul>

<h4>2. El Correo de Agradecimiento en 24 Horas</h4>
<p>Envía un correo breve de agradecimiento en las primeras 24 horas posteriores a la reunión, agradeciendo la amabilidad del diálogo y reforzando en 2 líneas tu entusiasmo por contribuir a resolver el reto conversado.</p>"
                        }
                    },
                    Quiz = new QuizSeedData
                    {
                        Title = "Evaluación Sumativa: Técnicas para Superar Entrevistas Laborales Exitosas",
                        Questions = new List<QuestionSeedData>
                        {
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál es la respuesta más adecuada ante la pregunta '¿Cuál es tu mayor defecto o debilidad laboral'?",
                                Options = new[]
                                {
                                    "Decir 'Soy demasiado perfecto y nunca me equivoco'.",
                                    "Mencionar un área de mejora real y describir de inmediato el plan de acción concreto que estás ejecutando para superarla.",
                                    "Decir que no te gusta levantarte temprano ni cumplir horarios.",
                                    "Quedarse en silencio mirando el reloj."
                                },
                                CorrectIndex = 1,
                                Explanation = "Demostrar autoconciencia acompañada de una acción formativa o correctiva real refleja madurez profesional y proactividad constante."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Qué impacto tiene hablar mal del jefe o de la empresa anterior durante una entrevista de trabajo?",
                                Options = new[]
                                {
                                    "Genera simpatía y hace que te contraten inmediatamente.",
                                    "Causa una pésima impresión de deslealtad y falta de profesionalismo, descartando al candidato casi de inmediato.",
                                    "Es obligatorio para demostrar sinceridad.",
                                    "Permite que te ofrezcan un salario más elevado."
                                },
                                CorrectIndex = 1,
                                Explanation = "Criticar a empleadores previos destruye la confianza del entrevistador, quien asumirá que en el futuro hablarás igual de su organización."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "En una entrevista por videollamada, ¿hacia dónde debes dirigir tu mirada para que el entrevistador perciba contacto visual directo?",
                                Options = new[]
                                {
                                    "Hacia el teclado de la computadora.",
                                    "Hacia la lente física de la cámara web.",
                                    "Hacia la esquina inferior derecha de la pantalla.",
                                    "Hacia la ventana de la habitación."
                                },
                                CorrectIndex = 1,
                                Explanation = "Mirar fijamente a la lente de la cámara web recrea la ilusión óptica de mirar directamente a los ojos de la persona en el otro extremo de la videollamada."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Qué debes responder cuando el entrevistador pregunta: '¿Tienes alguna pregunta para nosotros?' al finalizar la sesión?",
                                Options = new[]
                                {
                                    "Responder 'No, ninguna pregunta, ya me quiero ir'.",
                                    "Formular preguntas estratégicas sobre los retos del área o las expectativas de éxito para los primeros meses en el puesto.",
                                    "Preguntar a qué hora es la hora del almuerzo el primer día.",
                                    "Pedirle dinero prestado al entrevistador."
                                },
                                CorrectIndex = 1,
                                Explanation = "Formular preguntas estratégicas demuestra curiosidad genuina, preparación previa y motivación por generar valor concreto en el rol."
                            }
                        }
                    }
                },

                // =========================================================================
                // CURSO 8: INGLÉS PROFESIONAL PARA ENTREVISTAS, NETWORKING Y PRESENTACIONES
                // =========================================================================
                new CourseSeedData
                {
                    CategorySlug = "empleabilidad-desarrollo-idiomas",
                    Title = "Inglés Profesional para Entrevistas, Networking y Presentaciones Laborales",
                    Slug = "ingles-profesional-entrevistas-networking",
                    ShortDescription = "Adquiere el vocabulario, expresiones idiomáticas y soltura para desenvolverte en entrevistas de trabajo en inglés, llamadas corporativas y reuniones globales.",
                    Level = "Intermedio",
                    EstimatedHours = 18,
                    BadgeColor = "info",
                    Modules = new List<ModuleSeedData>
                    {
                        new ModuleSeedData
                        {
                            Title = "Módulo 1: El Elevator Pitch Profesional en Inglés: Tu Perfil en 60 Segundos",
                            LessonTitle = "Guía Lingüística: Estructuras Clave para Hablar de tu Carrera",
                            Summary = "Domina fórmulas verbales fluidas para responder a 'Tell me about yourself' con seguridad, precisión léxica y pronunciación natural.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Estructura de un Elevator Pitch Corporativo</h4>
<p>En el mercado internacional, abrir una conversación con soltura marca la diferencia. Utiliza la fórmula <strong>Pasado - Presente - Futuro</strong>:</p>

<div class=""card p-3 border-primary bg-light rounded-3 my-3"">
    <h6 class=""fw-bold text-primary mb-2""><i class=""bi bi-chat-dots-fill me-1""></i> Fórmulas Verbales Imprescindibles:</h6>
    <ul class=""small mb-0"">
        <li><strong>Present:</strong> <em>'I am currently working as a [Cargo], specializing in [Especialidad]. Over the past [X] years, I have helped organizations streamline their daily operations.'</em></li>
        <li><strong>Past:</strong> <em>'Previously, I led initiatives focused on cloud migration and automated data reporting, which resulted in a 20% efficiency increase.'</em></li>
        <li><strong>Future:</strong> <em>'I am looking forward to leveraging my technical background in a forward-thinking global team like yours.'</em></li>
    </ul>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 2: Preguntas Frecuentes de Entrevistas Globales y Conectores de Alto Nivel",
                            LessonTitle = "Presentación Aplicada: Conectores Lógicos y Expresión de Logros",
                            Summary = "Aprende a enlazar argumentos con conectores formales (Furthermore, Consequently, However) para sonar elocuente y profesional.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>Conectores Formales para Enriquecer tu Discurso</h4>
<p>Evita limitarte a decir <em>'and... and... and...'</em> o <em>'so... so...'</em>. Eleva el nivel con conectores utilizados en ambientes ejecutivos:</p>

<div class=""table-responsive my-3"">
    <table class=""table table-bordered table-striped align-middle"">
        <thead class=""table-dark"">
            <tr><th>Función</th><th>Conector Ejecutivo</th><th>Ejemplo en Contexto</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>Añadir Información</strong></td>
                <td><em>Furthermore / Moreover</em></td>
                <td><em>'Furthermore, I successfully implemented a new ticketing system for customer support.'</em></td>
            </tr>
            <tr>
                <td><strong>Causa y Efecto</strong></td>
                <td><em>Consequently / As a result</em></td>
                <td><em>'As a result, inventory reconciliation time was reduced by half.'</em></td>
            </tr>
            <tr>
                <td><strong>Contraste</strong></td>
                <td><em>Nevertheless / However</em></td>
                <td><em>'The project timeline was tight; nevertheless, the team delivered all milestones on schedule.'</em></td>
            </tr>
        </tbody>
    </table>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 3: Redacción Formal de Correos Corporativos y Mensajes de LinkedIn",
                            LessonTitle = "Guía de Correspondencia: Plantillas de Negocios en Inglés",
                            Summary = "Redacta correos diplomáticos, solicitudes de información respetuosas y notas de contacto profesional en LinkedIn sin errores de registro formal.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Anatomía de un Correo Profesional en Inglés</h4>
<p>El tono formal en inglés requiere fórmulas de cortesía específicas:</p>
<ul>
    <li><strong>Apertura Formal:</strong> <em>'Dear Mr./Ms. [Apellido],'</em> o <em>'Dear Hiring Team,'</em> (evita <em>'Hey'</em> o <em>'Hi guys'</em> en primeros contactos).</li>
    <li><strong>Motivo del Mensaje:</strong> <em>'I am writing to express my strong interest in the [Cargo] role posted on your careers portal.'</em></li>
    <li><strong>Adjuntos:</strong> <em>'Please find attached my resume and certifications for your review.'</em></li>
    <li><strong>Cierre Formal:</strong> <em>'Sincerely,'</em> o <em>'Best regards,'</em> seguido de tu nombre y teléfono.</li>
</ul>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 4: Estructuración y Exposición de Presentaciones de Negocios en Inglés",
                            LessonTitle = "Guía de Oratoria: Signposting y Manejo de Preguntas Difíciles (Q&A)",
                            Summary = "Aprende frases de transición entre diapositivas (Signposting) y técnicas para responder preguntas con calma durante reuniones internacionales.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>El Arte del Signposting (Guía Verbal del Oyente)</h4>
<p>En presentaciones en inglés, el presentador guía explícitamente a la audiencia usando fórmulas consagradas:</p>
<ul>
    <li><strong>Introducción:</strong> <em>'The purpose of today's presentation is to provide an overview of our quarterly performance.'</em></li>
    <li><strong>Cambio de Tema:</strong> <em>'Turning now to our next slide, let's examine the sales metrics by region.'</em></li>
    <li><strong>Conclusión:</strong> <em>'To wrap up, I would like to highlight the three key takeaways from our analysis.'</em></li>
    <li><strong>Manejo de Preguntas (Q&A):</strong> <em>'That is an excellent question. Allow me to clarify how our pricing model operates in practice.'</em></li>
</ul>"
                        }
                    },
                    Quiz = new QuizSeedData
                    {
                        Title = "Evaluación Sumativa: Inglés Profesional para el Ámbito Laboral",
                        Questions = new List<QuestionSeedData>
                        {
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál de las siguientes frases es la más adecuada para indicar en un correo formal que adjuntas tu currículum?",
                                Options = new[]
                                {
                                    "Look at my paper down here.",
                                    "Please find attached my resume and certifications for your consideration.",
                                    "I give you my CV on this email.",
                                    "Take my document now."
                                },
                                CorrectIndex = 1,
                                Explanation = "'Please find attached...' es la convención internacional estándar y formal en correspondencia corporativa en inglés."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "En una presentación laboral en inglés, ¿para qué se utiliza la técnica de 'Signposting'?",
                                Options = new[]
                                {
                                    "Para pintar señales de tránsito en la oficina.",
                                    "Para guiar verbalmente a la audiencia entre secciones, diapositivas y conclusiones con frases de transición estructuradas.",
                                    "Para silenciar el micrófono de los participantes.",
                                    "Para traducir subtítulos automáticamente."
                                },
                                CorrectIndex = 1,
                                Explanation = "Signposting consiste en emplear frases de transición (ej. 'Turning now to...', 'In conclusion...') que orientan la atención del oyente."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Qué conector formal es el más apropiado para expresar causa y consecuencia lógica en un reporte en inglés?",
                                Options = new[]
                                {
                                    "Consequently / As a result.",
                                    "Maybe / Perhaps.",
                                    "Never / Nowhere.",
                                    "Blue / Yellow."
                                },
                                CorrectIndex = 0,
                                Explanation = "'Consequently' y 'As a result' son conectores de causa-efecto formales indispensables en el ámbito ejecutivo."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál es la despedida formal más recomendada para cerrar una carta de postulación o correo comercial en inglés?",
                                Options = new[]
                                {
                                    "See ya later bro.",
                                    "Sincerely, / Best regards,",
                                    "Bye bye,",
                                    "Kiss and hug,"
                                },
                                CorrectIndex = 1,
                                Explanation = "'Sincerely' y 'Best regards' constituyen las fórmulas de cierre profesionales por excelencia en los negocios internacionales."
                            }
                        }
                    }
                },

                // =========================================================================
                // CURSO 9: ESTRATEGIAS DE NETWORKING, CRECIMIENTO Y LIDERAZGO EFECTIVO
                // =========================================================================
                new CourseSeedData
                {
                    CategorySlug = "empleabilidad-desarrollo-idiomas",
                    Title = "Estrategias de Networking, Crecimiento Profesional y Liderazgo Efectivo",
                    Slug = "networking-crecimiento-liderazgo",
                    ShortDescription = "Construye relaciones estratégicas duraderas, impulsa tu marca personal y desarrolla competencias de liderazgo situacional para guiar equipos de alto desempeño.",
                    Level = "Avanzado",
                    EstimatedHours = 16,
                    BadgeColor = "dark",
                    Modules = new List<ModuleSeedData>
                    {
                        new ModuleSeedData
                        {
                            Title = "Módulo 1: Principios del Networking Auténtico: Crear Valor Antes de Pedir Favores",
                            LessonTitle = "Guía Conceptual: De la Colección de Tarjetas al Capital Social Real",
                            Summary = "Descubre por qué el networking superficial fracasa y cómo cultivar una red de aliados estratégicos basada en la reciprocidad y la generosidad profesional.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. La Paradoja del Networking</h4>
<p>El error más recurrente de los profesionales es hacer 'networking' únicamente cuando se quedan sin empleo o necesitan vender desesperadamente. Ese comportamiento se percibe transaccional y genera rechazo. El networking de alto nivel se fundamenta en la <strong>ley de la reciprocidad</strong>: brindar valor desinteresado (compartir contactos, resolver dudas técnicas, recomendar lecturas) mucho antes de solicitar un favor.</p>

<div class=""card p-3 border-0 bg-light rounded-3 my-3"">
    <h6 class=""fw-bold text-dark mb-2""><i class=""bi bi-people-fill text-primary me-2""></i>Los 3 Niveles de la Red de Contactos:</h6>
    <ul class=""mb-0 small"">
        <li><strong>Lazos Fuertes (Strong Ties):</strong> Amigos cercanos y colegas íntimos de confianza. Excelente soporte emocional, pero suelen compartir la misma información y oportunidades.</li>
        <li><strong>Lazos Débiles (Weak Ties):</strong> Conocidos de la industria, excompañeros de cursos, personas que sigues en conferencias. Los sociólogos han demostrado que la gran mayoría de los ascensos laborales de alto nivel provienen de lazos débiles.</li>
        <li><strong>Superconectores:</strong> Personas clave que disfrutan conectar a profesionales de distintas disciplinas de manera natural.</li>
    </ul>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 2: Modelos de Liderazgo Situacional y Adaptabilidad de Equipos",
                            LessonTitle = "Presentación Técnica: El Modelo Hersey-Blanchard Aplicado",
                            Summary = "Aprende a adaptar tu estilo de liderazgo (Dirigir, Persuadir, Participar, Delegar) según la competencia técnica y compromiso de cada colaborador.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>El Modelo de Liderazgo Situacional</h4>
<p>No existe un único 'estilo de liderazgo perfecto'. Un líder maduro ajusta su comportamiento directivo y de apoyo en función de la etapa de madurez del colaborador en la tarea específica:</p>

<div class=""row g-3 my-3"">
    <div class=""col-md-6"">
        <div class=""card p-3 border-primary h-100"">
            <h6 class=""fw-bold text-primary"">E1 - Dirigir (Alta Dirección / Bajo Apoyo)</h6>
            <p class=""small text-muted mb-0"">Para colaboradores novatos con entusiasmo pero sin experiencia técnica. Requiere instrucciones precisas paso a paso y supervisión cercana.</p>
        </div>
    </div>
    <div class=""col-md-6"">
        <div class=""card p-3 border-success h-100"">
            <h6 class=""fw-bold text-success"">E4 - Delegar (Baja Dirección / Bajo Apoyo)</h6>
            <p class=""small text-muted mb-0"">Para colaboradores expertos y altamente motivados. Se les asigna el objetivo final y la autonomía total para ejecutarlo, reconociendo su maestría.</p>
        </div>
    </div>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 3: Delegación Inteligente y Retroalimentación Constructiva (Feedback SBI)",
                            LessonTitle = "Guía Operativa: Cómo Dar Retroalimentación sin Herir Susceptibilidades",
                            Summary = "Domina el marco SBI (Situación - Comportamiento - Impacto) para corregir desviaciones operativas manteniendo la motivación del equipo.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>El Marco SBI (Situation - Behavior - Impact)</h4>
<p>Decirle a un empleado: <em>'Siempre eres irresponsable con las entregas'</em> es un ataque a la identidad que solo genera defensividad y resentimiento. En su lugar, aplica el marco objetivo <strong>SBI</strong>:</p>

<div class=""table-responsive my-3"">
    <table class=""table table-bordered align-middle"">
        <thead class=""table-dark"">
            <tr><th>Fase SBI</th><th>Contenido</th><th>Ejemplo en Conversación</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong class=""text-primary"">Situación</strong></td>
                <td>Momento y lugar exacto del suceso.</td>
                <td><em>'El martes pasado durante la entrega del informe financiero mensual...'</em></td>
            </tr>
            <tr>
                <td><strong class=""text-warning"">Comportamiento</strong></td>
                <td>Acción observable comprobable (sin adjetivos).</td>
                <td><em>'...los cálculos de retención de IVA se entregaron dos horas después del cierre bancario...'</em></td>
            </tr>
            <tr>
                <td><strong class=""text-danger"">Impacto</strong></td>
                <td>Consecuencia real sufrida por el equipo o la empresa.</td>
                <td><em>'...lo que ocasionó un recargo administrativo por mora y estrés extra para tesorería.'</em></td>
            </tr>
        </tbody>
    </table>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 4: Gestión Constructiva y Resolución Positiva de Conflictos",
                            LessonTitle = "Guía de Mediación: Negociación Basada en Intereses (Modelo Harvard)",
                            Summary = "Aprende a desarticular roces entre departamentos separando a las personas del problema y negociando intereses subyacentes.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>Los 4 Pilares del Modelo Harvard de Negociación</h4>
<p>Ante una disputa interna entre áreas (ej. Ventas vs. Operaciones), la mediación directiva aplica cuatro principios:</p>
<ol>
    <li><strong>Separar a las personas del problema:</strong> Aborda la ineficiencia técnica sin convertir la conversación en un juicio personal.</li>
    <li><strong>Centrarse en intereses, no en posiciones:</strong> La posición es <em>'Quiero el presupuesto hoy'</em>; el interés subyacente es <em>'Temo no cumplir la meta de entrega con el cliente'</em>. Al descubrir el interés, surgen soluciones alternativas.</li>
    <li><strong>Generar opciones de beneficio mutuo:</strong> Crear alternativas donde ambas partes ganen antes de tomar decisiones unilaterales.</li>
    <li><strong>Insistir en criterios objetivos:</strong> Usar estándares verificables (datos históricos, costos reales, normas legales) para dirimir diferencias.</li>
</ol>"
                        }
                    },
                    Quiz = new QuizSeedData
                    {
                        Title = "Evaluación Sumativa: Estrategias de Networking y Liderazgo Efectivo",
                        Questions = new List<QuestionSeedData>
                        {
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cuál es el principio fundamental para construir una red de contactos (networking) sólida y duradera?",
                                Options = new[]
                                {
                                    "Contactar personas solo cuando te encuentres desempleado para pedirles trabajo urgente.",
                                    "Aportar valor, compartir conocimientos y ayudar a otros desinteresadamente antes de necesitar solicitar favores.",
                                    "Enviar mensajes masivos no solicitados de publicidad a desconocidos.",
                                    "Coleccionar tarjetas de presentación y no volver a hablar con nadie jamás."
                                },
                                CorrectIndex = 1,
                                Explanation = "El networking auténtico se sostiene sobre la reciprocidad y la generosidad profesional: construir relaciones genuinas antes de requerir ayuda."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "En el marco de retroalimentación SBI, ¿qué representa la letra 'B'?",
                                Options = new[]
                                {
                                    "Bonificación salarial.",
                                    "Comportamiento observable (Behavior), describiendo acciones objetivas sin emitir juicios de personalidad.",
                                    "Beneficio de inventario.",
                                    "Búsqueda de culpables."
                                },
                                CorrectIndex = 1,
                                Explanation = "La 'B' de SBI alude al Comportamiento (Behavior) observable, permitiendo dialogar sobre hechos medibles y no sobre ataques a la persona."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "Según el Modelo de Liderazgo Situacional, ¿qué estilo de liderazgo debe aplicarse con un colaborador con alta competencia y alta motivación?",
                                Options = new[]
                                {
                                    "Microgestión y vigilancia constante minuto a minuto.",
                                    "Delegar con autonomía, definiendo los objetivos estratégicos y confiando en su maestría operativa.",
                                    "Sancionarlo preventivamente.",
                                    "Ignorarlo por completo."
                                },
                                CorrectIndex = 1,
                                Explanation = "Colaboradores con alta madurez y dominio técnico responden óptimamente al estilo de 'Delegación', donde gozan de autonomía para cumplir los objetivos."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "De acuerdo con el Modelo Harvard de negociación, ¿cuál es la clave para resolver un conflicto entre dos áreas de trabajo?",
                                Options = new[]
                                {
                                    "Gritar más fuerte que la contraparte.",
                                    "Centrarse en los intereses reales subyacentes y no en las posiciones rígidas iniciales de cada uno.",
                                    "Imponer la solución por la fuerza sin escuchar a nadie.",
                                    "Renunciar a la empresa."
                                },
                                CorrectIndex = 1,
                                Explanation = "Identificar los intereses reales que motivan a las partes permite diseñar opciones de beneficio mutuo que desarticulan posiciones intransigentes."
                            }
                        }
                    }
                },

                // =========================================================================
                // CURSO 10: GESTIÓN DEL TIEMPO, PRODUCTIVIDAD Y PENSAMIENTO CRÍTICO
                // =========================================================================
                new CourseSeedData
                {
                    CategorySlug = "empleabilidad-desarrollo-idiomas",
                    Title = "Gestión del Tiempo, Productividad y Pensamiento Crítico para Profesionales",
                    Slug = "gestion-tiempo-productividad-pensamiento-critico",
                    ShortDescription = "Multiplica tu rendimiento profesional dominando la Matriz de Eisenhower, técnica Pomodoro, enfoque profundo (Deep Work) y resolución analítica de problemas.",
                    Level = "Intermedio",
                    EstimatedHours = 15,
                    BadgeColor = "secondary",
                    Modules = new List<ModuleSeedData>
                    {
                        new ModuleSeedData
                        {
                            Title = "Módulo 1: La Matriz de Eisenhower y el Principio de Pareto (Regla 80/20)",
                            LessonTitle = "Guía Estratégica: Priorización Sistemática y Discriminación de lo Urgente",
                            Summary = "Aprende a clasificar tareas en cuatro cuadrantes según su urgencia e importancia real para enfocarte en el cuadrante de alto impacto.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. La Trampa de la Urgencia</h4>
<p>La mayoría de los profesionales pasan sus jornadas 'apagando fuegos': atendiendo notificaciones inmediatas, llamadas no planificadas y correos con asuntos en mayúsculas. Al final del día, están agotados pero no han avanzado ni un centímetro en sus proyectos verdaderamente estratégicos.</p>

<div class=""table-responsive my-3"">
    <table class=""table table-bordered align-middle"">
        <thead class=""table-dark"">
            <tr><th>Cuadrante</th><th>Clasificación</th><th>Estrategia Operativa</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong class=""text-danger"">Cuadrante 1</strong></td>
                <td>Urgente e Importante</td>
                <td><strong>HACER DE INMEDIATO:</strong> Crisis reales, vencimientos de impuestos hoy, caída de servidores.</td>
            </tr>
            <tr>
                <td><strong class=""text-success"">Cuadrante 2</strong></td>
                <td>No Urgente pero Importante</td>
                <td><strong>PROGRAMAR EN AGENDA:</strong> Planificación, capacitación, prevención, innovación, networking. Es el cuadrante donde se construye el éxito profesional.</td>
            </tr>
            <tr>
                <td><strong class=""text-warning"">Cuadrante 3</strong></td>
                <td>Urgente pero No Importante</td>
                <td><strong>DELEGAR / AUTOMATIZAR:</strong> Interrupciones, reportes rutinarios que otros pueden hacer.</td>
            </tr>
            <tr>
                <td><strong class=""text-secondary"">Cuadrante 4</strong></td>
                <td>Ni Urgente Ni Importante</td>
                <td><strong>ELIMINAR:</strong> Scroll pasivo en redes sociales, tareas obsoletas que ya no generan valor.</td>
            </tr>
        </tbody>
    </table>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 2: Técnicas de Concentración Profunda (Deep Work) y Pomodoro",
                            LessonTitle = "Presentación Aplicada: Blindaje contra la Dispersión y el Multitasking",
                            Summary = "Domina bloques ininterrumpidos de trabajo cognitivo profundo (Deep Work), descansos estratégicos Pomodoro y control de la atención.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. El Mito Tóxico del 'Multitasking'</h4>
<p>La neurociencia moderna ha comprobado que el cerebro humano no procesa dos tareas complejas al mismo tiempo; lo que hace es <strong>cambio de contexto continuo (Context Switching)</strong>, con una penalización de hasta un 40% de pérdida de rendimiento y acumulación de fatiga mental.</p>

<div class=""row g-3 my-3"">
    <div class=""col-md-6"">
        <div class=""card p-3 border-primary h-100"">
            <h6 class=""fw-bold text-primary"">Técnica Pomodoro Estructurada</h6>
            <p class=""small text-muted mb-0"">25 minutos de enfoque absoluto en una sola tarea (cero celular, cero pestañas secundarias) seguidos de 5 minutos de descanso activo. Tras 4 ciclos, realiza una pausa de 20 minutos.</p>
        </div>
    </div>
    <div class=""col-md-6"">
        <div class=""card p-3 border-success h-100"">
            <h6 class=""fw-bold text-success"">Bloques de Tiempo (Time-Blocking)</h6>
            <p class=""small text-muted mb-0"">Reserva bloques de 90 a 120 minutos en tu Google Calendar matutino exclusivamente para trabajo profundo, antes de abrir el correo o responder mensajería instantánea.</p>
        </div>
    </div>
</div>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 3: Modelos Mentales y Marcos de Pensamiento Crítico en los Negocios",
                            LessonTitle = "Guía Intelectual: Razonamiento de Primeros Principios y Pensamiento de Segundo Orden",
                            Summary = "Aprende a descomponer problemas complejos en verdades fundamentales y a evaluar las consecuencias de segundo y tercer orden de tus decisiones.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Razonamiento por Primeros Principios</h4>
<p>Popularizado por físicos y grandes innovadores como Elon Musk, consiste en descomponer un problema hasta sus verdades fundamentales más básicas e incuestionables, construyendo una solución desde los cimientos en lugar de razonar por analogía (<em>'lo hacemos así porque siempre se ha hecho así'</em>).</p>

<h4>2. Pensamiento de Segundo Orden</h4>
<p>El pensamiento de primer orden se pregunta: <em>'¿Cuál es el beneficio inmediato de esta decisión?'</em>. El pensamiento de segundo orden va más allá y se pregunta: <em>'¿Y después qué ocurrirá en 6 meses? ¿Cuáles serán las consecuencias no deseadas de este cambio?'</em>. Esta visión previene errores costosos en políticas de precios y contrataciones.</p>"
                        },
                        new ModuleSeedData
                        {
                            Title = "Módulo 4: Construcción de Hábitos Sostenibles y Prevención del Burnout",
                            LessonTitle = "Guía de Bienestar Profesional: La Regla de los 2 Minutos y Recuperación Cognitiva",
                            Summary = "Aplica la regla de los dos minutos para vencer la procrastinación, establece límites firmes de desconexión y protege tu salud mental laboral.",
                            DurationMinutes = 25,
                            ContentHtml = @"<h4>1. Vencer la Procrastinación: La Regla de los 2 Minutos</h4>
<p>La inercia de comenzar es la fase más costosa de cualquier tarea. Aplica la regla: cuando una tarea te dé pereza, comprométete a trabajar en ella <strong>solo durante 2 minutos</strong>. Una vez vencida la fricción inicial, el cerebro tiende a continuar por el principio psicológico de cierre de tareas (Efecto Zeigarnik).</p>

<div class=""card p-3 border-warning bg-light rounded-3 my-3"">
    <h6 class=""fw-bold text-dark mb-1""><i class=""bi bi-shield-check text-warning me-1""></i> Prevención del Síndrome de Burnout (Agotamiento):</h6>
    <p class=""small text-muted mb-0"">El alto rendimiento profesional es una maratón de resistencia, no un sprint de 100 metros. Establece un ritual claro de cierre de jornada: guarda archivos, revisa la agenda del día siguiente y apaga las notificaciones laborales del teléfono móvil.</p>
</div>"
                        }
                    },
                    Quiz = new QuizSeedData
                    {
                        Title = "Evaluación Sumativa: Gestión del Tiempo y Pensamiento Crítico",
                        Questions = new List<QuestionSeedData>
                        {
                            new QuestionSeedData
                            {
                                QuestionText = "En la Matriz de Eisenhower, ¿qué acción estratégica corresponde a las tareas ubicadas en el Cuadrante 2 (Importantes pero No Urgentes)?",
                                Options = new[]
                                {
                                    "Ignorarlas para siempre.",
                                    "Programarlas intencionalmente en la agenda para garantizar su ejecución sin interrupciones.",
                                    "Hacerlas a la medianoche con cansancio.",
                                    "Delegarlas al primer transeúnte que pase."
                                },
                                CorrectIndex = 1,
                                Explanation = "El Cuadrante 2 contiene las tareas de mayor retorno a largo plazo (planificación, formación, estrategia), las cuales deben ser programadas proactivamente en agenda."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Qué efecto produce en la productividad el llamado 'multitasking' (multitarea simultánea)?",
                                Options = new[]
                                {
                                    "Multiplica la inteligencia por tres.",
                                    "Reduce el rendimiento hasta en un 40% debido a la pérdida de foco provocada por el cambio continuo de contexto mental.",
                                    "Es la única manera de terminar a tiempo todos los proyectos.",
                                    "No tiene ningún efecto demostrable."
                                },
                                CorrectIndex = 1,
                                Explanation = "El cerebro humano no procesa múltiples tareas analíticas a la vez, sino que alterna entre ellas perdiendo energía, concentración y cometiendo más errores."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿En qué consiste el 'Pensamiento de Segundo Orden' en la toma de decisiones profesionales?",
                                Options = new[]
                                {
                                    "Pensar dos veces antes de contestar el teléfono.",
                                    "Evaluar no solo los efectos inmediatos de una decisión, sino las consecuencias derivadas a mediano y largo plazo.",
                                    "Copiar exactamente lo que hace la competencia.",
                                    "Dejar que una moneda al aire decida."
                                },
                                CorrectIndex = 1,
                                Explanation = "El pensamiento de segundo orden analiza las consecuencias de las consecuencias, evitando soluciones inmediatas que creen crisis futuras peores."
                            },
                            new QuestionSeedData
                            {
                                QuestionText = "¿Cómo ayuda la 'Regla de los 2 Minutos' a combatir la procrastinación en tareas pesadas?",
                                Options = new[]
                                {
                                    "Trabajar únicamente 2 minutos al día y descansar las otras 23 horas y 58 minutos.",
                                    "Comprometerse a iniciar la tarea solo por 2 minutos para vencer la resistencia psicológica inicial de arranque.",
                                    "Escribir correos que tarden 2 minutos en enviarse.",
                                    "Poner una alarma cada 2 minutos en la oficina."
                                },
                                CorrectIndex = 1,
                                Explanation = "Reducir la barrera inicial a solo dos minutos vence la fricción mental de empezar, facilitando que el cerebro continúe concentrado una vez superada la inercia."
                            }
                        }
                    }
                }
            };
        }
    }
}
