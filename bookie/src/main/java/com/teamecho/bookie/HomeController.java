package com.teamecho.bookie;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession(false);

		if (session == null) {
			model.addAttribute("session", "no");
			return "home";
		} else {
			long uId = (long) session.getAttribute("uId");
			model.addAttribute("session", "yes");
			return "home";
		}
	}

}
