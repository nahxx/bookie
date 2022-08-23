package com.teamecho.bookie.question.web;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.domain.CategoryCommand;
import com.teamecho.bookie.common.domain.CategoryProvider;
import com.teamecho.bookie.common.domain.SubjectPattern;
import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.service.SolveProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller("question.web.solveProblemController")
public class SolveProblemController {
	
	@Autowired
	private SolveProblemService solveProblemService;

	private List<Question> questionList;
	private SubjectPattern subjectPattern;
	private int count = 0;

	@GetMapping("/question/solveProblemList")
	public String solveProblemListPage(Model model, HttpServletResponse response, HttpServletRequest request) throws IOException {

		HttpSession session = request.getSession(false);
		if(session.getAttribute("questionList") != null) {
			System.out.println("session 초기화");
			session.removeAttribute("questionList");
		}

		if (session == null) {
			model.addAttribute("session", "no");
			return "error/no_session";
		}
		
		if(session.getAttribute("uId") == null) {
			model.addAttribute("session", "no");
			return "error/no_session";
		}
		
		long uId = (long)session.getAttribute("uId");

		count = 0;
		
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

	@GetMapping("/question/solveProblem")
	public String solveProblem(HttpServletRequest request, Model model, @ModelAttribute("category") CategoryCommand category) {
		HttpSession session = request.getSession(false);

		if (session == null) {
			model.addAttribute("session", "no");
			return "question/solveProblemPage";
		}
		if(session.getAttribute("uId") == null) {
			model.addAttribute("session", "no");
			return "question/solveProblemPage";
		}

		// 해당 카테고리 불러오기
		Category realCategory = solveProblemService.findCategory(category.getCLevel().charAt(0), category.getGrade(), category.getSubject());
		model.addAttribute("realCategory", realCategory);

		// 새로고침 했을때 question이 랜덤으로 바뀌지 않게 하기 위함
		questionList = (List<Question>) session.getAttribute("questionList");

		if(questionList == null) {
			// session에 아직 리스트가 안담겼을 경우 DB에서 받아오기
			questionList = solveProblemService.findQuestionByCategoryId(realCategory.getCateId(), (long)session.getAttribute("uId"));
			System.out.println("realCategory.getSubject() = " + realCategory.getSubject());

			// 더이상 풀 문제가 없는 경우 보내는 메세지
			if(questionList.size() == 0) {
				String str = "해당 학년의 문제를 다 푸셨습니다!";
				model.addAttribute("str", str);
				return "error/solveProblemError";
			}

			subjectPattern = solveProblemService.getQuestionPattern(questionList.get(0).getQId());

			model.addAttribute("question", questionList.get(0));
			model.addAttribute("subjectPattern", subjectPattern);

			// session에 담아주기
			session.setAttribute("questionList", questionList);

			return "question/solveProblemPage";
		}
		/**
		 * session에 리스트가 담겼을 경우
		 */
		System.out.println("questionList가 있는 경우 : 진입");
		if(questionList.get(0).getMainText() != null) {
			model.addAttribute("question", questionList.get(0));
		}

		subjectPattern = solveProblemService.getQuestionPattern(questionList.get(0).getQId());

		model.addAttribute("question", questionList.get(0));
		model.addAttribute("subjectPattern", subjectPattern);

		// 더이상 풀 문제가 없는 경우 보내는 메세지
		if(questionList.size() == 0) {
			String str = "해당 학년의 문제를 다 푸셨습니다!";
			model.addAttribute("str", str);
			return "error/solveProblemError";
		}


		return "question/solveProblemPage";
	}

	@PostMapping("/question/solveProblem")
	public String solveProblemPaging(Model model, @RequestParam(value="answer")String answer, @RequestParam(value="question")String questionId, HttpServletRequest request) {
		HttpSession session = request.getSession(false);

		long sessionQid;
		Question question;
		if (session == null) {
			model.addAttribute("session", "no");
			return "question/solveProblemPage";
		}
		if(session.getAttribute("uId") == null) {
			model.addAttribute("session", "no");
			return "question/solveProblemPage";
		}

		// 해당 카테고리 불러오기
		char cLevel = request.getParameter("cLevel").charAt(0);
		int grade = Integer.parseInt(request.getParameter("grade"));
		String subject = request.getParameter("subject");
		Category realCategory = solveProblemService.findCategory(cLevel, grade, subject);
		model.addAttribute("realCategory", realCategory);

		// 문제 다 풀었을때 새로 불러오기
		if(questionList.get(questionList.size()-1).getQId() == Long.parseLong(questionId)){
			questionList = solveProblemService.findQuestionByCategoryId(realCategory.getCateId(), (long)session.getAttribute("uId"));
		}

		if(session.getAttribute("questionId") == null) {
			sessionQid  = 0;
		}else {
			sessionQid = (long)session.getAttribute("questionId");
		}

		// 세션에 담긴 questionId와 리턴받은 questionId값이 다를경우 정답 확인 후 DB넣기
		if ( sessionQid == 0 || Long.parseLong(questionId) != sessionQid ) {
			System.out.println("questionId의 세션이 다를때 진입");
			solveProblemService.answerChecking(Long.parseLong(questionId), (long)session.getAttribute("uId"), Integer.parseInt(answer));

			question = solveProblemService.findQuestionByQuestionId(Long.parseLong(questionId));


			// 다음문제 넘기기
			for(int i=0;i<questionList.size();i++){
				if(questionList.get(i).getQId() == question.getQId()){
					if((i+1) >= questionList.size()){
						questionList = solveProblemService.findQuestionByCategoryId(realCategory.getCateId(), (long)session.getAttribute("uId"));
						model.addAttribute("againProblem", "on");
						return "question/solveProblemPage";
					}
					subjectPattern = solveProblemService.getQuestionPattern(questionList.get(i+1).getQId());
					model.addAttribute("question", questionList.get(i+1));
					model.addAttribute("subjectPattern", subjectPattern);
				}
			}
			session.setAttribute("questionId", Long.parseLong(questionId));
						
		}else {
			question = solveProblemService.findQuestionByQuestionId(Long.parseLong(questionId));


			// 다음문제 넘기기
			for(int i=0;i<questionList.size();i++){
				if(questionList.get(i).getQId() == question.getQId()){
					subjectPattern = solveProblemService.getQuestionPattern(questionList.get(i+1).getQId());
					model.addAttribute("question", questionList.get(i+1));
					model.addAttribute("subjectPattern", subjectPattern);
				}
			}
		}
		
		return "question/solveProblemPage";
	}
}
