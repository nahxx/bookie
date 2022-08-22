package com.teamecho.bookie.question.web;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionText;
import com.teamecho.bookie.question.service.AddQuestionService;

@Controller
public class AddCommentController {
	@Autowired
	AddQuestionService addQuestionService;
	
	@Autowired
	ServletContext servletContext;
	
	@GetMapping("/question/add_comment/{qnaId}")
	public ModelAndView commentForm(HttpServletRequest request, ModelAndView mv, @PathVariable long qnaId) throws Exception{
		HttpSession session = request.getSession(false);
		long uId = (long) session.getAttribute("uId");
		
		QuestionText questionText = addQuestionService.getQuestionTextByQtId(qnaId);
		List<Question> qList = addQuestionService.getQuestionByQtId(questionText.getQtId());
		
		mv.addObject("questionText", questionText);
		mv.addObject("qList", qList);
		mv.setViewName("question/add_comment");
		return mv;
	}
	
	@PostMapping("/question/add_comment/{qId}")
	public ModelAndView addComment(HttpServletRequest request, ModelAndView mv, @PathVariable long qId) throws Exception{
		//DB에 넣으면 끝.
		return mv;
	}
	/*
	@ResponseBody
	@RequestMapping(value = "/add_comment", method = RequestMethod.POST)
	public ModelAndView imageTempSave(@RequestParam("image") MultipartFile multi, HttpServletRequest request, HttpServletResponse response) {
		String url = null;
		ModelAndView mv = new ModelAndView();
		try {
			String uploadPath = servletContext .getRealPath("/resources/temp");
			String originFilename = UUID.randomUUID().toString() + "_" + multi.getOriginalFilename();
			File folder = new File(uploadPath);
			if (!folder.exists()) folder.mkdirs();
			url = folder.getPath() + File.separator;
			File destination = new File(url + originFilename);
			multi.transferTo(destination);
			mv.addObject("url", "http://localhost:8080/bookie/tempimg/");
			mv.addObject("filename", originFilename);
			mv.setViewName("/qna/qna_image_json");
		} catch (Exception e) {
			System.out.println("[Error] " + e.getMessage());
		}
		return mv;
	}
	*/
}
