# fix_broken_quiz_injections.ps1
# Repairs CurriculumUpgrade.TechAI.cs and CurriculumUpgrade.OfficeData.cs
# by replacing the broken heredoc markers with real C# quiz question data.

$ErrorActionPreference = "Stop"
$dataDir = "c:\Users\plase\source\repos\CursosCertificadosApp\CursosCertificadosApp\Data"
$jsonPath = "c:\Users\plase\source\repos\CursosCertificadosApp\all_clean_quizzes.json"

$raw = [System.IO.File]::ReadAllText($jsonPath, [System.Text.Encoding]::UTF8)
$allQuestions = $raw | ConvertFrom-Json

function Get-QuizCSharp([string]$slug) {
    $questions = $allQuestions | Where-Object { $_.slug -eq $slug } | Sort-Object order
    if ($questions.Count -eq 0) {
        Write-Warning "No questions found for slug: $slug"
        return "new List<UpgradeQuizQuestionData>()"
    }

    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine("new List<UpgradeQuizQuestionData>")
    [void]$sb.AppendLine("                    {")
    
    foreach ($q in $questions) {
        $correctIdx = -1
        $opts = $q.options
        for ($i = 0; $i -lt $opts.Count; $i++) {
            if ($opts[$i].isCorrect) { $correctIdx = $i; break }
        }
        $optA = $opts[0].text -replace '"', '\"'
        $optB = if ($opts.Count -gt 1) { $opts[1].text -replace '"', '\"' } else { "" }
        $optC = if ($opts.Count -gt 2) { $opts[2].text -replace '"', '\"' } else { "" }
        $optD = if ($opts.Count -gt 3) { $opts[3].text -replace '"', '\"' } else { "" }
        $qText = $q.question -replace '"', '\"'
        $expText = $q.explanation -replace '"', '\"'
        $correctLetter = @("A","B","C","D")[$correctIdx]
        if ($correctIdx -lt 0) { $correctLetter = "A" }

        [void]$sb.AppendLine("                        new UpgradeQuizQuestionData {")
        [void]$sb.AppendLine("                            Question    = `"$qText`",")
        [void]$sb.AppendLine("                            OptionA     = `"$optA`",")
        [void]$sb.AppendLine("                            OptionB     = `"$optB`",")
        [void]$sb.AppendLine("                            OptionC     = `"$optC`",")
        [void]$sb.AppendLine("                            OptionD     = `"$optD`",")
        [void]$sb.AppendLine("                            CorrectAnswer = `"$correctLetter`",")
        [void]$sb.AppendLine("                            Explanation = `"$expText`"")
        [void]$sb.AppendLine("                        },")
    }

    [void]$sb.AppendLine("                    }")
    return $sb.ToString().TrimEnd()
}

function Repair-File([string]$filePath, [hashtable]$varToSlug) {
    Write-Host "`nRepairing: $filePath"
    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    
    foreach ($varName in $varToSlug.Keys) {
        $slug = $varToSlug[$varName]
        Write-Host "  Injecting quiz for: $varName -> $slug"
        $quizCSharp = Get-QuizCSharp $slug
        
        # The broken pattern is: QuizQuestions = `r`n'@ + $qVarName + @'
        # We need to replace it with: QuizQuestions = <actual C# list>
        $brokenPattern = "QuizQuestions = ``r``n'@ + `$$varName + @'"
        $replacement   = "QuizQuestions = $quizCSharp"
        
        if ($content.Contains($brokenPattern)) {
            $content = $content.Replace($brokenPattern, $replacement)
            Write-Host "    -> Replaced successfully"
        } else {
            Write-Warning "    -> Pattern NOT found for $varName!"
        }
    }
    
    # Write with UTF-8 BOM
    $utf8Bom = New-Object System.Text.UTF8Encoding($true)
    [System.IO.File]::WriteAllText($filePath, $content, $utf8Bom)
    Write-Host "  Saved with UTF-8 BOM."
}

# ── TechAI ──────────────────────────────────────────────────────────────────
Repair-File "$dataDir\CurriculumUpgrade.TechAI.cs" @{
    "qGemini"  = "domina-la-ia-con-gemini"
    "qSec"     = "introduccion-ciberseguridad"
    "qSupport" = "servicio-tecnico-informatico-soporte-sistemas"
    "qTI"      = "ti-para-el-exito-empresarial"
}

# ── OfficeData ───────────────────────────────────────────────────────────────
Repair-File "$dataDir\CurriculumUpgrade.OfficeData.cs" @{
    "qOfficeBasico"     = "office-basico"
    "qExcelAvanzado"    = "excel-avanzado"
    "qPowerBi"          = "power-bi"
    "qCienciaDatos"     = "ciencia-y-analisis-de-datos"
    "qOfficeIntermedio" = "office-intermedio"
}

Write-Host "`nDone. Now verify with: grep -c 'QuizQuestions' files..."

# Quick verification
foreach ($f in @("CurriculumUpgrade.TechAI.cs", "CurriculumUpgrade.OfficeData.cs")) {
    $c = [System.IO.File]::ReadAllText("$dataDir\$f", [System.Text.Encoding]::UTF8)
    $broken = ([regex]::Matches($c, "QuizQuestions = ``r``n")).Count
    $good   = ([regex]::Matches($c, "QuizQuestions = new List")).Count
    Write-Host "$f => broken=$broken, good=$good"
}
