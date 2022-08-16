package com.teamecho.bookie.question.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.service.CategoryService;
import com.teamecho.bookie.common.service.CommonService;
import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.service.AddQuestionService;

@Controller("question.web.addQuestionController")
public class AddQuestionController {
	
	@Autowired
	CategoryService cateService;
	
	@Autowired
	AddQuestionService addQService;
	
	@Autowired
	CommonService commonService;
	
	@Autowired 
	ServletContext servletContext;
	
	HttpSession session;
	long uId;
	
	String cLevel = "";
	int grade = 0;
	String subject = "";
	int qType = 0;
		
	/**
	 * add_question 페이지 접속
	 * @return
	 */
	@GetMapping("/question/add_question")
	public String addQuestionForm() {
		return "question/add_question";
	}
	
	@PostMapping("/question/add_questions")
	public String addQuestions(AddQuestionsCommand command) {
		System.out.println(command.getCLevel());
		System.out.println(command.getGrade());
		System.out.println(command.getSubject());
		System.out.println(command.getQText());
		System.out.println(command.getAnswerList());
		System.out.println(command.getQCommentList());
		System.out.println(command.getQuestionImgArr());
		System.out.println(command.getQuestionCount());
		return "";
	}

	/**
	 * 일반문제 등록
	 * @return
	 * @throws IOException 
	 */
	@PostMapping("/question/add_common_question")
	public String addCommonQuestion(HttpServletRequest request, RedirectAttributes redirectAttributes,
			@RequestParam(value="questionImgArr", required=false) List<String> questionImgArr,
			@RequestParam(value="commentImgArr", required=false) List<String> commentImgArr) throws IOException {
		
		String qType = request.getParameter("qType");
		String qTitle = request.getParameter("qTitle");
		String qText = request.getParameter("qText");
		int answer = Integer.valueOf(request.getParameter("answer"));
		String qComment = request.getParameter("qComment");
		Category category = cateService.getCategory(cLevel, grade, subject);
		
		session = request.getSession(false);
		uId = (long) session.getAttribute("uId");
		//String noHidden = "no Hidden";
		
		// 유효성 검사
		/*
		if(qTitle == null || qTitle.length() == 0) {
			String errMsg1 = "<span class=\"error\">제목을 입력해주세요.</span>";
			request.setAttribute("errMsg1", errMsg1);
			request.setAttribute("noHidden", noHidden);
			return "/question/select_type";
		}
		if(qText == null || qText.length() == 0) {
			String errMsg2 = "<span class=\"error\">질문을 입력해주세요.</span>";
			request.setAttribute("errMsg2", errMsg2);
		}
		
		// 만약 답을 radio로 선택할 수 있다면 이부분 삭제1
		if(answer == 0) {
			String errMsg3 = "<span class=\"error\">답을 입력해주세요.</span>";
			request.setAttribute("errMsg2", errMsg3);
		}
		// 만약 답을 radio로 선택할 수 있다면 이부분 삭제1
		if(answer < 0 || answer > 5) {
			String errMsg4 = "<span class=\"error\">답은 1~5 중에서 선택해주세요.</span>";
			request.setAttribute("errMsg2", errMsg4);
		}
		
		if(qComment == null || qComment.length() == 0) {
			String errMsg5 = "<span class=\"error\">해설을 입력해주세요.</span>";
			request.setAttribute("errMsg5", errMsg5);
		}
		*/
		
		
		Question q = new Question(qTitle, qText, answer, qComment, category);
		
		// 서비스 호출
		addQService.addQuestionNotMainText(q);
		
		// 에디터에서 받아온 html문자열에서 이미지 태그 분리 후 이미지파일 이름 저장
		List<String> qTextImgNameList = commonService.getImageName(qText);
		List<String> qCommentImgNameList = commonService.getImageName(qComment);
		
		// 임시저장 폴더에서 이미지파일 찾아서 최종적으로 html에 포함된 이미지만 골라서 최종 폴더에 저장
		commonService.saveFinalImages(questionImgArr, qTextImgNameList);
		commonService.saveFinalImages(commentImgArr, qCommentImgNameList);
		
		// 임시 저장 이미지 삭제
		commonService.deleteTempImages(questionImgArr);
		commonService.deleteTempImages(commentImgArr);
		
		return "";
	}

}
