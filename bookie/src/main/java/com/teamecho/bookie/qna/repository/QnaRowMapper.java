package com.teamecho.bookie.qna.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.user.domain.User;

public class QnaRowMapper implements RowMapper<Qna>{
	
	@Override
	public Qna mapRow(ResultSet rs, int rowNum) throws SQLException {
		Qna q = new Qna();
		q.setQnaId(rs.getLong("qnaId"));
		q.setSubject(rs.getString("subject"));
		q.setDocument(rs.getString("document"));
		q.setCategory(new Category(rs.getLong("cateId")));
		q.setUser(new User(rs.getLong("uId")));
		q.setRegDate(rs.getDate("regDate"));
		return q;
	}
}
