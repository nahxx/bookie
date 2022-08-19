package com.teamecho.bookie.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.common.domain.SubjectPattern;
import com.teamecho.bookie.common.repository.SubjectPatternDao;

@Service
public class SubjectPatternService {
	
	@Autowired
	SubjectPatternDao spDao;
	
	public List<String> getBigPatternsPatternsByCateId(long cateId) {
		return spDao.findBigPatternsByCateId(cateId);
	}
	
	public List<String> getMidPatternsByBigPattern(String bigPattern) {
		return spDao.findMidPatternsByBigPattern(bigPattern);
	}
	
	public SubjectPattern getSubjectPatternByBPatternAndMPattern(String bp, String mp) {
		return spDao.findSubjectPatternByBPatternAndMPattern(bp, mp);
	}
}
