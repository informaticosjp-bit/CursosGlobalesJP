$c = [System.IO.File]::ReadAllText("CursosCertificadosApp\Data\CurriculumUpgrade.TechAI.cs", [System.Text.Encoding]::UTF8)
$c3 = [char]0x00C3
$fffd = [char]0xFFFD

Write-Host "TechAI.cs -> has \u00C3: $($c.Contains($c3)), has 0xFFFD: $($c.Contains($fffd))"
$lines = $c -split "`r?`n"
for ($i = 25; $i -le 35; $i++) {
    Write-Host "$i : $($lines[$i])"
}
for ($i = 390; $i -le 405; $i++) {
    Write-Host "$i : $($lines[$i])"
}
