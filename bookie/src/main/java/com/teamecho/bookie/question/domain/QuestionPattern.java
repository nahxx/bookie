package com.teamecho.bookie.question.domain;

import com.teamecho.bookie.common.domain.SubjectPattern;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class QuestionPattern {
	private long qpId; // QuestionPattern 클래스 키값
	private Question question; // Question 클래스
	private SubjectPattern subjectPattern; // SubjectPattern
	
	public QuestionPattern() {
		
	}
}
