package com.teamecho.bookie.question.repository;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionText;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;


public class QuestionRowMapper implements RowMapper<Question>{

	@Override
	public Question mapRow(ResultSet rs, int rowNum) throws SQLException {
		Question q = new Question();
		QuestionText questionText = new QuestionText();
		Category category = new Category();
		category.setCateId(rs.getLong("cateId"));
		questionText.setMtId(rs.getLong("mtId"));
		q.setQId(rs.getLong("qId"));
		q.setQText(rs.getString("qText"));
		q.setAnswer(rs.getInt("answer"));
		q.setQComment(rs.getString("qComment"));
		q.setQuestionText(questionText);
		q.setCategory(category);
		return q;
	}
}
