package com.teamecho.bookie.qna.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	List<Answer> answers;
	Qna qna;
	
	@RequestMapping(value = "/answer/{qnaId}", method = RequestMethod.GET)
	public ModelAndView qnaform(HttpServletRequest request, ModelAndView mv, @PathVariable int qnaId) throws Exception{
		HttpSession session = request.getSession(false);
		uId = (long) session.getAttribute("uId");
		//qnaId = request.getParameter("");
		//qnaId = 1;
		System.out.println(qnaId);
		
		qna = qnaService.getQnaByQnaId(qnaId);
		// 질문 제목
		mv.addObject("subject", qna.getSubject());	
		// 질문		
		mv.addObject("document_q", qna.getDocument());
		// 질문 작성자 아이디
		mv.addObject("userId", qna.getUser().getUserId());
		// 댓글 목록
		answers = answerService.getAnswersByQnaId(qnaId);
		mv.addObject("answers", answers);
		mv.setViewName("qna/qna_answer");
		return mv;
	}
	
	@RequestMapping(value = "/answer", method = RequestMethod.POST)
	public ModelAndView qna(HttpServletRequest request, ModelAndView mv) {
		HttpSession session = request.getSession(false);
		uId = (long) session.getAttribute("uId");
		qnaId = 1;
		
		qna = qnaService.getQnaByQnaId(qnaId);
		// 질문 제목
		mv.addObject("subject", qna.getSubject());	
		// 질문 내용
		mv.addObject("document_q", qna.getDocument());
		// 질문 작성자 아이디
		mv.addObject("userId", qna.getUser().getUserId());
		// 댓글 목록
		answers = answerService.getAnswersByQnaId(qnaId);
		mv.addObject("answers", answers);
		
		// 해당 질문에 대한 답변 쓰기
		// 에디터에서 쓴 글(폼으로)
		String documnet = request.getParameter("documnet");

		Answer answer = new Answer();
		answer.setDocument(documnet);
		// 해당 qnaId를 가진 qna객체
		answer.setQna(qnaService.getQnaByQnaId(qnaId));
		// 현재 로그인한 유저
		answer.setUser(userService.getUserByUid(uId));
		answerService.addAnswer(answer);
		mv.setViewName("qna/qna_answer");
		return mv;
	}
}
