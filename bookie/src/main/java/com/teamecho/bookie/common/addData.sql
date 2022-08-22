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

INSERT INTO Category (cLevel, grade, subject) VALUES ('m', 1, '기타');
INSERT INTO Category (cLevel, grade, subject) VALUES ('m', 2, '기타');
INSERT INTO Category (cLevel, grade, subject) VALUES ('m', 3, '기타');
INSERT INTO Category (cLevel, grade, subject) VALUES ('h', 1, '기타');
INSERT INTO Category (cLevel, grade, subject) VALUES ('h', 2, '기타');
INSERT INTO Category (cLevel, grade, subject) VALUES ('h', 3, '기타');

-- 관리자 user 데이터 추가
INSERT INTO User (userId, passwd, name, uType, phone, addr, manager) VALUES('knh@bookie.com', '1q2w', '관리자1', 'e', '010-1111-1111', '부키', 'Y');
INSERT INTO User (userId, passwd, name, uType, phone, addr, manager) VALUES('pdg@bookie.com', '1q2w', '관리자2', 'e', '010-2222-2222', '부키', 'Y');
INSERT INTO User (userId, passwd, name, uType, phone, addr, manager) VALUES('kdh@bookie.com', '1q2w', '관리자3', 'e', '010-3333-3333', '부키', 'Y');
INSERT INTO User (userId, passwd, name, uType, phone, addr, manager) VALUES('ssj@bookie.com', '1q2w', '관리자4', 'e', '010-4444-4444', '부키', 'Y');
INSERT INTO User (userId, passwd, name, uType, phone, addr, manager) VALUES('gsj@bookie.com', '1q2w', '관리자5', 'e', '010-5555-5555', '부키', 'Y');
INSERT INTO User (userId, passwd, name, uType, phone, addr, manager) VALUES('syj@bookie.com', '1q2w', '관리자6', 'e', '010-6666-6666', '부키', 'Y');