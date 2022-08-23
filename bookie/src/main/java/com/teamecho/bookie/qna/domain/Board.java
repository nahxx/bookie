package com.teamecho.bookie.qna.domain;

import java.util.Date;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.user.domain.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Board {
	private long qnaId;
	private String subject;
	private Category category;
	private User user;
	private int answerCount;
	private Date regDate;
	private int qcCount;
}
