package com.teamecho.bookie.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.repository.UserDao;

@Service
public class UserService {
	
	@Autowired
	private UserDao userDao;
	
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
	
	public User isValidUser(String userId, String passwd) {
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
}
