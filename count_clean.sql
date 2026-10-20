SELECT count(*) as clean_q_count
FROM "QuizQuestions"
WHERE "QuestionText" LIKE '%¿%' OR "QuestionText" LIKE '%ó%' OR "QuestionText" LIKE '%é%' OR "QuestionText" LIKE '%á%' OR "QuestionText" LIKE '%í%';
