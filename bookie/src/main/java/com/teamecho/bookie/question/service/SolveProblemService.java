package com.teamecho.bookie.question.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.repository.CategoryDao;
import com.teamecho.bookie.question.repository.SolveProblemRepository;

@Service("question.service.solveProblemService")
public class SolveProblemService {
	
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private SolveProblemRepository solveProblemRepository;
	
	public Category findCategory(String cLevel, int grade, String subject) {
		return categoryDao.findCategory(cLevel, grade, subject);
	}
	
	
}
