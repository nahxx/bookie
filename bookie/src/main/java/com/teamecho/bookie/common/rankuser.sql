CREATE PROCEDURE bookie.RANK_USER_PROCEDURE()
BEGIN
	DECLARE table_size INT DEFAULT 0;
	DECLARE temp_uid LONG;
	DECLARE temp_cnt INT DEFAULT 0;
	DECLARE i INT DEFAULT 1;
	 
	DROP TEMPORARY TABLE IF EXISTS rank_user;
    CREATE TEMPORARY TABLE rank_user (
    	id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
		uid long not null,
		total  int null,
		solvedQ int null
    );


	INSERT INTO rank_user(uid, total)
   	SELECT uid, count(*)
   	FROM QuestionHistory
   	GROUP BY uid;
   	
   	SELECT count(*) INTO table_size
   	from rank_user;
   
    WHILE (i <= table_size) DO
		SELECT uid INTO temp_uid
		FROM rank_user
		WHERE id = i;
		IF temp_uid IS NOT NULL THEN
		   	SELECT count(*) INTO temp_cnt
	   		FROM QuestionHistory
	   		WHERE identify = 'Y'
	   		AND uid = temp_uid;
	    	
	   		UPDATE rank_user
	   		SET solvedQ = temp_cnt
	   		WHERE id = i;
   		END IF;
   		
        SET i = i + 1;
        SET temp_cnt = 0;
    END WHILE;
   		
  SELECT uid, total, (solvedQ / total) * 100
  FROM rank_user
  ORDER BY (solvedQ / total) * 100, total ASC;

END
