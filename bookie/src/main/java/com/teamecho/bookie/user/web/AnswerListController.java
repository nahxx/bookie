package com.teamecho.bookie.user.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamecho.bookie.user.domain.User;
@Controller
@RequestMapping("/user/answerList")
public class AnswerListController {
	
	@GetMapping
	public String answerList(){
		return "/user/answerList";
	}
}