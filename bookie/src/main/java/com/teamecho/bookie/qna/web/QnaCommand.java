package com.teamecho.bookie.qna.web;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QnaCommand {
	private String qnaTitle;
	private String content;
	private String level;
	private String grade;
	private String subject;
}
