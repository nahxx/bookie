package com.teamecho.bookie.question.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.service.SolveProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamecho.bookie.common.domain.CategoryCommand;
import com.teamecho.bookie.common.domain.CategoryProvider;

@Controller("question.web.solveProblemController")
public class SolveProblemController {
	
	@Autowired
	private SolveProblemService solveProblemService;
	
	@GetMapping("/question/solveProblemList")
	public String solveProblemListPage(Model model, HttpServletResponse response, HttpServletRequest request) throws IOException {

		HttpSession session = request.getSession(false);
		if (session == null) {
			model.addAttribute("session", "no");
			return "error/no_session";
		}
		
		if(session.getAttribute("uId") == null) {
			model.addAttribute("session", "no");
			return "error/no_session";
		}
		
		long uId = (long)session.getAttribute("uId");
		
		model.addAttribute("category", new CategoryCommand());
		return "question/solveProblemListPage";
	}
	
	@ModelAttribute("categoryProviderList")
	public List<CategoryProvider> getLevelProviderList() {
		List<CategoryProvider> list = new ArrayList<CategoryProvider>();
		list.add(new CategoryProvider("중학생", "m"));
		list.add(new CategoryProvider("고등학생", "h"));
		return list;
	}
	
	@ModelAttribute("gradeProviderList")
	public List<CategoryProvider> getGradeProviderList() {
		List<CategoryProvider> list = new ArrayList<CategoryProvider>();
		list.add(new CategoryProvider("1학년", "1"));
		list.add(new CategoryProvider("2학년", "2"));
		list.add(new CategoryProvider("3학년", "3"));
		return list;
	}
	@ModelAttribute("subjectProviderList")
	public List<CategoryProvider> getSubjectProviderList() {
		List<CategoryProvider> list = new ArrayList<CategoryProvider>();
		list.add(new CategoryProvider("국어", "국어"));
		list.add(new CategoryProvider("수학", "수학"));
		list.add(new CategoryProvider("영어", "영어"));
		return list;
	}
	
	@GetMapping("/question/solveProblemList/list")
	public String solveProblemListPage(@ModelAttribute("category") CategoryCommand category, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		if (session == null) {
			model.addAttribute("session", "no");
			return "error/no_session";
		}
		if(session.getAttribute("uId") == null) {
			model.addAttribute("session", "no");
			return "error/no_session";
		}
		Category realCategory = solveProblemService.findCategory(category.getCLevel(), category.getGrade(), category.getSubject());
		
//		System.out.println("realCategory.getSubject() = " + realCategory.getSubject());
//		System.out.println("realCategory.getGrade() = " + realCategory.getGrade());
//		System.out.println("realCategory.getCLevel() = " + realCategory.getCLevel());
		
		model.addAttribute("realCategory",realCategory);
		return "question/solveProblemListPage";
	}
	
//	@GetMapping("/question/solveProblem")
//	public String solveProblemPage(Model model, HttpServletRequest request) {
//		HttpSession session = request.getSession(false);
//		if (session == null) {
//			model.addAttribute("session", "no");
//			return "question/solveProblemPage";
//		}
//		if(session.getAttribute("uId") == null) {
//			model.addAttribute("session", "no");
//			return "question/solveProblemPage";
//		}
//
//		if(session.getAttribute("flag") != null && (boolean) session.getAttribute("flag") == false) {
//			return "redirect:/question/solveProblem";
//		}
//		int grade = Integer.parseInt(request.getParameter("grade"));
//		char cLevel = request.getParameter("cLevel").charAt(0);
//		String subject = request.getParameter("subject");
//		int numOfQuestion = Integer.parseInt(request.getParameter("numOfquestions"));
//
//		// 해당 카테고리 불러오기
//		Category realCategory = solveProblemService.findCategory(cLevel, grade, subject);
//		// 카테고리에 맞는 사용자가 풀지않은 문제 리스트 받아오기
//		List<Question> unsolveQuestionList = solveProblemService.findQuestionByCategoryId(realCategory.getCateId(), (long)session.getAttribute("uId"));
//
//		// 더이상 풀 문제가 없는 경우 보내는 메세지
//		if(unsolveQuestionList.size() == 0) {
//			String str = "해당 학년의 문제를 다 푸셨습니다!";
//			model.addAttribute("str", str);
//			return "error/solveProblemError";
//		}
//
//		System.out.println("unsolveQuestionList.size() = " + unsolveQuestionList.size());
//		long mtId = 0;
//		for(Question question : unsolveQuestionList) {
//			mtId = question.getMainText().getMtId();
//		}
//
//		MainText mainText = solveProblemService.getMainText(mtId);
//
//		model.addAttribute("questionList", unsolveQuestionList);
//		model.addAttribute("mainText", mainText);
//
//		session.setAttribute("flag", false);
//
//		return "question/solveProblemPage";
//	}

	@GetMapping("/question/solveProblem/{numOfquestions}")
	public String solveProblem(HttpServletRequest request, @PathVariable int numOfquestions, Model model) {
		HttpSession session = request.getSession(false);

		if(session.getAttribute("flag") != null && (boolean) session.getAttribute("flag") == false) {
			System.out.println("진입2");
			return "redirect:/question/solveProblem/"+numOfquestions;
		}

		int grade = Integer.parseInt(request.getParameter("grade"));
		char cLevel = request.getParameter("cLevel").charAt(0);
		String subject = request.getParameter("subject");

		// 해당 카테고리 불러오기
		Category realCategory = solveProblemService.findCategory(cLevel, grade, subject);
		// 카테고리에 맞는 사용자가 풀지않은 문제 리스트 받아오기
		List<Question> unsolveQuestionList = solveProblemService.findQuestionByCategoryId(realCategory.getCateId(), (long)session.getAttribute("uId"));

		long mtId = 0;
		for(Question question : unsolveQuestionList) {
			mtId = question.getMainText().getMtId();
		}

		MainText mainText = solveProblemService.getMainText(mtId);

		model.addAttribute("questionList", unsolveQuestionList);
		model.addAttribute("mainText", mainText);

		session.setAttribute("flag", false);

		return "question/solveProblemPage";
	}

	@PostMapping("/question/solveProblem")
	public String solveProblemPaging(Model model, @RequestParam(value="answer")String answer, @RequestParam(value="question")String question, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
//		System.out.println(answer);
//		System.out.println("question = " + question);
//		System.out.println("session.getAttribute(\"uId\") = " + session.getAttribute("uId"));
//		solveProblemService.findQuestionByQuestionId(Long.parseLong(question));
		solveProblemService.answerChecking(Long.parseLong(question), (long)session.getAttribute("uId"), Integer.parseInt(answer));
		return "question/solveProblemPage";
	}
}
