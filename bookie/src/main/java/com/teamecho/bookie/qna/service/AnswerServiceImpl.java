package com.teamecho.bookie.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.qna.domain.Answer;
import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.qna.repository.AnswerDao;

@Service
public class AnswerServiceImpl implements AnswerService {
	@Autowired
	AnswerDao answerDao;
	
	@Override
	public void addAnswer(Answer answer) {
		answerDao.addAnswer(answer);
	}

	@Override
	public List<Answer> getAnswerByQnaId(long qnaId) {
		return answerDao.getAnswerByQnaId(qnaId);
	}
}
