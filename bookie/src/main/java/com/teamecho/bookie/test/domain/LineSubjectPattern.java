package com.teamecho.bookie.test.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class LineSubjectPattern {

    private int questionCount; // 문제 갯수
    private long spId; // 과목유형 pk
    private long cateId; // 카테고리 pk

    public LineSubjectPattern(){}

}
