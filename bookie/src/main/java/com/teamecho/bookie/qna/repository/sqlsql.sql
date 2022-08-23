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

CALL FIND_QUESTION_SAME_CATEGORY(17, 8, 30)