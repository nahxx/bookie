package com.teamecho.bookie.common.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.teamecho.bookie.common.domain.SubjectPattern;
import com.teamecho.bookie.common.repository.SubjectPatternDao;

public class SubjectPatternService {
	
	@Autowired
	SubjectPatternDao spDao;
	
	public List<String> getSubjectPatternList(String subject) {
		List<SubjectPattern> spList = spDao.findSubjectPatternsBySubject(subject);
		List<String> sp = new ArrayList<String>();
		
		for(String str : sp) {
			sp.add(str);
		}
		return sp;
	}
}
