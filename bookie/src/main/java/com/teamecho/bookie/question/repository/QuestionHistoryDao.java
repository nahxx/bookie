package com.teamecho.bookie.question.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
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
	
	public List<QuestionHistory> findAllQuestionHistoryByUId(long uId) {
		String sql = "SELECT * FROM QuestionHistory WHERE uId = ?";
		return jdbcTemplate.query(sql, new QuestionHistoryRowMapper(), uId);
	}
	
	public Question findQuestionByQId(long qId){
		String sql = "SELECT DISTINCT q.*"
				+ "   FROM Question q INNER JOIN QuestionHistory qh ON q.qid = qh.qid"
				+ "   WHERE q.qid = ?";
		return jdbcTemplate.queryForObject(sql, new QuestionRowMapper(), qId);
	}
	
	public Question findQuestionByQId2(long qId){
		String sql = "SELECT * "
				+ "   FROM Question"
				+ "   WHERE qid = ?";
		return jdbcTemplate.queryForObject(sql, new QuestionRowMapper(), qId);
	}
	
	public List<QuestionBoard> getQuestionByUId(long uId, int BoardStartItemNo) {
		String sql = "SELECT q.*, qh.qhId, qh.regDate"
				+ "   FROM Question q INNER JOIN QuestionHistory qh ON q.qid = qh.qid"
				+ "   WHERE qh.uid = ? ORDER BY qh.regDate desc"
				+ "	  LIMIT ? , 10";
		return jdbcTemplate.query(sql, new QuestionBoardRowMapper(), uId, BoardStartItemNo);
	}
	
	public QuestionHistory findQuestionHistoryByQhId(long qhId) {
		String sql = "SELECT * FROM QuestionHistory WHERE qhId = ?";
		return jdbcTemplate.queryForObject(sql, new QuestionHistoryRowMapper(), qhId);
	}

	 public String findSubjectPatternByQid(long qId) {
			String sql = " SELECT bigPattern, midPattern, qid FROM SubjectPattern sp INNER JOIN QuestionPattern qp ON sp.spId = qp.spId WHERE qp.qId = ?";
			return jdbcTemplate.queryForObject(sql, new RowMapper<String>() {
				// 익명 클래스
				@Override
				public String mapRow(ResultSet rs, int rowNum) throws SQLException {
					String s = rs.getString("bigPattern") + " / " + rs.getString("midPattern") +" -> "+ String.valueOf(rs.getLong("qid")) + "번 문제"; 
					return s;
				}
			}, qId);
	}
}
