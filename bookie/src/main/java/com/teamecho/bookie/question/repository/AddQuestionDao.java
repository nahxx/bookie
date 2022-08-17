package com.teamecho.bookie.question.repository;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.question.domain.Question;
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
}
