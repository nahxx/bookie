package com.teamecho.bookie.question.repository;

import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionBoard;
import com.teamecho.bookie.question.domain.QuestionHistory;

@Repository
public class QuestionHistoryDao {

	private JdbcTemplate jdbcTemplate;
	
	public QuestionHistoryDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	public List<Question> findAllQuestionHistory(long uId){
		String sql = "SELECT q.*"
				+ "   FROM Question q INNER JOIN QuestionHistory qh ON q.qid = qh.qid"
				+ "   WHERE qh.uid = ?";
		return jdbcTemplate.query(sql, new QuestionRowMapper(), uId);
	}
	
	public List<QuestionBoard> getQuestionByUId(long uId, int BoardStartItemNo) {
		String sql = "SELECT q.*, qh.qhId"
				+ "   FROM Question q INNER JOIN QuestionHistory qh ON q.qid = qh.qid"
				+ "   WHERE qh.uid = ? ORDER BY qh.regDate"
				+ "	  LIMIT ? , 10";
		return jdbcTemplate.query(sql, new QuestionBoardRowMapper(), uId, BoardStartItemNo);
	}
	
	public QuestionHistory findQuestionHistoryByQhId(long qhId) {
		String sql = "SELECT * FROM QuestionHistory WHERE qhId = ?";
		return jdbcTemplate.queryForObject(sql, new QuestionHistoryRowMapper(), qhId);
	}
}
