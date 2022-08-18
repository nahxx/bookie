package com.teamecho.bookie.question.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.teamecho.bookie.question.domain.QuestionText;

public class QuestionTextRowMapper implements RowMapper<QuestionText> {

	@Override
	public QuestionText mapRow(ResultSet rs, int rowNum) throws SQLException {
		QuestionText questionText = new QuestionText();
		questionText.setQtId(rs.getLong("qtId"));
		questionText.setTotalText(rs.getString("totalText"));
		questionText.setRegDate(rs.getTimestamp("regDate"));
		return questionText;
	}

}
