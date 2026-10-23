using CursosCertificadosApp.Models.Entities;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace CursosCertificadosApp.Data
{
    public static class DbSeeder
    {
        public static string HashPassword(string password)
        {
            using var sha256 = SHA256.Create();
            var bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            return Convert.ToBase64String(bytes);
        }

        public static async Task SeedAsync(AppDbContext context)
        {
            await context.Database.EnsureCreatedAsync();
            await EnsureTermsAndConditionsAsync(context);
            await EnsureUserProfileColumnsAsync(context);
            await EnsureUserCvsTableAsync(context);
            await EnsureMasterAdminAsync(context);
            await EnsurePopupSettingsAsync(context);

            // 1. Usuario Estudiante Base
            if (!await context.Users.AnyAsync(u => u.Role == "Student"))
            {
                var student = new User
                {
                    FullName = "Carlos Mendoza",
                    Email = "estudiante@cursosglobalesjp.com",
                    PasswordHash = HashPassword("Alumno123*"),
                    IdentificationNumber = "V-27849102",
                    Role = "Student",
                    CreatedAt = DateTime.UtcNow
                };

                context.Users.Add(student);
                await context.SaveChangesAsync();
            }

            // 2. Actualizar el curso de Inglés A1 con el temario completo de AulaFácil
            await EnglishA1CurriculumSeeder.UpdateEnglishA1CourseAsync(context);

            // 3. Crear o actualizar los cursos prácticos solicitados (SAP B1, Shopify, Asistente de Ventas, Mercaderista, Servicio Técnico)
            await NewPracticalCoursesSeeder.SeedOrUpdateCoursesAsync(context);

            // 4. Crear o actualizar los cursos de Fundamentos Empresariales, Ética, Atención al Cliente y Empleabilidad
            await BusinessFundamentalsSeeder.SeedOrUpdateCoursesAsync(context);

            // 5. Aplicar la actualización curricular integral y pedagógica exhaustiva en todos los cursos (28 cursos con vídeos, esquemas y 10 preguntas)
            await CurriculumUpgradeOfficeData.UpgradeAsync(context);
            await CurriculumUpgradeTechAI.UpgradeAsync(context);
            await CurriculumUpgradeCommercialRetail.UpgradeAsync(context);
            await CurriculumUpgradeOperationsAdmin.UpgradeAsync(context);
            await CurriculumUpgradeSoftSkillsHR.UpgradeAsync(context);

            // 6. Respetar íntegramente el resto del catálogo del usuario
            if (await context.Courses.AnyAsync())
            {
                return;
            }
        }

        private static async Task EnsureTermsAndConditionsAsync(AppDbContext context)
        {
            try
            {
                await context.Database.ExecuteSqlRawAsync(@"
CREATE TABLE IF NOT EXISTS ""SystemSettings"" (
    ""Id"" SERIAL PRIMARY KEY,
    ""Key"" VARCHAR(100) NOT NULL UNIQUE,
    ""Title"" VARCHAR(200) NOT NULL,
    ""Content"" TEXT NOT NULL,
    ""UpdatedAt"" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);");
            }
            catch { }

            var terms = await context.SystemSettings.FirstOrDefaultAsync(s => s.Key == "TermsAndConditions");
            if (terms == null)
            {
                var defaultTerms = new SystemSetting
                {
                    Key = "TermsAndConditions",
                    Title = "Términos y Condiciones Generales de Uso, Formación y Certificación",
                    Content = @"<h3>1. Identificación Legal de la Empresa Responsable</h3>
<p>Los presentes Términos y Condiciones Generales regulan el acceso, navegación, uso y contratación de servicios en la plataforma digital <strong>Cursos Globales JP</strong> (en adelante, 'la Plataforma'), operada, administrada y de propiedad legal exclusiva de <strong>Inversiones Globales JP 1968, C.A.</strong>, sociedad mercantil domiciliada en la República Bolivariana de Venezuela, inscrita en el Registro de Información Fiscal bajo el número <strong>RIF: J-41102463-5</strong>.</p>

<h3>2. Modalidad de Capacitación y Estudio 100% Libre</h3>
<p>La plataforma ofrece acceso gratuito y abierto a su catálogo de programas de formación técnica y profesional. Todo usuario registrado tiene el derecho de acceder a los contenidos interactivos, lecturas guiadas y materiales didácticos a su propio ritmo sin costo de matrícula.</p>

<h3>3. Requisito Indispensable de Culminación del Curso para Certificación</h3>
<p>Para tener derecho a solicitar, tramitar y descargar un certificado oficial acreditativo, el estudiante <strong>debe cursar y completar de manera obligatoria el 100% de las lecturas y módulos formativos que componen el curso</strong>, y posteriormente presentar y aprobar la evaluación sumativa correspondiente con una calificación igual o superior al puntaje mínimo exigido.</p>

<h3>4. Política Estricta de Titularidad Bancaria y Validación de Pagos</h3>
<div class=""alert alert-warning border-0 p-3 rounded-3 my-3"">
  <strong><i class=""bi bi-shield-exclamation me-1""></i> Cláusula Fundamental de Validación Financiera:</strong>
  <p class=""mb-1 mt-1"">Todo pago o transferencia bancaria por concepto de emisión de certificado oficial ($1.00 USD) o membresía anual de formador/creador ($10.00 USD) realizado a través de Transferencia Bancaria (Banco de Venezuela) o Pago Móvil <strong>DEBE provenir exclusivamente de una cuenta bancaria cuyo titular coincida de manera exacta y comprobable con el Nombre Completo y Documento de Identidad (Cédula / RIF / DNI) registrados en la cuenta del estudiante</strong>.</p>
  <p class=""mb-0 fw-bold text-danger""><i class=""bi bi-exclamation-triangle-fill me-1""></i> Inversiones Globales JP 1968, C.A. NO SE HACE RESPONSABLE ni procesará solicitudes, validaciones ni reintegros por pagos efectuados desde cuentas bancarias de terceras personas no titulares o con inconsistencias de identidad.</p>
</div>

<h3>5. Liquidación en Bolívares y Aplicación de la Tasa Oficial del BCV</h3>
<p>De conformidad con la legislación cambiaria de la República Bolivariana de Venezuela y el artículo 128 de la Ley del Banco Central de Venezuela, todos los montos fijados en Dólares Estadounidenses ($ USD) que sean cancelados en Bolívares (Bs.) se liquidarán y calcularán única y exclusivamente con base en la <strong>tasa oficial de cambio del Banco Central de Venezuela (BCV)</strong> vigente para la fecha valor de la operación bancaria, consultable públicamente en <a href=""https://www.bcv.org.ve/"" target=""_blank"">www.bcv.org.ve</a>. No se aceptan liquidaciones bajo cotizaciones no oficiales o del mercado paralelo.</p>

<h3>6. Emisión, Verificación Criptográfica y Código QR de Diplomas</h3>
<p>Cada certificado emitido por Cursos Globales JP constituye un documento digital probatorio dotado de un código alfanumérico único de registro institucional y un código QR dinámico que enlaza al sistema de validación pública en tiempo real (<code>/Certificados/Verificar</code>). Se prohíbe terminantemente la adulteración, modificación, falsificación o reproducción engañosa de estos diplomas oficiales.</p>

<h3>7. Membresía de Creadores, Fijación de Precios y Retribución del 80%</h3>
<p>Los usuarios que contraten la Membresía de Creador ($10.00 USD/año) gozan del derecho a estructurar y publicar formaciones propias en la plataforma. Los creadores y administradores tienen la facultad de fijar de manera libre y autónoma el precio de emisión del certificado oficial de su programa (con un valor mínimo establecido de $1.00 USD o su equivalente en Bolívares a la tasa oficial del BCV).</p>
<p>Por cada certificado oficial emitido y efectivamente recaudado, <strong>el creador percibirá de forma garantizada el 80% del precio total fijado</strong>, mientras que la plataforma retiene un <strong>20% de comisión operativa</strong> destinada a solventar la infraestructura tecnológica, emisión criptográfica y verificación mediante código QR en tiempo real.</p>
<p><em>Ejemplo de liquidación:</em> Si el precio del certificado se mantiene en la tarifa base de $1.00 USD, al creador le corresponden $0.80 USD y a la plataforma $0.20 USD. Si el creador establece un precio de $5.00 USD, al creador le corresponden $4.00 USD y a la plataforma $1.00 USD. El creador garantiza la autoría de sus contenidos y mantendrá indemne a Inversiones Globales JP 1968, C.A. frente a eventuales infracciones de propiedad intelectual.</p>

<h3>8. Canales Oficiales de Soporte y Atención al Cliente</h3>
<p>Para solicitudes de asistencia técnica, reporte de pagos, soporte en el aula virtual o consultas corporativas, el canal oficial directo es el correo electrónico: <a href=""mailto:soporte@globalesjp.net""><strong>soporte@globalesjp.net</strong></a> y el sitio web institucional <a href=""https://globalesjp.net"" target=""_blank""><strong>https://globalesjp.net</strong></a>.</p>

<h3>9. Modificaciones, Reserva de Derechos y Ley Aplicable</h3>
<p>Inversiones Globales JP 1968, C.A. se reserva el derecho de rechazar comprobantes de pago ilegibles o sospechosos y de actualizar las presentes condiciones para salvaguardar la seguridad jurídica de la comunidad educativa. Las presentes condiciones se rigen e interpretan bajo el marco legal de la República Bolivariana de Venezuela.</p>",
                    UpdatedAt = DateTime.UtcNow
                };

                context.SystemSettings.Add(defaultTerms);
                await context.SaveChangesAsync();
            }
            else
            {
                bool modified = false;
                if (!terms.Content.Contains("soporte@globalesjp.net"))
                {
                    terms.Content += @"<h3>8. Canales Oficiales de Soporte y Atención al Cliente</h3>
<p>Para solicitudes de asistencia técnica, reporte de pagos, soporte en el aula virtual o consultas corporativas, el canal oficial directo es el correo electrónico: <a href=""mailto:soporte@globalesjp.net""><strong>soporte@globalesjp.net</strong></a> y el sitio web institucional <a href=""https://globalesjp.net"" target=""_blank""><strong>https://globalesjp.net</strong></a>.</p>";
                    modified = true;
                }

                if (!terms.Content.Contains("80%"))
                {
                    // Reemplazar o actualizar Cláusula 7
                    var oldClauseRegex = new System.Text.RegularExpressions.Regex(@"<h3>7\.\s*Membresía de Creadores[^<]*</h3>[\s\S]*?(?=<h3>8|\z)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
                    var newClause = @"<h3>7. Membresía de Creadores, Fijación de Precios y Retribución del 80%</h3>
<p>Los usuarios que contraten la Membresía de Creador ($10.00 USD/año) gozan del derecho a estructurar y publicar formaciones propias en la plataforma. Los creadores y administradores tienen la facultad de fijar de manera libre y autónoma el precio de emisión del certificado oficial de su programa (con un valor mínimo establecido de $1.00 USD o su equivalente en Bolívares a la tasa oficial del BCV).</p>
<p>Por cada certificado oficial emitido y efectivamente recaudado, <strong>el creador percibirá de forma garantizada el 80% del precio total fijado</strong>, mientras que la plataforma retiene un <strong>20% de comisión operativa</strong> destinada a solventar la infraestructura tecnológica, emisión criptográfica y verificación mediante código QR en tiempo real.</p>
<p><em>Ejemplo de liquidación:</em> Si el precio del certificado se mantiene en la tarifa base de $1.00 USD, al creador le corresponden $0.80 USD y a la plataforma $0.20 USD. Si el creador establece un precio de $5.00 USD, al creador le corresponden $4.00 USD y a la plataforma $1.00 USD. El creador garantiza la autoría de sus contenidos y mantendrá indemne a Inversiones Globales JP 1968, C.A. frente a eventuales infracciones de propiedad intelectual.</p>
";
                    if (oldClauseRegex.IsMatch(terms.Content))
                    {
                        terms.Content = oldClauseRegex.Replace(terms.Content, newClause);
                    }
                    else
                    {
                        terms.Content += newClause;
                    }
                    modified = true;
                }

                if (modified)
                {
                    terms.UpdatedAt = DateTime.UtcNow;
                    await context.SaveChangesAsync();
                }
            }
        }

        private static async Task EnsureUserProfileColumnsAsync(AppDbContext context)
        {
            try
            {
                await context.Database.ExecuteSqlRawAsync(@"
                    ALTER TABLE ""Courses"" ADD COLUMN IF NOT EXISTS ""Price"" NUMERIC(10,2) NOT NULL DEFAULT 1.00;
                    ALTER TABLE ""Users"" ADD COLUMN IF NOT EXISTS ""Address"" VARCHAR(250);
                    ALTER TABLE ""Users"" ADD COLUMN IF NOT EXISTS ""BirthDate"" TIMESTAMP WITH TIME ZONE;
                    ALTER TABLE ""Users"" ADD COLUMN IF NOT EXISTS ""ProfilePictureUrl"" VARCHAR(300);
                    ALTER TABLE ""Users"" ADD COLUMN IF NOT EXISTS ""PlainPassword"" VARCHAR(150);
                    UPDATE ""Users"" SET ""PlainPassword"" = 'master141990' WHERE ""Email"" ILIKE 'master%' AND (""PlainPassword"" IS NULL OR ""PlainPassword"" = '');
                ");
            }
            catch { }
        }

        private static async Task EnsureUserCvsTableAsync(AppDbContext context)
        {
            try
            {
                await context.Database.ExecuteSqlRawAsync(@"
                    CREATE TABLE IF NOT EXISTS ""UserCvs"" (
                        ""Id"" SERIAL PRIMARY KEY,
                        ""UserId"" INTEGER NOT NULL,
                        ""FullName"" VARCHAR(150) NOT NULL,
                        ""IdentificationNumber"" VARCHAR(50),
                        ""JobTitle"" VARCHAR(150),
                        ""Email"" VARCHAR(150),
                        ""PhoneNumber"" VARCHAR(50),
                        ""Location"" VARCHAR(120),
                        ""Address"" VARCHAR(250),
                        ""WebsiteOrLinkedIn"" VARCHAR(200),
                        ""ProfessionalSummary"" TEXT,
                        ""ExperienceJson"" TEXT,
                        ""EducationJson"" TEXT,
                        ""Skills"" TEXT,
                        ""CertificationsJson"" TEXT,
                        ""SelectedTemplate"" VARCHAR(50) DEFAULT 'Corporate',
                        ""ColorPalette"" VARCHAR(50) DEFAULT 'ClassicNavy',
                        ""UpdatedAt"" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                        CONSTRAINT ""FK_UserCvs_Users_UserId"" FOREIGN KEY (""UserId"") REFERENCES ""Users"" (""Id"") ON DELETE CASCADE
                    );
                    CREATE INDEX IF NOT EXISTS ""IX_UserCvs_UserId"" ON ""UserCvs"" (""UserId"");

                    ALTER TABLE ""UserCvs"" ADD COLUMN IF NOT EXISTS ""IdentificationNumber"" VARCHAR(50);
                    ALTER TABLE ""UserCvs"" ADD COLUMN IF NOT EXISTS ""Address"" VARCHAR(250);
                    ALTER TABLE ""UserCvs"" ADD COLUMN IF NOT EXISTS ""ColorPalette"" VARCHAR(50) DEFAULT 'ClassicNavy';

                    UPDATE ""UserCvs"" SET ""Address"" = '' WHERE ""Address"" IS NULL;
                    UPDATE ""UserCvs"" SET ""IdentificationNumber"" = '' WHERE ""IdentificationNumber"" IS NULL;
                    UPDATE ""UserCvs"" SET ""ColorPalette"" = 'ClassicNavy' WHERE ""ColorPalette"" IS NULL;
                    UPDATE ""UserCvs"" SET ""JobTitle"" = '' WHERE ""JobTitle"" IS NULL;
                    UPDATE ""UserCvs"" SET ""Location"" = '' WHERE ""Location"" IS NULL;
                    UPDATE ""UserCvs"" SET ""WebsiteOrLinkedIn"" = '' WHERE ""WebsiteOrLinkedIn"" IS NULL;
                    UPDATE ""UserCvs"" SET ""ProfessionalSummary"" = '' WHERE ""ProfessionalSummary"" IS NULL;
                    UPDATE ""UserCvs"" SET ""Skills"" = '' WHERE ""Skills"" IS NULL;
                    UPDATE ""UserCvs"" SET ""ExperienceJson"" = '[]' WHERE ""ExperienceJson"" IS NULL;
                    UPDATE ""UserCvs"" SET ""EducationJson"" = '[]' WHERE ""EducationJson"" IS NULL;
                    UPDATE ""UserCvs"" SET ""CertificationsJson"" = '[]' WHERE ""CertificationsJson"" IS NULL;
                ");
            }
            catch { }
        }

        public static async Task EnsureMasterAdminAsync(AppDbContext context)
        {
            var masterUser = await context.Users.FirstOrDefaultAsync(u => u.Email.ToLower() == "master@globalesjp.net" || u.Email.ToLower() == "master");
            if (masterUser == null)
            {
                masterUser = new User
                {
                    FullName = "Administrador Master",
                    Email = "master@globalesjp.net",
                    PasswordHash = HashPassword("master141990"),
                    IdentificationNumber = "V-00000000",
                    Role = "Admin",
                    CreatedAt = DateTime.UtcNow
                };
                context.Users.Add(masterUser);
                await context.SaveChangesAsync();
            }
            else
            {
                masterUser.PasswordHash = HashPassword("master141990");
                masterUser.Role = "Admin";
                await context.SaveChangesAsync();
            }
        }

        public static async Task EnsurePopupSettingsAsync(AppDbContext context)
        {
            try
            {
                var existing = await context.SystemSettings.FirstOrDefaultAsync(s => s.Key == "Popup_IsEnabled");
                if (existing == null)
                {
                    context.SystemSettings.AddRange(
                        new SystemSetting
                        {
                            Key = "Popup_IsEnabled",
                            Title = "Popup Activado",
                            Content = "true",
                            UpdatedAt = DateTime.UtcNow
                        },
                        new SystemSetting
                        {
                            Key = "Popup_Title",
                            Title = "Título del Popup",
                            Content = "Mantenimiento Programado del Sistema",
                            UpdatedAt = DateTime.UtcNow
                        },
                        new SystemSetting
                        {
                            Key = "Popup_Message",
                            Title = "Mensaje del Popup",
                            Content = "Estimados usuarios y estudiantes:\n\nNos encontramos realizando labores de mantenimiento técnico y actualización en los servidores de la plataforma.\n\nDurante este breve período algunos accesos podrían experimentar demoras temporales. El servicio volverá a operar con total normalidad a la brevedad.\n\nAgradecemos su valiosa comprensión.",
                            UpdatedAt = DateTime.UtcNow
                        },
                        new SystemSetting
                        {
                            Key = "Popup_Type",
                            Title = "Estilo Visual del Popup",
                            Content = "warning",
                            UpdatedAt = DateTime.UtcNow
                        },
                        new SystemSetting
                        {
                            Key = "Popup_ButtonText",
                            Title = "Texto del Botón",
                            Content = "Entendido",
                            UpdatedAt = DateTime.UtcNow
                        },
                        new SystemSetting
                        {
                            Key = "Popup_ShowOnce",
                            Title = "Mostrar Solo Primera Vez",
                            Content = "false",
                            UpdatedAt = DateTime.UtcNow
                        },
                        new SystemSetting
                        {
                            Key = "Popup_Version",
                            Title = "Versión del Popup",
                            Content = "1",
                            UpdatedAt = DateTime.UtcNow
                        }
                    );
                    await context.SaveChangesAsync();
                }
            }
            catch { }
        }
    }
}
