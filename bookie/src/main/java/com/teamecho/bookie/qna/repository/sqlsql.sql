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
