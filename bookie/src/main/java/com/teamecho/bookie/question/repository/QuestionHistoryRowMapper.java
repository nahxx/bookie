package com.teamecho.bookie.question.repository;

import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionHistory;

import com.teamecho.bookie.user.domain.User;

import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;


public class QuestionHistoryRowMapper implements RowMapper<QuestionHistory>{

	@Override
	public QuestionHistory mapRow(ResultSet rs, int rowNum) throws SQLException {
		QuestionHistory qh = new QuestionHistory();
		qh.setQhId(rs.getLong("qhId"));
		qh.setIdentify(rs.getString("identify").charAt(0));
		qh.setRegDate(rs.getTimestamp("regDate"));
		qh.setQuestion(new Question(rs.getLong("qId")));
		qh.setUser(new User(rs.getLong("uId")));
		return qh;
	}
}
