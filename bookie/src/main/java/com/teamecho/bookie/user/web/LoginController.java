package com.teamecho.bookie.user.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.service.UserService;

@Controller
@RequestMapping("/user/login")
public class LoginController {

	@Autowired
	private UserService userService;
	HttpSession session;

	@GetMapping
	public String loginForm() {
		return "user/login";
	}

	@PostMapping
	public String login(User user, @RequestParam String userId, @RequestParam String passwd, HttpServletRequest request) {
		
		user = userService.isValidUser(userId, passwd);
	
		if(user == null) {
			return "user/add_user";
		}
		
		session = request.getSession(true);
		session.setAttribute("uId", user.getUId());
		session.setAttribute("name", user.getName());
		session.setAttribute("userId", user.getUserId());
		
		return "redirect:/";	
	}
}