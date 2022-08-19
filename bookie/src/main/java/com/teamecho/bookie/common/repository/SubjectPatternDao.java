package com.teamecho.bookie.common.repository;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import com.teamecho.bookie.common.domain.SubjectPattern;

public class SubjectPatternDao {
	
private JdbcTemplate jdbcTemplate;
	
	public SubjectPatternDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public List<SubjectPattern> findSubjectPatternsBySubject(String subject) {
		String sql = "SELECT * FROM SubjectPattern WHERE subject = ?";
		return jdbcTemplate.query(sql, new SubjectPatternRowMapper(), subject);
	}
}
