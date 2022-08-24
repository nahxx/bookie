package com.teamecho.bookie.admin.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.admin.repository.AdminDao;
import com.teamecho.bookie.common.domain.QuestionCountForGrade;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionAndQuestionPattern;
import com.teamecho.bookie.user.domain.User;

@Service("admin.service.adminService")
public class AdminService {
	
	@Autowired
	AdminDao adminDao;
	
	public List<User> getUserList(int pagingNo, int listCount) {
		int BoardStartItemNo;
		pagingNo = pagingNo - 1;
		if(pagingNo == 0) {
			BoardStartItemNo = 0;
		} else {
			BoardStartItemNo = listCount * pagingNo;
		}
		List<User> userList = adminDao.findUserList(BoardStartItemNo);
		
		return userList;
	}
	
	public List<Question> getQuestionList(int pagingNo, int listCount) {
		int BoardStartItemNo;
		pagingNo = pagingNo - 1;
		if(pagingNo == 0) {
			BoardStartItemNo = 0;
		} else {
			BoardStartItemNo = listCount * pagingNo;
		}
		List<Question> questionList = adminDao.findQuestionList(BoardStartItemNo);
		
		return questionList;
	}
	
	public List<QuestionAndQuestionPattern> getQuestionsAndQuestionPatterns(int pagingNo, int listCount) {
		int BoardStartItemNo;
		pagingNo = pagingNo - 1;
		if(pagingNo == 0) {
			BoardStartItemNo = 0;
		} else {
			BoardStartItemNo = listCount * pagingNo;
		}
		List<QuestionAndQuestionPattern> qaqpList = adminDao.findQuestionsAndQuestionPatterns(BoardStartItemNo);
		
		return qaqpList;
	}
	
	public List<QuestionAndQuestionPattern> getQuestionsAndQuestionPatternsByCateId(int pagingNo, int listCount, long cateId) {
		int BoardStartItemNo;
		pagingNo = pagingNo - 1;
		if(pagingNo == 0) {
			BoardStartItemNo = 0;
		} else {
			BoardStartItemNo = listCount * pagingNo;
		}
		List<QuestionAndQuestionPattern> qaqpList = adminDao.findQuestionsAndQuestionPatternsByCateId(cateId, BoardStartItemNo);
		
		return qaqpList;
	}
	
	public long getQuestionCountByCateId(long cateId) {
		return adminDao.findQuestionCountByCateId(cateId);
	}
	
	public List<QuestionCountForGrade> getQuestionCountGrades(long cateCnt) {
		List<QuestionCountForGrade> cntList = new ArrayList<>();
		for(long i = 1; i < cateCnt + 1; i += 3) {
			long kor = getQuestionCountByCateId(i);
			long eng = getQuestionCountByCateId(i+1);
			long math = getQuestionCountByCateId(i+2);

			QuestionCountForGrade cnt = new QuestionCountForGrade(kor, eng, math);
			cntList.add(cnt);
		}
		return cntList;
	}
}

