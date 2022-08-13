package com.teamecho.bookie.question.repository;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("question.repository.solveProblemRepository")
public class SolveProblemRepository {
	
	private JdbcTemplate jdbcTemplate;
	
	public SolveProblemRepository(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	
}
