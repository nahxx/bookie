package com.teamecho.bookie.question.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.teamecho.bookie.question.domain.MainText;


public class MainTextRowMapper implements RowMapper<MainText> {

	@Override
	public MainText mapRow(ResultSet rs, int rowNum) throws SQLException {
		MainText mt = new MainText();
		mt.setMtId(rs.getLong("mtId"));
		mt.setMText(rs.getString("mText"));
		mt.setRegDate(rs.getTimestamp("regDate"));
		return mt;
	}

}
