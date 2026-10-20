$env:PGPASSWORD = "admin123"
& "C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d cursos_globales_jp -t -f test_export_q.sql
