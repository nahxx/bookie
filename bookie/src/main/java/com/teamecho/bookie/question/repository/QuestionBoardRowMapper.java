package com.teamecho.bookie.question.repository;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.QuestionBoard;
import com.teamecho.bookie.question.domain.QuestionHistory;
import com.teamecho.bookie.question.domain.QuestionText;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;


public class QuestionBoardRowMapper implements RowMapper<QuestionBoard>{

	@Override
	public QuestionBoard mapRow(ResultSet rs, int rowNum) throws SQLException {
		QuestionBoard q = new QuestionBoard();
		
		q.setQId(rs.getLong("qId"));
		q.setQText(rs.getString("qText"));
		q.setAnswer(rs.getInt("answer"));
		q.setQComment(rs.getString("qComment"));
		q.setQuestionText(new QuestionText(rs.getLong("qtId")));
		q.setCategory(new Category(rs.getLong("cateId")));
		q.setMainText(new MainText(rs.getLong("mtId")));
		q.setRegDate(rs.getTimestamp("regDate"));
		q.setQuestionHistory(new QuestionHistory(rs.getLong("qhId")));
		return q;
	}
}
