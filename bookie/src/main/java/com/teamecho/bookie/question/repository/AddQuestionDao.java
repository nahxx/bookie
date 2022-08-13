package com.teamecho.bookie.question.repository;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.question.domain.Question;

@Repository("question.repository.addQuestionDao")
public class AddQuestionDao {
	
	private JdbcTemplate jdbcTemplate;
		
	public AddQuestionDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public void addQuestionNotMainText(Question question) {
		String sql = "INSERT INTO Question (qTitle, qText, answer, qComment, cateId) VALUES (?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql, question.getQTitle(), question.getQText(), question.getAnswer(), question.getQComment(), question.getCategory().getCateId());
	}
}
