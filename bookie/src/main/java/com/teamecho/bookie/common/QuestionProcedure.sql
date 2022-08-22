CREATE PROCEDURE QUESTION_COUNT_PROCEDURE()
BEGIN
	DECLARE totalQuestion INT DEFAULT 0;
	DECLARE koreanQuestion INT DEFAULT 0;
	DECLARE englishQuestion INT DEFAULT 0;
	DECLARE mathQuestion INT DEFAULT 0;
	
	SELECT count(*) INTO totalQuestion
	FROM Question;
	
	SELECT count(*) INTO koreanQuestion
    FROM Question
	WHERE cateid in (SELECT cateid FROM Category WHERE subject = "국어");
	
	SELECT count(*) INTO englishQuestion
    FROM Question
	WHERE cateid in (SELECT cateid FROM Category WHERE subject = "영어");
	
	SELECT count(*) INTO mathQuestion
    FROM Question
	WHERE cateid in (SELECT cateid FROM Category WHERE subject = "수학");
	
	
	SELECT totalQuestion, koreanQuestion, englishQuestion, mathQuestion;
END
