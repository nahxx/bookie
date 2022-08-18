-- 테이블 삭제
DROP TABLE Answer;
DROP TABLE QnaCount;
DROP TABLE QuestionHistory;
DROP TABLE QuestionPattern;
DROP TABLE Question;
DROP TABLE QuestionText;
DROP TABLE MainText;
DROP TABLE SubjectPattern;
DROP TABLE QNA;
DROP TABLE Category;
DROP TABLE User;


-- 테이블 비우기
DELETE FROM QuestionHistory;
DELETE FROM QuestionPattern;
DELETE FROM Question;
DELETE FROM QuestionText;
DELETE FROM MainText;
DELETE FROM SubjectPattern;
DELETE FROM Category;
DELETE FROM User;
DELETE FROM Qna;
DELETE FROM Answer;
DELETE FROM QnaCount;

-- 테이블 보기
SELECT * FROM User;
SELECT * FROM Category;
SELECT * FROM SubjectPattern;
SELECT * FROM MainText;
SELECT * FROM Question;
SELECT * FROM QuestionPattern;
SELECT * FROM QuestionHistory;
SELECT * FROM Qna;
SELECT * FROM Answer;
SELECT * FROM QnaCount;
SELECT * FROM QuestionText;

-- User 테이블 생성
CREATE TABLE User (
   	uId         	BIGINT         	PRIMARY KEY AUTO_INCREMENT,
   	userId      	VARCHAR(50)     NOT NULL,
   	passwd      	VARCHAR(20)     NOT NULL,
   	name        	VARCHAR(20)     NOT NULL,
   	uType      		CHAR(1)         NOT NULL,
   	phone      		VARCHAR(13)     NOT NULL,
   	addr         	VARCHAR(60)     NOT NULL,
   	manager			CHAR(1)			NOT NULL 	DEFAULT 'N',
   	regDate      	TIMESTAMP       NOT NULL 	DEFAULT CURRENT_TIMESTAMP
)AUTO_INCREMENT = 1;

-- Category 테이블 생성
CREATE TABLE Category (
   	cateId      	BIGINT      	PRIMARY KEY AUTO_INCREMENT,
   	cLevel      	CHAR(1)         NOT NULL,
   	grade      		INT             NOT NULL,
   	subject      	VARCHAR(10)     NOT NULL,
   	regDate      	TIMESTAMP       NOT NULL    DEFAULT CURRENT_TIMESTAMP
)AUTO_INCREMENT=1;

-- SubjectPattern 테이블 생성
CREATE TABLE SubjectPattern (
   	spId      		BIGINT         	PRIMARY KEY AUTO_INCREMENT,
   	pattern      	VARCHAR(20)    	NOT NULL,
   	subject      	VARCHAR(10)    	NOT NULL,
   	regDate      	TIMESTAMP      	NOT NULL	DEFAULT CURRENT_TIMESTAMP
)AUTO_INCREMENT = 1;

-- MainText 테이블 생성
CREATE TABLE MainText (
   	mtId         	BIGINT         	PRIMARY KEY AUTO_INCREMENT,
   	mText      		VARCHAR(3500)  	NOT NULL,
   	regDate      	TIMESTAMP	   	NOT NULL 	DEFAULT CURRENT_TIMESTAMP
)AUTO_INCREMENT = 1;

-- QuestionText 테이블 생성
CREATE TABLE QuestionText (
	qtId			BIGINT			PRIMARY KEY AUTO_INCREMENT,
	totalText		VARCHAR(3500)  	NOT NULL,
	regDate      	TIMESTAMP	   	NOT NULL 	DEFAULT CURRENT_TIMESTAMP
)AUTO_INCREMENT = 1;

-- Question 테이블 생성
CREATE TABLE Question (
	qId				BIGINT			PRIMARY KEY AUTO_INCREMENT,
	qTitle			VARCHAR(100)	NOT NULL,
	qText			VARCHAR(3500)	NOT NULL,
	answer			INT				NOT NULL,
	qComment		VARCHAR(1000)	NULL,
	qtId			BIGINT			NOT NULL,
	mtId			BIGINT			NULL,
	cateId			BIGINT			NOT NULL,
	regDate			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	
	CONSTRAINT	Question_qtId_FK	FOREIGN KEY(qtId) 	REFERENCES	QuestionText(qtId),
	CONSTRAINT	Question_mtId_FK	FOREIGN KEY(mtId) 	REFERENCES	MainText(mtId),
	CONSTRAINT	Question_cateId_FK	FOREIGN KEY(cateId) REFERENCES	Category(cateId)
)AUTO_INCREMENT = 1;

-- QuestionPattern 클래스 생성
CREATE TABLE QuestionPattern (
   	qpId      		BIGINT          PRIMARY KEY AUTO_INCREMENT,
   	qId         	BIGINT          NOT NULL,
   	spId      		BIGINT          NOT NULL,
   	regDate      	TIMESTAMP      	NOT NULL 	DEFAULT CURRENT_TIMESTAMP,
   
   CONSTRAINT QuestionPattern_qId_FK FOREIGN KEY(qId) REFERENCES Question(qId),
   CONSTRAINT QuestionPattern_spId_FK FOREIGN KEY(spId) REFERENCES SubjectPattern(spId)
)AUTO_INCREMENT = 1;

-- QuestionHistory 테이블 생성
CREATE TABLE QuestionHistory(
   	qhId      		BIGINT      	PRIMARY KEY AUTO_INCREMENT,
   	uId         	BIGINT     		NOT NULL,
   	qId         	BIGINT     		NOT NULL,
   	identify   		CHAR(1)      	NOT NULL,
   	regDate      	TIMESTAMP   	NOT NULL   DEFAULT CURRENT_TIMESTAMP,
   
   CONSTRAINT QuestionHistory_uId_FK FOREIGN KEY (uId) REFERENCES User(uId),
   CONSTRAINT QuestionHistory_qId_FK FOREIGN KEY (qId) REFERENCES Question(qId)
)AUTO_INCREMENT = 1;

-- QNA 테이블 생성
CREATE TABLE Qna(
   	qnaId      		BIGINT      	PRIMARY KEY AUTO_INCREMENT,
   	subject			VARCHAR(500)	NOT NULL,
	document		VARCHAR(3500)	NOT NULL,
	cateId			BIGINT			NOT NULL,
   	uId         	BIGINT     		NOT NULL,
   	regDate      	TIMESTAMP   	NOT NULL   DEFAULT CURRENT_TIMESTAMP,
   
   CONSTRAINT Qna_cateId_FK FOREIGN KEY (cateId) REFERENCES Category(cateId),
   CONSTRAINT Qna_uId_FK FOREIGN KEY (uId) REFERENCES User(uId)
)AUTO_INCREMENT = 1;

-- Answer 테이블 생성
CREATE TABLE Answer(
   	anId      		BIGINT      	PRIMARY KEY      AUTO_INCREMENT,
	document		VARCHAR(1500)	NOT NULL,
	qnaId      		BIGINT			NOT NULL,
   	uId         	BIGINT     		NOT NULL,
   	regDate      	TIMESTAMP   	NOT NULL   DEFAULT CURRENT_TIMESTAMP,
   
   CONSTRAINT Answer_qnaId_FK FOREIGN KEY (qnaId) REFERENCES Qna(qnaId),
   CONSTRAINT Answer_uId_FK FOREIGN KEY (uId) REFERENCES User(uId)
)AUTO_INCREMENT = 1;

-- QnaCount 테이블 생성
CREATE TABLE QnaCount(
	qcId			BIGINT			PRIMARY KEY      AUTO_INCREMENT,
	qcCount			INT				NOT NULL DEFAULT 0,
	qnaId			BIGINT			NOT NULL,
	regDate			TIMESTAMP		NOT NULL   DEFAULT CURRENT_TIMESTAMP,
   
	CONSTRAINT QnaCount_qnaId_FK FOREIGN KEY (qnaId) REFERENCES Qna(qnaId)
)AUTO_INCREMENT = 1;