package com.teamecho.bookie.admin.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.admin.domain.AdminUserInfo;
import com.teamecho.bookie.admin.repository.AdminDao;
import com.teamecho.bookie.common.domain.QuestionCountForGrade;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionAndQuestionPattern;
import com.teamecho.bookie.question.domain.QuestionHistory;
import com.teamecho.bookie.question.service.QuestionHistoryService;
import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.service.UserService;

@Service("admin.service.adminService")
public class AdminService {
	
	@Autowired
	AdminDao adminDao;
	
	@Autowired
	UserService userService;
	
	@Autowired
	QuestionHistoryService questionHistoryService;
	
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
	
	public AdminUserInfo getAdminUserInfoByUId(long uId) {
		int count = 0;
		double rate = 0;
		double correct = 0;
		User user = null;
		user = userService.getUserByUid(uId);
		List<QuestionHistory> qhl = questionHistoryService.getAllQuestionHistoryByUid(uId);
		
		count = qhl.size();
		
		for (QuestionHistory questionHistory : qhl) {
			if(questionHistory.getIdentify() == 'Y') {
				correct += 1;
			}
		}
		
		if (count != 0 ) {
			rate = Math.round(correct / count * 100) ;
		} else{
			rate = 0;
		}
		
		AdminUserInfo aui = new AdminUserInfo(user, count, rate);
		return aui;
	}
}

