package com.teamecho.bookie.admin.repository;

import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.user.domain.User;

@Repository
public class AdminDao {

	private JdbcTemplate jdbcTemplate;
	
	public AdminDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	/*
	public List<User> getAllUserList(int BoardStartItemNo) {
		String sql = "SELECT * FROM User ORDER BY regDate desc LIMIT ?, 10";
		return jdbcTemplate.query(sql, null);
	}
	*/
}
