$sample = [System.IO.File]::ReadAllLines("CursosCertificadosApp\Data\CurriculumUpgrade.TechAI.cs", [System.Text.Encoding]::UTF8)[28]
Write-Host "Raw line: $sample"
$iso = [System.Text.Encoding]::GetEncoding("iso-8859-1")
$utf8 = [System.Text.Encoding]::UTF8
$bytes = $iso.GetBytes($sample)
$fixed = $utf8.GetString($bytes)
Write-Host "Fixed: $fixed"
