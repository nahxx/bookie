package com.teamecho.bookie.qna.service;

import java.util.List;

import com.teamecho.bookie.qna.domain.Answer;

public interface AnswerService {
	void addAnswer(Answer answer);
	List<Answer> getAnswersByQnaId(long qnaId);
	Answer getAnswerByQnaId(long qnaId, long anId);
	Answer getAnswerByAnId(long anId);
	List<Answer> getAnswersByUId(long uId);
	void deleteAnswersByQnaId(long qnaId);
	void deleteAnswerByAnId(long anId);
	void updateAnswerByAnId(String document, long anId);
	List<Answer> getAnswerListByUId(long uId, int pagingNo, int listCount);
	List<Answer> getAllAnswers();
}
