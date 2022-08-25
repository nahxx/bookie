package com.teamecho.bookie.test.domain;


import com.teamecho.bookie.common.domain.SubjectPattern;
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
    private int totalQuestionCount;
    
    public QuestionCart(){
        lineSubjectPattern = new ArrayList<>();
        totalQuestionCount = 0;
    }
    
    /**
     * 작성자 : PDG
     * lineSubjectPattern 객체에 총 문제의 수를 계산하는 메소드
     */
    public void calcTotalQuestionCount(){
    	totalQuestionCount = 0;
    	for(int i=0; i<lineSubjectPattern.size(); i++) {
    		this.totalQuestionCount += lineSubjectPattern.get(i).getQuestionCount();
    	}
    }

    public void removeLineSubjectPattern() {
        lineSubjectPattern.clear();
    }

    public void eachRemoveLineSubjectPattern(SubjectPattern sp) {
        for(int i=0; i<lineSubjectPattern.size(); i++) {
            if(lineSubjectPattern.get(i).getSubjectPattern().getSpId() == sp.getSpId()){
                lineSubjectPattern.remove(i);
                this.totalQuestionCount -= lineSubjectPattern.get(i).getQuestionCount();
            }
        }
    }
}
