package com.teamecho.bookie.user.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.teamecho.bookie.user.service.UserService;

@Controller
@RequestMapping("/user/mypage")
public class MypageController {
	
	@Autowired
	UserService userService;
	
	HttpSession session;
	long uId;
	
	@GetMapping
	public String mypage(HttpServletRequest request) {
		session = request.getSession(false);
		uId = (long) session.getAttribute("uId");
		if(userService.getUserByUid(uId).getManager() == 'Y') {
			request.setAttribute("adminPage", "adminPage");
			return "/user/mypage";
		}
		
		return "/user/mypage";
	}
}