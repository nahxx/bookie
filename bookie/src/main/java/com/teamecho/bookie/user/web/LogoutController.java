package com.teamecho.bookie.user.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/logout")
public class LogoutController {

	  @GetMapping
	  public String logout(HttpServletRequest request, HttpServletResponse response, Model model) {
			HttpSession session = request.getSession(false);
			if (session == null) {
				model.addAttribute("session", "no");
				return "redirect:/";
			}
			
			session.invalidate(); 
	      return "redirect:/";
	  }
}