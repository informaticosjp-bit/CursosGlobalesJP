using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace CursosCertificadosApp.Data
{
    public static class EnglishA1CurriculumSeeder
    {
        public static async Task UpdateEnglishA1CourseAsync(AppDbContext context)
        {
            var course = await context.Courses
                .Include(c => c.Modules)
                    .ThenInclude(m => m.Lessons)
                .FirstOrDefaultAsync(c => c.Slug == "ingles-a1-english-fundamentals" || c.Id == 13);

            if (course == null)
            {
                // Si no existe con ese slug, buscar por ID o crearlo en la categoría Ciberseguridad e Idiomas
                var cat = await context.Categories.FirstOrDefaultAsync(c => c.Slug == "ciberseguridad-e-idiomas") 
                       ?? await context.Categories.FirstOrDefaultAsync();

                if (cat == null) return;

                course = new Course
                {
                    CategoryId = cat.Id,
                    Title = "Inglés A1 / English Fundamentals",
                    Slug = "ingles-a1-english-fundamentals",
                    ShortDescription = "Programa completo de gramática, vocabulario y expresiones prácticas de nivel A1 basado en el temario estructurado de AulaFácil.",
                    FullDescription = "Curso completo de gramática y comunicación en inglés nivel principiante (A1) basado en el temario de AulaFácil. Incluye pronombres, verbo To Be, verbos auxiliares To Have y To Do, Present Simple, Present Continuous, Past Simple con verbos regulares e irregulares, futuros con Will y Going To, preposiciones de tiempo y lugar, pronombres demostrativos/posesivos y verbos modales.",
                    Level = "Básico",
                    EstimatedHours = 20,
                    PassingScore = 70.00m,
                    BadgeColor = "info",
                    IsPublished = true,
                    CreatedAt = DateTime.UtcNow
                };
                context.Courses.Add(course);
                await context.SaveChangesAsync();
            }
            else
            {
                course.Title = "Inglés A1 / English Fundamentals";
                course.ShortDescription = "Programa completo de gramática, vocabulario y expresiones prácticas de nivel A1 basado en el temario estructurado de AulaFácil.";
                course.FullDescription = "Curso completo de gramática y comunicación en inglés nivel principiante (A1) basado en el temario de AulaFácil. Incluye pronombres, verbo To Be, verbos auxiliares To Have y To Do, Present Simple, Present Continuous, Past Simple con verbos regulares e irregulares, futuros con Will y Going To, preposiciones de tiempo y lugar, pronombres demostrativos/posesivos y verbos modales.";
                course.Level = "Básico";
                course.EstimatedHours = 20;
                course.IsPublished = true;
            }

            // Datos de los 10 Módulos de AulaFácil
            var modulesData = GetAulaFacilA1Modules();

            var existingMods = await context.CourseModules
                .Include(m => m.Lessons)
                .Where(m => m.CourseId == course.Id)
                .OrderBy(m => m.OrderIndex)
                .ToListAsync();

            // Ajustar o crear módulos
            for (int i = 0; i < modulesData.Count; i++)
            {
                var modInfo = modulesData[i];
                CourseModule targetMod;

                if (i < existingMods.Count)
                {
                    targetMod = existingMods[i];
                    targetMod.Title = modInfo.Title;
                    targetMod.OrderIndex = i + 1;
                }
                else
                {
                    targetMod = new CourseModule
                    {
                        CourseId = course.Id,
                        Title = modInfo.Title,
                        OrderIndex = i + 1
                    };
                    context.CourseModules.Add(targetMod);
                    await context.SaveChangesAsync();
                }

                var targetLesson = targetMod.Lessons.FirstOrDefault();
                if (targetLesson != null)
                {
                    targetLesson.Title = modInfo.LessonTitle;
                    targetLesson.ContentType = "Reading";
                    targetLesson.ContentHtml = modInfo.ContentHtml;
                    targetLesson.Summary = modInfo.Summary;
                    targetLesson.DurationMinutes = 25;
                    targetLesson.OrderIndex = 1;
                    targetLesson.IsMandatory = true;
                }
                else
                {
                    var newLesson = new Lesson
                    {
                        ModuleId = targetMod.Id,
                        Title = modInfo.LessonTitle,
                        ContentType = "Reading",
                        ContentHtml = modInfo.ContentHtml,
                        Summary = modInfo.Summary,
                        DurationMinutes = 25,
                        OrderIndex = 1,
                        IsMandatory = true
                    };
                    context.Lessons.Add(newLesson);
                }
            }
            await context.SaveChangesAsync();

            // Sincronizar o recrear el Quiz sumativo final
            var existingQuiz = await context.Quizzes
                .Include(q => q.Questions).ThenInclude(qu => qu.Options)
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
                    Title = "Evaluación Sumativa: Inglés A1 (Curso Completo)",
                    Description = "Evaluación integral de gramática, tiempos verbales y vocabulario de nivel A1 basado en el temario de AulaFácil. Calificación mínima aprobatoria: 70%.",
                    PassingPercentage = 70.00m,
                    TimeLimitMinutes = 25
                };
                context.Quizzes.Add(existingQuiz);
                await context.SaveChangesAsync();
            }

            existingQuiz.Title = "Evaluación Sumativa: Inglés A1 (Curso Completo)";
            existingQuiz.Description = "Evaluación integral de gramática, tiempos verbales y vocabulario de nivel A1 basado en el temario de AulaFácil. Calificación mínima aprobatoria: 70%.";

            var quizQuestions = GetAulaFacilA1Quiz();
            int qIndex = 1;
            foreach (var qData in quizQuestions)
            {
                var question = new QuizQuestion
                {
                    QuizId = existingQuiz.Id,
                    QuestionText = qData.QuestionText,
                    Explanation = qData.Explanation,
                    OrderIndex = qIndex
                };
                context.QuizQuestions.Add(question);
                await context.SaveChangesAsync();

                for (int optIdx = 0; optIdx < qData.Options.Length; optIdx++)
                {
                    var option = new QuizOption
                    {
                        QuestionId = question.Id,
                        OptionText = qData.Options[optIdx],
                        IsCorrect = (optIdx == qData.CorrectIndex)
                    };
                    context.QuizOptions.Add(option);
                }
                await context.SaveChangesAsync();
                qIndex++;
            }
        }

        private class ModuleDef
        {
            public string Title { get; set; } = string.Empty;
            public string LessonTitle { get; set; } = string.Empty;
            public string Summary { get; set; } = string.Empty;
            public string ContentHtml { get; set; } = string.Empty;
        }

        private class QuizQuestionDef
        {
            public string QuestionText { get; set; } = string.Empty;
            public string[] Options { get; set; } = Array.Empty<string>();
            public int CorrectIndex { get; set; }
            public string Explanation { get; set; } = string.Empty;
        }

        private static List<ModuleDef> GetAulaFacilA1Modules()
        {
            return new List<ModuleDef>
            {
                // =========================================================================
                // MÓDULO 1: PRONOMBRES PERSONALES SUJETOS Y VERBO "TO BE"
                // =========================================================================
                new ModuleDef
                {
                    Title = "Módulo 1: Pronombres Personales Sujetos y el Verbo \"To Be\" (Ser o Estar)",
                    LessonTitle = "Guía Gramatical y Fonética: Sujetos, Formas Afirmativas, Negativas y Contracciones",
                    Summary = "Domina los pronombres personales (I, you, he, she, it, we, they) y las conjugaciones completas del verbo To Be con contracciones y respuestas cortas.",
                    ContentHtml = @"<h4>1. Pronombres Personales Sujetos (Personal Subject Pronouns)</h4>
<p>En inglés, a diferencia del español, <strong>el sujeto siempre debe escribirse o pronunciarse</strong> (no existe el sujeto tácito u omitido). La única excepción es el modo imperativo (órdenes directas como <em>'Listen!'</em>).</p>

<div class=""table-responsive my-3"">
    <table class=""table table-bordered table-striped align-middle"">
        <thead class=""table-dark"">
            <tr><th>Pronombre</th><th>Traducción al Español</th><th>Notas de Uso y Pronunciación</th></tr>
        </thead>
        <tbody>
            <tr><td><strong>I</strong></td><td>Yo</td><td>Siempre se escribe con mayúscula, sin importar su posición en la frase.</td></tr>
            <tr><td><strong>You</strong></td><td>Tú / Usted</td><td>Se emplea tanto para el trato informal como formal en singular.</td></tr>
            <tr><td><strong>He</strong></td><td>Él</td><td>Para personas masculinas singulares.</td></tr>
            <tr><td><strong>She</strong></td><td>Ella</td><td>Para personas femeninas singulares.</td></tr>
            <tr><td><strong>It</strong></td><td>Ello / Eso / Animal o Cosa</td><td>Para objetos inanimados, lugares, ideas o animales cuyo sexo se desconoce.</td></tr>
            <tr><td><strong>We</strong></td><td>Nosotros / Nosotras</td><td>Primera persona del plural.</td></tr>
            <tr><td><strong>You</strong></td><td>Vosotros / Ustedes</td><td>Segunda persona del plural (idéntico al singular).</td></tr>
            <tr><td><strong>They</strong></td><td>Ellos / Ellas</td><td>Tercera persona del plural para personas, animales o cosas.</td></tr>
        </tbody>
    </table>
</div>

<h4>2. El Verbo ""To Be"" (Ser / Estar)</h4>
<p>El verbo <em>To Be</em> es el pilar fundamental del idioma. Posee 3 formas distintas en presente simple: <strong>am</strong>, <strong>is</strong>, <strong>are</strong>.</p>

<div class=""row g-3 my-3"">
    <div class=""col-md-4"">
        <div class=""card h-100 p-3 border-primary"">
            <h6 class=""fw-bold text-primary"">Forma Afirmativa y Contracciones</h6>
            <ul class=""small mb-0 list-unstyled"">
                <li>I am &rarr; <strong>I'm</strong> (Yo soy / estoy)</li>
                <li>You are &rarr; <strong>You're</strong></li>
                <li>He is &rarr; <strong>He's</strong></li>
                <li>She is &rarr; <strong>She's</strong></li>
                <li>It is &rarr; <strong>It's</strong></li>
                <li>We are &rarr; <strong>We're</strong></li>
                <li>They are &rarr; <strong>They're</strong></li>
            </ul>
        </div>
    </div>
    <div class=""col-md-4"">
        <div class=""card h-100 p-3 border-danger"">
            <h6 class=""fw-bold text-danger"">Forma Negativa</h6>
            <ul class=""small mb-0 list-unstyled"">
                <li>I am not &rarr; <strong>I'm not</strong></li>
                <li>You are not &rarr; <strong>You aren't</strong></li>
                <li>He is not &rarr; <strong>He isn't</strong></li>
                <li>She is not &rarr; <strong>She isn't</strong></li>
                <li>It is not &rarr; <strong>It isn't</strong></li>
                <li>We are not &rarr; <strong>We aren't</strong></li>
                <li>They are not &rarr; <strong>They aren't</strong></li>
            </ul>
        </div>
    </div>
    <div class=""col-md-4"">
        <div class=""card h-100 p-3 border-success"">
            <h6 class=""fw-bold text-success"">Forma Interrogativa (Inversión)</h6>
            <ul class=""small mb-0 list-unstyled"">
                <li><strong>Am I</strong> late?</li>
                <li><strong>Are you</strong> a student?</li>
                <li><strong>Is he</strong> ready?</li>
                <li><strong>Is she</strong> at home?</li>
                <li><strong>Is it</strong> cold?</li>
                <li><strong>Are we</strong> ready?</li>
                <li><strong>Are they</strong> coming?</li>
            </ul>
        </div>
    </div>
</div>

<div class=""alert alert-info border-0 p-3 rounded-3 my-3"">
    <h6 class=""fw-bold mb-1""><i class=""bi bi-check2-circle text-success me-1""></i> Respuestas Cortas (Short Answers):</h6>
    <p class=""small mb-0"">A la pregunta <em>'Are you Spanish?'</em> se responde afirmativamente: <strong>'Yes, I am'</strong> (¡nunca en forma contraída 'Yes, I'm'!). En negativo sí se contrae: <strong>'No, I'm not'</strong> o <strong>'No, he isn't'</strong>.</p>
</div>"
                },

                // =========================================================================
                // MÓDULO 2: VERBOS AUXILIARES TO HAVE Y TO DO
                // =========================================================================
                new ModuleDef
                {
                    Title = "Módulo 2: Los Verbos Clave \"To Have\" (Tener/Haber) y \"To Do\" (Hacer/Auxiliar)",
                    LessonTitle = "Guía de Auxiliares: Usos como Verbo Principal y como Operador Auxiliar",
                    Summary = "Aprende la conjugación de Have/Has, la estructura Have Got, y el papel imprescindible de Do/Does como operador auxiliar de preguntas y negaciones.",
                    ContentHtml = @"<h4>1. El Verbo ""To Have"" (Tener / Haber)</h4>
<p>El verbo <em>To Have</em> indica posesión en presente y se conjuga con dos formas: <strong>have</strong> y <strong>has</strong> (para la 3ª persona del singular: He, She, It).</p>

<div class=""table-responsive my-3"">
    <table class=""table table-bordered align-middle"">
        <thead class=""table-dark"">
            <tr><th>Sujeto</th><th>Afirmativa Estándar</th><th>Con 'Have Got' (UK)</th><th>Negativa Estándar</th></tr>
        </thead>
        <tbody>
            <tr><td>I / You / We / They</td><td><strong>have</strong> a car</td><td>have got a car</td><td>don't have a car</td></tr>
            <tr><td>He / She / It</td><td><strong>has</strong> a passport</td><td>has got a passport</td><td>doesn't have a passport</td></tr>
        </tbody>
    </table>
</div>

<h4>2. El Verbo ""To Do"" (Hacer y Operador Auxiliar)</h4>
<p>El verbo <em>To Do</em> tiene una doble naturaleza en inglés:</p>
<ol>
    <li><strong>Como Verbo Principal de Acción:</strong> Significa 'hacer' (actividades, tareas intelectuales o rutinas):
        <ul>
            <li><em>I do my homework every evening.</em> (Hago mi tarea todas las tardes).</li>
            <li><em>She does exercise at the gym.</em> (Ella hace ejercicio en el gimnasio).</li>
        </ul>
    </li>
    <li><strong>Como Verbo Auxiliar de Preguntas y Negaciones:</strong> No tiene traducción literal en español; sirve como herramienta sintáctica para formular oraciones negativas e interrogativas en Present Simple:
        <ul>
            <li><strong>Pregunta:</strong> <em><strong>Do</strong> you speak English?</em> / <em><strong>Does</strong> he live in Madrid?</em></li>
            <li><strong>Negación:</strong> <em>They <strong>do not (don't)</strong> work today.</em> / <em>She <strong>does not (doesn't)</strong> like coffee.</em></li>
        </ul>
    </li>
</ol>

<div class=""alert alert-warning border-0 p-3 rounded-3"">
    <strong><i class=""bi bi-exclamation-triangle-fill text-danger me-1""></i> Regla de Oro:</strong> Cuando usas el auxiliar <em>Does</em> o <em>Doesn't</em>, el verbo principal <strong>vuelve a su forma base (infinitivo sin to)</strong>. Es incorrecto decir <em>'Does he works?'</em>; lo correcto es <em>'Does he work?'</em>.
</div>"
                },

                // =========================================================================
                // MÓDULO 3: ESTRUCTURA DE LA ORACIÓN Y ARTÍCULOS (A, AN, THE)
                // =========================================================================
                new ModuleDef
                {
                    Title = "Módulo 3: La Estructura de la Oración en Inglés y los Artículos (A, An, The)",
                    LessonTitle = "Sintaxis Fundamental: Orden SVO, Adjetivos y Reglas de Determinantes",
                    Summary = "Domina el orden inmutable Sujeto-Verbo-Objeto, la posición del adjetivo antes del nombre y el uso correcto de A, An, The y el Artículo Cero.",
                    ContentHtml = @"<h4>1. Estructura Sintáctica Básica: Orden S-V-O</h4>
<p>A diferencia del español, donde el orden de las palabras es muy libre, en inglés el orden de las oraciones afirmativas es estricto y sistemático:</p>

<div class=""card p-3 bg-light border-primary rounded-3 my-3"">
    <div class=""row text-center fw-bold text-dark"">
        <div class=""col-md-3""><span class=""badge bg-primary px-3 py-2"">SUJETO (S)</span><br><span class=""small text-muted"">Peter</span></div>
        <div class=""col-md-3""><span class=""badge bg-success px-3 py-2"">VERBO (V)</span><br><span class=""small text-muted"">plays</span></div>
        <div class=""col-md-3""><span class=""badge bg-warning text-dark px-3 py-2"">OBJETO (O)</span><br><span class=""small text-muted"">the guitar</span></div>
        <div class=""col-md-3""><span class=""badge bg-secondary px-3 py-2"">COMPLEMENTO</span><br><span class=""small text-muted"">every day</span></div>
    </div>
</div>

<h4>2. La Posición Ineludible del Adjetivo</h4>
<p>En inglés, los adjetivos <strong>siempre se colocan ANTES del sustantivo</strong> al que califican, y <strong>nunca llevan plural</strong>:</p>
<ul>
    <li>Correcto: <em>A <strong>new car</strong></em> / <em>Two <strong>new cars</strong></em> (¡nunca <em>two news cars</em> ni <em>a car new</em>!).</li>
    <li>Correcto: <em>She has <strong>blue eyes</strong></em>.</li>
</ul>

<h4>3. Artículos Indeterminados (A / An) vs. Determinado (The)</h4>
<div class=""table-responsive my-3"">
    <table class=""table table-bordered align-middle"">
        <thead class=""table-dark"">
            <tr><th>Artículo</th><th>Regla de Aplicación Fonética</th><th>Ejemplos Correctos</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>A</strong></td>
                <td>Delante de palabras que comienzan con <strong>sonido consonántico</strong>.</td>
                <td><em>a book, a car, a house, a university</em> (la 'u' suena /ju:/, sonido consonántico).</td>
            </tr>
            <tr>
                <td><strong>AN</strong></td>
                <td>Delante de palabras que comienzan con <strong>sonido vocálico</strong>.</td>
                <td><em>an apple, an elephant, an orange, an hour</em> (la 'h' es muda).</td>
            </tr>
            <tr>
                <td><strong>THE</strong></td>
                <td>El, la, los, las (para sustantivos específicos y conocidos por el oyente).</td>
                <td><em>The sun, the teacher of English, the keys on the table.</em></td>
            </tr>
            <tr>
                <td><strong>Zero Article (&Oslash;)</strong></td>
                <td>NO se usa artículo cuando se habla de cosas o personas en sentido general.</td>
                <td><em><strong>Cats</strong> are independent animals</em> (Hablando de los gatos en general).</td>
            </tr>
        </tbody>
    </table>
</div>"
                },

                // =========================================================================
                // MÓDULO 4: PRESENT SIMPLE Y ADVERBIOS DE FRECUENCIA
                // =========================================================================
                new ModuleDef
                {
                    Title = "Módulo 4: Present Simple (El Presente del Indicativo) y Adverbios de Frecuencia",
                    LessonTitle = "Guía de Rutinas: Formación, Reglas de la 3ª Persona y Preguntas con Do/Does",
                    Summary = "Aprende a formular oraciones afirmativas, negativas e interrogativas en Present Simple, las reglas ortográficas de -s/-es y la ubicación de adverbios de frecuencia.",
                    ContentHtml = @"<h4>1. Usos del Present Simple</h4>
<p>El <strong>Present Simple</strong> se utiliza para describir hábitos, rutinas diarias, horarios establecidos y hechos que son verdades permanentes:</p>
<ul>
    <li><em>The Earth revolves around the Sun.</em> (Verdad científica permanente).</li>
    <li><em>I drink coffee every morning at 7:00 AM.</em> (Hábito o rutina).</li>
</ul>

<h4>2. Reglas Ortográficas de la 3ª Persona Singular (He, She, It)</h4>
<p>En oraciones afirmativas, los verbos añaden una terminación al conjugarse con <em>He, She o It</em>:</p>
<ul>
    <li><strong>Regla General:</strong> Añadir <code>-s</code> &rarr; <em>work &rarr; works</em>, <em>speak &rarr; speaks</em>, <em>live &rarr; lives</em>.</li>
    <li><strong>Verbos terminados en -o, -sh, -ch, -ss, -x:</strong> Añadir <code>-es</code> &rarr; <em>go &rarr; goes</em>, <em>watch &rarr; watches</em>, <em>wash &rarr; washes</em>, <em>kiss &rarr; kisses</em>, <em>fix &rarr; fixes</em>.</li>
    <li><strong>Consonante + -y:</strong> Cambia la 'y' por <code>-ies</code> &rarr; <em>study &rarr; studies</em>, <em>fly &rarr; flies</em>. (Pero si precede vocal: <em>play &rarr; plays</em>).</li>
</ul>

<h4>3. Negación e Interrogación con Do y Does</h4>
<div class=""table-responsive my-3"">
    <table class=""table table-bordered align-middle"">
        <thead class=""table-dark"">
            <tr><th>Tipo</th><th>Estructura</th><th>Ejemplo</th></tr>
        </thead>
        <tbody>
            <tr><td><strong>Afirmativa</strong></td><td>Sujeto + Verbo (+s/es)</td><td><em>She works in an office.</em></td></tr>
            <tr><td><strong>Negativa</strong></td><td>Sujeto + <strong>don't / doesn't</strong> + Verbo base</td><td><em>She <strong>doesn't work</strong> on Saturdays.</em></td></tr>
            <tr><td><strong>Pregunta</strong></td><td><strong>Do / Does</strong> + Sujeto + Verbo base?</td><td><em><strong>Does</strong> she work here? &mdash; Yes, she does.</em></td></tr>
        </tbody>
    </table>
</div>

<h4>4. Adverbios de Frecuencia (Adverbs of Frequency)</h4>
<p>Indican con qué regularidad se produce una acción: <em>Always (100%), Usually (80%), Often (60%), Sometimes (40%), Rarely/Seldom (10%), Never (0%)</em>.</p>
<div class=""alert alert-info border-0 p-3 rounded-3"">
    <strong>Posición del Adverbio:</strong> Se ubica <strong>ANTES del verbo principal</strong> (<em>I <strong>always drink</strong> tea</em>), pero <strong>DESPUÉS del verbo To Be</strong> (<em>He is <strong>always</strong> punctual</em>).
</div>"
                },

                // =========================================================================
                // MÓDULO 5: PRESENT CONTINUOUS VS. PRESENT SIMPLE
                // =========================================================================
                new ModuleDef
                {
                    Title = "Módulo 5: Present Continuous (El Presente Continuo) vs. Present Simple",
                    LessonTitle = "Acciones en Progreso: Estructura Be + -ing, Reglas del Gerundio y Verbos Estativos",
                    Summary = "Domina el Present Continuous para acciones que ocurren en el momento de hablar y aprende a diferenciarlo claramente del Present Simple habitual.",
                    ContentHtml = @"<h4>1. Formación del Present Continuous</h4>
<p>El <strong>Present Continuous</strong> se utiliza para describir acciones que están ocurriendo <strong>exactamente en el momento en que se habla</strong> o situaciones temporales actuales:</p>

<div class=""card p-3 border-success bg-light rounded-3 my-3"">
    <h6 class=""fw-bold text-success mb-2"">Fórmula Matemática de Estructura:</h6>
    <p class=""fs-5 mb-1""><strong>SUJETO + VERBO TO BE (am / is / are) + VERBO-ING</strong></p>
    <ul class=""small mb-0 mt-2"">
        <li><strong>Afirmativa:</strong> <em>I am studying English right now.</em> / <em>They are working in the garden.</em></li>
        <li><strong>Negativa:</strong> <em>She is not (isn't) listening to music.</em></li>
        <li><strong>Interrogativa:</strong> <em>Are you watching television? &mdash; Yes, I am / No, I'm not.</em></li>
    </ul>
</div>

<h4>2. Reglas de Ortografía para Añadir -ing</h4>
<ul>
    <li><strong>Regla general:</strong> <em>read &rarr; reading</em>, <em>talk &rarr; talking</em>.</li>
    <li><strong>Terminados en -e muda:</strong> Se elimina la 'e' &rarr; <em>write &rarr; writing</em>, <em>make &rarr; making</em>.</li>
    <li><strong>Monosílabos con Consonante + Vocal + Consonante (CVC):</strong> Se duplica la consonante final &rarr; <em>run &rarr; running</em>, <em>swim &rarr; swimming</em>, <em>sit &rarr; sitting</em>.</li>
</ul>

<h4>3. La Gran Diferencia: Present Simple vs. Present Continuous</h4>
<div class=""table-responsive my-3"">
    <table class=""table table-bordered align-middle"">
        <thead class=""table-dark"">
            <tr><th>Tiempo Verbal</th><th>Cuándo Usarlo</th><th>Palabras Clave Típicas</th><th>Ejemplo Demostrativo</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>Present Simple</strong></td>
                <td>Hábitos, rutinas, hechos generales.</td>
                <td><em>every day, on Mondays, always, never</em></td>
                <td><em>I usually <strong>walk</strong> to work.</em> (Hábito cotidiano).</td>
            </tr>
            <tr>
                <td><strong>Present Continuous</strong></td>
                <td>Acción sucediendo ahora mismo o temporalmente.</td>
                <td><em>now, right now, at the moment, today</em></td>
                <td><em>Today it is raining, so I <strong>am taking</strong> a taxi.</em> (Acción en progreso hoy).</td>
            </tr>
        </tbody>
    </table>
</div>"
                },

                // =========================================================================
                // MÓDULO 6: PAST SIMPLE (VERBOS REGULARES E IRREGULARES)
                // =========================================================================
                new ModuleDef
                {
                    Title = "Módulo 6: Past Simple (El Pasado Simple): Verbos Regulares e Irregulares",
                    LessonTitle = "Guía del Pasado: Terminación -ed, Fonética (/t/, /d/, /id/), Verbos Irregulares y Auxiliar Did",
                    Summary = "Aprende a narrar sucesos concluidos en el pasado, la pronunciación correcta de -ed, los 20 verbos irregulares más comunes y el uso de Did/Didn't.",
                    ContentHtml = @"<h4>1. Verbos Regulares en Past Simple (-ed)</h4>
<p>Los verbos regulares forman el pasado simple añadiendo la terminación <code>-ed</code> a su forma base:</p>
<ul>
    <li><em>play &rarr; played</em>, <em>clean &rarr; cleaned</em>, <em>watch &rarr; watched</em>.</li>
    <li>Terminados en '-e': solo añaden '-d' &rarr; <em>live &rarr; lived</em>, <em>dance &rarr; danced</em>.</li>
    <li>Terminados en consonante + '-y': cambian a '-ied' &rarr; <em>study &rarr; studied</em>.</li>
    <li>Consonante-Vocal-Consonante monosílabo: doblan la consonante &rarr; <em>stop &rarr; stopped</em>.</li>
</ul>

<h4>2. Pronunciación Fonética de la Terminación -ed</h4>
<div class=""row g-3 my-3"">
    <div class=""col-md-4"">
        <div class=""card p-3 border-primary h-100"">
            <h6 class=""fw-bold text-primary"">Sonido /id/ (Extra Sílaba)</h6>
            <p class=""small text-muted mb-0"">Únicamente cuando el verbo termina en sonido <strong>/t/</strong> o <strong>/d/</strong>:<br><em>wanted, needed, invited, decided</em>.</p>
        </div>
    </div>
    <div class=""col-md-4"">
        <div class=""card p-3 border-success h-100"">
            <h6 class=""fw-bold text-success"">Sonido /t/ (Sordo)</h6>
            <p class=""small text-muted mb-0"">Tras consonantes sordas (/p/, /k/, /s/, /sh/, /ch/, /f/):<br><em>worked (/t/), watched (/t/), stopped (/t/), laughed (/t/)</em>.</p>
        </div>
    </div>
    <div class=""col-md-4"">
        <div class=""card p-3 border-warning h-100"">
            <h6 class=""fw-bold text-warning"">Sonido /d/ (Sonoro)</h6>
            <p class=""small text-muted mb-0"">Tras vocales y consonantes sonoras (/b/, /g/, /v/, /l/, /m/, /n/, /r/):<br><em>played (/d/), cleaned (/d/), lived (/d/)</em>.</p>
        </div>
    </div>
</div>

<h4>3. Verbos Irregulares Principales de Nivel A1</h4>
<p>Los verbos irregulares no siguen la regla de '-ed' y deben memorizarse. Los 10 más habituales:</p>
<div class=""table-responsive my-3"">
    <table class=""table table-bordered table-striped align-middle"">
        <thead class=""table-dark"">
            <tr><th>Infinitivo</th><th>Past Simple</th><th>Traducción</th><th>Ejemplo en Frase</th></tr>
        </thead>
        <tbody>
            <tr><td><strong>be</strong></td><td>was / were</td><td>ser / estar</td><td><em>I was at home yesterday. / They were happy.</em></td></tr>
            <tr><td><strong>have</strong></td><td>had</td><td>tener</td><td><em>We had breakfast at 8:00 AM.</em></td></tr>
            <tr><td><strong>do</strong></td><td>did</td><td>hacer</td><td><em>He did a great job.</em></td></tr>
            <tr><td><strong>go</strong></td><td>went</td><td>ir</td><td><em>She went to London last summer.</em></td></tr>
            <tr><td><strong>see</strong></td><td>saw</td><td>ver</td><td><em>I saw Peter at the supermarket.</em></td></tr>
            <tr><td><strong>buy</strong></td><td>bought</td><td>comprar</td><td><em>They bought a new house.</em></td></tr>
            <tr><td><strong>come</strong></td><td>came</td><td>venir</td><td><em>He came to the party.</em></td></tr>
            <tr><td><strong>make</strong></td><td>made</td><td>fabricar / hacer</td><td><em>She made a delicious cake.</em></td></tr>
        </tbody>
    </table>
</div>

<h4>4. Negaciones y Preguntas en Pasado: Auxiliar DID</h4>
<p>Tanto para verbos regulares como irregulares, se emplea el auxiliar <strong>DID</strong> en preguntas y <strong>DIDN'T</strong> en negaciones, volviendo el verbo a su forma infinitivo base:</p>
<ul>
    <li>Afirmativa: <em>She <strong>went</strong> to the store.</em></li>
    <li>Negativa: <em>She <strong>didn't go</strong> to the store.</em> (¡No 'didn't went'!).</li>
    <li>Pregunta: <em><strong>Did</strong> you <strong>see</strong> the email? &mdash; Yes, I did / No, I didn't.</em></li>
</ul>"
                },

                // =========================================================================
                // MÓDULO 7: FORMAS DE FUTURO (WILL VS. BE GOING TO)
                // =========================================================================
                new ModuleDef
                {
                    Title = "Módulo 7: Las Formas de Futuro: Future Simple (\"Will\") vs. \"Be Going To\"",
                    LessonTitle = "Expresión del Futuro: Decisiones Espontáneas, Promesas, Planes e Intenciones",
                    Summary = "Aprende a expresar el futuro en inglés distinguiendo con claridad cuándo usar Will (decisiones espontáneas) y cuándo Be Going To (planes premeditados).",
                    ContentHtml = @"<h4>1. Future Simple con el Auxiliar ""Will""</h4>
<p>El modal <strong>Will</strong> (negación <strong>Won't</strong>) se utiliza con la forma base del verbo para todos los pronombres (<em>I will, you will, he will...</em>):</p>
<ul>
    <li><strong>Decisiones Espontáneas:</strong> Tomadas en el instante exacto de hablar: <em>'The phone is ringing. I will (I'll) answer it.'</em></li>
    <li><strong>Promesas y Ofrecimientos:</strong> <em>'I will always help you, I promise.'</em></li>
    <li><strong>Predicciones Subjetivas u Opiniones:</strong> <em>'I think technology will change education.'</em></li>
</ul>

<h4>2. Estructura de Futuro con ""Be Going To""</h4>
<p>Se construye con el verbo To Be + <strong>going to</strong> + verbo base:</p>
<ul>
    <li><strong>Planes e Intenciones Premeditadas:</strong> Decisiones ya tomadas antes del momento de hablar: <em>'I am going to study English at university next year.'</em></li>
    <li><strong>Predicciones con Evidencia Visible Inmediata:</strong> Basadas en hechos que estás viendo ahora mismo: <em>'Look at those dark clouds! It is going to rain.'</em></li>
</ul>

<div class=""table-responsive my-3"">
    <table class=""table table-bordered align-middle"">
        <thead class=""table-dark"">
            <tr><th>Estructura</th><th>Propósito Principal</th><th>Ejemplo Práctico</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>WILL</strong></td>
                <td>Decisión espontánea / Promesa.</td>
                <td><em>'I'm cold. I will close the window.'</em></td>
            </tr>
            <tr>
                <td><strong>BE GOING TO</strong></td>
                <td>Plan premeditado / Evidencia clara.</td>
                <td><em>'We are going to visit our grandparents this weekend.'</em></td>
            </tr>
        </tbody>
    </table>
</div>"
                },

                // =========================================================================
                // MÓDULO 8: SUSTANTIVOS, ADJETIVOS, POSESIVOS Y DEMOSTRATIVOS
                // =========================================================================
                new ModuleDef
                {
                    Title = "Módulo 8: Sustantivos, Adjetivos, Pronombres Posesivos y Demostrativos",
                    LessonTitle = "Guía de Determinantes: Plurales Irregulares, This/That/These/Those y Pronombres Objeto",
                    Summary = "Domina los plurales irregulares en inglés, los adjetivos demostrativos de cercanía/lejanía, adjetivos vs. pronombres posesivos y los pronombres objeto.",
                    ContentHtml = @"<h4>1. Sustantivos: Plurales Regulares e Irregulares</h4>
<p>La mayoría de los sustantivos forman el plural añadiendo <code>-s</code> o <code>-es</code> (<em>book &rarr; books, bus &rarr; buses</em>). Sin embargo, en nivel A1 debes dominar los <strong>plurales irregulares</strong> más habituales:</p>
<ul>
    <li><em>child &rarr; children</em> (niño / niños)</li>
    <li><em>person &rarr; people</em> (persona / personas o gente)</li>
    <li><em>man &rarr; men</em> (hombre / hombres)</li>
    <li><em>woman &rarr; women</em> (mujer / mujeres)</li>
    <li><em>tooth &rarr; teeth</em> (diente / dientes)</li>
    <li><em>foot &rarr; feet</em> (pie / pies)</li>
</ul>

<h4>2. Adjetivos y Pronombres Demostrativos</h4>
<div class=""table-responsive my-3"">
    <table class=""table table-bordered text-center align-middle"">
        <thead class=""table-dark"">
            <tr><th>Distancia</th><th>Singular</th><th>Plural</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>Cerca (Aquí)</strong></td>
                <td><strong>This</strong> (Este / Esta)<br><span class=""small text-muted"">This book here</span></td>
                <td><strong>These</strong> (Estos / Estas)<br><span class=""small text-muted"">These books here</span></td>
            </tr>
            <tr>
                <td><strong>Lejos (Allí)</strong></td>
                <td><strong>That</strong> (Ese / Aquel)<br><span class=""small text-muted"">That car over there</span></td>
                <td><strong>Those</strong> (Esos / Aquellos)<br><span class=""small text-muted"">Those cars over there</span></td>
            </tr>
        </tbody>
    </table>
</div>

<h4>3. Posesivos: Adjetivos vs. Pronombres</h4>
<div class=""table-responsive my-3"">
    <table class=""table table-bordered align-middle"">
        <thead class=""table-dark"">
            <tr><th>Sujeto</th><th>Adjetivo Posesivo (Acompaña nombre)</th><th>Pronombre Posesivo (Reemplaza nombre)</th></tr>
        </thead>
        <tbody>
            <tr><td>I</td><td>This is <strong>my</strong> car.</td><td>This car is <strong>mine</strong>.</td></tr>
            <tr><td>You</td><td>This is <strong>your</strong> passport.</td><td>This passport is <strong>yours</strong>.</td></tr>
            <tr><td>He</td><td>This is <strong>his</strong> phone.</td><td>This phone is <strong>his</strong>.</td></tr>
            <tr><td>She</td><td>This is <strong>her</strong> book.</td><td>This book is <strong>hers</strong>.</td></tr>
            <tr><td>We</td><td>This is <strong>our</strong> house.</td><td>This house is <strong>ours</strong>.</td></tr>
            <tr><td>They</td><td>This is <strong>their</strong> classroom.</td><td>This classroom is <strong>theirs</strong>.</td></tr>
        </tbody>
    </table>
</div>

<h4>4. Pronombres Personales Objeto (Object Pronouns)</h4>
<p>Se utilizan cuando la persona recibe la acción del verbo o va precedida de una preposición: <strong>me, you, him, her, it, us, them</strong>.</p>
<ul>
    <li><em>She called <strong>me</strong> yesterday.</em> (Ella me llamó ayer).</li>
    <li><em>Listen to <strong>him</strong>!</em> (¡Escúchalo a él!).</li>
    <li><em>We invited <strong>them</strong> to dinner.</em> (Los invitamos a ellos a cenar).</li>
</ul>"
                },

                // =========================================================================
                // MÓDULO 9: PREPOSICIONES DE TIEMPO, LUGAR, MOVIMIENTO Y TRANSPORTE
                // =========================================================================
                new ModuleDef
                {
                    Title = "Módulo 9: Preposiciones Fundamentales: Tiempo, Lugar, Movimiento y Transporte",
                    LessonTitle = "Guía de Preposiciones: Reglas Nemotécnicas de In, On, At y Medios de Transporte",
                    Summary = "Aprende el uso infalible de AT, ON e IN para fechas, horas y ubicaciones espaciales, preposiciones de posición (under, above, between) y transporte con By vs. On.",
                    ContentHtml = @"<h4>1. Preposiciones de Tiempo: La Pirámide AT - ON - IN</h4>
<p>Para no equivocarte jamás con el tiempo, visualiza una pirámide de lo más específico a lo más general:</p>

<div class=""row g-3 my-3"">
    <div class=""col-md-4"">
        <div class=""card p-3 border-danger h-100"">
            <h6 class=""fw-bold text-danger"">AT (Punto Muy Específico)</h6>
            <p class=""small text-muted mb-1"">Horas exactas y momentos puntuales:</p>
            <ul class=""small mb-0"">
                <li><em>at 5:00 PM</em></li>
                <li><em>at noon / at midnight</em></li>
                <li><em>at night</em></li>
                <li><em>at the weekend</em> (UK)</li>
            </ul>
        </div>
    </div>
    <div class=""col-md-4"">
        <div class=""card p-3 border-warning h-100"">
            <h6 class=""fw-bold text-warning"">ON (Días y Fechas)</h6>
            <p class=""small text-muted mb-1"">Días concretos del calendario:</p>
            <ul class=""small mb-0"">
                <li><em>on Monday, on Fridays</em></li>
                <li><em>on May 12th</em> (Fecha con día)</li>
                <li><em>on my birthday</em></li>
                <li><em>on Christmas Day</em></li>
            </ul>
        </div>
    </div>
    <div class=""col-md-4"">
        <div class=""card p-3 border-primary h-100"">
            <h6 class=""fw-bold text-primary"">IN (Periodos Amplios)</h6>
            <p class=""small text-muted mb-1"">Meses, años, siglos y estaciones:</p>
            <ul class=""small mb-0"">
                <li><em>in July</em> (Solo el mes)</li>
                <li><em>in 2026</em> (Años)</li>
                <li><em>in summer</em> (Estaciones)</li>
                <li><em>in the morning / afternoon</em></li>
            </ul>
        </div>
    </div>
</div>

<h4>2. Preposiciones de Lugar y Espacio</h4>
<ul>
    <li><strong>AT:</strong> Ubicación como punto de referencia institucional o social: <em>at home, at work, at school, at the bus stop</em>.</li>
    <li><strong>IN:</strong> Dentro de un espacio cerrado, ciudad o país: <em>in the kitchen, in Madrid, in Venezuela, in a box</em>.</li>
    <li><strong>ON:</strong> En contacto directo sobre una superficie o línea: <em>on the table, on the wall, on the second floor</em>.</li>
    <li><strong>UNDER:</strong> Debajo de algo: <em>The cat is under the chair</em>.</li>
    <li><strong>BETWEEN:</strong> En medio de dos elementos: <em>The bank is between the pharmacy and the bakery</em>.</li>
</ul>

<h4>3. Preposiciones con Medios de Transporte</h4>
<div class=""alert alert-success border-0 p-3 rounded-3"">
    <p class=""mb-1""><strong>Regla General:</strong> Se utiliza <strong>BY</strong> para indicar el medio de transporte: <em>by car, by train, by bus, by plane, by boat</em>.</p>
    <p class=""mb-0""><strong>Excepción Fundamental:</strong> Si te desplazas caminando se dice <strong>ON foot</strong> (nunca <em>by foot</em>).</p>
</div>"
                },

                // =========================================================================
                // MÓDULO 10: VERBOS MODALES BÁSICOS Y QUESTION TAGS
                // =========================================================================
                new ModuleDef
                {
                    Title = "Módulo 10: Verbos Modales Básicos (Can, Must, Should, May, Would) y Question Tags",
                    LessonTitle = "Modales y Preguntas de Confirmación: Habilidad, Obligación, Consejos y Cortesía",
                    Summary = "Conoce las reglas de los verbos modales auxiliares (Can, Must, Should, May, Would), cómo formular peticiones formales y el uso de Question Tags.",
                    ContentHtml = @"<h4>1. Reglas Universales de los Verbos Modales</h4>
<p>Los verbos modales poseen 3 características que simplifican su uso en inglés:</p>
<ol>
    <li><strong>Inmutables:</strong> No añaden <code>-s</code> en 3ª persona (*He can*, nunca *He cans*).</li>
    <li><strong>Seguidos de Infinitivo sin 'to':</strong> *I must go*, *She can swim* (no *can to swim*).</li>
    <li><strong>Negación e Interrogación Directa:</strong> No necesitan *do/does*; niegan directamente (*cannot / can't, should not / shouldn't*) e invierten el orden en preguntas (*Can you speak Spanish?*).</li>
</ol>

<div class=""table-responsive my-3"">
    <table class=""table table-bordered align-middle"">
        <thead class=""table-dark"">
            <tr><th>Modal</th><th>Significado / Función</th><th>Ejemplo en Contexto</th></tr>
        </thead>
        <tbody>
            <tr>
                <td><strong class=""text-primary"">CAN / CAN'T</strong></td>
                <td>Habilidad física o mental; permiso informal.</td>
                <td><em>I can drive a car. / You can't park here.</em></td>
            </tr>
            <tr>
                <td><strong class=""text-danger"">MUST / MUSTN'T</strong></td>
                <td>Obligación fuerte o deber legal; prohibición estricta.</td>
                <td><em>You must wear a seatbelt. / You mustn't enter this area.</em></td>
            </tr>
            <tr>
                <td><strong class=""text-warning"">SHOULD / SHOULDN'T</strong></td>
                <td>Consejo, recomendación u opinión moral.</td>
                <td><em>You have a headache; you should rest.</em></td>
            </tr>
            <tr>
                <td><strong class=""text-info"">MAY / MIGHT</strong></td>
                <td>Posibilidad o permiso formal respetuoso.</td>
                <td><em>May I ask a question? / It might rain later.</em></td>
            </tr>
            <tr>
                <td><strong class=""text-success"">WOULD</strong></td>
                <td>Cortesía refinada y ofrecimientos.</td>
                <td><em>Would you like some coffee? &mdash; Yes, I would.</em></td>
            </tr>
        </tbody>
    </table>
</div>

<h4>2. Introducción a las ""Question Tags"" (Coletillas Interrogativas)</h4>
<p>Son pequeñas preguntas al final de la oración para confirmar información (equivalentes a <em>'¿verdad?'</em> o <em>'¿no?'</em>):</p>
<ul>
    <li>Frase afirmativa &rarr; Tag negativa: <em>You are a student, <strong>aren't you?</strong></em></li>
    <li>Frase negativa &rarr; Tag afirmativa: <em>He isn't Spanish, <strong>is he?</strong></em></li>
    <li>Con Present Simple: <em>You work in an office, <strong>don't you?</strong></em></li>
</ul>"
                }
            };
        }

        private static List<QuizQuestionDef> GetAulaFacilA1Quiz()
        {
            return new List<QuizQuestionDef>
            {
                new QuizQuestionDef
                {
                    QuestionText = "¿Cuál de las siguientes oraciones utiliza correctamente el verbo 'To Be' en forma negativa contraída?",
                    Options = new[]
                    {
                        "She aren't at home today.",
                        "She isn't at home today.",
                        "She don't is at home today.",
                        "She not is at home today."
                    },
                    CorrectIndex = 1,
                    Explanation = "Para la 3ª persona del singular (She), la forma negativa contraída correcta del verbo To Be es 'isn't' (is not)."
                },
                new QuizQuestionDef
                {
                    QuestionText = "¿Cuál es la regla ortográfica correcta para la 3ª persona del singular en Present Simple para el verbo 'watch'?",
                    Options = new[]
                    {
                        "He watchs television.",
                        "He watches television.",
                        "He watchies television.",
                        "He watching television."
                    },
                    CorrectIndex = 1,
                    Explanation = "Los verbos terminados en '-ch', '-sh', '-s', '-x' u '-o' añaden la terminación '-es' en la 3ª persona del singular (He watches)."
                },
                new QuizQuestionDef
                {
                    QuestionText = "¿Cuándo se debe utilizar el artículo indeterminado 'AN' en lugar de 'A'?",
                    Options = new[]
                    {
                        "Únicamente delante de sustantivos en plural.",
                        "Delante de palabras que comienzan fonéticamente con sonido vocálico (ej. an apple, an hour).",
                        "Solo cuando la palabra comienza con la letra 's'.",
                        "Delante de cualquier adjetivo de color."
                    },
                    CorrectIndex = 1,
                    Explanation = "'AN' se emplea ante sonidos vocálicos para facilitar la pronunciación fluida y evitar el choque de vocales (an orange, an hour con 'h' muda)."
                },
                new QuizQuestionDef
                {
                    QuestionText = "¿Cuál es la diferencia fundamental entre 'Present Simple' y 'Present Continuous'?",
                    Options = new[]
                    {
                        "El Present Simple describe rutinas y hábitos permanentes, mientras que el Present Continuous describe acciones que ocurren en este preciso momento.",
                        "El Present Simple solo se usa en el Reino Unido y el Present Continuous en Estados Unidos.",
                        "No hay diferencia, pueden intercambiarse sin alterar el significado.",
                        "El Present Continuous solo se utiliza con el pronombre 'I'."
                    },
                    CorrectIndex = 0,
                    Explanation = "Present Simple expresa verdades generales y rutinas (I work every day); Present Continuous expresa acciones en desarrollo en el momento del habla (I am working right now)."
                },
                new QuizQuestionDef
                {
                    QuestionText = "¿Cuál es la forma correcta en Past Simple (pasado simple) del verbo irregular 'GO' (ir)?",
                    Options = new[]
                    {
                        "Goed.",
                        "Went.",
                        "Gone.",
                        "Going."
                    },
                    CorrectIndex = 1,
                    Explanation = "El verbo 'go' es un verbo irregular cuyo pasado simple afirmativo es 'went' (She went to London yesterday)."
                },
                new QuizQuestionDef
                {
                    QuestionText = "En una oración negativa en Past Simple, ¿cómo se conjuga el verbo principal tras el auxiliar 'didn't'?",
                    Options = new[]
                    {
                        "En pasado con terminación '-ed' (ej. She didn't played).",
                        "En su forma base infinitivo sin to (ej. She didn't play).",
                        "En participio pasado irregular.",
                        "Con la terminación '-ing'."
                    },
                    CorrectIndex = 1,
                    Explanation = "El auxiliar 'didn't' ya transporta la marca gramatical de tiempo pasado, por lo que el verbo principal vuelve obligatoriamente a su forma base (She didn't play)."
                },
                new QuizQuestionDef
                {
                    QuestionText = "¿Qué estructura de futuro es la más indicada para expresar una decisión espontánea tomada en el instante de hablar?",
                    Options = new[]
                    {
                        "Future Simple con 'WILL' (ej. I will help you).",
                        "Be Going To (ej. I am going to help you).",
                        "Past Continuous.",
                        "Imperativo negativo."
                    },
                    CorrectIndex = 0,
                    Explanation = "'Will' se utiliza para decisiones espontáneas, promesas y ofrecimientos surgidos en el momento de la conversación."
                },
                new QuizQuestionDef
                {
                    QuestionText = "¿Cuál es el plural irregular correcto del sustantivo 'person' (persona)?",
                    Options = new[]
                    {
                        "Persons.",
                        "People.",
                        "Peoples.",
                        "Persones."
                    },
                    CorrectIndex = 1,
                    Explanation = "En inglés general estándar, el plural irregular de 'person' es 'people' (There were ten people in the room)."
                },
                new QuizQuestionDef
                {
                    QuestionText = "¿Qué preposición de tiempo corresponde utilizar con los días de la semana y fechas específicas (ej. Monday, July 4th)?",
                    Options = new[]
                    {
                        "AT.",
                        "IN.",
                        "ON.",
                        "BY."
                    },
                    CorrectIndex = 2,
                    Explanation = "La preposición 'ON' se utiliza rigurosamente para días de la semana (on Monday) y fechas completas con día (on July 4th)."
                },
                new QuizQuestionDef
                {
                    QuestionText = "¿Qué verbo modal expresa un consejo o recomendación en inglés?",
                    Options = new[]
                    {
                        "Must.",
                        "Should.",
                        "Can.",
                        "Will."
                    },
                    CorrectIndex = 1,
                    Explanation = "'Should' (deberías) se emplea para aconsejar, recomendar o sugerir una acción beneficiosa a otra persona (You should rest)."
                }
            };
        }
    }
}
