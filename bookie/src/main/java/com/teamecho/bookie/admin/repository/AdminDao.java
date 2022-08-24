package com.teamecho.bookie.admin.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.common.domain.SubjectPattern;
import com.teamecho.bookie.common.service.SubjectPatternService;
import com.teamecho.bookie.question.QuesCateQPRowMappper;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionAndQuestionPattern;
import com.teamecho.bookie.question.repository.QuestionRowMapper;
import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.repository.UserRowMapper;

@Repository
public class AdminDao {

	private JdbcTemplate jdbcTemplate;
	
	public AdminDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	@Autowired
	SubjectPatternService spService;

	public List<User> findUserList(int BoardStartItemNo) {
		String sql = "SELECT * FROM User ORDER BY regDate desc LIMIT ?, 10";
		return jdbcTemplate.query(sql, new UserRowMapper(), BoardStartItemNo);
	}
	
	public List<Question> findQuestionList(int BoardStartItemNo) {
		String sql = "SELECT * FROM Question ORDER BY regDate desc LIMIT ?, 10";
		return jdbcTemplate.query(sql, new QuestionRowMapper(), BoardStartItemNo);
	}
	
	public List<QuestionAndQuestionPattern> findQuestionsAndQuestionPatterns(int BoardStartItemNo) {
		String sql = "SELECT q.qId, q.regDate, c.cateId, c.cLevel, c.grade, c.subject, qp.qpId, qp.spId"
					+ " FROM Question q"
					+ " INNER JOIN Category c"
					+ " ON q.cateId = c.cateId"
					+ " INNER JOIN QuestionPattern qp"
					+ " ON qp.qId = q.qId"
					+ " ORDER BY q.regDate desc LIMIT ?, 10";
		List<QuestionAndQuestionPattern> qaqpList = jdbcTemplate.query(sql, new QuesCateQPRowMappper(), BoardStartItemNo);
		
		
		for (QuestionAndQuestionPattern qaqp : qaqpList) {
			long spId = qaqp.getQuestionPattern().getSubjectPattern().getSpId();
			SubjectPattern sp = spService.getSubjectPatternBySpId(spId);
			qaqp.getQuestionPattern().setSubjectPattern(sp);
			
			String bP = qaqp.getQuestionPattern().getSubjectPattern().getBigPattern();
			String mP = qaqp.getQuestionPattern().getSubjectPattern().getMidPattern();
			long qId = qaqp.getQuestion().getQId();
			String spTitle = bP + " / " + mP + " -> " + qId + "번 문제";
			qaqp.setSpTitle(spTitle);
		}
		
		return qaqpList;
	}
	
	public List<QuestionAndQuestionPattern> findQuestionsAndQuestionPatternsByCateId(long cateId, int BoardStartItemNo) {
		String sql = "SELECT q.qId, q.regDate, c.cateId, c.cLevel, c.grade, c.subject, qp.qpId, qp.spId"
					+ " FROM Question q"
					+ " INNER JOIN Category c"
					+ " ON q.cateId = c.cateId"
					+ " INNER JOIN QuestionPattern qp"
					+ " ON qp.qId = q.qId"
					+ " WHERE q.cateId = ?"
					+ " ORDER BY q.regDate desc LIMIT ?, 10";
		List<QuestionAndQuestionPattern> qaqpList = jdbcTemplate.query(sql, new QuesCateQPRowMappper(), cateId, BoardStartItemNo);
		
		for (QuestionAndQuestionPattern qaqp : qaqpList) {
			long spId = qaqp.getQuestionPattern().getSubjectPattern().getSpId();
			SubjectPattern sp = spService.getSubjectPatternBySpId(spId);
			qaqp.getQuestionPattern().setSubjectPattern(sp);
			
			String bP = qaqp.getQuestionPattern().getSubjectPattern().getBigPattern();
			String mP = qaqp.getQuestionPattern().getSubjectPattern().getMidPattern();
			long qId = qaqp.getQuestion().getQId();
			String spTitle = bP + " / " + mP + " -> " + qId + "번 문제";
			qaqp.setSpTitle(spTitle);
		}
		
		return qaqpList;
	}
	
	public long findQuestionCountByCateId(long cateId) {
		String sql = "SELECT Count(*) as cnt FROM Question WHERE cateId = ?";
		return jdbcTemplate.queryForObject(sql, new RowMapper<Long>() {

			@Override
			public Long mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getLong("cnt");
			}
			
		}, cateId);
	}
}
