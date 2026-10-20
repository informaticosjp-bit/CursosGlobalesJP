SELECT json_build_object(
    'slug', c."Slug",
    'order', q."OrderIndex",
    'question', q."QuestionText",
    'explanation', q."Explanation",
    'options', (
        SELECT json_agg(json_build_object('text', o."OptionText", 'isCorrect', o."IsCorrect") ORDER BY o."Id")
        FROM "QuizOptions" o
        WHERE o."QuestionId" = q."Id"
    )
)
FROM "QuizQuestions" q
JOIN "Quizzes" qu ON q."QuizId" = qu."Id"
JOIN "Courses" c ON qu."CourseId" = c."Id"
WHERE c."Slug" = 'sap-business-one-b1-gestion-operativa'
ORDER BY q."OrderIndex"
LIMIT 2;
