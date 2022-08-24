package com.teamecho.bookie.question.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionPattern;
import com.teamecho.bookie.question.domain.QuestionText;
import com.teamecho.bookie.question.repository.AddQuestionDao;

@Service("question.service.addQuestionService")
public class AddQuestionService {
	
	@Autowired
	AddQuestionDao addQDao;
	
	public void addQuestionText(QuestionText qt) {
		addQDao.addQuestionText(qt);
	}
	
	public QuestionText getQuestionTextByTotalText(String totalText) {
		return addQDao.findQuestionTextByTotalText(totalText);
	}
	
	public void addQuestion(Question q) {
		addQDao.addQuestion(q);
	}
	
	public void addQuestionNotMtId(Question q) {
		addQDao.addQuestionNotMtId(q);
	}
	
	public void addMainText(MainText mt) {
		addQDao.addMainText(mt);
	}
	
	public MainText getMainTextByMText(String mText) {
		return addQDao.findMainTextByMText(mText);
	}
	
	public MainText getMainTextByMtId(long mtId) {
		return addQDao.findMainTextByMtId(mtId);
	}
	
	public Question getQuestionByText(String qText) {
		return addQDao.findQuestionByText(qText);
	}
	
	public void addQuestionPattern(QuestionPattern qp) {
		addQDao.addQuestionPattern(qp);
	}
	
	public List<Question> getAllQuestions() {
		return addQDao.findAllQuestions();
	}
	
	public List<QuestionPattern> getAllQuestionPatterns() {
		return addQDao.findAllQuestionPatterns();
	}
	
	/**
	 * 작성자 : 박동근
	 * 내용 :
	 * QuestionText insert할때 스트링값으로 넣고, 리턴으로 key값을 받는다.
	 */
	public long addQuestionTextRetrunID(String text) {
		return addQDao.addQuestionTextRetrunID(text);
	}
	/**
	 * 작성자 : 박동근
	 * 내용 :
	 * QuestionText 키값으로 QuestionText가져온다.
	 */
	public QuestionText getQuestionTextByQtId(long qtId) {
		return addQDao.finQuestionTextByQtId(qtId);
	}
	/**
	 * 작성자 : 박동근
	 * 내용 :
	 * QuestionText 키값으로 Question 리스트 가져온다.
	 */
	public List<Question> getQuestionByQtId(long qtId){
		return addQDao.findQuestionByQtId(qtId);
	}
}
