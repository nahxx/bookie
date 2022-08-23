package com.teamecho.bookie;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.service.CategoryService;
import com.teamecho.bookie.qna.domain.Answer;
import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.qna.service.AnswerService;
import com.teamecho.bookie.qna.service.QnaService;
import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.service.UserService;

@Controller
public class HomeController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private QnaService qnaService;
	@Autowired
	private AnswerService answerService;
	@Autowired
	private CategoryService categoryService;

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
	        
	         List<Qna> qnaList = qnaService.getAllQna();;
	         Collections.reverse(qnaList);
	         request.setAttribute("qnaList", qnaList);
	         
	         for(Qna q : qnaList) {
	        	 long uid = q.getUser().getUId();
	        	 long caId = q.getCategory().getCateId();
	        	 User u = userService.getUserByUid(uid);
	        	 Category ca = categoryService.getCategoryByCateId(caId);
	        	 String uName = u.getName();
	        	 String caName = ca.getSubject();
	        	 request.setAttribute("uName",uName);
	        	 request.setAttribute("caName",caName);
	         }
	  
	         List<Answer> answerList = answerService.getAllAnswers();
	         Collections.reverse(answerList);
	         request.setAttribute("answerList", answerList);
	         
	         for(Answer a : answerList) {
	        	 long uid = a.getUser().getUId();
	        	 User u = userService.getUserByUid(uid);
	        	 String userName = u.getName();
	        	 request.setAttribute("userName",userName);
	         }
	         
	         return "home";
	      }
	}
	
}
