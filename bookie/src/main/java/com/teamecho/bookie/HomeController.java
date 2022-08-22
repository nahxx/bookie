package com.teamecho.bookie;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.teamecho.bookie.qna.domain.Board;
import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.qna.service.AnswerService;
import com.teamecho.bookie.qna.service.QnaService;
//import com.teamecho.bookie.user.domain.Ranking;
import com.teamecho.bookie.user.service.UserService;

@Controller
public class HomeController {
	
	@Autowired
	private UserService userService;
	private QnaService qnaService;
	private AnswerService answerService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession(false);

		if (session == null) {
	         model.addAttribute("session", "no");
	         return "home";
	      } else {
	         if(session.getAttribute("uId") == null) {
	            model.addAttribute("session", "no");
	            return "home";
	         }
	         long uId = (long) session.getAttribute("uId");
	         
	         model.addAttribute("session", "yes");
	         return "home";
	      }
	}
	
//	@GetMapping("home")
//	public ModelAndView ranking(HttpServletRequest request) {
//		ModelAndView mav = new ModelAndView();
//		HttpSession session = request.getSession(false);
//		long uId = (long) session.getAttribute("uId");
//		System.out.println(uId);
//		
//		userService.rankingUser();
//		
//		List<Ranking> ranking = userService.rankingUser();
//
//        mav.addObject("ranking", ranking);
//        mav.setViewName("home");
//		
//        return mav;
//	}
	
//	@GetMapping("/")
//	public String list(Model model) {
//        List<Qna> qnaList = qnaService.getAllQna();
//        model.addAttribute("qnaList", qnaList);
//        
//		return "/";
//        
//		
//	}
	
}
