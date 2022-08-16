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

INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목1', '<P>본문1</P>',12,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목2', '<P>본문2</P>',13,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목3', '<P>본문3</P>',11,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목4', '<P>본문4</P>',10,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목5', '<P>본문5</P>',3,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목6', '<P>본문6</P>',5,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목7', '<P>본문7</P>',10,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목8', '<P>본문8</P>',12,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목9', '<P>본문9</P>',13,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목10', '<P>본문10</P>',11,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목11', '<P>본문11</P>',10,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목12', '<P>본문12</P>',9,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목13', '<P>본문13</P>',8,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목14', '<P>본문14</P>',7,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목15', '<P>본문15</P>',6,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목16', '<P>본문16</P>',4,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목17', '<P>본문17</P>',3,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목18', '<P>본문18</P>',5,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목19', '<P>본문19</P>',12,1);
INSERT INTO QNA (subject, document, cateId, uid)
VALUES ('제목20', '<P>본문20</P>',13,1);

DELETE FROM Qna WHERE qnaid = 66 AND uid = 2; 

UPDATE Qna SET subject = "하하하하" , document = "<p>dddddddd</p>" WHERE qnaid = 65 AND uid = 1;