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
	
	public List<String> findMidPatternsByBigPatternAndCateId(String bigPattern, long cateId) {
		String sql = "SELECT midPattern FROM SubjectPattern WHERE bigPattern = ? AND cateId = ?";
		return jdbcTemplate.query(sql, new RowMapper<String>() {

			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getString("midPattern");
			}
			
		}, bigPattern, cateId);
	}
	
	public SubjectPattern findSubjectPatternByBPatternAndMPatternAndCateId(String bp, String mp, long cateId) {
		String sql = "SELECT * FROM SubjectPattern WHERE bigPattern = ? AND midPattern = ? AND cateId = ?";
		return jdbcTemplate.queryForObject(sql, new SubjectPatternRowMapper(), bp, mp, cateId);
	}

	public SubjectPattern getQuestionPattern(long qId) {
		String sql = "SELECT * FROM SubjectPattern sp WHERE sp.spId = (SELECT spId FROM QuestionPattern qp WHERE qId = ?)";
		return jdbcTemplate.queryForObject(sql, new SubjectPatternRowMapper(), qId );
	}
	
	public SubjectPattern findSubjectPatternBySpId(long spId) {
		String sql = "SELECT * FROM SubjectPattern WHERE spId = ?";
		return jdbcTemplate.queryForObject(sql, new SubjectPatternRowMapper(), spId);
	}

}
