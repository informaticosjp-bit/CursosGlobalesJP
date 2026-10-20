$file = "CursosCertificadosApp\Data\CurriculumUpgrade.SoftSkillsHR.cs"
$c = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
$slugs = @(
    'filosofia-empresarial-etica-laboral',
    'atencion-al-cliente-presencial-fidelizacion',
    'atencion-al-cliente',
    'trabajo-en-equipo-habilidades-blandas-productividad',
    'liderazgo-efectivo',
    'tacticas-de-negociacion-efectiva',
    'gestion-del-tiempo',
    'primeros-auxilios'
)
foreach ($s in $slugs) {
    $pattern = '(?s)Slug\s*=\s*"' + [regex]::Escape($s) + '".*?QuizQuestions\s*=\s*(new List<UpgradeQuizQuestionData>\s*\{.*?\n\s*\})\s*\}'
    if ($c -match $pattern) {
        Write-Host "Found ${s}: $($matches[1].Length) chars"
    } else {
        Write-Warning "NOT found $s"
    }
}
