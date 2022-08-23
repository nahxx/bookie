SELECT qt.* FROM Question qt WHERE qt.cateId = 11
AND ( qt.mtId IS NULL OR qt.mtId IN ( SELECT q.mtId FROM Question q WHERE q.cateId = qt.cateId
AND NOT EXISTS ( SELECT * FROM QuestionHistory qh WHERE qh.uid = 6 AND qh.identify = 'Y' AND q.qid = qh.qid )
GROUP BY q.mtId )) ORDER BY qt.mtId limit 30;

<<<<<<< Updated upstream
CREATE PROCEDURE `FIND_QUESTION_SAME_CATEGORY` ( CATE_ID long, UID long )
BEGIN
   DECLARE MID INTEGER;
   DECLARE MAX_COUNT INTEGER;
   DECLARE RANDOM_NO LONG;
    
     /* 1. 안푼문제들 추출 */
   CREATE TEMPORARY TABLE IF NOT EXISTS temp_question AS (
      SELECT @ROWNUM:=@ROWNUM+1 as r, q.qid as q, q.mtid as m
      FROM Question q , (SELECT @ROWNUM:=0) R
      WHERE q.cateid = CATE_ID
      AND NOT EXISTS (SELECT * FROM Questionhistory qh WHERE qh.uid = UID AND qh.identify = 'Y' AND q.qid = qh.qid )
   );
    
    /* 2. 안푼문제들 총갯수 가져오기 */
   SELECT count(*) INTO MAX_COUNT 
   FROM temp_question;
    
    /* 3. 안푼문제들 총갯수에서 랜덤 값 하나 추출하기 */
   SELECT FLOOR(RAND() * MAX_COUNT) INTO RANDOM_NO;  
    
    /* 4. 랜덤값으로 추출한 문제에서 지문을 가지고 온다. */
    SELECT m INTO MID
    FROM temp_question
    WHERE r = RANDOM_NO;
    
    /* 5. 해당지문 키값으로 문제 전체 가져오기 */
    SELECT *
    FROM Question
    WHERE mtId = MID;
    
END
=======
INSERT INTO questiontext(totalText) VALUES ('<p>지문 지문 입니다 !!</p><p>문제1 문제 입니다 !</p>');
INSERT INTO maintext (mText) VALUES ('<p>지문 입니다 !!</p>');
INSERT INTO question (qText, answer, qComment, qtId, mtId, cateId)
VALUES('<p>문제 입니다 !</p>', 1, '<p>해설입니다 !!!</p>', 1 , 1 , 10);



INSERT INTO questiontext(totalText) VALUES ('<p>지문 지문 입니다 !!</p><p>문제1 문제 입니다 !</p><p>문제2 문제 입니다 !</p><p>문제3 문제 입니다 !</p>');
INSERT INTO maintext (mText) VALUES ('<p>지문 입니다 !!</p>');
INSERT INTO question (qText, answer, qComment, qtId, mtId, cateId)
VALUES('<p>문제1 입니다 !</p>', 1, '<p>해설1 입니다 !!!</p>', 2 , 2 , 10);
INSERT INTO question (qText, answer, qComment, qtId, mtId, cateId)
VALUES('<p>문제2 입니다 !</p>', 1, '<p>해설2 입니다 !!!</p>', 2 , 2 , 10);
INSERT INTO question (qText, answer, qComment, qtId, mtId, cateId)
VALUES('<p>문제3 입니다 !</p>', 1, '<p>해설3 입니다 !!!</p>', 2 , 2 , 10);


CREATE PROCEDURE `FIND_QUESTION_SAME_CATEGORY` (CATE_ID long, UID long)
BEGIN
    DECLARE MID INTEGER;
    DECLARE MAX_COUNT INTEGER;
    DECLARE RANDOM_NO LONG;

    /* 1. 안푼문제들 추출 */
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_question AS (
        SELECT @ROWNUM:=@ROWNUM+1 as r, q.qid as q, q.mtid as m
        FROM Question q , (SELECT @ROWNUM:=0) R
        WHERE q.cateid = CATE_ID
          AND NOT EXISTS (SELECT * FROM Questionhistory qh WHERE qh.uid = UID AND qh.identify = 'Y' AND q.qid = qh.qid )
    );

    /* 2. 안푼문제들 총갯수 가져오기 */
    SELECT count(*) INTO MAX_COUNT
    FROM temp_question;

    /* 3. 안푼문제들 총갯수에서 랜덤 값 하나 추출하기 */
    SELECT FLOOR(RAND() * MAX_COUNT) INTO RANDOM_NO;

    IF RANDOM_NO = 0 THEN
        SET RANDOM_NO = 1;
    END IF;

    /* 4. 랜덤값으로 추출한 문제에서 지문을 가지고 온다. */
    SELECT CASE WHEN m IS NULL THEN 0 ELSE m END INTO MID
    FROM temp_question
    WHERE r = RANDOM_NO;

    /*
       5. 해당지문 키값으로 문제 전체 가져오기
        4번에서 지문의값이 없을때는 0으로 변환하고, 0일때는 랜덤값에 해당하는 qid로 문제를 가져온다.
    */
    IF MID = 0 THEN
        SELECT *
        FROM Question
        WHERE qid = (SELECT q FROM temp_question WHERE r = RANDOM_NO);
    ELSE
        SELECT *
        FROM Question
        WHERE mtId = MID;
    END IF;
END;

CALL FIND_QUESTION_SAME_CATEGORY(10, 2);
>>>>>>> Stashed changes

SELECT * FROM SubjectPattern WHERE bigPattern = "읽기" AND midPattern = "세부 정보 이해" AND cateId = 2;

DELETE FROM MainText WHERE mtId = 22;

SELECT qp.spId, sp.bigPattern, sp.midPattern, count(*) FROM QuestionPattern qp INNER JOIN SubjectPattern sp ON qp.spId = sp.spId
   GROUP BY qp.spId, sp.bigPattern, sp.midPattern
   ;
   
   
SELECT q.qId, q.regDate, c.cateId, c.cLevel, c.grade, c.subject, qp.qpId, qp.spId
FROM Question q
INNER JOIN Category c
ON c.cateId = q.cateId
INNER JOIN QuestionPattern qp
ON qp.qId = q.qId
ORDER BY q.regDate DESC LIMIT 0, 10;
