package com.teamecho.bookie.question.repository;

import com.teamecho.bookie.question.domain.Question;
import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository("question.repository.solveProblemRepository")
public class SolveProblemRepository {
	
	private JdbcTemplate jdbcTemplate;
	
	public SolveProblemRepository(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}


	public List<Question> getQuestionByCateogyId(long cateId) {
		String sql = "SELECT * FROM Question WHERE cateId=?";
		return jdbcTemplate.query(sql, new QuestionRowMapper(), cateId);
	}
	
	public List<Question> getUnsolveQuestionByCateogyId(long cateId) {
		String sql = "SELECT q.* FROM Question q WHERE q.cateid = ? AND NOT EXISTS (SELECT * FROM Questionhistory qh WHERE qh.uid = 1 AND qh.identify = 'Y' AND q.qid = qh.qid )";
		return jdbcTemplate.query(sql, new QuestionRowMapper(), cateId);
	}

	public void addQuestionHistory(long uId, long qId, char identify) {
		String sql = "INSERT INTO QuestionHistory (uId, qId, identify) VALUES(?,?,?)";
		jdbcTemplate.update(sql, uId, qId, String.valueOf(identify));
	}

	public Question findQuestionByQuestionId(long question) {
		String sql = "SELECT * FROM Question WHERE qId=?";
		return jdbcTemplate.queryForObject(sql, new QuestionRowMapper(), question);
	}
}
