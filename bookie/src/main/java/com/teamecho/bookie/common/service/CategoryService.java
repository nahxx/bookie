package com.teamecho.bookie.common.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.repository.CategoryDao;

@Service
public class CategoryService {
	
	@Autowired
	CategoryDao cateDao;
	@Autowired
	CategoryCashService categoryCashService;
	
	public Category getCategory(String cLevel, int grade, String subject) {
		return cateDao.findCategory(cLevel, grade, subject);
	}
	
	public Category getCategoryByCateId(long cateId) {
		return cateDao.findCategoryByCateId(cateId);
	}
	
	public List<Category> getAllCategory() {
		return categoryCashService.getCategories();
	}
}
