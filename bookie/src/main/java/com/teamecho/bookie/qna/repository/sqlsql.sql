SELECT uId, userId, passwd, name, uType, phone, addr, regDate 
FROM User 
WHERE uId=25;

SELECT *
FROM qna;

SELECT u.uId, u.userId, u.name, q.qnaId, q.subject, q.document, q.cateId, q.uId, q.regDate
FROM User u INNER JOIN Qna q ON u.uId = q.uId 
WHERE q.qnaId=1;

SELECT * FROM Category WHERE cateId = 14;

/*
 * 선택한 카테고리에서 내가 풀지 않았거나, 틀린 문제들만 문제를 추출한다.   
 */
select q.*
from Question q
where q.cateid = 15
and not exists (select * from Questionhistory qh where uid = 1 and qh.identify = "Y" and q.qid = qh.qid )
;

select *
from Questionhistory qh
where qh.identify = 'Y'
and uid = 1
and qid = 1

insert into Questionhistory(uid, qid, identify)
values(1,1,'Y')

SELECT subject, uid, cateid, regDate 
FROM qna  ORDER BY q.regDate desc LIMIT 0, 10;


DELETE FROM Qna WHERE qnaid = 66 AND uid = 2; 

UPDATE Qna SET subject = "하하하하" , document = "<p>dddddddd</p>" WHERE qnaid = 65 AND uid = 1;


SELECT q.qnaId, q.subject, q.cateid, q.uid, q.regDate, qc.qcCount FROM qna q INNER JOIN qnacount qc ON q.qnaId = qc.qnaId
ORDER BY q.regDate desc LIMIT 0, 10

SELECT q.qnaId, q.subject, q.cateid, q.uid, q.regDate, qc.qcCount
FROM qna q INNER JOIN qnacount qc ON q.qnaId = qc.qnaId
ORDER BY q.regDate desc LIMIT 0, 10


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

INSERT INTO question (qText, answer, qComment, qtId, cateId)
VALUES('<p>문제4 입니다 !</p>', 1, '<p>해설4 입니다 !!!</p>', 2 , 10);

	SELECT q.qid, q.mtId 
		FROM Question q 
		WHERE q.cateid = 10
		AND NOT EXISTS (SELECT * FROM Questionhistory qh WHERE qh.uid = 1 AND qh.identify = 'Y' AND q.qid = qh.qid)

CALL FIND_QUESTION_SAME_CATEGORY(10, 1);



SELECT @ROWNUM:=@ROWNUM+1 as rownum, q.qid, q.mtId 
		FROM Question q , (SELECT @ROWNUM:=0) R
		WHERE q.cateid = 10
		AND NOT EXISTS (SELECT * FROM Questionhistory qh WHERE qh.uid = 1 AND qh.identify = 'Y' AND q.qid = qh.qid );



