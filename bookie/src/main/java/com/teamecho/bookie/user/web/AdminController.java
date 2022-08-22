package com.teamecho.bookie.user.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.service.UserService;

@Controller("user.web.adminController")
public class AdminController {
	
	@Autowired
	UserService userService;
	
	HttpSession session;
	long uId;
	
	/**
	 * admin_service 페이지 접속
	 * @return
	 */
	@GetMapping("/admin/admin_service")
	public String addQuestionForm(HttpServletRequest request, RedirectAttributes redirectAttributes) {
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

		if(userService.getUserByUid(uId).getManager() == 'N') {
			redirectAttributes.addFlashAttribute("session", "no");
			// 에러 페이지 이동
			return "redirect:/error/no_admin";
		}
		
		User user = userService.getUserByUid(uId);
		request.setAttribute("user", user);
		return "admin/admin_service";
	}
}
