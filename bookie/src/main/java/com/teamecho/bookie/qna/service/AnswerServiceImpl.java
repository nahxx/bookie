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
	public Answer getAnswerByQnaId(long qnaId) {
		return answerDao.getAnswerByQnaId(qnaId);
	}

	@Override
	public List<Answer> getAnswersByUId(long uId) {
		return answerDao.getAnswersByUId(uId);
	}

	@Override
	public void deleteAnswersByQnaId(long qnaId, long uId) {
		answerDao.deleteAnswersByQnaId(qnaId, uId);	
	}

	@Override
	public void deleteAnswerByAnId(long anId) {
		answerDao.deleteAnswerByAnId(anId);
	}
}
