package com.teamecho.bookie.qna.domain;

import java.util.Date;

import com.teamecho.bookie.user.domain.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Answer {
	private long anId;
	private String document;
	private Qna qna;
	private User user;
	private Date regDate;
	
	public Answer() {
		
	}
	
	public Answer(long anId) {
		this.anId = anId;
	}
}

