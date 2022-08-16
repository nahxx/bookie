package com.teamecho.bookie.question.repository;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.Question;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;


public class QuestionRowMapper implements RowMapper<Question>{

	@Override
	public Question mapRow(ResultSet rs, int rowNum) throws SQLException {
		Question q = new Question();
		MainText mainText = new MainText();
		Category category = new Category();
		category.setCateId(rs.getLong("cateId"));
		mainText.setMtId(rs.getLong("mtId"));
		q.setQId(rs.getLong("qId"));
		q.setQTitle(rs.getString("qTitle"));
		q.setQText(rs.getString("qText"));
		q.setAnswer(rs.getInt("answer"));
		q.setQComment(rs.getString("qComment"));
		q.setMainText(mainText);
		q.setCategory(category);
		return q;
	}
}
