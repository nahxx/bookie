package com.teamecho.bookie.question.repository;

import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.Question;
import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
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
	
	public List<Question> getUnsolveQuestionByCateogyId(long cateId, long uid) {
		//String sql = "CALL FIND_QUESTION_SAME_CATEGORY(?, ?, ?)";
		String sql = "SELECT a.* FROM (SELECT q.* FROM Question q "
				+ "WHERE q.cateid = ? "
				+ "AND NOT EXISTS (SELECT * FROM QuestionHistory qh WHERE qh.uid = ? AND qh.identify = 'Y' AND q.qid = qh.qid ) "
				+ "ORDER BY RAND() LIMIT ?) a ORDER BY a.mtId";
		return jdbcTemplate.query(sql, new QuestionRowMapper(), cateId, uid, 30);
	}

	public void addQuestionHistory(long uId, long qId, char identify) {
		String sql = "INSERT INTO QuestionHistory (uId, qId, identify) VALUES(?,?,?)";
		jdbcTemplate.update(sql, uId, qId, String.valueOf(identify));
	}

	public Question findQuestionByQuestionId(long question) {
		String sql = "SELECT * FROM Question WHERE qId=?";
		return jdbcTemplate.queryForObject(sql, new QuestionRowMapper(), question);
	}

	public MainText getMainTest(long mtId) {
		String sql = "SELECT * FROM MainText WHERE mtId=?";
		return jdbcTemplate.queryForObject(sql, new RowMapper<MainText>() {
			@Override
			public MainText mapRow(ResultSet resultSet, int i) throws SQLException {
				MainText mainText = new MainText(resultSet.getLong("mtId"), resultSet.getString("mText"), resultSet.getDate("regDate"));
				return mainText;
			}
		}, mtId);
	}
}
