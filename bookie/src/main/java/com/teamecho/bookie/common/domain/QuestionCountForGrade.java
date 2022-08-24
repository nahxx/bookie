package com.teamecho.bookie.common.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class QuestionCountForGrade {
	private String grade;
	private long kor;
	private long eng;
	private long math;
	
	public QuestionCountForGrade() {
		
	}
	
	public QuestionCountForGrade(long kor, long eng, long math) {
		this.kor = kor;
		this.eng = eng;
		this.math = math;
	}
}
