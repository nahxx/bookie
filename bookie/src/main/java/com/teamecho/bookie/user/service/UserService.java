package com.teamecho.bookie.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.question.repository.AddQuestionDao;
import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.repository.UserDao;

@Service
public class UserService {
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private AddQuestionDao addQDao;
	
	public void addUser(User user) {
		userDao.addUser(user);
	}
	
	public List<User> getAllUser() {
		return userDao.findAllUsers();	
	}
	
	public User getUserByuType(String uType) {
		return userDao.findUserByuType(uType);	
	}
	
	public User getUserByUid(long uId) {
		return userDao.findUserByUid(uId);
	}
	
	public boolean isValidUser(String userId, String passwd) {
		return userDao.isValidUser(userId, passwd);
	}
	
	public User getUserByUserId(String userId) {
		return userDao.findUserByUserId(userId);
	}
	
	public void updateUser(User user) {
		userDao.updateUser(user);
	}
	
	public int login(String userId, String passwd) {
		return userDao.login(userId, passwd);
	}

	public int checkingUserId(String userId) {
		return userDao.checkingUserId(userId);
	}
	
	
	public Map<String, String> questionCount() {
		return addQDao.questionCount();
	}
	
	public List<Map<String, String>> findrankingUser(){
		return userDao.rankingUser();
	}
	
	public Map<String, String> getRankingUserByUId(long uId) {
		List<Map<String, String>> rankingList = findrankingUser();
		Map<String, String> u = new HashMap<String, String>();
		
		for(Map<String, String> user : rankingList) {
			long checkUId = Long.valueOf(user.get("uid"));
			if(uId == checkUId) {
				u.put("uid", user.get("uid"));
				u.put("total", user.get("total"));
				u.put("percent", user.get("percent"));
			}
			break;
		}
		return u;
	}
}
