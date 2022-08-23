package com.teamecho.bookie.question.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.teamecho.bookie.common.domain.SubjectPattern;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionPattern;

public class QuestionPatternRowMapper implements RowMapper<QuestionPattern> {

	@Override
	public QuestionPattern mapRow(ResultSet rs, int rowNum) throws SQLException {
		QuestionPattern qp = new QuestionPattern();
		qp.setQpId(rs.getLong("qpId"));
		Question q = new Question(rs.getLong("qId"));
		qp.setQuestion(q);
		SubjectPattern sp = new SubjectPattern(rs.getLong("spId"));
		qp.setSubjectPattern(sp);
		
		return qp;
	}

}
