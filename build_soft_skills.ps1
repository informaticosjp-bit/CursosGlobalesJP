$targetFile = "c:\Users\plase\source\repos\CursosCertificadosApp\CursosCertificadosApp\Data\CurriculumUpgrade.SoftSkillsHR.cs"

# 1. Read existing questions from SoftSkillsHR.cs
$oldContent = [System.IO.File]::ReadAllText($targetFile, [System.Text.Encoding]::UTF8)

function Extract-QuizQuestions ($slug) {
    $pattern = '(?s)Slug\s*=\s*"' + [regex]::Escape($slug) + '".*?QuizQuestions\s*=\s*(new List<UpgradeQuizQuestionData>\s*\{.*?\n\s*\})\s*\}'
    if ($oldContent -match $pattern) {
        return $matches[1]
    }
    throw "Could not extract quiz questions for $slug"
}

$qFilosofia = Extract-QuizQuestions "filosofia-empresarial-etica-laboral"
$qAtencionPresencial = Extract-QuizQuestions "atencion-al-cliente-presencial-fidelizacion"
$qAtencionOmnicanal = Extract-QuizQuestions "atencion-al-cliente"
$qTrabajoEquipo = Extract-QuizQuestions "trabajo-en-equipo-habilidades-blandas-productividad"
$qLiderazgo = Extract-QuizQuestions "liderazgo-efectivo"
$qNegociacion = Extract-QuizQuestions "tacticas-de-negociacion-efectiva"
$qGestionTiempo = Extract-QuizQuestions "gestion-del-tiempo"
$qPrimerosAuxilios = Extract-QuizQuestions "primeros-auxilios"

Write-Host "All 8 quiz question sets extracted successfully."

# 2. Source the helpers
. "c:\Users\plase\source\repos\CursosCertificadosApp\build_soft_skills_1.ps1"
. "c:\Users\plase\source\repos\CursosCertificadosApp\build_soft_skills_2.ps1"

# 3. Assemble the file
$header = @'
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
'@

$c1 = Get-Course-Filosofia $qFilosofia
$c2 = Get-Course-AtencionPresencial $qAtencionPresencial
$c3 = Get-Course-AtencionOmnicanal $qAtencionOmnicanal
$c4 = Get-Course-TrabajoEquipo $qTrabajoEquipo
$c5 = Get-Course-Liderazgo $qLiderazgo
$c6 = Get-Course-Negociacion $qNegociacion
$c7 = Get-Course-GestionTiempo $qGestionTiempo
$c8 = Get-Course-PrimerosAuxilios $qPrimerosAuxilios

$fullContent = $header + "`r`n" + $c1 + "`r`n" + $c2 + "`r`n" + $c3 + "`r`n" + $c4 + "`r`n" + $c5 + "`r`n" + $c6 + "`r`n" + $c7 + "`r`n" + $c8

[System.IO.File]::WriteAllText($targetFile, $fullContent, [System.Text.Encoding]::UTF8)
Write-Host "Updated CurriculumUpgrade.SoftSkillsHR.cs successfully!"
