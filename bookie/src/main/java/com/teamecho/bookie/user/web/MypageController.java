package com.teamecho.bookie.user.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamecho.bookie.user.service.UserService;

@Controller
@RequestMapping("/user/mypage")
public class MypageController {
	
	@Autowired
	UserService userService;
	
	HttpSession session;
	long uId;
	
	@GetMapping
	public String mypage(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		session = request.getSession(false);
		
		if (session == null) {
			redirectAttributes.addFlashAttribute("session", "no");
			return "redirect:/error/no_session";
		}
		
		if(session.getAttribute("uId") == null) {
			redirectAttributes.addFlashAttribute("session", "no");
			return "redirect:/error/no_session";
		}
		
		uId = (long) session.getAttribute("uId");
		if(userService.getUserByUid(uId).getManager() == 'Y') {
			request.setAttribute("adminPage", "adminPage");
			return "/user/mypage";
		}
		
		return "/user/mypage";
	}
}