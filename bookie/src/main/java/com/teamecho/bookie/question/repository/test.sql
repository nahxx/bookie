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