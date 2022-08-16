package com.teamecho.bookie.qna.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.teamecho.bookie.qna.domain.Answer;
import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.qna.service.AnswerService;
import com.teamecho.bookie.qna.service.AnswerServiceImpl;
import com.teamecho.bookie.qna.service.QnaService;
import com.teamecho.bookie.qna.service.QnaServiceImpl;
import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.service.UserService;

@RestController
public class AnswerController {
	
	@Autowired
	private AnswerService answerService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private QnaService qnaService;
	
	long uId;
	long qnaId;
	User user;
	List<Answer> answer;
	Qna qna;
	
	@RequestMapping(value = "/answer", method = RequestMethod.GET)
	public ModelAndView qnaform(HttpServletRequest request, ModelAndView mv) {
		HttpSession session = request.getSession(false);
		uId = (long) session.getAttribute("uId");

		qnaId = 1;
		System.out.println(uId);
		System.out.println(qnaId);
		
		qna = qnaService.getQnaByQnaId(qnaId);
		System.out.println("진입11"+qna.getUser());

		user = userService.getUserByUid(qna.getUser().getUId());
		mv.addObject("document_q", qna.getDocument());

		answer = answerService.getAnswerByQnaId(qnaId);
		mv.addObject("userId", qna.getUser().getUserId());
		mv.addObject("answer", answer);
		mv.setViewName("qna/qna_answer");
		return mv;
	}
	
	@RequestMapping(value = "/answer", method = RequestMethod.POST)
	public ModelAndView qna(HttpServletRequest request, ModelAndView mv) {
		String documnet = request.getParameter("documnet");
		System.out.println(documnet);
		
		Answer answer = new Answer();
		answer.setDocument(documnet);
		answer.setQna(null);
		answer.setUser(null);
		
		mv.addObject("documnet", documnet);
		mv.setViewName("qna/qna_answer");
		return mv;
	}
}
