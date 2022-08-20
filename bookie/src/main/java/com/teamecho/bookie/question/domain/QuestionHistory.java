package com.teamecho.bookie.question.domain;

import java.util.Date;

import com.teamecho.bookie.user.domain.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuestionHistory {
	private long qhId;
   	private User user;
   	private Question question;
   	private char identify;
   	private Date regDate;
   	
   	public QuestionHistory() {
   		
   	}
   	
   	public QuestionHistory(long qhId) {
   		this.qhId =qhId;
   	}
}
