package com.teamecho.bookie.question.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.Question;
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
}
