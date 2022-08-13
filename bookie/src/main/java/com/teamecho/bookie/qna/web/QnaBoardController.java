package com.teamecho.bookie.qna.web;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import com.teamecho.bookie.common.domain.Paging;

@Controller
public class QnaBoardController {
	
	@GetMapping("/qna_board")
	public ModelAndView qnaBoard() throws Exception {
		ModelAndView mav = new ModelAndView();
	    try {
	    	
	        Paging paging = new Paging();
	        paging.setViewPageNo(5); // 화면에 5개의 번호를 보여주고 싶다.
	        paging.setFirstPageNo(1); // 화면에 시작번호 이다.
	        paging.setTotalCount(100); // 총 게시글 수 이다.
	        paging.calcPagingNo(); // 마지막페이지 계산
	        paging.makePaging(1);
	        //Map<String, String> map = new HashMap<String, String>();
	        mav.addObject("paging", paging);
	        mav.setViewName("/qna/qna_board");
	        
	    } catch (Exception e) {
	        throw e;
	    }
	    return mav;
	}
	@GetMapping("/qna_board/{pagingNo}")
	public ModelAndView qnaBoardPaging(@PathVariable int pagingNo) throws Exception {
		ModelAndView mav = new ModelAndView();
		System.out.println("페이지번호 " + pagingNo);
	    try {
	        Paging paging = new Paging();
	        paging.setViewPageNo(5); // 화면에 5개의 번호를 보여주고 싶다.
	        paging.setFirstPageNo(1); // 화면에 시작번호 이다.
	        paging.setTotalCount(100); // 총 게시글 수 이다.
	        paging.calcPagingNo(); // 마지막페이지 계산
	        paging.makePaging(pagingNo+1);
	        
	        mav.addObject("paging", paging);
	        mav.setViewName("/qna/qna_board");
	        
	    } catch (Exception e) {
	        throw e;
	    }
	    return mav;
	}
}
