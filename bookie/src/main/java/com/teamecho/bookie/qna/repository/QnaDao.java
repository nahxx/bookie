package com.teamecho.bookie.qna.repository;

import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.qna.domain.Qna;

@Repository
public class QnaDao {
	
	private JdbcTemplate jdbcTemplate;
	
	public QnaDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public void addQna(Qna qna) {
		String sql = "INSERT INTO Qna (subject, document, cateId, uId) VALUES (?,?,?,?)";
		jdbcTemplate.update(sql, qna.getSubject() , qna.getDocument(), qna.getCategory().getCateId(), qna.getUser().getUId());
	}
	
	public List<Qna> findAllQna(){
		String sql = "SELECT * FROM Qna";
		return jdbcTemplate.query(sql, new QnaRowMapper());
	}
	
	public Qna findCQnaByQnaId(long qnaId) {
		String sql = "SELECT * FROM Qna WHERE qnaId = ?";
		return jdbcTemplate.queryForObject(sql, new QnaRowMapper(), qnaId);
	}
}
