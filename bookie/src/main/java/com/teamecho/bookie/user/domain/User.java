package com.teamecho.bookie.user.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class User {
	private long uId;
	private String userId;
	private String passwd;
	private String name;
	private char uType;
	private String phone;
	private char manager;
	private String addr;
	private Date regDate;
	
	public User() {
		
	}
	
	public User(long uId) {
		this.uId = uId;
	}

}

	
