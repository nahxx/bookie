package com.teamecho.bookie.question.repository;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionText;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;


public class QuestionCountRowMapper implements RowMapper<Map<String, String>>{

	@Override
	public Map<String, String> mapRow(ResultSet rs, int rowNum) throws SQLException {
		Map<String, String> questionCount = new HashMap<String, String>();
		
		questionCount.put("totalQuestion", String.valueOf(rs.getInt("totalQuestion")));
		questionCount.put("koreanQuestion", String.valueOf(rs.getInt("koreanQuestion")));
		questionCount.put("englishQuestion", String.valueOf(rs.getInt("englishQuestion")));
		questionCount.put("mathQuestion", String.valueOf(rs.getInt("mathQuestion")));
		
		return questionCount;
	}
}
