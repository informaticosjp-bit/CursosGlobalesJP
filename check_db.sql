SELECT COUNT(*) as total_courses FROM "Courses";
SELECT COUNT(*) as total_modules FROM "CourseModules";
SELECT COUNT(*) as total_lessons FROM "Lessons";
SELECT COUNT(*) as total_quizzes FROM "Quizzes";
SELECT COUNT(*) as total_questions FROM "QuizQuestions";
SELECT c."Title", length(l."ContentHtml") as html_len
FROM "Courses" c
JOIN "CourseModules" m ON m."CourseId" = c."Id"
JOIN "Lessons" l ON l."ModuleId" = m."Id"
WHERE c."Slug" = 'ingles-a1-english-fundamentals'
LIMIT 2;
SELECT c."Title", length(l."ContentHtml") as html_len, left(l."Summary", 60) as summary
FROM "Courses" c
JOIN "CourseModules" m ON m."CourseId" = c."Id"
JOIN "Lessons" l ON l."ModuleId" = m."Id"
WHERE c."Slug" IN ('sap-business-one-b1-gestion-operativa', 'liderazgo-efectivo', 'excel-avanzado-macros-dashboards')
LIMIT 3;
