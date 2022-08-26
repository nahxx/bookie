package com.teamecho.bookie.test.web;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.domain.CategoryCommand;
import com.teamecho.bookie.common.domain.CategoryProvider;
import com.teamecho.bookie.common.domain.SubjectPattern;
import com.teamecho.bookie.common.exception.DuplicateQuestionPattern;
import com.teamecho.bookie.common.service.CategoryService;
import com.teamecho.bookie.common.service.SubjectPatternService;
import com.teamecho.bookie.test.domain.LineSubjectPattern;
import com.teamecho.bookie.test.service.QuestionCartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@Controller("test.web.createExamController")
public class CreateExamController {

    @Autowired
    private CategoryService cateService;
    @Autowired
    private SubjectPatternService spService;
    @Autowired
    private SubjectPatternService subjectPatternService;
    @Autowired
    private QuestionCartService questionCartService;

    private List<LineSubjectPattern> lineSubjectPatterns;

    String totalStr;
    @GetMapping("/test/createExam")
    public String createExamPage(Model model, HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        // 유형라인리스트 초기화해주기
        if(session.getAttribute("lineSubjectPatterns") != null) {
            questionCartService.removeList();
            session.removeAttribute("lineSubjectPatterns");
        }

        // 모의고사 풀려면 로그인 해야합니다 :)
        if (session == null) {
            model.addAttribute("session", "no");
            return "error/no_session";
        }

        if(session.getAttribute("uId") == null) {
            model.addAttribute("session", "no");
            return "error/no_session";
        }
        totalStr = "총 <span class='num-txt'>" + questionCartService.getTotalQuestionCount() + "</span>문제";
        model.addAttribute("category", new CategoryCommand());
        model.addAttribute("totalQuestionCount", totalStr);
        return "/test/create_exam";
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

    Category category;
    String bigTag;
    @GetMapping("test/createExamSelectPattern")
    public String selectPattern(HttpServletRequest request, Model model, @ModelAttribute("category") CategoryCommand command) {
        HttpSession session = request.getSession(false);

        if (session == null) {
            model.addAttribute("session", "no");
            return "error/no_session";
        }

        if(session.getAttribute("uId") == null) {
            model.addAttribute("session", "no");
            return "error/no_session";
        }

        category = cateService.getCategory(command.getCLevel(), command.getGrade(), command.getSubject());
        // 카테아이디를 통해 대분류를 각각 태그에 담아서 해당 String을 다시 던져주기(이때 각 태그에는 중분류를 찾는 스트립트함수 호출하는 내용 들어가야 함)
        List<String> bigPatterns = spService.getBigPatternsPatternsByCateId(category.getCateId());

        bigTag = "";
        for(int i = 0; i < bigPatterns.size(); i++) {
            String big = bigPatterns.get(i);
            bigTag += "<option value='" + big + "'>" + big + "</option>";

        }

        model.addAttribute("category", command);
        model.addAttribute("bigTag", bigTag);
        model.addAttribute("totalQuestionCount", totalStr);
        return "test/create_exam";
    }

    String midTag;
    @GetMapping("test/createExamSelectPattern_m")
    public String selectPatternM(HttpServletRequest request, Model model){
        HttpSession session = request.getSession(false);

        if (session == null) {
            model.addAttribute("session", "no");
            return "error/no_session";
        }

        if(session.getAttribute("uId") == null) {
            model.addAttribute("session", "no");
            return "error/no_session";
        }


        midTag = "";
        String bigPattern = request.getParameter("bp");

        List<String> midPatterns = spService.getMidPatternsByBigPatternAndCateId(bigPattern, category.getCateId());
        for(int i = 0; i < midPatterns.size(); i++) {
            String mid = midPatterns.get(i);
            midTag += "<option value='" + mid + "'>" + mid +  "</option>";
        }

        model.addAttribute("midTag", midTag);
        model.addAttribute("category", category);
        model.addAttribute("bigPattern", bigPattern);
        model.addAttribute("bigTag", bigTag);
        model.addAttribute("totalQuestionCount", totalStr);
        return "test/create_exam";
    }


    @PostMapping("test/createExamSelectPattern")
    public String selectPatternAll(HttpServletRequest request, HttpServletResponse response, Model model){
        HttpSession session = request.getSession(false);

        if (session == null) {
            model.addAttribute("session", "no");
            return "error/no_session";
        }

        if(session.getAttribute("uId") == null) {
            model.addAttribute("session", "no");
            return "error/no_session";
        }

        long sessionSP;

        if(session.getAttribute("spId") == null) {
            sessionSP = 0;
        } else {
            sessionSP = (long)session.getAttribute("spId");
        }

        String bigPattern = request.getParameter("bp");
        String midPattern = request.getParameter("mp");
        int questionCount = Integer.parseInt(request.getParameter("questionCount"));

        SubjectPattern subjectPattern = subjectPatternService.getSubjectPatternByBPatternAndMPatternAndCateId(bigPattern, midPattern, category.getCateId());
        lineSubjectPatterns = (List<LineSubjectPattern>) session.getAttribute("lineSubjectPatterns");

        if( sessionSP == 0 || subjectPattern.getSpId() != sessionSP) {

            // subjectPattern이 달라지면 문제 담기
            try {
                lineSubjectPatterns = questionCartService.addQuestionPattern(category, subjectPattern, questionCount);
                questionCartService.calcTotalQuestionCount();
                totalStr = "총 <span class='num-txt'>" + questionCartService.getTotalQuestionCount() + "</span>문제";
            } catch (DuplicateQuestionPattern e) {
                model.addAttribute("questionDuplicate", "y");
                model.addAttribute("questionDuplicateException", e.getMessage());
            }

            model.addAttribute("midTage", midTag);
            model.addAttribute("category", category);
            model.addAttribute("bigPattern", bigPattern);
            model.addAttribute("bigTag", bigTag);
            model.addAttribute("midTag", midTag);
            model.addAttribute("midPattern", midPattern);
            model.addAttribute("totalQuestionCount", totalStr);
            session.setAttribute("lineSubjectPatterns", lineSubjectPatterns);
            session.setAttribute("spId", subjectPattern.getSpId());

            return "/test/create_exam";
        }

        System.out.println("subjectPattern의 세션이 같을때");

        model.addAttribute("midTage", midTag);
        model.addAttribute("category", category);
        model.addAttribute("bigPattern", bigPattern);
        model.addAttribute("bigTag", bigTag);
        model.addAttribute("midTag", midTag);
        model.addAttribute("midPattern", midPattern);
        model.addAttribute("totalQuestionCount", totalStr);
        session.setAttribute("lineSubjectPatterns", lineSubjectPatterns);
        return "/test/create_exam";
    }

    @GetMapping("test/createExam/{subjectPattern}")
    public String deleteLineItem(@PathVariable String subjectPattern, Model model, HttpServletRequest request){
        HttpSession session = request.getSession(false);

        if (session == null) {
            model.addAttribute("session", "no");
            return "error/no_session";
        }

        if(session.getAttribute("uId") == null) {
            model.addAttribute("session", "no");
            return "error/no_session";
        }

        String[] str = subjectPattern.split("_");
        String bigPattern = str[0];
        String midPattern = str[1];

        SubjectPattern sp = subjectPatternService.getSubjectPatternByBPatternAndMPatternAndCateId(bigPattern, midPattern, category.getCateId());

        // linsubjectPattern 지우기
        lineSubjectPatterns = questionCartService.eachRemoveList(sp);
        totalStr = "총 <span class='num-txt'>" + questionCartService.getTotalQuestionCount() + "</span>문제";

        model.addAttribute("midTage", midTag);
        model.addAttribute("category", category);
        model.addAttribute("bigPattern", bigPattern);
        model.addAttribute("bigTag", bigTag);
        model.addAttribute("midTag", midTag);
        model.addAttribute("midPattern", midPattern);
        model.addAttribute("totalQuestionCount", totalStr);
        session.setAttribute("lineSubjectPatterns", lineSubjectPatterns);
        return "/test/create_exam";
    }
}
