$env:PGPASSWORD = "admin123"
$raw = & "C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d cursos_globales_jp -t -A -f export_all_quizzes.sql
$lines = $raw -split "`r?`n" | Where-Object { $_.Trim().StartsWith("{") }
$all = "[" + ($lines -join ",`r`n") + "]"
[System.IO.File]::WriteAllText("c:\Users\plase\source\repos\CursosCertificadosApp\all_clean_quizzes.json", $all, [System.Text.Encoding]::UTF8)
Write-Host "Exported $($lines.Count) quiz questions to all_clean_quizzes.json"
