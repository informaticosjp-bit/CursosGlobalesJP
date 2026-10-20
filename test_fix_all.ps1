$files = @(
    "CursosCertificadosApp\Data\CurriculumUpgrade.CommercialRetail.cs",
    "CursosCertificadosApp\Data\CurriculumUpgrade.OfficeData.cs",
    "CursosCertificadosApp\Data\CurriculumUpgrade.OperationsAdmin.cs",
    "CursosCertificadosApp\Data\CurriculumUpgrade.SoftSkillsHR.cs",
    "CursosCertificadosApp\Data\CurriculumUpgrade.TechAI.cs"
)

$iso = [System.Text.Encoding]::GetEncoding("iso-8859-1")
$utf8 = [System.Text.Encoding]::UTF8
$c3 = [char]0x00C3

foreach ($path in $files) {
    $raw = [System.IO.File]::ReadAllText($path, $utf8)
    $bytes = $iso.GetBytes($raw)
    $fixed = $utf8.GetString($bytes)

    $leftoverC3 = $fixed.Contains($c3)
    Write-Host "$path -> Fixed! Any leftover \u00C3? $leftoverC3"
    
    # Show a sample containing 'Gestión' or 'Módulo' or 'Ágil'
    $lines = $fixed -split "`r?`n"
    $sampleLine = ($lines | Where-Object { $_ -match 'Módulo 1' } | Select-Object -First 1)
    Write-Host "Sample line: $sampleLine"
}
