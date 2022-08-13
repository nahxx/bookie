package com.teamecho.bookie.common.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class Category {
	private long cateId;
	private char cLevel;
	private int grade;
	private String subject;
	private Date regDate;
	
	public Category() {
		
	}
	
	public Category(long cateId) {
		this.cateId = cateId;
	}
}
