package com.teamecho.bookie.question.repository;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionPattern;
import com.teamecho.bookie.question.domain.QuestionText;

@Repository("question.repository.addQuestionDao")
public class AddQuestionDao {
	
	private JdbcTemplate jdbcTemplate;
		
	public AddQuestionDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public void addQuestionText(QuestionText qt) {
		String sql = "INSERT INTO QuestionText (totalText) VALUES (?)";
		jdbcTemplate.update(sql, qt.getTotalText());
	}
	
	public QuestionText findQuestionTextByTotalText(String totalText) {
		String sql = "SELECT * FROM QuestionText WHERE totalText = ?";
		return jdbcTemplate.queryForObject(sql, new QuestionTextRowMapper(), totalText);
	}
	
	public void addQuestion(Question q) {
		String sql = "INSERT INTO Question (qTitle, qText, answer, qComment, qtId, mtId, cateId) VALUES (?, ?, ?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql, q.getQTitle(), q.getQText(), q.getAnswer(), q.getQComment(), q.getQuestionText().getQtId(), q.getMainText().getMtId(), q.getCategory().getCateId());
	}
	
	public void addQuestionNotMtId(Question q) {
		String sql = "INSERT INTO Question (qTitle, qText, answer, qComment, qtId, cateId) VALUES (?, ?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql, q.getQTitle(), q.getQText(), q.getAnswer(), q.getQComment(), q.getQuestionText().getQtId(), q.getCategory().getCateId());
	}
	
	public void addMainText(MainText mt) {
		String sql = "INSERT INTO MainText (mText) VALUES (?)";
		jdbcTemplate.update(sql, mt.getMText());
	}
	
	public MainText findMainTextByMText(String mText) {
		String sql = "SELECT * FROM MainText WHERE mText = ?";
		return jdbcTemplate.queryForObject(sql, new MainTextRowMapper(), mText);
	}
	
	public Question findQuestionByText(String qText) {
		String sql = "SELECT * FROM Question WHERE qText = ?";
		return jdbcTemplate.queryForObject(sql, new QuestionRowMapper(), qText);
	}
	
	public void addQuestionPattern(QuestionPattern qp) {
		String sql = "INSERT INTO QuestionPattern (qId, spId) VALUES (?, ?)";
		jdbcTemplate.update(sql, qp.getQuestion().getQId(), qp.getSubjectPattern().getSpId());
	}
}
