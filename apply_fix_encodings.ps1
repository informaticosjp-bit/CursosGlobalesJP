$files = @(
    "CursosCertificadosApp\Data\CurriculumUpgrade.CommercialRetail.cs",
    "CursosCertificadosApp\Data\CurriculumUpgrade.OfficeData.cs",
    "CursosCertificadosApp\Data\CurriculumUpgrade.OperationsAdmin.cs",
    "CursosCertificadosApp\Data\CurriculumUpgrade.SoftSkillsHR.cs",
    "CursosCertificadosApp\Data\CurriculumUpgrade.TechAI.cs"
)

$iso = [System.Text.Encoding]::GetEncoding("iso-8859-1")
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
$utf8NoBom = [System.Text.Encoding]::UTF8
$c3 = [char]0x00C3

foreach ($path in $files) {
    $raw = [System.IO.File]::ReadAllText($path, $utf8NoBom)
    if ($raw.Contains($c3)) {
        $bytes = $iso.GetBytes($raw)
        $fixed = $utf8NoBom.GetString($bytes)
        [System.IO.File]::WriteAllText($path, $fixed, $utf8WithBom)
        Write-Host "Fixed and saved with UTF-8 BOM: $path"
    } else {
        Write-Host "No mojibake found in: $path"
    }
}

Write-Host "All files processed successfully!"
