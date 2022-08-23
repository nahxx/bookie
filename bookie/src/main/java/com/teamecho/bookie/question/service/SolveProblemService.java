package com.teamecho.bookie.question.service;

import com.teamecho.bookie.common.domain.SubjectPattern;
import com.teamecho.bookie.common.repository.SubjectPatternDao;
import com.teamecho.bookie.common.service.CategoryService;
import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.repository.CategoryDao;
import com.teamecho.bookie.question.repository.SolveProblemRepository;

import javax.security.auth.Subject;
import java.util.*;

@Service("question.service.solveProblemService")
public class SolveProblemService {
	
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private SubjectPatternDao subjectPatternDao;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private SolveProblemRepository solveProblemRepository;
	
	public Category findCategory(char cLevel, int grade, String subject) {
		List<Category> categoryList = categoryService.getAllCategory();
		for(Category category : categoryList) {
			if(category.getSubject().equals(subject) && category.getGrade() == grade && String.valueOf(category.getCLevel()).equals(String.valueOf(cLevel))) {
				return category;
			}
		}
		return null;
	}

	public List<Question> findQuestionByCategoryId(long cateId, long uId) {
		List<Question> unsolveQuestionList = solveProblemRepository.getUnsolveQuestionByCateogyId(cateId, uId);
		for(Question question : unsolveQuestionList) {
			if (question.getMainText().getMtId() != 0) {
				question.setMainText(solveProblemRepository.getMainTest(question.getMainText().getMtId()));
			}
		}
		return unsolveQuestionList;
	}

	public void addQuestionHistory(long uId, long qId, char identify) {
		solveProblemRepository.addQuestionHistory(uId, qId, identify);
	}

	public Question findQuestionByQuestionId(long question) {
		return solveProblemRepository.findQuestionByQuestionId(question);
	}

	public void answerChecking(long qId, long uId, int answer) {
		Question question = solveProblemRepository.findQuestionByQuestionId(qId);

		if(question.getAnswer() == answer) {
			solveProblemRepository.addQuestionHistory(uId, qId, 'Y');
		} else {
			solveProblemRepository.addQuestionHistory(uId, qId, 'N');
		}
	}

	public MainText getMainText(long mtId) {
		return solveProblemRepository.getMainTest(mtId);
	}

	public SubjectPattern getQuestionPattern(long qId) {
		return subjectPatternDao.getQuestionPattern(qId);
	}
}
