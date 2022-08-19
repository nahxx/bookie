package com.teamecho.bookie.question.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.domain.CategoryCommand;
import com.teamecho.bookie.common.domain.SubjectPattern;
import com.teamecho.bookie.common.service.CategoryService;
import com.teamecho.bookie.common.service.CommonService;
import com.teamecho.bookie.common.service.SubjectPatternService;
import com.teamecho.bookie.question.domain.MainText;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.domain.QuestionPattern;
import com.teamecho.bookie.question.domain.QuestionText;
import com.teamecho.bookie.question.service.AddQuestionService;
import com.teamecho.bookie.user.service.UserService;

@Controller("question.web.addQuestionController")
public class AddQuestionController {
	
	@Autowired
	CategoryService cateService;
	
	@Autowired
	AddQuestionService addQService;
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	UserService userService;
	
	@Autowired 
	SubjectPatternService spService;
	
	@Autowired 
	ServletContext servletContext;
	
	HttpSession session;
	long uId;
		
	/**
	 * add_question 페이지 접속
	 * @return
	 */
	@GetMapping("/question/add_question")
	public String addQuestionForm(HttpServletRequest request, RedirectAttributes redirectAttributes) {
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
		
		return "question/add_question";
	}
	
	@GetMapping("/error/no_admin")
	public String noAdmin() {
		return "error/no_admin";
	}
	
	@GetMapping("/error/no_session")
	public String noSession() {
		return "error/no_session";
	}
	
	/**
	 * 문제 등록
	 * @param command
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@PostMapping("/question/add_question")
	public String addQuestions(AddQuestionsCommand command, HttpServletRequest request) throws IOException {
		
		// 카테고리 얻기
		Category category = cateService.getCategory(command.getCLevel(), command.getGrade(), command.getSubject());
		
		// 전체 텍스트 DB에 저장
		String text = command.getQText();
		QuestionText questionText = new QuestionText();
		questionText.setTotalText(text);
		addQService.addQuestionText(questionText);
		
		// 지문, 문제 분리
		List<String> mList = new ArrayList(); // 지문 담을 리스트
		List<String> qList = new ArrayList(); // 문제 담을 리스트
		List<String> titleList = new ArrayList(); // 문제 제목 담을 리스트
		List<String> textList = new ArrayList(); // 지문, 문제 구분자 제거 후 텍스트 담을 리스트
		
		StringTokenizer st = new StringTokenizer(text, "◆<>", false);
		while(st.hasMoreTokens()) {
			String str = st.nextToken();
			if(!str.equals("p") && !str.equals("/p")  && !str.equals("br")) {
				textList.add(str);
			}
		}
		
		String m = "";
		String s = "";
		
		if(textList.size() > 0) {
			for(int i = 0; i < textList.size(); i++) {
				if(textList.get(i).equals("지문")) {
					for(int j = i + 1; j < textList.size(); j++) {
						if(!(textList.get(j).equals("지문")) && !(textList.get(j).equals("문제"))) {
							m += "<p>" + textList.get(j) + "</p>";
						} else {
							mList.add(m);
							i = j-1;
							m = "";
							break;
						}
						if(j == textList.size() - 1) {
							mList.add(m);
						}
					}
				} else if (textList.get(i).equals("문제")) {
					for(int j = i + 1; j < textList.size(); j++) {
						if(!(textList.get(j).equals("지문")) && !(textList.get(j).equals("문제"))) {
							s += "<p>" + textList.get(j) + "</p>";
							if(j == i + 1) {
								titleList.add(textList.get(j));
							}
						} else {
							qList.add(s);
							i = j-1;
							s = "";
							break;
						}
						if(j == textList.size() - 1) {
							qList.add(s);
						}
					}
				}
			}
		}
		
		// MainText, Question, QuestionPattern 테이블에 담기
		if(command.getQuestionCount() == 1) { // 한문제인 경우
			Question question = new Question();
			QuestionText qt = addQService.getQuestionTextByTotalText(text);
			MainText mt = new MainText();
			titleList.add(textList.get(0));
			question.setQTitle(titleList.get(0));
			question.setQText(text);
			question.setAnswer(command.getAnswerList().get(0));
			question.setQComment(command.getQCommentList().get(0));
			question.setQuestionText(qt);
			question.setCategory(category);
			
			if(mList.size() > 0) { // 지문이 있다면
				mt.setMText(mList.get(0));
				addQService.addMainText(mt);
				mt = addQService.getMainTextByMText(mList.get(0));
				question.setMainText(mt);
				addQService.addQuestion(question);
			} else { // 지문이 없다면
				addQService.addQuestionNotMtId(question);
			}
			
			// QuestionPattern DB 등록
			Question q = addQService.getQuestionByText(text);
			SubjectPattern sp = spService.getSubjectPatternByBPatternAndMPattern(command.getBPattern(), command.getMPattern());
			
			QuestionPattern qp = new QuestionPattern();
			qp.setQuestion(q);
			qp.setSubjectPattern(sp);
			addQService.addQuestionPattern(qp);
			
		} else { // 지문1에 문제 여러개인 경우
			// 지문 DB 등록
			MainText mt = new MainText();
			mt.setMText(mList.get(0));
			addQService.addMainText(mt);
			
			// 문제 DB 등록
			QuestionText qt = addQService.getQuestionTextByTotalText(text);
			for(int i = 0; i < qList.size(); i++) {
				Question question = new Question();
				question.setQTitle(titleList.get(i));
				question.setQText(qList.get(i));
				question.setAnswer(command.getAnswerList().get(i));
				question.setQComment(command.getQCommentList().get(i));
				question.setQuestionText(qt);
				mt = addQService.getMainTextByMText(mList.get(0));
				question.setMainText(mt);
				question.setCategory(category);
				
				addQService.addQuestion(question);
				
				// QuestionPattern DB 등록
				Question q = addQService.getQuestionByText(text);
				SubjectPattern sp = spService.getSubjectPatternByBPatternAndMPattern(command.getBPattern(), command.getMPattern());
				
				QuestionPattern qp = new QuestionPattern();
				qp.setQuestion(q);
				qp.setSubjectPattern(sp);
				addQService.addQuestionPattern(qp);
			}
		}
		
		
		
		
		// 에디터에서 받아온 html문자열에서 이미지 태그 분리 후 이미지파일 이름 저장
		List<String> qTextImgNameList = commonService.getImageName(text);
		// 임시저장 폴더에서 이미지파일 찾아서 최종적으로 html에 포함된 이미지만 골라서 최종 폴더에 저장
		commonService.saveFinalImages(command.getQuestionImgArr(), qTextImgNameList);
		// 임시 저장 이미지 삭제
		commonService.deleteTempImages(command.getQuestionImgArr());
		
		
		return "";
	}
	
	Category category = new Category();
	
	@PostMapping("/question/checking_pattern")
	public String checkingPattern(CategoryCommand command, RedirectAttributes redirectAttributes) {
		// jsp에 던져줄 태그 변수
		String bigTag = "<select id='bPattern' name='bPattern'>";
		
		// 위 세가지에 해당하는 카테고리 추출
		category = cateService.getCategory(String.valueOf(command.getCLevel()), command.getGrade(), command.getSubject());
		
		// 카테아이디를 통해 대분류를 각각 태그에 담아서 해당 String을 다시 던져주기(이때 각 태그에는 중분류를 찾는 스트립트함수 호출하는 내용 들어가야 함)
		List<String> bigPatterns = spService.getBigPatternsPatternsByCateId(category.getCateId());
		for(int i = 0; i < bigPatterns.size(); i++) {
			String big = bigPatterns.get(i);
			//bigTag += "<div id='" + i + "' class='big_pattern' onclick='javascript:checkingMPattern('<c:url value=\"/question/checking_Mpattern\"/>', " + big + ")'>" + big + "</div>";
			bigTag += "<option value='" + big + "' onclick='javascript:checkingMPattern('<c:url value=\"/question/checking_Mpattern\"/>', " + big + ")'>" + big + "</option>";
		}
		bigTag += "</select>";
		
		redirectAttributes.addFlashAttribute("bigTag", bigTag);
		redirectAttributes.addFlashAttribute("category", category);
		
		return "redirect:/question/add_question";
	}
	
	@PostMapping("/question/checking_Mpattern")
	public String checkingMPattern(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		String midTag = "<select id='mPattern' name='mPattern'>";
		
		String bigPattern = request.getParameter("bp");
		
		List<String> midPatterns = spService.getMidPatternsByBigPattern(bigPattern);
		for(int i = 0; i < midPatterns.size(); i++) {
			String mid = midPatterns.get(i);
			midTag += "<option value='" + mid + "' onclick='javascript:checkingMPattern('<c:url value=\"/question/checking_Mpattern\"/>', " + mid + ")'>" + mid + "</option>";
		}
		midTag += "</select>";
		
		redirectAttributes.addFlashAttribute("midTag", midTag);
		redirectAttributes.addFlashAttribute("category", category);
		redirectAttributes.addFlashAttribute("bigPattern", bigPattern);
		
		return "redirect:/question/add_question";
	}
}
