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
	
	public List<String> getMidPatternsByBigPatternAndCateId(String bigPattern, long cateId) {
		return spDao.findMidPatternsByBigPatternAndCateId(bigPattern, cateId);
	}
	
	public SubjectPattern getSubjectPatternByBPatternAndMPatternAndCateId(String bp, String mp, long cateId) {
		return spDao.findSubjectPatternByBPatternAndMPatternAndCateId(bp, mp, cateId);
	}
}
