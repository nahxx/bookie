package com.teamecho.bookie.question;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.domain.SubjectPattern;
import com.teamecho.bookie.common.service.SubjectPatternService;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionAndQuestionPattern;
import com.teamecho.bookie.question.domain.QuestionPattern;

public class QuesCateQPRowMappper implements RowMapper<QuestionAndQuestionPattern> {
	
	@Autowired
	SubjectPatternService spService;
	
	@Override
	public QuestionAndQuestionPattern mapRow(ResultSet rs, int rowNum) throws SQLException {
		QuestionAndQuestionPattern qaqp = new QuestionAndQuestionPattern();
		Question q = new Question();
		q.setQId(rs.getLong("qId"));
		q.setRegDate(rs.getTimestamp("regDate"));
		qaqp.setQuestion(q);
		
		Category category = new Category();
		category.setCateId(rs.getLong("cateId"));
		category.setCLevel(rs.getString("cLevel").charAt(0));
		category.setGrade(rs.getInt("grade"));
		category.setSubject(rs.getString("subject"));
		q.setCategory(category);
		qaqp.setQuestion(q);
		
		QuestionPattern qp = new QuestionPattern();
		qp.setQpId(rs.getLong("qpId"));
		SubjectPattern sp = new SubjectPattern();
		sp.setSpId(rs.getLong("spId"));
		qp.setSubjectPattern(sp);
		qaqp.setQuestionPattern(qp);
		
		return qaqp;
	}

}
