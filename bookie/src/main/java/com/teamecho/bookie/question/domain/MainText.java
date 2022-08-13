package com.teamecho.bookie.question.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class MainText {
	private long mtId; // MainText 클래스 키값
	private String mTitle; // 지문 제목
	private String mText; // 지문 텍스트
	private Date regDate;
	
	public MainText() {
		
	}
}
