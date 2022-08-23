package com.teamecho.bookie.qna.repository;

import java.sql.PreparedStatement;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.qna.domain.Board;
import com.teamecho.bookie.qna.domain.Qna;

@Repository
public class QnaDao {
	
	private JdbcTemplate jdbcTemplate;
	
	public QnaDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public void addQna(Qna qna) {
		String sql = "INSERT INTO Qna (subject, document, cateId, uId) VALUES (?,?,?,?)";
		KeyHolder keyHolder = new GeneratedKeyHolder();
		PreparedStatementCreator creator = (connection) -> {
			PreparedStatement pstmt = connection.prepareStatement(sql, new String[] {"qnaid"});
			pstmt.setString(1, qna.getSubject());
			pstmt.setString(2, qna.getDocument());
			pstmt.setLong(3, qna.getCategory().getCateId());
			pstmt.setLong(4, qna.getUser().getUId());
			return pstmt;
		};
		jdbcTemplate.update(creator, keyHolder);
		
		addQnaCount(keyHolder.getKey().longValue());
	}
	
	public void addQnaCount(long qnaId) {
		String sql = "INSERT INTO QnaCount (qnaId, qcCount) VALUES (?, ?)";
		jdbcTemplate.update(sql, qnaId, 0);
	}
	
	public List<Qna> findAllQna(){
		String sql = "SELECT * FROM Qna";
		return jdbcTemplate.query(sql, new QnaRowMapper());
	}
	
	public List<Qna> findQnaListByUid(long uId, int listViewNo) {
		String sql = "SELECT * FROM Qna WHERE uid = ? ORDER BY regDate desc LIMIT ?, 10";
		return jdbcTemplate.query(sql, new QnaRowMapper(), uId, listViewNo);
	}
	
	public List<Qna> findQnaByUid(long uId){
		String sql = "SELECT * FROM Qna WHERE uid = ?";
		return jdbcTemplate.query(sql, new QnaRowMapper(), uId);
	}

	public Qna findCQnaByQnaId(long qnaId) {
		String sql = "SELECT * FROM Qna WHERE qnaId = ?";
		return jdbcTemplate.queryForObject(sql, new QnaRowMapper(), qnaId);
	}
	
	public List<Board> findQnaBoardList(int BoardStartItemNo){
//		String sql = "SELECT q.qnaId, q.subject, q.cateid, q.uid, q.regDate, qc.qcCount "
//				    + "FROM Qna q INNER JOIN QnaCount qc ON q.qnaId = qc.qnaId"
//		     		+" ORDER BY q.regDate desc LIMIT ?, 10";
		String sql = "CALL BOARD_PROCEDURE(?)";
		return jdbcTemplate.query(sql, new QnaBoardRowMapper(), BoardStartItemNo);
	}
	
	public void deleteQnaByQnaId(long qnaId) {
		deleteQnaCountByQnaId(qnaId);
		String sql = "DELETE FROM Qna WHERE qnaid = ?";
		jdbcTemplate.update(sql, qnaId);
	}
	
	public void updateQnaByQnaId(Qna qna) {
		String sql = "UPDATE Qna SET subject = ? , document = ?, cateId = ? WHERE qnaid = ?";
		jdbcTemplate.update(sql, qna.getSubject(), qna.getDocument(), qna.getCategory().getCateId(), 
				qna.getQnaId());
	}
	
	public void boardCountingByQnaId(long qnaId) {
		String sql = "UPDATE QnaCount SET qcCount = qcCount + 1 WHERE qnaid = ?";
		jdbcTemplate.update(sql, qnaId);
	}
	
	public void deleteQnaCountByQnaId(long qnaId) {
		String sql = "DELETE FROM QnaCount WHERE qnaid = ?";
		jdbcTemplate.update(sql, qnaId);
	}
}
