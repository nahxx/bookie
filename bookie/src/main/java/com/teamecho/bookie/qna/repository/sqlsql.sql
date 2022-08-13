SELECT uId, userId, passwd, name, uType, phone, addr, regDate 
FROM User 
WHERE uId=25;

SELECT *
FROM qna;

SELECT u.uId, u.userId, u.name, q.qnaId, q.subject, q.document, q.cateId, q.uId, q.regDate
FROM User u INNER JOIN Qna q ON u.uId = q.uId 
WHERE q.qnaId=1;

SELECT * FROM Category WHERE cateId = 14;