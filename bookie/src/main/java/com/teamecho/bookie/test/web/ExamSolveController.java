package com.teamecho.bookie.test.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.test.service.QuestionCartService;

@Controller
public class ExamSolveController {
	
	@Autowired
	QuestionCartService questionCartService;
	
	@GetMapping("/test/examSolve")
	public String examPage(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		long uId = (long) session.getAttribute("uId");
		
		List<Question> qList = questionCartService.createExam(uId);
		for(Question q : qList) {
			System.out.println("진입 : " + q.getQId());
		}
		model.addAttribute("qList", qList);
		return "/test/exam_solve";
	}
	
}
