$path = "CursosCertificadosApp\Data\CurriculumUpgrade.TechAI.cs"
$iso = [System.Text.Encoding]::GetEncoding("iso-8859-1")
$utf8 = [System.Text.Encoding]::UTF8
$raw = [System.IO.File]::ReadAllText($path, $utf8)
$bytes = $iso.GetBytes($raw)
$fixed = $utf8.GetString($bytes)

$lines = $fixed -split "`r?`n"
for ($i = 25; $i -le 45; $i++) {
    Write-Host "$i : $($lines[$i])"
}
