package com.teamecho.bookie.qna.domain;

import java.util.Date;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.user.domain.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Qna {
	private long qnaId;
	private String subject;
	private String document;
	private Category category;
	private User user;
	private Date regDate;
}
