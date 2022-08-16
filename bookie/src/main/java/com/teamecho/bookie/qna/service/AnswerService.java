package com.teamecho.bookie.qna.service;

import java.util.List;

import com.teamecho.bookie.qna.domain.Answer;
import com.teamecho.bookie.qna.domain.Qna;

public interface AnswerService {
	void addAnswer(Answer answer);
	Answer getAnswerByQnaId(long qnaId);
	List<Answer> getAnswersByQnaId(long qnaId);
}
