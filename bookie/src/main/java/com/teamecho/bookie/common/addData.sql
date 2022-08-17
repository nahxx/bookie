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