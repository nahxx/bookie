-- Category 데이터 추가
INSERT INTO Category (cLevel, grade, subject) VALUES ('m', 1, '국어');
INSERT INTO Category (cLevel, grade, subject) VALUES ('m', 1, '영어');
INSERT INTO Category (cLevel, grade, subject) VALUES ('m', 1, '수학');
INSERT INTO Category (cLevel, grade, subject) VALUES ('m', 2, '국어');
INSERT INTO Category (cLevel, grade, subject) VALUES ('m', 2, '영어');
INSERT INTO Category (cLevel, grade, subject) VALUES ('m', 2, '수학');
INSERT INTO Category (cLevel, grade, subject) VALUES ('m', 3, '국어');
INSERT INTO Category (cLevel, grade, subject) VALUES ('m', 3, '영어');
INSERT INTO Category (cLevel, grade, subject) VALUES ('m', 3, '수학');
INSERT INTO Category (cLevel, grade, subject) VALUES ('h', 1, '국어');
INSERT INTO Category (cLevel, grade, subject) VALUES ('h', 1, '영어');
INSERT INTO Category (cLevel, grade, subject) VALUES ('h', 1, '수학');
INSERT INTO Category (cLevel, grade, subject) VALUES ('h', 2, '국어');
INSERT INTO Category (cLevel, grade, subject) VALUES ('h', 2, '영어');
INSERT INTO Category (cLevel, grade, subject) VALUES ('h', 2, '수학');
INSERT INTO Category (cLevel, grade, subject) VALUES ('h', 3, '국어');
INSERT INTO Category (cLevel, grade, subject) VALUES ('h', 3, '영어');
INSERT INTO Category (cLevel, grade, subject) VALUES ('h', 3, '수학');

-- 관리자 user 데이터 추가
INSERT INTO User (userId, passwd, name, uType, phone, addr, manager) VALUES('admin@bookie.com', 'admin', '관리자', 'e', '010-1111-1111', '부키', 'Y');

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