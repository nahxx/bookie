package com.teamecho.bookie.common.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Paging {
	private int viewPageNo; 	// 화면에 보여주고 싶은 페이지 갯수
    private int pageSize; 		// 한 화면에 보여주고 싶은 게시글 갯수
    private int totalCount; 	// 게시 글 전체 수
    private int currentPageNo;	// 현재의 페이지.
    private int firstPageNo; 	// 첫 번째 페이지 번호
    private int finalPageNo; 	// 마지막 페이지 번호
    private int startPageNo; 	// 시작 페이지 (페이징 네비 기준)
    private int endPageNo; 		// 끝 페이지 (페이징 네비 기준)

    public void calcPagingNo() {
    	// 총 게시글수가 20개 인데 한페이지에 보여줄 게시물 갯수는 12개 이면 필요한 페이지 갯수는 2가 된다. 
    	// 1페이지에는 12개 2페이지에는 8개가 보여진다. 올림 사용하였고, 결국 2페이지가 마지막페이지가 된다.
    	int calcViewPage = (int) Math.ceil( (double) totalCount / (double) pageSize );
    	finalPageNo = calcViewPage;
    	//보여주는 페이지수가 마지막페이지 수보다 크다면 보여지는 수는 마지막페이지 수까지 이다. 
    	if(viewPageNo > finalPageNo) {
    		viewPageNo = finalPageNo;
    	}
    }
    
    public void makePaging(int selectPageNo) {
    	
    	//보여주고 싶은 페이지 갯수로 그룹을 지정하면 선택한 페이지번호의 그룹번호를 찾기 위함이다.
    	// 1 2 3 4 5
    	// 6 7 8 9 10 
    	// 8번을 눌렀을때 해당 페이지번호의 그룹번호는 1가 된다. ( 0이 첫번째 이다.)
    	int pageLine;
    	
    	if(selectPageNo == viewPageNo) {
    		pageLine = (int) Math.floor( (double) (selectPageNo - 1) / (double) viewPageNo);
    	}else {
    		pageLine = (int) Math.floor( (double) selectPageNo / (double) viewPageNo);
    	}
    	
    	//선택한 페이지가 현재의 페이지로 등록함.
    	currentPageNo = selectPageNo;
    	
    	if(pageLine < 1) {
    		startPageNo = 1;
    		endPageNo = startPageNo + viewPageNo - 1;
    	}else {
    		startPageNo = (viewPageNo * pageLine) + 1 ;
    		endPageNo = startPageNo + viewPageNo - 1;
    		if (endPageNo > finalPageNo ) {
    			endPageNo = finalPageNo;
    		}
    	}
    }
}

