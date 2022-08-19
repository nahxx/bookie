package com.teamecho.bookie.question.web;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AddQuestionsCommand {
	private String cLevel;
	private int grade;
	private String subject;
	private String qText;
	private List<Integer> answerList;
	private List<String> qCommentList;
	private List<String> questionImgArr;
	private int questionCount;
	private String bPattern;
	private String mPattern;
}
