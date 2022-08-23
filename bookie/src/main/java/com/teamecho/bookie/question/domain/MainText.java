package com.teamecho.bookie.question.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
public class MainText {
    private long mtId; // MainText 클래스 키값
    private String mText; // 지문 텍스트
    private Date regDate;

    public MainText() {
    	
    }
    
    public MainText(long mtId) {
    	this.mtId = mtId;
    }
}
