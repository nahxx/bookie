package com.teamecho.bookie.test.service;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.domain.SubjectPattern;
import com.teamecho.bookie.common.exception.DuplicateQuestionPattern;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.test.domain.LineSubjectPattern;
import com.teamecho.bookie.test.domain.QuestionCart;
import com.teamecho.bookie.test.repository.CreateExamDao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("test.service.questionCartService")
public class QuestionCartService {

    @Autowired
    private QuestionCart questionCart;
    
    @Autowired
    private CreateExamDao createExamDao;

	public List<LineSubjectPattern> addQuestionPattern(Category category, SubjectPattern subjectPattern, int questionNum) throws DuplicateQuestionPattern {
		boolean flag = true;

		for(LineSubjectPattern lp : questionCart.getLineSubjectPattern()) {
			if(lp.getSubjectPattern().getSpId() == subjectPattern.getSpId()) {
				//같은 이름이 존재할때 처리.
				flag = false;
				throw new DuplicateQuestionPattern("이미 존재하는 유형입니다.");
			}
		}

		if(flag == true) {
			return addQuestionPatternObject(category, subjectPattern, questionNum);
		}
		return null;
	}

	/**
	 * 작성자: 서영정
	 * 같은 유형이 아닐때 cart에 담김
	 * 근데 유형이 담길때 calcTotalQuestionCount() 이것도 실행시켜야하나요 ..???
	 * @param category
	 * @param subjectPattern
	 * @param questionNum
	 */
	public List<LineSubjectPattern> addQuestionPatternObject(Category category, SubjectPattern subjectPattern, int questionNum) {
		LineSubjectPattern cartItem = new LineSubjectPattern();
		cartItem.setQuestionCount(questionNum);
		cartItem.setCategory(category);
		cartItem.setSubjectPattern(subjectPattern);

		questionCart.getLineSubjectPattern().add(cartItem);
		return questionCart.getLineSubjectPattern();
	}

	public void removeList(){
		questionCart.removeLineSubjectPattern();
	}

	public List<LineSubjectPattern> eachRemoveList(SubjectPattern sp) {
		questionCart.eachRemoveLineSubjectPattern(sp);
		return questionCart.getLineSubjectPattern();
	}
    
    /**
     * 작성자 : PDG
     * 문제 추출하는 서비스메소드 사용자 키값 받아서 넘겨준다.
     * LineSubjectPattern의 리스트를 보관하는 QuestionCart로 문제유형과 문제수량을 가져온다.
     *  ?: 사용자 아이디도 LineSubjectPattern 받으면 좀더 편리할까?
     *  나중에는 문제 생성을 다하면 객체도 비워줘야겠다.
     * @param uid
     * @return
     */
    public List<Question> createExam(long uid){
    	
    	List<Question> list = new ArrayList<Question>();
    	for(int i = 0; i<questionCart.getLineSubjectPattern().size(); i++) {
    		for(Question q : createExamDao.createExam(uid, questionCart.getLineSubjectPattern().get(i))) {
        		list.add(q);
        	}
    	}
    	questionCart = new QuestionCart(); //객체 초기화 담긴 리스트를 초기화 한다.
    	return list;
    }

	public void calcTotalQuestionCount() {
		questionCart.calcTotalQuestionCount();
	}

	public String getTotalQuestionCount() {
		return String.valueOf(questionCart.getTotalQuestionCount());
	}

}
