package com.teamecho.bookie.question.repository;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.Question;
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
		QuestionText questionText = new QuestionText();
		MainText mainText = new MainText();
		Category category = new Category();
		category.setCateId(rs.getLong("cateId"));
		questionText.setQtId(rs.getLong("qtId"));
		mainText.setMtId(rs.getLong("mtId"));
		q.setQId(rs.getLong("qId"));
		q.setQText(rs.getString("qText"));
		q.setAnswer(rs.getInt("answer"));
		q.setQComment(rs.getString("qComment"));
		q.setQuestionText(questionText);
		q.setCategory(category);
		q.setMainText(mainText);
		q.setQuestionHistory(new QuestionHistory(rs.getLong("qhId")));
		return q;
	}
}
