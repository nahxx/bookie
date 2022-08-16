<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/qna/table.css"/>" />
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
    		<td>
    		 카테고리부분
    		</td>
    		<td>${qna.subject}</td>
    		<td>${qna.user.userId}</td>
    		<td>${qna.regDate}</td>
    		<c:set var="boardNo" value="${boardNo - 1}" />
  		</tr>
	</c:forEach>

</tbody>
</table>
</div>
<div class="paging">
 <ul>
 <li><a href="<c:url value='/qna_board/${paging.currentPageNo - 1}'/>">◀</a></li>
<c:forEach var="i" begin="${ paging.startPageNo }" end="${ paging.endPageNo }">
	<li><a href="<c:url value="/qna_board/${i}"/>">${i}</a></li>
</c:forEach>
<li><a href="<c:url value='/qna_board/${paging.currentPageNo + 1}'/>">▶</a></li>
        </ul>
</div>
<!--
<div class="pager">
    <ul>
        <c:if test="${ curPageNum > 5 && !empty kwd }">
            <li><a href="/mysite/board?page=${ blockStartNum - 1 }&kwd=${ kwd }">◀</a></li>
        </c:if>

        <c:if test="${ curPageNum > 5 }">
            <li><a href="/mysite/board?page=${ blockStartNum - 1 }">◀</a></li>
        </c:if>

        <c:forEach var="i" begin="${ blockStartNum }" end="${ blockLastNum }">
            <c:choose>
                <c:when test="${ i > lastPageNum }">
                    <li>${ i }</li>
                </c:when>
                <c:when test="${ i == curPageNum }">
                    <li class="selected">${ i }</li>
                </c:when>
                <c:when test="${ !empty kwd}">
                    <li><a href="/mysite/board?a=search&page=${ i }&kwd=${ kwd }">${ i }</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="/mysite/board?page=${ i }">${ i }</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${ lastPageNum > blockLastNum && !empty kwd }">
            <li><a href="/mysite/board?a=search&page=${ blockLastNum + 1 }&kwd=${ kwd }">▶</a></li>
        </c:if>

        <c:if test="${ lastPageNum > blockLastNum }">
            <li><a href="/mysite/board?page=${ blockLastNum + 1 }">▶</a></li>
        </c:if>
    </ul>
</div>
 -->

</body>
</html>
