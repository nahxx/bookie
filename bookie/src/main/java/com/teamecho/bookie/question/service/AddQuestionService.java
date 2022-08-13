package com.teamecho.bookie.question.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.repository.AddQuestionDao;

@Service("question.service.addQuestionService")
public class AddQuestionService {
	
	@Autowired
	AddQuestionDao addQDao;
	
	public void addQuestionNotMainText(Question question) {
		addQDao.addQuestionNotMainText(question);
	}
}
