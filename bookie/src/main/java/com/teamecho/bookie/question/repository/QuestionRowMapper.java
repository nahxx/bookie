package com.teamecho.bookie.question.repository;

import org.springframework.jdbc.core.RowMapper;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionText;

import java.sql.ResultSet;
import java.sql.SQLException;



public class QuestionRowMapper implements RowMapper<Question>{

	@Override
	public Question mapRow(ResultSet rs, int rowNum) throws SQLException {
		Question q = new Question();
		QuestionText questionText = new QuestionText();
		MainText mainText = new MainText();
		Category category = new Category();
		category.setCateId(rs.getLong("cateId"));
		questionText.setQtId(rs.getLong("qtId"));
		mainText.setMtId(rs.getLong("mtId"));
		q.setQId(rs.getLong("qId"));
		q.setQText(rs.getString("qText"));
		q.setAnswer(rs.getInt("answer"));
		q.setQComment(rs.getString("qComment"));
		q.setQuestionText(questionText);
		q.setCategory(category);
		q.setMainText(mainText);
		q.setRegDate(rs.getTimestamp("regDate"));
		return q;
	}
}
