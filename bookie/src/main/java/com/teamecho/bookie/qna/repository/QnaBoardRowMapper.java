package com.teamecho.bookie.qna.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.qna.domain.Board;
import com.teamecho.bookie.user.domain.User;



public class QnaBoardRowMapper implements RowMapper<Board>{
	
	@Override
	public Board mapRow(ResultSet rs, int rowNum) throws SQLException {
		Board b = new Board();
		b.setQnaId(rs.getLong("qnaId"));
		b.setSubject(rs.getString("subject"));
		b.setCategory(new Category(rs.getLong("cateId")));
		b.setUser(new User(rs.getLong("uId")));
		b.setAnswerCount(rs.getInt("answerCount"));
		b.setRegDate(rs.getTimestamp("regDate"));
		b.setQcCount(rs.getInt("qcCount"));
		return b;
	}
}
