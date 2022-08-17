package com.teamecho.bookie.qna.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import com.teamecho.bookie.common.domain.Paging;
import com.teamecho.bookie.qna.domain.Board;
import com.teamecho.bookie.qna.service.QnaService;


@Controller
public class QnaBoardController {
	
	@Autowired
	QnaService qnaService;

	@GetMapping("/qna_board/{pagingNo}")
	public ModelAndView qnaBoardPaging(@PathVariable int pagingNo, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession(false);
		
		if (session == null) {
			  mav.addObject("session", "no");
	      } 
		else {
	         if(session.getAttribute("uId") == null) {
	        	 mav.addObject("session", "no");
	         }
	         mav.addObject("session", "yes");
	      }
		

	    try {
	        Paging paging = new Paging();
	        paging.setViewPageNo(5); 	// 초기값1 : 화면에 5개의 번호를 보여주고 싶다.
	        paging.setFirstPageNo(1); 	// 초기값2 :  화면에 시작번호 이다.
	        paging.setPageSize(10);		// 초기값3 : 한 페이지에 보여줄 게시글 갯수
	        paging.setTotalCount(qnaService.getAllQna().size());	// 초기값4 : 총 게시글 수 이다.
	        paging.calcPagingNo();	//초기값5 : 페이지 갯수 계산 함.
	        
	        paging.makePaging(pagingNo); //페이지에 맞게
	        List<Board> boardList = qnaService.getQnaBoardList(pagingNo, paging.getPageSize());
	        
	        mav.addObject("boardList", boardList);
	        mav.addObject("paging", paging);
	        mav.addObject("uId", (long)session.getAttribute("uId"));
	        mav.setViewName("/qna/qna_board");
	        
	    } catch (Exception e) {
	        throw e;
	    }
	    return mav;
	}
}
