$seeders = @(
    "CursosCertificadosApp\Data\CurriculumSeeder.cs",
    "CursosCertificadosApp\Data\CurriculumSeeder.Tech.cs",
    "CursosCertificadosApp\Data\CurriculumSeeder.Employability.cs",
    "CursosCertificadosApp\Data\BusinessFundamentalsSeeder.cs",
    "CursosCertificadosApp\Data\NewPracticalCoursesSeeder.cs"
)
$c3 = [char]0x00C3
$o_acute = [char]0x00F3

foreach ($s in $seeders) {
    $c = [System.IO.File]::ReadAllText($s, [System.Text.Encoding]::UTF8)
    $hasC3 = $c.Contains($c3)
    $hasO = $c.Contains($o_acute)
    Write-Host "$s -> has \u00C3: $hasC3, has \u00F3 (ó): $hasO"
}
