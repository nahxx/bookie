package com.teamecho.bookie.test.web;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.service.SolveProblemService;
import com.teamecho.bookie.test.service.QuestionCartService;

@Controller
public class ExamSolveController {
	
	@Autowired
	QuestionCartService questionCartService;
	
	@Autowired
	SolveProblemService solveProblemService;
	
	List<Question> mainList;
	
	@GetMapping("/test/examSolve")
	public String examPage(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		long uId = (long) session.getAttribute("uId");
		int cnt = 0;

		List<Question> qList = questionCartService.createExam(uId);
		mainList = new ArrayList<Question>();
		
    	for(int i= 0; i<qList.size(); i++) {
    		if(i == 0) {
    			mainList.add(qList.get(i));
    		}else {
    			cnt = 0;
    			if(qList.get(i).getMainText().getMtId() != 0) {
	    			for(int j=0; j<mainList.size(); j++) {
	    				if(mainList.get(j).getMainText().getMtId() != 0 && ( qList.get(i).getMainText().getMtId() == mainList.get(j).getMainText().getMtId() )) {  
	    					mainList.add(j, qList.get(i));
	    					cnt++;
	    					break;
	    				}
	    			}
    			}
    			if(cnt == 0) {
    				mainList.add(qList.get(i));
    			}
    		}
    	}
    	/*
    	for(Question q : mainList) {
    		System.out.println("문제 키값 : " + q.getQId() + " // "+ "지문 키값 : " + q.getMainText().getMtId());    		
    	}
    	*/
    	model.addAttribute("mainList", mainList);
		return "/test/exam_solve";
	}
	
	@PostMapping("/test/examSolve")
	public String examConfirm(HttpServletRequest request, @RequestParam(value="answer") List<String> answer, Model model) {
		HttpSession session = request.getSession(false);
		long uId = (long) session.getAttribute("uId");
		List<Boolean> answerConfirmList = new ArrayList<Boolean>(); 
		
		for(int i=0; i<answer.size(); i++) {
			boolean answerConfirm = solveProblemService.answerCheckingReturnBoolean(mainList.get(i).getQId(), uId, Integer.valueOf(answer.get(i)));
			answerConfirmList.add(answerConfirm);
		}
		
		//System.out.println(answerConfirmList);
		model.addAttribute("answerConfirmList", answerConfirmList);
		model.addAttribute("mainList", mainList);
		return "/test/exam_solve";
	}
	
	@GetMapping("/test/examComment")
	public String examCommentPage(Model model) {
		model.addAttribute("mainList", mainList);
		return "/test/exam_comment";
	}
}
