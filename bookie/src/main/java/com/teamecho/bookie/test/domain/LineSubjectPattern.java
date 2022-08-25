package com.teamecho.bookie.test.domain;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.domain.SubjectPattern;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class LineSubjectPattern {

    private int questionCount; // 문제 갯수
    private SubjectPattern subjectPattern; // 과목유형 pk
    private Category category; // 카테고리 pk

    public LineSubjectPattern(){}

}
