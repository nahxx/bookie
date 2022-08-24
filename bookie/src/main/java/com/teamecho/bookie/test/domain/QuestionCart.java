package com.teamecho.bookie.test.domain;


import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Component(value = "questionCart")
public class QuestionCart {

    private List<LineSubjectPattern> lineSubjectPattern;

    public QuestionCart(){
        lineSubjectPattern = new ArrayList<>();
    }
}
