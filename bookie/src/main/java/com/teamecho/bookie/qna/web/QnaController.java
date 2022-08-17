package com.teamecho.bookie.qna.web;

import java.io.File;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.teamecho.bookie.common.service.CategoryService;
import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.qna.service.QnaService;
import com.teamecho.bookie.user.service.UserService;

/**
 * -. 자신의 톰캣서버 안에있는 server.xml에서 <Host></Host> 태그사이에 아래의 태그를 추가한다. -.
 * <Context docBase="실제 저장되는 파일 위치 경로" path="서버에서 찾는 파일 경로" reloadable="true"/>
 * -. docBase :
 * "C:/NCS/teamecho/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/bookie/resources/temp"
 * -. path : "/bookie/tempimg" -. mac은 아래 소스에서 uploadPath 경로를
 * System.out.println(); 찍어서 변경해준다.
 */

@Controller
public class QnaController {
	@Autowired
	ServletContext servletContext;

	@Autowired
	CategoryService categoryService;

	@Autowired
	QnaService qnaService;

	@Autowired
	UserService userService;

	/**
	 * QNA 작성페이지로 이동 한다.
	 */
	@GetMapping("/qna_write/{pagingNo}")
	public String qnaMainPage(HttpServletRequest request, Model model, @PathVariable int pagingNo) {
		HttpSession session = request.getSession(false);

		if (session == null) {
			model.addAttribute("session", "no");
		} else {
			if (session.getAttribute("uId") == null) {
				model.addAttribute("session", "no");
			}
			model.addAttribute("session", "yes");
		}
		model.addAttribute("pagingNo", pagingNo);
		return "/qna/qna_write";
	}

	/**
	 * QNA 작성페이지에서 작성한 값을 넘겨 받아서
	 * 
	 * @return
	 */
	@PostMapping("/add_qna")
	public String saveQna(QnaCommand qnaCommand, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		long uId = (long) session.getAttribute("uId");
		Qna qna = new Qna();
		qna.setSubject(qnaCommand.getQnaTitle());
		qna.setDocument(qnaCommand.getContent());
		qna.setCategory(categoryService.getCategory(qnaCommand.getLevel(), Integer.valueOf(qnaCommand.getGrade()),
				qnaCommand.getSubject()));
		qna.setUser(userService.getUserByUid(uId));
		qnaService.addQna(qna);
		return "redirect:/qna_board/1";
	}

	@ResponseBody
	@RequestMapping(value = "/qna_write", method = RequestMethod.POST)
	public ModelAndView imageTempSave(@RequestParam("image") MultipartFile multi, HttpServletRequest request,
			HttpServletResponse response) {
		String url = null;
		ModelAndView mv = new ModelAndView();
		try {
			String uploadPath = servletContext.getRealPath("/resources/temp");
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

}
