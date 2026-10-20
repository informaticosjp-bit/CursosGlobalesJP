$scripts = Get-ChildItem "build_*.ps1"
$fffd = [char]0xFFFD
foreach ($s in $scripts) {
    $c = [System.IO.File]::ReadAllText($s.FullName, [System.Text.Encoding]::UTF8)
    $hasFFFD = $c.Contains($fffd)
    Write-Host "$($s.Name) has 0xFFFD: $hasFFFD"
}
