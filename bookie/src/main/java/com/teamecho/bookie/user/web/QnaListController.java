package com.teamecho.bookie.user.web;

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
import com.teamecho.bookie.qna.service.QnaService;

@Controller
@RequestMapping("/user/qnaList")
public class QnaListController {
	
	@Autowired
	private QnaService qnaService;
	
	List<Qna> qnaList;
	
	@GetMapping
	public String qnaAllList(HttpServletRequest request, HttpServletResponse response, Model model){
		HttpSession session = request.getSession(false);
		long uid = (long) session.getAttribute("uId");

		qnaList = qnaService.getAllQnaByUid(uid);
		session.setAttribute("qnaList", qnaList);
		
		return "/user/qnaList";
		
	}
}