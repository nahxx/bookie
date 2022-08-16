package com.teamecho.bookie.user.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamecho.bookie.qna.domain.Answer;
import com.teamecho.bookie.qna.service.AnswerService;
import com.teamecho.bookie.user.domain.User;

@Controller
@RequestMapping("/user/answerList")
public class AnswerListController {
		
	@Autowired
	private AnswerService answerService;
	
	List<Answer> answerList;
	
	@GetMapping
	public String qnaAllList(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession(false);
		long uid = (long) session.getAttribute("uId");

//		AnswerList = answerService.;
//		session.setAttribute("AnswerList", AnswerList);
		
		return "/user/answerList";
		
	}
}