package com.teamecho.bookie.user.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.teamecho.bookie.user.domain.User;

@Component("userDao")
public class UserDao {
	private JdbcTemplate jdbcTemplate;

	@Autowired
	public UserDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public void addUser(User user) {
		String sql = "INSERT INTO User (userId, passwd, name, uType, phone, manager, addr) VALUES (?, ?, ?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql, user.getUserId(), user.getPasswd(), user.getName(), String.valueOf(user.getUType()), user.getPhone(), String.valueOf(user.getManager()),user.getAddr());
	}

	public List<User> findAllUsers() {
		String sql = "SELECT uId, userId, passwd, name, uType, phone, manager, addr, regDate FROM User";
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<User>(User.class));
	}
	
	public User findUserByuType(String uType) {
		String sql = "SELECT uId, userId, passwd, name, uType, phone, manager, addr, regDate FROM User WHERE uType=?";
		return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<User>(User.class), uType);
	}
	
	public User findUserByUid(long uId) {
		String sql = "SELECT uId, userId, passwd, name, uType, phone, manager, addr, regDate FROM User WHERE uId=?";
		return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<User>(User.class), uId);
	}
	
	public User isValidUser(String userId, String passwd) {
		String sql = "SELECT uId, userId, passwd, name, uType, phone, manager, addr, regDate FROM User WHERE userId=? and passwd=?";
		return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<User>(User.class), userId, passwd);
	}
	
	public User findUserByUserId(String userId) {
		String sql = "SELECT userId FROM User WHERE userId=?";
		return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<User>(User.class), userId);
	}

	public void updateUser(User user) {
		String sql = "UPDATE User SET passwd=?, name=?, uType=?, phone=?, addr=? WHERE uId = ?";
		jdbcTemplate.update(sql, user.getPasswd(), user.getName(), String.valueOf(user.getUType()), user.getPhone(), user.getAddr(), user.getUId());
	}
	
	public int checkingUserId(String userId) {
		try {
			String sql = "SELECT userId FROM User WHERE userId=?";
			return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<Integer>() {
				
				public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
					if (rs.getString(1).contentEquals(userId)) {
						return 1; // 생성 불가
					}
					return null;
				}

			}, userId);
		} catch (IncorrectResultSizeDataAccessException error) {
			return 2;
		}
	}
	
	public int login(String userId, String passwd) {
		try {
			String sql = "SELECT userId, passwd FROM User WHERE userId=? and passwd=?";
			return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<Integer>() {
				
				public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
					if (rs.getString(1).contentEquals(userId)) {
						return 1; // 생성 불가
					}
					return null;
				}

			}, userId, passwd);
		} catch (IncorrectResultSizeDataAccessException error) {
			return 2;
		}
	}
}