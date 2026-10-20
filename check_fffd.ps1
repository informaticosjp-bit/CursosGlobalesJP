$files = Get-ChildItem "CursosCertificadosApp\Data\CurriculumUpgrade*.cs"
$fffd = [char]0xFFFD
foreach ($f in $files) {
    $c = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $hasFFFD = $c.Contains($fffd)
    Write-Host "$($f.Name) has 0xFFFD (): $hasFFFD"
}
