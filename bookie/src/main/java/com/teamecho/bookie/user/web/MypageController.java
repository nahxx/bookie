package com.teamecho.bookie.user.web;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user/mypage")
public class MypageController {
	
	@GetMapping
	public String mypage(){
		return "/user/mypage";
	}
}