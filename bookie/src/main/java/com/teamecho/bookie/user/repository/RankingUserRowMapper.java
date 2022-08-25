package com.teamecho.bookie.user.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.RowMapper;

import com.teamecho.bookie.user.domain.RankingUser;
import com.teamecho.bookie.user.domain.User;

public class RankingUserRowMapper implements RowMapper<Map<String, String>>{

	@Override
	public Map<String, String> mapRow(ResultSet rs, int rowNum) throws SQLException {
		Map<String, String> u = new HashMap<String, String>();
		
		u.put("uid", String.valueOf(rs.getLong("uid")));
		u.put("total", String.valueOf(rs.getInt("total")));
		u.put("percent", String.valueOf(rs.getInt("(solvedQ / total) * 100")));
		return u;
	}
	
}
