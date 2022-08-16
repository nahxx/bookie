package com.teamecho.bookie.qna.service;

import java.util.List;

import com.teamecho.bookie.qna.domain.Qna;

public interface QnaService {
	void addQna(Qna qna);
	List<Qna> getAllQna();
	List<Qna> getAllQnaByUid(long uId);
	Qna getQnaByQnaId(long qnaId);
	List<Qna> getQnaBoardList(int pagingNo, int listCount);
	void deleteQna(long qnaId, long uId);
	public void updateQna(String subject, String document, long qnaId, long uId);
}
