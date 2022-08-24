SELECT qt.* 
FROM Question qt 
WHERE qt.cateId = 18 
AND ( qt.mtId IS NULL OR qt.mtId IN (
	SELECT q.mtId 
	FROM Question q 
	WHERE q.cateId = qt.cateId 
	AND NOT EXISTS ( SELECT * 
					FROM QuestionHistory qh 
					WHERE qh.uid = 7 
					AND qh.identify = 'Y' 
					AND q.qid = qh.qid )
GROUP BY q.mtId )) 
ORDER BY qt.mtId limit 30;

SELECT q.*
		FROM Question q
		WHERE q.cateid = 16
		AND NOT EXISTS (SELECT * FROM QuestionHistory qh WHERE qh.uid = 7 AND qh.identify = 'Y' AND q.qid = qh.qid )
		ORDER BY RAND() LIMIT 30;
		

		SELECT q.qnaId, q.subject, q.cateid, q.uid, (SELECT COUNT(*) FROM Answer a WHERE q.qnaId = a.qnaId) as answer , q.regDate, qc.qcCount
FROM Qna q INNER JOIN QnaCount qc ON q.qnaId = qc.qnaId 
ORDER BY q.regDate desc LIMIT 0, 10


CALL BOARD_PROCEDURE(0);

CALL FIND_QUESTION_SAME_CATEGORY(18, 8, 30)

SELECT a.* FROM (SELECT q.* FROM Question q WHERE q.cateid = 17 AND NOT EXISTS (SELECT * FROM QuestionHistory qh WHERE qh.uid = 7 AND qh.identify = 'Y' AND q.qid = qh.qid ) ORDER BY RAND() LIMIT 30) a ORDER BY a.mtId;


SELECT bigPattern, midPattern, qid FROM SubjectPattern sp INNER JOIN QuestionPattern qp ON sp.spId = qp.spId WHERE qp.qId = 193;

CALL RANK_USER_PROCEDURE



SELECT q.*, a.identify FROM Question q LEFT JOIN (SELECT * FROM QuestionHistory qh WHERE qh.uid = 7) a ON q.qid = a.qid INNER JOIN QuestionPattern qp ON q.qId = qp.qId WHERE qp.spId = 537 ORDER BY a.identify, RAND()
;