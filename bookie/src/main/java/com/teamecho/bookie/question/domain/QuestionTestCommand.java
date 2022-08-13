package com.teamecho.bookie.question.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuestionTestCommand {
	private String questionTitle;
	private String example1;
	private String example2;
	private String example3;
	private String example4;
	private String example5;
	private int answer;
}
