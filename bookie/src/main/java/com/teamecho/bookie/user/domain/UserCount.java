package com.teamecho.bookie.user.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class UserCount {
	private String day;
	private long userCnt;
	
	public UserCount() {
		
	}
}
