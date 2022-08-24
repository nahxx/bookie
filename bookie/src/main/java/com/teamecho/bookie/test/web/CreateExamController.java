package com.teamecho.bookie.test.web;

import com.teamecho.bookie.common.domain.Category;
import com.teamecho.bookie.common.domain.CategoryCommand;
import com.teamecho.bookie.common.domain.CategoryProvider;
import com.teamecho.bookie.common.service.CategoryService;
import com.teamecho.bookie.common.service.SubjectPatternService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller("test.web.createExamController")
public class CreateExamController {

    @Autowired
    CategoryService cateService;
    @Autowired
    SubjectPatternService spService;

    @GetMapping("/test/createExam")
    public String createExamPage(Model model, HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        model.addAttribute("category", new CategoryCommand());
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
        model.addAttribute("category", command);

        category = cateService.getCategory(command.getCLevel(), command.getGrade(), command.getSubject());
        // 카테아이디를 통해 대분류를 각각 태그에 담아서 해당 String을 다시 던져주기(이때 각 태그에는 중분류를 찾는 스트립트함수 호출하는 내용 들어가야 함)
        List<String> bigPatterns = spService.getBigPatternsPatternsByCateId(category.getCateId());

        bigTag = "";
        for(int i = 0; i < bigPatterns.size(); i++) {
            String big = bigPatterns.get(i);
            bigTag += "<option value='" + big + "'>" + big + "</option>";

        }

        model.addAttribute("bigTag", bigTag);
        return "test/create_exam";
    }

    @GetMapping("test/createExamSelectPattern_m")
    public String selectPatternM(HttpServletRequest request, Model model){
        String midTag = "";
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
        return "test/create_exam";
    }
}
