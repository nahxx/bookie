package com.teamecho.bookie.user.web;

//import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.qna.service.AnswerService;
import com.teamecho.bookie.qna.service.QnaService;
import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.service.UserService;

@Controller
@RequestMapping("/user/qnaList")
public class QnaListController {
	
	@Autowired
	private UserService userService;
	private QnaService qnaService;
	private List<Qna> qnaList;
	
	@GetMapping
	public String qnaList(){
		return "/user/qnaList";
	}
	
	@PostMapping
	public String qnaAllList(HttpServletRequest request, HttpServletResponse response, Model model){
		HttpSession session = request.getSession(false);
		long uid = (long) session.getAttribute("uId");
		userService.getUserByUid(uid);
		System.out.println(uid);

		qnaList = qnaService.getAllQnaByUid(uid);
		System.out.println(qnaList);
//		model.addAttribute("qnaList", qnaList);
		request.setAttribute("qnaList", qnaList);
		
		return "/user/qnaList";
		
	}
}