# Helper to run a .ps1 file with explicit UTF-8 decoding
function Run-Utf8Script ($scriptPath) {
    Write-Host "Running $scriptPath with UTF-8 encoding..."
    $scriptText = [System.IO.File]::ReadAllText($scriptPath, [System.Text.Encoding]::UTF8)
    $scriptBlock = [ScriptBlock]::Create($scriptText)
    & $scriptBlock
}

Run-Utf8Script "c:\Users\plase\source\repos\CursosCertificadosApp\build_tech_ai.ps1"

# Check line 47-50 of CurriculumUpgrade.TechAI.cs
$lines = [System.IO.File]::ReadAllLines("CursosCertificadosApp\Data\CurriculumUpgrade.TechAI.cs", [System.Text.Encoding]::UTF8)
for ($i = 25; $i -le 30; $i++) {
    Write-Host "$i : $($lines[$i])"
}
