package com.teamecho.bookie.question.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class QuestionAndQuestionPattern {
	private Question question;
	private QuestionPattern questionPattern;
	private String spTitle;
	
	public QuestionAndQuestionPattern() {
		
	}
}
