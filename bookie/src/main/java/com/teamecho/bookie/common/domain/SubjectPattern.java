package com.teamecho.bookie.common.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class SubjectPattern {
	private long spId;
	private String bigPattern;
	private String midPattern;
	private Category category;
	private Date regDate;
	
	public SubjectPattern() {
		
	}
}
