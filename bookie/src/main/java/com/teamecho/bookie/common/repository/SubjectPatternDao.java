package com.teamecho.bookie.common.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.common.domain.SubjectPattern;

@Repository
public class SubjectPatternDao {
	
private JdbcTemplate jdbcTemplate;
	
	public SubjectPatternDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public List<String> findBigPatternsByCateId(long cateId) {
		String sql = "SELECT DISTINCT bigPattern FROM SubjectPattern WHERE cateId = ?";
		return jdbcTemplate.query(sql, new RowMapper<String>() {

			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getString("bigPattern");
			}
			
		}, cateId);
	}
	
	public List<String> findMidPatternsByBigPattern(String bigPattern) {
		String sql = "SELECT midPattern FROM SubjectPattern WHERE bigPattern = ?";
		return jdbcTemplate.query(sql, new RowMapper<String>() {

			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getString("midPattern");
			}
			
		}, bigPattern);
	}
	
	public SubjectPattern findSubjectPatternByBPatternAndMPattern(String bp, String mp) {
		String sql = "SELECT spId FROM SubjectPattern WHERE bigPattern = ? AND MidPattern = ?";
		return jdbcTemplate.queryForObject(sql, new SubjectPatternRowMapper(), bp, mp);
	}
	
}
