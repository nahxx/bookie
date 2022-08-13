package com.teamecho.bookie.common.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.service.CategoryService;
import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.user.service.UserService;


public class CategoryRowMapper implements RowMapper<Category>{

	@Override
	public Category mapRow(ResultSet rs, int rowNum) throws SQLException {
		Category c = new Category();
		c.setCateId(rs.getLong("cateId"));
		c.setCLevel(rs.getString("cLevel").charAt(0));
		c.setGrade(rs.getInt("grade"));
		c.setSubject(rs.getString("subject"));
		c.setRegDate(rs.getTimestamp("regDate"));
		return c;
	}
}
