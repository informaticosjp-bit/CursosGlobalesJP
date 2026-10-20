# Master Rebuilder: Generates all 5 CurriculumUpgrade files using pure UTF-8 with BOM and clean quiz questions
$quizzes = Get-Content "c:\Users\plase\source\repos\CursosCertificadosApp\all_clean_quizzes.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$utf8Bom = New-Object System.Text.UTF8Encoding($true)

function Get-QuizCSharp ($slug) {
    $items = $global:quizzes | Where-Object { $_.slug -eq $slug } | Sort-Object order
    if ($items.Count -eq 0) {
        throw "No questions found for slug $slug"
    }

    $sb = New-Object System.Text.StringBuilder
    $sb.AppendLine("new List<UpgradeQuizQuestionData>") | Out-Null
    $sb.AppendLine("                    {") | Out-Null

    for ($i = 0; $i -lt $items.Count; $i++) {
        $q = $items[$i]
        $optA = if ($q.options.Count -gt 0) { $q.options[0].text.Replace('"', '""') } else { "" }
        $optB = if ($q.options.Count -gt 1) { $q.options[1].text.Replace('"', '""') } else { "" }
        $optC = if ($q.options.Count -gt 2) { $q.options[2].text.Replace('"', '""') } else { "" }
        $optD = if ($q.options.Count -gt 3) { $q.options[3].text.Replace('"', '""') } else { "" }

        $corr = "A"
        for ($k = 0; $k -lt $q.options.Count; $k++) {
            if ($q.options[$k].isCorrect) {
                $corr = @("A", "B", "C", "D")[$k]
                break
            }
        }

        $qText = $q.question.Replace('"', '""')
        $expText = $q.explanation.Replace('"', '""')

        $sb.AppendLine("                        new UpgradeQuizQuestionData") | Out-Null
        $sb.AppendLine("                        {") | Out-Null
        $sb.AppendLine("                            Question = @""$qText"",") | Out-Null
        $sb.AppendLine("                            OptionA = @""$optA"",") | Out-Null
        $sb.AppendLine("                            OptionB = @""$optB"",") | Out-Null
        $sb.AppendLine("                            OptionC = @""$optC"",") | Out-Null
        $sb.AppendLine("                            OptionD = @""$optD"",") | Out-Null
        $sb.AppendLine("                            CorrectAnswer = ""$corr"",") | Out-Null
        $sb.AppendLine("                            Explanation = @""$expText""") | Out-Null
        if ($i -lt ($items.Count - 1)) {
            $sb.AppendLine("                        },") | Out-Null
        } else {
            $sb.AppendLine("                        }") | Out-Null
        }
    }

    $sb.Append("                    }") | Out-Null
    return $sb.ToString()
}

# -----------------------------------------------------------------------------
# 1. TechAI
# -----------------------------------------------------------------------------
Write-Host "Rebuilding TechAI..."
$qGemini = Get-QuizCSharp "domina-la-ia-con-gemini"
$qSec = Get-QuizCSharp "introduccion-ciberseguridad"
$qSupport = Get-QuizCSharp "servicio-tecnico-informatico-soporte-sistemas"
$qTI = Get-QuizCSharp "ti-para-el-exito-empresarial"

$sTech = [System.IO.File]::ReadAllText("c:\Users\plase\source\repos\CursosCertificadosApp\build_tech_ai.ps1", [System.Text.Encoding]::UTF8)
$sTech = $sTech -replace '(?s)\$qGemini = Extract-Questions.*?\n(\$newCode =)', "`$qGemini = @'`r`n$qGemini`r`n'@`r`n`$qSec = @'`r`n$qSec`r`n'@`r`n`$qSupport = @'`r`n$qSupport`r`n'@`r`n`$qTI = @'`r`n$qTI`r`n'@`r`n`$1"
$sTech = $sTech -replace 'Questions = \r?\n''@ \+ \$q', 'QuizQuestions = `r`n''@ + $q'
$sTech = $sTech -replace '\[System\.IO\.File\]::WriteAllText\(\$techAiFile, \$newCode, \[System\.Text\.Encoding\]::UTF8\)', '[System.IO.File]::WriteAllText($techAiFile, $newCode, $utf8Bom)'
[ScriptBlock]::Create($sTech).Invoke()

# -----------------------------------------------------------------------------
# 2. OfficeData
# -----------------------------------------------------------------------------
Write-Host "Rebuilding OfficeData..."
$qOfficeBasico = Get-QuizCSharp "office-basico"
$qExcelAvanzado = Get-QuizCSharp "excel-avanzado"
$qPowerBi = Get-QuizCSharp "power-bi"
$qCienciaDatos = Get-QuizCSharp "ciencia-y-analisis-de-datos"
$qOfficeIntermedio = Get-QuizCSharp "office-intermedio"

$sOffice = [System.IO.File]::ReadAllText("c:\Users\plase\source\repos\CursosCertificadosApp\build_office_data.ps1", [System.Text.Encoding]::UTF8)
$sOffice = $sOffice -replace '(?s)\$qOfficeBasico = Extract-Questions.*?\n(\$newCode =)', "`$qOfficeBasico = @'`r`n$qOfficeBasico`r`n'@`r`n`$qExcelAvanzado = @'`r`n$qExcelAvanzado`r`n'@`r`n`$qPowerBi = @'`r`n$qPowerBi`r`n'@`r`n`$qCienciaDatos = @'`r`n$qCienciaDatos`r`n'@`r`n`$qOfficeIntermedio = @'`r`n$qOfficeIntermedio`r`n'@`r`n`$1"
$sOffice = $sOffice -replace 'Questions = \r?\n''@ \+ \$q', 'QuizQuestions = `r`n''@ + $q'
$sOffice = $sOffice -replace '\[System\.IO\.File\]::WriteAllText\(\$officeFile, \$newCode, \[System\.Text\.Encoding\]::UTF8\)', '[System.IO.File]::WriteAllText($officeFile, $newCode, $utf8Bom)'
[ScriptBlock]::Create($sOffice).Invoke()

# -----------------------------------------------------------------------------
# 3. CommercialRetail
# -----------------------------------------------------------------------------
Write-Host "Rebuilding CommercialRetail..."
$qSap = Get-QuizCSharp "sap-business-one-b1-gestion-operativa"
$qShopify = Get-QuizCSharp "shopify-comercio-electronico-tiendas-online"
$qAsistente = Get-QuizCSharp "asistente-de-ventas-comercial-supervision"
$qMercaderista = Get-QuizCSharp "mercaderista-trade-merchandising-punto-venta"
$qVentasLinea = Get-QuizCSharp "ventas-en-linea"

$sRetail = [System.IO.File]::ReadAllText("c:\Users\plase\source\repos\CursosCertificadosApp\build_commercial_retail.ps1", [System.Text.Encoding]::UTF8)
$sRetail = $sRetail -replace '(?s)\$qSap = Extract-QuizQuestions.*?\n(\$newCode =)', "`$qSap = @'`r`n$qSap`r`n'@`r`n`$qShopify = @'`r`n$qShopify`r`n'@`r`n`$qAsistente = @'`r`n$qAsistente`r`n'@`r`n`$qMercaderista = @'`r`n$qMercaderista`r`n'@`r`n`$qVentasLinea = @'`r`n$qVentasLinea`r`n'@`r`n`$1"
$sRetail = $sRetail -replace '\[System\.IO\.File\]::WriteAllText\(\$retailFile, \$newCode, \[System\.Text\.Encoding\]::UTF8\)', '[System.IO.File]::WriteAllText($retailFile, $newCode, $utf8Bom)'
[ScriptBlock]::Create($sRetail).Invoke()

# -----------------------------------------------------------------------------
# 4. OperationsAdmin
# -----------------------------------------------------------------------------
Write-Host "Rebuilding OperationsAdmin..."
$qAdminEmp = Get-QuizCSharp "administracion-empresarial-procesos-reportes"
$qInv = Get-QuizCSharp "administracion-de-inventario"
$qAlmacen = Get-QuizCSharp "auxiliar-almacen-inventarios-logistica"
$qAgile = Get-QuizCSharp "gestion-proyectos-agile"
$qEstrategia = Get-QuizCSharp "planificacion-estrategica"

$sOps = [System.IO.File]::ReadAllText("c:\Users\plase\source\repos\CursosCertificadosApp\build_operations_admin.ps1", [System.Text.Encoding]::UTF8)
$sOps = $sOps -replace '(?s)\$qAdminEmp = Extract-QuizQuestions.*?\n(\$newCode =)', "`$qAdminEmp = @'`r`n$qAdminEmp`r`n'@`r`n`$qInv = @'`r`n$qInv`r`n'@`r`n`$qAlmacen = @'`r`n$qAlmacen`r`n'@`r`n`$qAgile = @'`r`n$qAgile`r`n'@`r`n`$qEstrategia = @'`r`n$qEstrategia`r`n'@`r`n`$1"
$sOps = $sOps -replace '\[System\.IO\.File\]::WriteAllText\(\$opsFile, \$newCode, \[System\.Text\.Encoding\]::UTF8\)', '[System.IO.File]::WriteAllText($opsFile, $newCode, $utf8Bom)'
[ScriptBlock]::Create($sOps).Invoke()

# -----------------------------------------------------------------------------
# 5. SoftSkillsHR
# -----------------------------------------------------------------------------
Write-Host "Rebuilding SoftSkillsHR..."
$qFilosofia = Get-QuizCSharp "filosofia-empresarial-etica-laboral"
$qAtencionPresencial = Get-QuizCSharp "atencion-al-cliente-presencial-fidelizacion"
$qAtencionOmnicanal = Get-QuizCSharp "atencion-al-cliente"
$qTrabajoEquipo = Get-QuizCSharp "trabajo-en-equipo-habilidades-blandas-productividad"
$qLiderazgo = Get-QuizCSharp "liderazgo-efectivo"
$qNegociacion = Get-QuizCSharp "tacticas-de-negociacion-efectiva"
$qGestionTiempo = Get-QuizCSharp "gestion-del-tiempo"
$qPrimerosAuxilios = Get-QuizCSharp "primeros-auxilios"

$targetSoft = "c:\Users\plase\source\repos\CursosCertificadosApp\CursosCertificadosApp\Data\CurriculumUpgrade.SoftSkillsHR.cs"

# Source the two helper scripts as UTF-8
$p1Text = [System.IO.File]::ReadAllText("c:\Users\plase\source\repos\CursosCertificadosApp\build_soft_skills_1.ps1", [System.Text.Encoding]::UTF8)
$p2Text = [System.IO.File]::ReadAllText("c:\Users\plase\source\repos\CursosCertificadosApp\build_soft_skills_2.ps1", [System.Text.Encoding]::UTF8)
. ([ScriptBlock]::Create($p1Text))
. ([ScriptBlock]::Create($p2Text))

$softHeader = @'
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

$fullSoft = $softHeader + "`r`n" + $c1 + "`r`n" + $c2 + "`r`n" + $c3 + "`r`n" + $c4 + "`r`n" + $c5 + "`r`n" + $c6 + "`r`n" + $c7 + "`r`n" + $c8
[System.IO.File]::WriteAllText($targetSoft, $fullSoft, $utf8Bom)
Write-Host "Updated CurriculumUpgrade.SoftSkillsHR.cs successfully!"

Write-Host "ALL 5 CURRICULUM UPGRADE FILES REBUILT CLEANLY WITH UTF-8 BOM!"
