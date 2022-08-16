package com.teamecho.bookie.user.web;

import java.util.ArrayList;
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

import com.teamecho.bookie.qna.service.AnswerService;
import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.service.UserService;

@Controller
@RequestMapping("/user/answerList")
public class AnswerListController {
	
////	private VoucherService voucherService;
//	@Autowired
//	private UserService userService;
//	private AnswerService answerService;
//	private List<AnswerService> answerList = new ArrayList<AnswerService>();
////	
////	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
////
////		voucherService = VoucherService.getInstance();
////		HttpSession session = request.getSession(false);
////		String userId = (String) session.getAttribute("userId");
////		long uId = uservice.findUIdByUserId(userId);
////		
////		voucherUseList = voucherService.getVoucherUseList(uId);
////		request.setAttribute("voucherList", voucherUseList);
////		request.getRequestDispatcher("voucher_list.jsp").forward(request, response);
////	}
//	
//	@GetMapping
//	public String answerList(){
//		return "/user/answerList";
//	}
//	
//	@PostMapping
//	public String answerAllList(HttpServletRequest request, HttpServletResponse response){
//		HttpSession session = request.getSession(false);
//		long uid = (long) session.getAttribute("uId");
//		
//		answerList = answerService.get
//	}
}