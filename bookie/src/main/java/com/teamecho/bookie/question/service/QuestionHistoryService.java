package com.teamecho.bookie.question.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.common.service.CategoryService;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionBoard;
import com.teamecho.bookie.question.domain.QuestionHistory;
import com.teamecho.bookie.question.repository.QuestionHistoryDao;

@Service
public class QuestionHistoryService {
	@Autowired
	QuestionHistoryDao qhDao;
	
	@Autowired
	CategoryService categoryService;
	
	
	public List<Question> getAllQuestionHistory(long uId){
		return qhDao.findAllQuestionHistory(uId);
	}
	
	public Question getQuestionByQId(long qId) {
		return qhDao.findQuestionByQId(qId);
	}
	
	public List<QuestionBoard> getQuestionHistory(long uId, int pagingNo, int listCount){
		int BoardStartItemNo;
		pagingNo = pagingNo - 1;
		if (pagingNo == 0) {
			BoardStartItemNo = 0;
		}else {
			BoardStartItemNo = listCount * pagingNo;
		}
		List<QuestionBoard> qbList = qhDao.getQuestionByUId(uId, BoardStartItemNo);
		
		for(QuestionBoard qb : qbList) {
			qb.setCategory(categoryService.getCategoryByCateId(qb.getCategory().getCateId()));
			qb.setQuestionHistory(qhDao.findQuestionHistoryByQhId(qb.getQuestionHistory().getQhId()));
			qb.setSubject(qhDao.findSubjectPatternByQid(qb.getQuestionHistory().getQuestion().getQId()));
		}
		return qbList;
	}
	
	public QuestionHistory getQuestionHistoryByQhId(long qhId) {
		return qhDao.findQuestionHistoryByQhId(qhId);
	}
}
