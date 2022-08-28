package com.teamecho.bookie.common.web;

import java.io.File;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

/**
 * -. base64이미지를 짧은 주소로 치환시켜주는 함수.
 * -. 자신의 톰캣서버 안에있는 server.xml에서 <Host></Host> 태그사이에 아래의 태그를 추가한다.
 * -. <Context docBase="실제 저장되는 파일 위치 경로" path="서버에서 찾는 파일 경로" reloadable="true"/>
 * -. docBase : "C:/NCS/teamecho/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/bookie/resources"
 * -. path : "/bookie/tempimg" 
 * -. mac은 아래 소스에서 uploadPath 경로를 System.out.println(); 찍어서 변경해준다. 
 * -. <Context docBase="C:\NCS\teamecho\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\bookie\resources" path="/bookie/images" reloadable="true"/> //학원꺼
 */

@Controller
public class ImageSaveController {
	@Autowired
	ServletContext servletContext;
	
	HttpSession session;
	
	@ResponseBody
	@RequestMapping(value = "/qna_write", method = RequestMethod.POST)
	public ModelAndView qnaImageSave(@RequestParam("image") MultipartFile multi, HttpServletRequest request,
			HttpServletResponse response) {
		String url = null;
		ModelAndView mv = new ModelAndView();
		session = request.getSession(false);
		
		try {
			String uploadPath = "";
			if((long)session.getAttribute("uId") == 4) { // 관리자(수진) 접근시
				uploadPath = "/Users/mignon/Desktop/teamecho/bookie/images/qna";
			} else if((long)session.getAttribute("uId") == 6) { // 관리자(영정) 접근시
				uploadPath = "/Users/zeroj/yeongjeong/Study/bookie/bookie/images/qna";
			} else {
				uploadPath = "C:/NCS/teamecho/bookie/images/qna";
			}

			String originFilename = UUID.randomUUID().toString() + "_" + multi.getOriginalFilename();
			File folder = new File(uploadPath);
			if (!folder.exists()) folder.mkdirs();
			url = folder.getPath() + File.separator;
			File destination = new File(url + originFilename);
			multi.transferTo(destination);
			mv.addObject("url", "http://localhost:8080/bookie/images/qna/");
			mv.addObject("filename", originFilename);
			mv.setViewName("/common/image_json");
		} catch (Exception e) {
			System.out.println("[Error] " + e.getMessage());
		}
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/add_question", method = RequestMethod.POST)
	public ModelAndView questionImageSave(@RequestParam("image") MultipartFile multi, HttpServletRequest request,
			HttpServletResponse response) {
		String url = null;
		ModelAndView mv = new ModelAndView();
		session = request.getSession(false);
		
		try {
			String uploadPath = "";
			if((long)session.getAttribute("uId") == 4) { // 관리자(수진) 접근시
				uploadPath = "/Users/mignon/Desktop/teamecho/bookie/images/question";
			} else if((long)session.getAttribute("uId") == 6) { // 관리자(영정) 접근시
				uploadPath = "/Users/zeroj/yeongjeong/Study/bookie/bookie/images/question";
			} else {
				uploadPath = "C:/NCS/teamecho/bookie/images/question";
			}
			
			String originFilename = UUID.randomUUID().toString() + "_" + multi.getOriginalFilename();
			File folder = new File(uploadPath);
			if (!folder.exists()) folder.mkdirs();
			url = folder.getPath() + File.separator;
			File destination = new File(url + originFilename);
			multi.transferTo(destination);
			mv.addObject("url", "http://localhost:8080/bookie/images/question/");
			mv.addObject("filename", originFilename);
			mv.setViewName("/common/image_json");
		} catch (Exception e) {
			System.out.println("[Error] " + e.getMessage());
		}
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/add_comment", method = RequestMethod.POST)
	public ModelAndView commentImageSave(@RequestParam("image") MultipartFile multi, HttpServletRequest request,
			HttpServletResponse response) {
		String url = null;
		ModelAndView mv = new ModelAndView();
		session = request.getSession(false);
		
		try {
			String uploadPath = "";
			if((long)session.getAttribute("uId") == 4) { // 관리자(수진) 접근시
				uploadPath = "/Users/mignon/Desktop/teamecho/bookie/images/comment";
			} else if((long)session.getAttribute("uId") == 6) { // 관리자(영정) 접근시
				uploadPath = "/Users/zeroj/yeongjeong/Study/bookie/bookie/images/comment";
			} else {
				uploadPath = "C:/NCS/teamecho/bookie/images/comment";
			}
			
			String originFilename = UUID.randomUUID().toString() + "_" + multi.getOriginalFilename();
			File folder = new File(uploadPath);
			if (!folder.exists()) folder.mkdirs();
			url = folder.getPath() + File.separator;
			File destination = new File(url + originFilename);
			multi.transferTo(destination);
			mv.addObject("url", "http://localhost:8080/bookie/images/comment/");
			mv.addObject("filename", originFilename);
			mv.setViewName("/common/image_json");
		} catch (Exception e) {
			System.out.println("[Error] " + e.getMessage());
		}
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/add_answer", method = RequestMethod.POST)
	public ModelAndView answerImageSave(@RequestParam("image") MultipartFile multi, HttpServletRequest request,
			HttpServletResponse response) {
		String url = null;
		ModelAndView mv = new ModelAndView();
		session = request.getSession(false);
		
		try {
			String uploadPath = "";
			if((long)session.getAttribute("uId") == 4) { // 관리자(수진) 접근시
				uploadPath = "/Users/mignon/Desktop/teamecho/bookie/images/answer";
			} else if((long)session.getAttribute("uId") == 6) { // 관리자(영정) 접근시
				uploadPath = "/Users/zeroj/yeongjeong/Study/bookie/bookie/images/answer";
			} else {
				uploadPath = "C:/NCS/teamecho/bookie/images/answer";
			}
			String originFilename = UUID.randomUUID().toString() + "_" + multi.getOriginalFilename();
			File folder = new File(uploadPath);
			if (!folder.exists()) folder.mkdirs();
			url = folder.getPath() + File.separator;
			File destination = new File(url + originFilename);
			multi.transferTo(destination);
			mv.addObject("url", "http://localhost:8080/bookie/images/answer/");
			mv.addObject("filename", originFilename);
			mv.setViewName("/common/image_json");
		} catch (Exception e) {
			System.out.println("[Error] " + e.getMessage());
		}
		return mv;
	}
	
}
