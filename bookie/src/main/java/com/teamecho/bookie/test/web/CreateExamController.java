package com.teamecho.bookie.test.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller("test.web.createExamController")
public class CreateExamController {

    @GetMapping("/test/createExam")
    public String createExamPage() {
        return "/test/create_exam";
    }
}
