package com.teamecho.bookie.common.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.qna.repository.QnaRowMapper;

@Repository
public class CategoryDao {
	
	private JdbcTemplate jdbcTemplate;
	
	public CategoryDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	/**
	 * 카테고리 찾기
	 * by knh
	 * @param cLevel
	 * @param grade
	 * @param subject
	 * @return
	 */
	
	public Category findCategory(String cLevel, int grade, String subject) {
		String sql = "SELECT * FROM Category WHERE cLevel = ? AND grade = ? AND subject = ?";
		return jdbcTemplate.queryForObject(sql, new RowMapper<Category>() {

			@Override
			public Category mapRow(ResultSet rs, int rowNum) throws SQLException {
				Category cate = new Category(rs.getLong("cateId"), rs.getString("cLevel").charAt(0), rs.getInt("grade"),
						rs.getString("subject"), rs.getTimestamp("regDate"));
				return cate;
			}
			
		}, cLevel, grade, subject);
	};
	
	public Category findCategoryByCateId(long cateId) {
		String sql = "SELECT * FROM Category WHERE cateId = ? ";
		return jdbcTemplate.queryForObject(sql, new CategoryRowMapper(), cateId);
	}

	public List<Category> getAllCategory() {
		String sql = "SELECT * FROM Category";
		return jdbcTemplate.query(sql, new CategoryRowMapper());
	};
	
}
