package com.teamecho.bookie.qna.repository;

import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.qna.domain.Answer;

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
	
	public List<Answer> getAnswersByQnaId(long qnaId) {
		String sql = "SELECT * FROM Answer WHERE qnaId = ?";
		return jdbcTemplate.query(sql, new AnswerRowMapper(), qnaId);
	}
	
	public Answer getAnswerByQnaId(long qnaId, long anId) {
		String sql = "SELECT * FROM Answer WHERE qnaId = ? AND anId = ?";
		return jdbcTemplate.queryForObject(sql, new AnswerRowMapper(), qnaId, anId);
	}
	
	public Answer findAnswerByAnId(long anId) {
		String sql = "SELECT * FROM Answer WHERE anId = ?";
		return jdbcTemplate.queryForObject(sql, new AnswerRowMapper(), anId);
	}
	
	public List<Answer> getAnswersByUId(long uId) {
		String sql = "SELECT * FROM Answer WHERE uId = ?";
		return jdbcTemplate.query(sql, new AnswerRowMapper(), uId);
	}
	
	public void deleteAnswersByQnaId(long qnaId) {
		String sql = "DELETE FROM Answer WHERE qnaId = ?";
		jdbcTemplate.update(sql, qnaId);
	}
	
	public void deleteAnswerByAnId(long anId) {
		String sql = "DELETE FROM Answer WHERE anId = ?";
		jdbcTemplate.update(sql, anId);
	}
	
	public void updateAnswerByAnId(String document, long anId) {
		String sql = "UPDATE Answer SET document = ? WHERE anId = ?";
		jdbcTemplate.update(sql, document, anId);
	}
	
	public List<Answer> findAnswerListByUId(long uId, int listViewNo) {
	    String sql = "SELECT * FROM Answer WHERE uId = ? ORDER BY regDate desc LIMIT ?, 10";
	    return jdbcTemplate.query(sql, new AnswerRowMapper(), uId, listViewNo);
	}
	
	public List<Answer> getAllAnswers() {
		String sql = "SELECT * FROM Answer";
		return jdbcTemplate.query(sql, new AnswerRowMapper());
	}
}
