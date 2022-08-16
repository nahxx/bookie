package com.teamecho.bookie.qna.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import com.teamecho.bookie.common.domain.Paging;
import com.teamecho.bookie.qna.domain.Board;
import com.teamecho.bookie.qna.domain.Qna;
import com.teamecho.bookie.qna.service.QnaService;


@Controller
public class QnaBoardController {
	
	@Autowired
	QnaService qnaService;
	/**
	 * 수진이한테 해더에 1을 붙여달라고 해야겠다. 그럼 이 컨트롤러는 필요 없을듯.
	 * @return
	 * @throws Exception
	 */
	/*
	@GetMapping("/qna_board")
	public ModelAndView qnaBoard() throws Exception {
		ModelAndView mav = new ModelAndView();
	    try {
	        Paging paging = new Paging();
	        paging.setViewPageNo(5); 	// 초기값1 : 화면에 5개의 번호를 보여주고 싶다.
	        paging.setFirstPageNo(1); 	// 초기값2 :  화면에 시작번호 이다.
	        paging.setPageSize(10);		// 초기값3 : 한 페이지에 보여줄 게시글 갯수
	        paging.setTotalCount(qnaService.getAllQna().size());	// 초기값4 : 총 게시글 수 이다.
	        paging.calcPagingNo();	//초기값5 : 페이지 갯수 계산 함.
	        paging.makePaging(1);
	        List<Qna> qnaList = qnaService.getQnaBoardList(1, paging.getPageSize());
	        
	        mav.addObject("qnaList", qnaList);
	        mav.addObject("paging", paging);
	        mav.setViewName("/qna/qna_board");
	        
	    } catch (Exception e) {
	        throw e;
	    }
	    return mav;
	}
	*/
	@GetMapping("/qna_board/{pagingNo}")
	public ModelAndView qnaBoardPaging(@PathVariable int pagingNo) throws Exception {
		ModelAndView mav = new ModelAndView();
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
	        mav.setViewName("/qna/qna_board");
	        
	    } catch (Exception e) {
	        throw e;
	    }
	    return mav;
	}
}
