package com.teamecho.bookie;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

		if (session == null || session.getAttribute("uId") == null) {
			request.setAttribute("session", "no");
		}else {
			if(session.getAttribute("uId") != null) {
					model.addAttribute("session", "yes");
					request.setAttribute("uId", (long) session.getAttribute("uId"));
					request.setAttribute("manager", (char) session.getAttribute("manager"));

			}
		}
					
		List<Map<String, String>> rankig = userService.findrankingUser();
		Collections.reverse(rankig);
		request.setAttribute("rankig", rankig);
		Map<String, String> rankingUser = new HashMap<String, String>();
		long checkUId;
		for(Map<String, String> user : rankig) {
			checkUId = Long.valueOf(user.get("uid"));
			request.setAttribute("checkUId", checkUId);
		}
		request.setAttribute("rankingUser", rankingUser);

		
		for(Map<String, String> myMap : rankig){
		     String val = myMap.get("uid");
		     long ud = Long.valueOf(val);
		     User u = userService.getUserByUid(ud);
		     String uName = u.getName();
		     String uManager = Character.toString(u.getManager());
		     myMap.put("uName", uName);
		     myMap.put("uManager", uManager);
		}

	     
		List<Qna> qnaList = qnaService.getAllQna();
		Collections.reverse(qnaList);
		request.setAttribute("qnaList", qnaList);

		for (Qna q : qnaList) {
			long uid = q.getUser().getUId();
			long caId = q.getCategory().getCateId();
			User u = userService.getUserByUid(uid);
			Category ca = categoryService.getCategoryByCateId(caId);
			q.setUser(u);
			q.setCategory(ca);
		}

		List<Answer> answerList = answerService.getAllAnswers();
		Collections.reverse(answerList);
		request.setAttribute("answerList", answerList);

		for (Answer a : answerList) {
			long uid = a.getUser().getUId();
			User u = userService.getUserByUid(uid);
			a.setUser(u);
		}
		
		Map<String, String> qCount = userService.questionCount();
		List<String> qCountList = new ArrayList<String>(qCount.values());

		List<String> queList = new ArrayList<>();
		queList.add("수학");
		queList.add("국어");
		queList.add("영어");
		queList.add("전체 문제");

		request.setAttribute("queList", queList);
		request.setAttribute("qCountList", qCountList);
		
		return "home";
	}

}
