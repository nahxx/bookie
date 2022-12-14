package com.teamecho.bookie.question.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class QuestionText {
	private long qtId; // QuestionText 클래스 키값
	private String totalText; // 지문 텍스트
	private Date regDate;
	
	public QuestionText() {
		
	}
	
	public QuestionText(long qtId) {
		this.qtId = qtId;
	}
}
