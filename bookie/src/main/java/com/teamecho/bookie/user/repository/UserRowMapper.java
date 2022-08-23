package com.teamecho.bookie.user.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.teamecho.bookie.user.domain.User;

public class UserRowMapper implements RowMapper<User>{

	@Override
	public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		User u = new User();
		u.setUId(rs.getLong("uId"));
		u.setUserId(rs.getString("userId"));
		u.setPasswd(rs.getString("passwd"));
		u.setName(rs.getString("name"));
		u.setUType(rs.getString("uType").charAt(0));
		u.setPhone(rs.getString("phone"));
		u.setAddr(rs.getString("addr"));
		u.setManager(rs.getString("manager").charAt(0));
		u.setRegDate(rs.getTimestamp("regDate"));
		return u;
	}
	
}
