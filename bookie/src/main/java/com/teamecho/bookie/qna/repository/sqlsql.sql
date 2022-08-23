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