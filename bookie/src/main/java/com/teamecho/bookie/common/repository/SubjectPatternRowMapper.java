package com.teamecho.bookie.common.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.teamecho.bookie.common.domain.SubjectPattern;

public class SubjectPatternRowMapper implements RowMapper<SubjectPattern>{

	@Override
	public SubjectPattern mapRow(ResultSet rs, int rowNum) throws SQLException {
		SubjectPattern sp = new SubjectPattern();
		sp.setSpId(rs.getLong("spId"));
		sp.setPattern(rs.getString("pattern"));
		sp.setSubject(rs.getString("subject"));
		sp.setRegDate(rs.getTimestamp("regDate"));
		return sp;
	}
	
}
