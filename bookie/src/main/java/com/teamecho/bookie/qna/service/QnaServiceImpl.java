package com.teamecho.bookie.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.common.service.CategoryService;
import com.teamecho.bookie.qna.domain.Board;
import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.qna.repository.QnaDao;
import com.teamecho.bookie.user.service.UserService;

@Service
public class QnaServiceImpl implements QnaService{
	@Autowired
	QnaDao qnaDao;
	
	@Autowired
	UserService userService;
	
	@Autowired
	CategoryService categoryService;
	
	@Override
	public void addQna(Qna qna) {
		qnaDao.addQna(qna);
	}

	@Override
	public List<Qna> getAllQna() {
		return qnaDao.findAllQna();
	}
	@Override
	public List<Qna> getQnaByUid(long uId){
		return qnaDao.findQnaByUid(uId);
	}
	
	@Override
	public List<Qna> getQnaListByUid(long uId, int pagingNo, int listCount) {
		int BoardStartItemNo;
		pagingNo = pagingNo - 1;
		if (pagingNo == 0) {
			BoardStartItemNo = 0;
		}else {
			BoardStartItemNo = listCount * pagingNo;
		}
		List<Qna> qnaList = qnaDao.findQnaListByUid(uId, BoardStartItemNo);
		
		for(Qna qna : qnaList) {
			qna.setCategory(categoryService.getCategoryByCateId(qna.getCategory().getCateId()));
			qna.setUser(userService.getUserByUid(qna.getUser().getUId()));
		}
		return qnaList;
	}

	@Override
	public Qna getQnaByQnaId(long qnaId) {
		Qna qna = qnaDao.findCQnaByQnaId(qnaId);
		long cateId = qna.getCategory().getCateId();
		long userId = qna.getUser().getUId();
		qna.setCategory(categoryService.getCategoryByCateId(cateId));
		qna.setUser(userService.getUserByUid(userId));
		return qna;
	}
	
	@Override
	public List<Board> getQnaBoardList(int pagingNo, int listCount){
		int BoardStartItemNo;
		pagingNo = pagingNo - 1;
		if (pagingNo == 0) {
			BoardStartItemNo = 0;
		}else {
			BoardStartItemNo = listCount * pagingNo;
		}
		List<Board> boardList = qnaDao.findQnaBoardList(BoardStartItemNo);
		
		for(Board board : boardList) {
			board.setCategory(categoryService.getCategoryByCateId(board.getCategory().getCateId()));
			board.setUser(userService.getUserByUid(board.getUser().getUId()));
		}
		return boardList;
	}
	
	@Override
	public void deleteQna(long qnaId) {
		qnaDao.deleteQnaByQnaId(qnaId);
	}
	
	@Override
	public void updateQna(Qna qna) {
		qnaDao.updateQnaByQnaId(qna);
	}
	
	@Override
	public void boardCounting(long qnaId) {
		qnaDao.boardCountingByQnaId(qnaId);
	}

}
