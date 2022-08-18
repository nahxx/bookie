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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamecho.bookie.common.service.CategoryService;
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
	
	@Autowired
	CategoryService categoryService;
	
	long uId;
	User user;
	List<Answer> answers;
	Answer answer;
	Qna qna;
	
	// 댓글 폼
	@RequestMapping(value = "/answer/{qnaId}", method = RequestMethod.GET)
	public ModelAndView qnaForm(HttpServletRequest request, ModelAndView mv, @PathVariable int qnaId) throws Exception{
		HttpSession session = request.getSession(false);
		uId = (long) session.getAttribute("uId");
		// 세션 uId로 uType 'e' 찾기
		user = userService.getUserByUid(uId);
		mv.addObject("uType", user.getUType());
		qnaService.boardCounting(qnaId);
		qna = qnaService.getQnaByQnaId(qnaId);
		// 유저 세션
		mv.addObject("uId_session", uId);
		// 질문 쓴 유저
		mv.addObject("uId", qna.getUser().getUId());
		// 질문 제목
		mv.addObject("subject", qna.getSubject());	
		// 질문		
		mv.addObject("document_q", qna.getDocument());
		// 질문 작성자 아이디
		mv.addObject("name", qna.getUser().getName());
		// 댓글 목록
		answers = answerService.getAnswersByQnaId(qnaId);
		mv.addObject("qnaId", qnaId);
		mv.addObject("answers", answers);
		mv.setViewName("qna/qna_answer");
		return mv;
	}
	
	// 댓글 작성
	@RequestMapping(value = "/answer/insert/{qnaId}", method = RequestMethod.POST)
	public ModelAndView answerInsert(HttpServletRequest request, ModelAndView mv, @PathVariable int qnaId) throws Exception{
		HttpSession session = request.getSession(false);
		uId = (long) session.getAttribute("uId");
		// 세션 uId로 uType 'e' 찾기
		user = userService.getUserByUid(uId);
		mv.addObject("uType", user.getUType());
		
		qna = qnaService.getQnaByQnaId(qnaId);
		// 유저 세션
		mv.addObject("uId_session", uId);
		// 질문 쓴 유저
		mv.addObject("uId", qna.getUser().getUId());
		// 질문 제목
		mv.addObject("subject", qna.getSubject());	
		// 질문 내용
		mv.addObject("document_q", qna.getDocument());
		// 질문 작성자 아이디
		mv.addObject("name", qna.getUser().getName());
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
		mv.addObject("answer", answer);
		//mv.setViewName("qna/qna_answer");
		mv.setViewName("redirect:/answer/{qnaId}");
		return mv;
	}
	
	// 댓글 삭제
	@RequestMapping(value = "/answer/delete/{qnaId}/{anId}", method = RequestMethod.POST)
	public ModelAndView answerDelete(HttpServletRequest request, ModelAndView mv, @PathVariable int qnaId, @PathVariable int anId){
		answers = answerService.getAnswersByQnaId(qnaId);
		answerService.deleteAnswerByAnId(anId);	
		mv.addObject("answers", answers);
		mv.setViewName("redirect:/answer/{qnaId}");
		return mv;
	}
	
	// 댓글 수정 get
	@RequestMapping(value = "/answer/update/{qnaId}/{anId}", method = RequestMethod.GET)
	public ModelAndView answerUpdateForm(HttpServletRequest request, ModelAndView mv, @PathVariable int qnaId, @PathVariable int anId, RedirectAttributes redirectAttributes){
		answer = answerService.getAnswerByQnaId(qnaId, anId);
		String document = answer.getDocument();
		String doc = document.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
		redirectAttributes.addFlashAttribute("update_answer_d", doc);
		redirectAttributes.addFlashAttribute("update_answer", answer);
		mv.setViewName("redirect:/answer/{qnaId}");
		return mv;
	}
	
	// 댓글 수정 post
	@RequestMapping(value = "/answer/update/{qnaId}/{anId}", method = RequestMethod.POST)
	public ModelAndView answerUpdate(HttpServletRequest request, ModelAndView mv, @PathVariable int qnaId, @PathVariable int anId, RedirectAttributes redirectAttributes){
		String documnet = request.getParameter("documnet");
		answerService.updateAnswerByAnId(documnet, anId);
		answers = answerService.getAnswersByQnaId(qnaId);
		redirectAttributes.addFlashAttribute("answers", answers);
		mv.setViewName("redirect:/answer/{qnaId}");
		return mv;
	}
	
	// 질문 삭제
	@RequestMapping(value = "/qna/delete/{qnaId}", method = RequestMethod.POST)
	public ModelAndView qnaDelete(HttpServletRequest request, ModelAndView mv, @PathVariable int qnaId){
		HttpSession session = request.getSession(false);
		uId = (long) session.getAttribute("uId");
		
		answerService.deleteAnswersByQnaId(qnaId);
		qnaService.deleteQna(qnaId);
		
		mv.setViewName("redirect:/qna_board/1");
		return mv;
	}
	
	// 질문 수정 get
	@RequestMapping(value = "/qna/update/{qnaId}", method = RequestMethod.GET)
	public ModelAndView qnaUpdateForm(HttpServletRequest request, ModelAndView mv, @PathVariable int qnaId){
		HttpSession session = request.getSession(false);
		uId = (long) session.getAttribute("uId");
		
		qna = qnaService.getQnaByQnaId(qnaId);
		
		mv.addObject("qna", qna);		
		mv.setViewName("qna/qna_update");
		return mv;
	}
	
	// 질문 수정 post
	@RequestMapping(value = "/qna/update/{qnaId}", method = RequestMethod.POST)
	public ModelAndView qnaUpdate(QnaCommand qnaCommand, HttpServletRequest request, ModelAndView mv, @PathVariable int qnaId){
		HttpSession session = request.getSession(false);
		uId = (long) session.getAttribute("uId");
		
		Qna qna = new Qna();
		qna.setSubject(qnaCommand.getQnaTitle());
		qna.setDocument(qnaCommand.getContent());
		qna.setCategory(categoryService.getCategory(qnaCommand.getLevel(), Integer.valueOf(qnaCommand.getGrade()), qnaCommand.getSubject()));
		qna.setQnaId(qnaId);
		qna.setUser(userService.getUserByUid(uId));
		qnaService.updateQna(qna);			
		mv.addObject("document_q", qna.getDocument());
		mv.setViewName("redirect:/answer/{qnaId}");
		return mv;
	}
}
