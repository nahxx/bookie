package com.teamecho.bookie.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.common.service.CategoryService;
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
	public Qna getCQnaByQnaId(long qnaId) {
		Qna qna = qnaDao.findCQnaByQnaId(qnaId);
		long cateId = qna.getCategory().getCateId();
		long userId = qna.getUser().getUId();
		qna.setCategory(categoryService.getCategoryByCateId(cateId));
		qna.setUser(userService.getUserByUid(userId));
		return qna;
	}

}
