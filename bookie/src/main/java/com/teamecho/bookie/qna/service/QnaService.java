package com.teamecho.bookie.qna.service;

import java.util.List;

import com.teamecho.bookie.qna.domain.Board;
import com.teamecho.bookie.qna.domain.Qna;

public interface QnaService {
	void addQna(Qna qna);
	List<Qna> getAllQna();
	List<Qna> getQnaByUid(long uId);
	List<Qna> getQnaListByUid(long uId, int pagingNo, int listCount);
	Qna getQnaByQnaId(long qnaId);
	List<Board> getQnaBoardList(int pagingNo, int listCount);
	void deleteQna(long qnaId, long uId);
	public void updateQna(Qna qna);
	void boardCounting(long qnaId);
}
