package com.teamecho.bookie.common.service;

import java.util.*;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.domain.CategoryCommand;
import com.teamecho.bookie.common.repository.CategoryDao;

@Component("categoryCashService")
public class CategoryCashService {
	
	@Autowired
	private CategoryDao categoryDao;
	
	@SuppressWarnings("unused")
	private List<Category> categoryList;
	
	@PostConstruct
	public void initialize() {
		categoryList = categoryDao.getAllCategory();
	}
	
	public void checkList(CategoryCommand menuCategory) {
		for(Category category : categoryList) {
			if(!(category.getCLevel() == menuCategory.getCLevel())) {
				categoryList = categoryDao.getAllCategory();				
			}
			if(!(category.getGrade() == menuCategory.getGrade())) {
				categoryList = categoryDao.getAllCategory();							
			}
			if(!category.getSubject().equals(menuCategory.getSubject())) {
				categoryList = categoryDao.getAllCategory();							
			}
		}
	}
	
	public List<Category> getCategories() {
		return categoryList;
	}
}
