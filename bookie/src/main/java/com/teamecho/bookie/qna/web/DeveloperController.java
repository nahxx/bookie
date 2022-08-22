package com.teamecho.bookie.qna.web;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.service.CategoryService;
import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.qna.service.QnaService;
import com.teamecho.bookie.user.service.UserService;

@Controller
public class DeveloperController {

	@Autowired 
	ServletContext servletContext;
	
	@Autowired
	QnaService qnaService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	UserService userService;
	
	@GetMapping("/devel")
	public String developerPage() {
	Category category = categoryService.getCategory("m", 1, "국어");
	System.out.println(category.getCLevel());
		return "/developer";
	}
	
	@GetMapping("/devel/addQna")
	public String addQna() {

		for(int i=0; i<60; i++) {
			long r = (long)((Math.random()*10000) % categoryService.getAllCategory().size());
			if(r < 1) {
				r = 1;
			}
			Qna qna = new Qna();
			qna.setSubject("제목"+i);
			qna.setDocument("<p>본문"+i+"</p>");
			qna.setCategory(categoryService.getCategoryByCateId(r));
			qna.setUser(userService.getUserByUid(1));
			qnaService.addQna(qna);
			try {
				Thread.sleep(300);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return "redirect:/developer";
	}
	
	/**
	 * -. base64이미지를 짧은 주소로 치환시켜주는 함수.
	 * -. 자신의 톰캣서버 안에있는 server.xml에서 <Host></Host> 태그사이에 아래의 태그를 추가한다.
	 * -. <Context docBase="실제 저장되는 파일 위치 경로" path="서버에서 찾는 파일 경로" reloadable="true"/>
	 * -. docBase : "C:/NCS/teamecho/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/bookie/resources/temp"
	 * -. path : "/bookie/tempimg" 
	 * -. mac은 아래 소스에서 uploadPath 경로를 System.out.println(); 찍어서 변경해준다. 
	 * -. <Context docBase="C:\NCS\teamecho\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\bookie\resources\temp" path="/bookie/tempimg" reloadable="true"/> //학원꺼
	 */
	@ResponseBody
	@RequestMapping(value = "/testdg", method = RequestMethod.POST)
	public ModelAndView imageTempSave(@RequestParam("image") MultipartFile multi, HttpServletRequest request, HttpServletResponse response) {
		String url = null;
		ModelAndView mv = new ModelAndView();
		
		try { 
			String uploadPath =  servletContext.getRealPath("/resources/qna");
			String originFilename = UUID.randomUUID().toString() + "_" + multi.getOriginalFilename();
			File folder = new File(uploadPath);
	        if (!folder.exists()) folder.mkdirs();
	        url = folder.getPath() + File.separator;
	        File destination = new File(url + originFilename);
	        multi.transferTo(destination);
			mv.addObject("url", "http://localhost:8080//bookie/images/qna/");
			mv.addObject("filename", originFilename);
			mv.setViewName("image_json");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("[Error] " + e.getMessage());
		}
		return mv;
	}
}
