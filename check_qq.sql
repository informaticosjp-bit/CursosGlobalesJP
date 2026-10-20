SELECT c."Slug", q."QuestionText", q."Explanation"
FROM "QuizQuestions" q
JOIN "Quizzes" qu ON q."QuizId" = qu."Id"
JOIN "Courses" c ON qu."CourseId" = c."Id"
WHERE c."Slug" IN ('sap-business-one-b1-gestion-operativa', 'liderazgo-efectivo', 'domina-la-ia-con-gemini')
LIMIT 6;
