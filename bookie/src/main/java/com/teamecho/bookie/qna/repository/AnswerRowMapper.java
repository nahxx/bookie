package com.teamecho.bookie.qna.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.teamecho.bookie.qna.domain.Answer;
import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.user.domain.User;

public class AnswerRowMapper implements RowMapper<Answer>{

	@Override
	public Answer mapRow(ResultSet rs, int rowNum) throws SQLException {
		Answer a = new Answer();
		a.setAnId(rs.getLong("anId"));
		a.setDocument(rs.getString("document"));
		a.setQna(new Qna(rs.getLong("qnaId")));
		a.setUser(new User(rs.getLong("uId")));
		a.setRegDate(rs.getDate("regDate"));
		return a;
	}
	
}
