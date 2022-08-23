package com.teamecho.bookie.admin.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamecho.bookie.admin.service.AdminService;
import com.teamecho.bookie.common.domain.Paging;
import com.teamecho.bookie.common.domain.SubjectPattern;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.service.AddQuestionService;
import com.teamecho.bookie.question.service.QuestionHistoryService;
import com.teamecho.bookie.user.domain.User;
import com.teamecho.bookie.user.service.UserService;

@Controller("admin.web.adminController")
public class AdminController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	AddQuestionService addQService;
	
	@Autowired
	QuestionHistoryService qhService;
	
	HttpSession session;
	long uId;
	
	/**
	 * admin_service 페이지 접속
	 * @return
	 */
	@GetMapping("/admin/admin_service")
	public String adminServiceForm(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		session = request.getSession(false);
		
		if (session == null) {
			redirectAttributes.addFlashAttribute("session", "no");
			return "redirect:/error/no_session";
		}
		
		if(session.getAttribute("uId") == null) {
			redirectAttributes.addFlashAttribute("session", "no");
			return "redirect:/error/no_session";
		}
		
		uId = (long) session.getAttribute("uId");

		if(userService.getUserByUid(uId).getManager() == 'N') {
			redirectAttributes.addFlashAttribute("session", "no");
			// 에러 페이지 이동
			return "redirect:/error/no_admin";
		}
		
		User user = userService.getUserByUid(uId);
		request.setAttribute("user", user);
		return "admin/admin_service";
	}
	
	/**
	 * admin_user 페이지 접속
	 * @return
	 */
	@GetMapping("/admin/admin_user/{pagingNo}")
	public String adminUserForm(@PathVariable int pagingNo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		session = request.getSession(false);
		
		if (session == null) {
			redirectAttributes.addFlashAttribute("session", "no");
			return "redirect:/error/no_session";
		}
		
		if(session.getAttribute("uId") == null) {
			redirectAttributes.addFlashAttribute("session", "no");
			return "redirect:/error/no_session";
		}
		
		uId = (long) session.getAttribute("uId");

		if(userService.getUserByUid(uId).getManager() == 'N') {
			redirectAttributes.addFlashAttribute("session", "no");
			// 에러 페이지 이동
			return "redirect:/error/no_admin";
		}
		
		// 로그인한 관리자 정보 넘기기
		User adminUser = userService.getUserByUid(uId);
		request.setAttribute("adminUser", adminUser);
		
		// 페이징
		try {
			Paging paging = new Paging();
			paging.setViewPageNo(5); 	// 초기값1 : 화면에 5개의 번호를 보여주고 싶다.
	        paging.setFirstPageNo(1); 	// 초기값2 :  화면에 시작번호 이다.
	        paging.setPageSize(10);		// 초기값3 : 한 페이지에 보여줄 게시글 갯수
	        paging.setTotalCount(userService.getAllUser().size());	// 초기값4 : 총 회원 수 이다.
	        paging.calcPagingNo();	//초기값5 : 페이지 갯수 계산 함.
	        
	        paging.makePaging(pagingNo); //페이지에 맞게
	        List<User> userList = adminService.getUserList(pagingNo, paging.getPageSize());
	        request.setAttribute("paging", paging);
	        request.setAttribute("userList", userList);
	        
		} catch(Exception e) {
			throw e;
		}
		
		return "admin/admin_user";
	}
	
	/**
	 * admin_question 페이지 접속
	 * @return
	 */
	@GetMapping("/admin/admin_question/{pagingNo}")
	public String adminQuestionForm(@PathVariable int pagingNo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		session = request.getSession(false);
		
		if (session == null) {
			redirectAttributes.addFlashAttribute("session", "no");
			return "redirect:/error/no_session";
		}
		
		if(session.getAttribute("uId") == null) {
			redirectAttributes.addFlashAttribute("session", "no");
			return "redirect:/error/no_session";
		}
		
		uId = (long) session.getAttribute("uId");

		if(userService.getUserByUid(uId).getManager() == 'N') {
			redirectAttributes.addFlashAttribute("session", "no");
			// 에러 페이지 이동
			return "redirect:/error/no_admin";
		}
		
		// 로그인한 관리자 정보 넘기기
		User adminUser = userService.getUserByUid(uId);
		request.setAttribute("adminUser", adminUser);
		
		// 페이징
		try {
			Paging paging = new Paging();
			paging.setViewPageNo(5); 	// 초기값1 : 화면에 5개의 번호를 보여주고 싶다.
	        paging.setFirstPageNo(1); 	// 초기값2 :  화면에 시작번호 이다.
	        paging.setPageSize(10);		// 초기값3 : 한 페이지에 보여줄 게시글 갯수
	        paging.setTotalCount(addQService.getAllQuestions().size());	// 초기값4 : 총 회원 수 이다.
	        paging.calcPagingNo();	//초기값5 : 페이지 갯수 계산 함.
	        
	        paging.makePaging(pagingNo); //페이지에 맞게
	        List<Question> questionList = adminService.getQuestionList(pagingNo, paging.getPageSize());
	        request.setAttribute("paging", paging);
	        request.setAttribute("questionList", questionList);
	        
	        /*
	        List<String> cateTitleList = new ArrayList<>();
	        for(Question q : questionList) {
	        	String title = "";
	        	if(q.getCategory().getCLevel() == 'm') {
	        		title += "중등/";
	        	} else if(q.getCategory().getCLevel() == 'h') {
	        		title += "고등/";
	        	}
	        	title += q.getCategory().getGrade() + "학년/";
	        	title += q.getCategory().getSubject();
	        	
	        	cateTitleList.add(title);
	        }
	        request.setAttribute("cateTitleList", cateTitleList);
	        */
	        
	        List<String> spTitleList = new ArrayList<>();
	        for(Question q : questionList) {
	        	spTitleList.add(qhService.getSubjectPatternByQid(q.getQId()));
	        }
	        
	        request.setAttribute("spTitleList", spTitleList);
		} catch(Exception e) {
			throw e;
		}
		return "admin/admin_question";
	}
	
	
}
