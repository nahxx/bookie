package com.teamecho.bookie.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamecho.bookie.common.repository.SubjectPatternDao;

@Service
public class SubjectPatternService {
	
	@Autowired
	SubjectPatternDao spDao;
	
	public List<String> getBigPatternsPatternsByCateId(long cateId) {
		return spDao.findBigPatternsByCateId(cateId);
	}
}
