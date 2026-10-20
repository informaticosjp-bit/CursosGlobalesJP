$files = Get-ChildItem "CursosCertificadosApp\Data\*.cs"
$c3 = [char]0x00C3
foreach ($f in $files) {
    $c = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    if ($c.Contains($c3)) {
        Write-Host "$($f.Name) HAS MOJIBAKE (\u00C3 found)"
    } else {
        Write-Host "$($f.Name) is clean"
    }
}
