# Rebuild CurriculumUpgrade.TechAI.cs with UTF-8 BOM and clean quizzes
$quizzes = Get-Content "c:\Users\plase\source\repos\CursosCertificadosApp\all_clean_quizzes.json" -Raw -Encoding UTF8 | ConvertFrom-Json

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

$qGemini = Get-QuizCSharp "domina-la-ia-con-gemini"
$qSec = Get-QuizCSharp "introduccion-ciberseguridad"
$qSupport = Get-QuizCSharp "servicio-tecnico-informatico-soporte-sistemas"
$qTI = Get-QuizCSharp "ti-para-el-exito-empresarial"

# Read raw text of build_tech_ai.ps1 with UTF-8
$buildScript = [System.IO.File]::ReadAllText("c:\Users\plase\source\repos\CursosCertificadosApp\build_tech_ai.ps1", [System.Text.Encoding]::UTF8)

# Replace the top extraction block with our clean quizzes
$buildScript = $buildScript -replace '(?s)\$qGemini = Extract-Questions.*?\n(\$newCode =)', "`$qGemini = @'`r`n$qGemini`r`n'@`r`n`$qSec = @'`r`n$qSec`r`n'@`r`n`$qSupport = @'`r`n$qSupport`r`n'@`r`n`$qTI = @'`r`n$qTI`r`n'@`r`n`$1"
$buildScript = $buildScript -replace 'Questions = \r?\n''@ \+ \$q', 'QuizQuestions = `r`n''@ + $q'

# Execute the modified build script block
$scriptBlock = [ScriptBlock]::Create($buildScript)
& $scriptBlock

Write-Host "Rebuilt CurriculumUpgrade.TechAI.cs"
