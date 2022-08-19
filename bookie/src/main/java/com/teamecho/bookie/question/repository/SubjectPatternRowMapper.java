package com.teamecho.bookie.question.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.domain.SubjectPattern;

public class SubjectPatternRowMapper implements RowMapper<SubjectPattern>{

	@Override
	public SubjectPattern mapRow(ResultSet rs, int rowNum) throws SQLException {
		SubjectPattern sp = new SubjectPattern();
		sp.setSpId(rs.getLong("spId"));
		sp.setBigPattern(rs.getString("bigPattern"));
		sp.setMidPattern(rs.getString("midPattern"));
		Category category = new Category();
		category.setCateId(rs.getLong("cateId"));
		sp.setCategory(category);
		sp.setRegDate(rs.getTimestamp("regDate"));
		return sp;
	}

}
