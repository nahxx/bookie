package com.teamecho.bookie.question.domain;

import java.util.Date;

import com.teamecho.bookie.common.domain.Category;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class QuestionBoard {
	private long qId; // Question 클래스 키값
	private String qText; // 문제 내용
	private int answer; // 답
	private String qComment; // 해설
	private QuestionText questionText; // QuestionText 클래스
	private Category category; // Category 클래스
	private MainText mainText; // MainText 클래스
	private Date regDate;
	private QuestionHistory questionHistory;
	
	public QuestionBoard() {
		
	}
	
	public QuestionBoard(long qId) {
		this.qId = qId;
	}
	
	public QuestionBoard(String qText, int answer, String qComment, Category category) {
		this.qText = qText;
		this.answer = answer;
		this.qComment = qComment;
		this.category = category;
	}
}
