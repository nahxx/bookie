package com.teamecho.bookie.qna.repository;

import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.qna.domain.Answer;
import com.teamecho.bookie.qna.domain.Qna;

@Repository
public class AnswerDao {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public AnswerDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public void addAnswer(Answer answer) {
		String sql = "INSERT INTO Answer (document, qnaId, uId) VALUES (?,?,?)";
		jdbcTemplate.update(sql, answer.getDocument(), answer.getQna().getQnaId(), answer.getUser().getUId());
	}
	
	public Answer getAnswerByQnaId(long qnaId) {
		String sql = "SELECT * FROM Answer WHERE qnaId = ?";
		return jdbcTemplate.queryForObject(sql, new AnswerRowMapper(), qnaId);
	}
	
	public List<Answer> getAnswersByQnaId(long qnaId) {
		String sql = "SELECT * FROM Answer WHERE qnaId = ?";
		return jdbcTemplate.query(sql, new AnswerRowMapper(), qnaId);
	}
}
