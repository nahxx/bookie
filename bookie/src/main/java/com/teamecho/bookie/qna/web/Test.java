package com.teamecho.bookie.qna.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class Test {
	
	@GetMapping("/testdg")
	public String testhome() {
		return "/test";
	}

}
