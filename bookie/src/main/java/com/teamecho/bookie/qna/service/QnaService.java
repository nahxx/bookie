package com.teamecho.bookie.qna.service;

import java.util.List;

import com.teamecho.bookie.qna.domain.Qna;

public interface QnaService {
	void addQna(Qna qna);
	List<Qna> getAllQna();
	Qna getCQnaByQnaId(long qnaId);
}
