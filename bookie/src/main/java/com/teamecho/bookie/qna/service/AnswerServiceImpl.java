package com.teamecho.bookie.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.qna.domain.Answer;
import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.qna.repository.AnswerDao;
import com.teamecho.bookie.user.service.UserService;

@Service
public class AnswerServiceImpl implements AnswerService {
	@Autowired
	AnswerDao answerDao;
	
	@Autowired
	UserService userService;
	
	@Autowired
	QnaService qnaService;
	
	@Override
	public void addAnswer(Answer answer) {
		answerDao.addAnswer(answer);
	}

	@Override
	public List<Answer> getAnswersByQnaId(long qnaId) {
//		Answer answer = answerDao.getAnswerByQnaId(qnaId);
		List<Answer> answers = answerDao.getAnswersByQnaId(qnaId);
		
		for(Answer answer : answers) {
			long uId = answer.getUser().getUId();
			answer.setUser(userService.getUserByUid(uId));
		}
		return answers;
	}

	@Override
	public Answer getAnswerByQnaId(long qnaId, long anId) {
		return answerDao.getAnswerByQnaId(qnaId, anId);
	}

	@Override
	public List<Answer> getAnswersByUId(long uId) {
		return answerDao.getAnswersByUId(uId);
	}

	@Override
	public void deleteAnswersByQnaId(long qnaId) {
		answerDao.deleteAnswersByQnaId(qnaId);	
	}

	@Override
	public void deleteAnswerByAnId(long anId) {
		answerDao.deleteAnswerByAnId(anId);
	}

	@Override
	public void updateAnswerByAnId(String document, long anId) {
		answerDao.updateAnswerByAnId(document, anId);
	}
	
	@Override
	public List<Answer> getAnswerListByUId(long uId, int pagingNo, int listCount) {
	      int BoardStartItemNo;
	      pagingNo = pagingNo - 1;
	      if (pagingNo == 0) {
	         BoardStartItemNo = 0;
	      }else {
	         BoardStartItemNo = listCount * pagingNo;
	      }
	      List<Answer> answerList = answerDao.findAnswerListByUId(uId, BoardStartItemNo);
	      
	      for(Answer answer : answerList) {
	         answer.setQna(qnaService.getQnaByQnaId(answer.getQna().getQnaId()));
	         answer.setUser(userService.getUserByUid(answer.getUser().getUId()));
	      }
	      return answerList;
	}

	@Override
	public List<Answer> getAllAnswers() {
		return answerDao.getAllAnswers();
	}
}
