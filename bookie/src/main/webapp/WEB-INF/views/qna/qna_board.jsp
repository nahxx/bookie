<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet"
	href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/qna/table.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/qna/paging.css"/>" />
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<body>
	<header>
		<%@ include file="../incl/no_login_header.jsp"%>
	</header>
	<div class="table-wrap">
		<table class="inner-table">
			<c:set var="boardNo" value="${paging.totalCount - (paging.currentPageNo - 1) * paging.pageSize }" />
			<thead>
				<tr>
					<th>번호</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="qna" items="${qnaList}">
					<tr>
						<td>${boardNo}</td>
						<td>카테고리</td>
						<td><a href="<c:url value='/answer/${qna.qnaId}'/>" >${qna.subject}</a></td>
						<td>${qna.user.name}</td>
						<td><fmt:formatDate value="${qna.regDate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
						<c:set var="boardNo" value="${boardNo - 1}" />
					</tr>
				</c:forEach>

			</tbody>
		</table>
		<div class="paging">
			<ul class="inner-paging-wrap">
			<c:choose>
			  <c:when test="${ paging.currentPageNo == '1' }">
            		<li><a style="color:#808080; disabled">◀</a></li>
        		</c:when>
        		 <c:otherwise>
                    <li><a href="<c:url value='/qna_board/${paging.currentPageNo - 1}'/>" >◀</a></li>
                </c:otherwise>
        	</c:choose>
				<c:forEach var="i" begin="${ paging.startPageNo }"
					end="${ paging.endPageNo }">
					<li><a class="pageNo ${i}" href="<c:url value="/qna_board/${i}"/>">${i}</a></li>
				</c:forEach>
				<c:choose>
			  <c:when test="${ paging.currentPageNo == paging.finalPageNo }">
            		<li><a style="color:#808080; disabled">▶</a></li>
        		</c:when>
        		 <c:otherwise>
                    <li><a href="<c:url value='/qna_board/${paging.currentPageNo + 1}'/>" >▶</a></li>
                </c:otherwise>
        	</c:choose>
			</ul>
		</div>
	</div>
▶<script>
   $(".pageNo").each(function(){
	  if($(this).hasClass("${paging.currentPageNo}")){
		  $(this).addClass("on");
	  }else{
		  $(this).removeClass("on");
	  }
   });
   
</script>
</body>
</html>
