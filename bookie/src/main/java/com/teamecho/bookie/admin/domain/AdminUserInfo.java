package com.teamecho.bookie.admin.domain;

import com.teamecho.bookie.user.domain.User;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class AdminUserInfo {
	private User user;
	private int count; 	//푼 문제 개수
	private double rate; // 정답률
	
	public AdminUserInfo() {
		
	}
}
