$scripts = Get-ChildItem "build_*.ps1"
$c3 = [char]0x00C3
$o_acute = [char]0x00F3
foreach ($s in $scripts) {
    $c = [System.IO.File]::ReadAllText($s.FullName, [System.Text.Encoding]::UTF8)
    $hasC3 = $c.Contains($c3)
    $hasO = $c.Contains($o_acute)
    Write-Host "$($s.Name) -> has \u00C3: $hasC3, has \u00F3 (ó): $hasO"
}
