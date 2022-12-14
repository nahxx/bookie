package com.teamecho.bookie.question.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
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

@Controller
public class AddQuestionController2 {
	
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
	 * add_question ????????? ??????
	 * @return
	 */
	@GetMapping("/question/add_question2")
	public String addQuestionForm(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		session = request.getSession(false);
		
		if (session == null) {
			redirectAttributes.addFlashAttribute("session", "no");
			return "redirect:/error/no_session2";
		}
		
		if(session.getAttribute("uId") == null) {
			redirectAttributes.addFlashAttribute("session", "no");
			return "redirect:/error/no_session2";
		}
		
		uId = (long) session.getAttribute("uId");

		if(userService.getUserByUid(uId).getManager() == 'N') {
			redirectAttributes.addFlashAttribute("session", "no");
			// ?????? ????????? ??????
			return "redirect:/error/no_admin2";
		}
		
		return "question/add_question2";
	}
	
	@GetMapping("/error/no_admin2")
	public String noAdmin() {
		return "error/no_admin";
	}
	
	@GetMapping("/error/no_session2")
	public String noSession() {
		return "error/no_session";
	}
	
	/**
	 * ?????? ??????
	 */
	@PostMapping("/question/add_question2")
	public String addQuestions(AddQuestionsCommand command, HttpServletRequest request, HttpServletResponse response) throws IOException {
		// ???????????? ??????
		Category category = cateService.getCategory(command.getCLevel(), command.getGrade(), command.getSubject());
		String text = command.getQText();
		// ?????? ????????? DB??? ??????
		long questionTextKey = addQService.addQuestionTextRetrunID(text);
		
		// ??????, ?????? ??????
		List<String> mList = new ArrayList<String>(); // ?????? ?????? ?????????
		List<String> qList = new ArrayList<String>(); // ?????? ?????? ?????????
		List<String> textList = new ArrayList<String>(); // ??????, ?????? ????????? ?????? ??? ????????? ?????? ?????????
		
		StringTokenizer st = new StringTokenizer(text, "???<>", false);
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
				if(textList.get(i).equals("??????")) {
					for(int j = i + 1; j < textList.size(); j++) {
						if(!(textList.get(j).equals("??????")) && !(textList.get(j).equals("??????"))) {
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
				} else if (textList.get(i).equals("??????")) {
					for(int j = i + 1; j < textList.size(); j++) {
						if(!(textList.get(j).equals("??????")) && !(textList.get(j).equals("??????"))) {
							s += "<p>" + textList.get(j) + "</p>";
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
		
		// MainText, Question, QuestionPattern ???????????? ??????
		if(qList.size() == 0 || qList.size() == 1) { // ???????????? ??????
			Question question = new Question();
			QuestionText qt = addQService.getQuestionTextByQtId(questionTextKey);
			MainText mt = new MainText();
			question.setAnswer(0);
			question.setQuestionText(qt);
			question.setCategory(category);
			Question q;
			if(mList.size() > 0) { // ????????? ?????????
				question.setQText(qList.get(0));
				mt.setMText(mList.get(0));
				addQService.addMainText(mt);
				mt = addQService.getMainTextByMText(mList.get(0));
				question.setMainText(mt);
				addQService.addQuestion(question);
				q = addQService.getQuestionByText(qList.get(0));
			} else { // ????????? ?????????
				question.setQText(text);
				addQService.addQuestionNotMtId(question);
				q = addQService.getQuestionByText(text);
			}
			
			// QuestionPattern DB ??????
			SubjectPattern sp = spService.getSubjectPatternByBPatternAndMPatternAndCateId(command.getBPattern(), command.getMPattern(), category.getCateId());
			
			QuestionPattern qp = new QuestionPattern();
			qp.setQuestion(q);
			qp.setSubjectPattern(sp);
			addQService.addQuestionPattern(qp);
			
		} else { // ??????1??? ?????? ???????????? ??????
			// ?????? DB ??????
			MainText mt = new MainText();
			mt.setMText(mList.get(0));
			addQService.addMainText(mt);
			
			// ?????? DB ??????
			QuestionText qt = addQService.getQuestionTextByQtId(questionTextKey);
			for(int i = 0; i < qList.size(); i++) {
				Question question = new Question();

				question.setQText(qList.get(i));
				question.setAnswer(0);
				question.setQuestionText(qt);
				mt = addQService.getMainTextByMText(mList.get(0));
				question.setMainText(mt);
				question.setCategory(category);
				
				addQService.addQuestion(question);
				
				// QuestionPattern DB ??????
				Question q = addQService.getQuestionByText(qList.get(i));
				SubjectPattern sp = spService.getSubjectPatternByBPatternAndMPatternAndCateId(command.getBPattern(), command.getMPattern(), category.getCateId());
				
				QuestionPattern qp = new QuestionPattern();
				qp.setQuestion(q);
				qp.setSubjectPattern(sp);
				addQService.addQuestionPattern(qp);
			}
		}

		// ??????????????? ????????? html??????????????? ????????? ?????? ?????? ??? ??????????????? ?????? ??????
		List<String> qTextImgNameList = commonService.getImageName(text);
		// ???????????? ???????????? ??????????????? ????????? ??????????????? html??? ????????? ???????????? ????????? ?????? ????????? ??????
		//commonService.saveFinalImages(command.getQuestionImgArr(), qTextImgNameList);
		// ?????? ?????? ????????? ??????
		//commonService.deleteTempImages(command.getQuestionImgArr());
		
		return "redirect:/question/add_comment/" + questionTextKey;
	}
	
	
	Category category;
	String bigTag;
	@PostMapping("/question/checking_pattern2")
	public String checkingPattern(CategoryCommand command, RedirectAttributes redirectAttributes) {
		// ??? ???????????? ???????????? ???????????? ??????
		category = cateService.getCategory(command.getCLevel(), command.getGrade(), command.getSubject());
		// ?????????????????? ?????? ???????????? ?????? ????????? ????????? ?????? String??? ?????? ????????????(?????? ??? ???????????? ???????????? ?????? ?????????????????? ???????????? ?????? ???????????? ???)
		List<String> bigPatterns = spService.getBigPatternsPatternsByCateId(category.getCateId());
		
		bigTag = "";
		for(int i = 0; i < bigPatterns.size(); i++) {
			String big = bigPatterns.get(i);
			bigTag += "<option value='" + big + "'>" + big + "</option>";
			
		}

		redirectAttributes.addFlashAttribute("bigTag", bigTag);
		redirectAttributes.addFlashAttribute("category", category);
		
		return "redirect:/question/add_question2";
	}
	
	@PostMapping("/question/checking_pattern_m2")
	public String checkingMPattern(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		String midTag = "";
		String bigPattern = request.getParameter("bp");
		
		List<String> midPatterns = spService.getMidPatternsByBigPatternAndCateId(bigPattern, category.getCateId());
		for(int i = 0; i < midPatterns.size(); i++) {
			String mid = midPatterns.get(i);
			midTag += "<option value='" + mid + "'>" + mid +  "</option>";
		}
		
		redirectAttributes.addFlashAttribute("midTag", midTag);
		redirectAttributes.addFlashAttribute("category", category);
		redirectAttributes.addFlashAttribute("bigPattern", bigPattern);
		redirectAttributes.addFlashAttribute("bigTag", bigTag);
		return "redirect:/question/add_question2";
	}
	
	@ResponseBody
	@RequestMapping(value = "/question_write", method = RequestMethod.POST)
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
