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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.service.CategoryService;
import com.teamecho.bookie.common.service.CommonService;
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
	ServletContext servletContext;
	
	HttpSession session;
	long uId;
		
	/**
	 * add_question 페이지 접속
	 * @return
	 */
	@GetMapping("/question/add_question")
	public String addQuestionForm(HttpServletRequest request) {
		session = request.getSession(false);
		uId = (long) session.getAttribute("uId");
		if(userService.getUserByUid(uId).getManager() == 'N') {
			// 에러 페이지 이동
		}
		
		return "question/add_question";
	}
	
	@PostMapping("/question/add_questions")
	public String addQuestions(AddQuestionsCommand command, HttpServletRequest request) {
		
//		System.out.println(command.getAnswerList());
//		System.out.println(command.getQCommentList());
//		System.out.println(command.getQuestionImgArr());
//		System.out.println(command.getQuestionCount());
//		
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
		
		List<String> textList = new ArrayList();
		
		StringTokenizer st = new StringTokenizer(text, "◆<>", false);
		while(st.hasMoreTokens()) {
			String str = st.nextToken();
			//System.out.println(str);
			if(!str.equals("p") && !str.equals("/p")  && !str.equals("br")) {
				System.out.println(str);
				textList.add(str);
			}
		}
		System.out.println();
		String m = "";
		String s = "";
		for(int i = 0; i < textList.size(); i++) {
			if(textList.get(i).equals("지문")) {
				for(int j = i + 1; j < textList.size(); j++) {
					if(!(textList.get(j).equals("지문")) && !(textList.get(j).equals("문제"))) {
						m += "<p>" + textList.get(j) + "</p>";
						System.out.println("지문:" + j);
					} else {
						mList.add(m);
						i = j-1;
						m = "";
						break;
					}
				}
			} else if (textList.get(i).equals("문제")) {
				for(int j = i + 1; j < textList.size(); j++) {
					if(!(textList.get(j).equals("지문")) && !(textList.get(j).equals("문제"))) {
						s += "<p>" + textList.get(j) + "</p>";
						System.out.println("문제:" + j);
					} else {
						qList.add(s);
						i = j-1;
						s = "";
						break;
					}
				}
			}
		}
		System.out.println(mList.size());
		System.out.println(qList.size());
		for(int i = 0; i < mList.size(); i++) {
			System.out.println("mList" + i + ":" + mList.get(i));
		}
		for(int i = 0; i < qList.size(); i++) {
			System.out.println("qList" + i + ":" + qList.get(i));
		}
		
		
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
		

		
		// 에디터에서 받아온 html문자열에서 이미지 태그 분리 후 이미지파일 이름 저장
		//List<String> qTextImgNameList = commonService.getImageName(qText);
		//List<String> qCommentImgNameList = commonService.getImageName(qComment);
		
		// 임시저장 폴더에서 이미지파일 찾아서 최종적으로 html에 포함된 이미지만 골라서 최종 폴더에 저장
		//commonService.saveFinalImages(questionImgArr, qTextImgNameList);
		//commonService.saveFinalImages(commentImgArr, qCommentImgNameList);
		
		// 임시 저장 이미지 삭제
		//commonService.deleteTempImages(questionImgArr);
		//commonService.deleteTempImages(commentImgArr);
		
		return "";
	}

}
