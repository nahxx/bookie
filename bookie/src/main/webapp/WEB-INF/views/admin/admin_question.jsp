<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/default.css"/>"/>
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/admin/paging.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/admin/admin.css"/>" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Bookie</title>
</head>
<body>
	<!-- 헤더 부분 -->
	<header>
		<%@ include file="../incl/header.jsp"%>
	</header>
	<div class="second-header">
		${adminUser.name} <span>님 환영합니다.</span>
	</div>
	
	<!-- wrap 부분 -->
	<div id="wrap" class="wrap mh">
		<div class="side-menu">
			<div class="only-admin">
				<a href="<c:url value="/admin/admin_service" />">관리자 전용</a>
			</div>
			<ul class="menu-box">
				<li class="menu-item">
					<a href="<c:url value="/admin/admin_user/1" />">회원 관리</a>
				</li>
				<li class="menu-item on">
					<a href="<c:url value="/admin/admin_question/1" />">문제 관리</a>
				</li>
			</ul>
		</div>
		
		<!-- 문제 관리 메인 화면 -->
		<div class="main-box">
			<h3>문제관리</h3>
			<!-- 문제 관리 메인 화면 -->
			<table class="question-table">
				<c:set var="boardNo" value="${1}" />
				<tr>
					<th>No.</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>등록일자</th>
				</tr>
				<c:forEach var="qaqp" items="${qaqpList}">
					<tr>
						<td>${boardNo}</td>
						<td>
							<c:choose>
								<c:when test="${fn:contains(qaqp.getQuestion().getCategory().getCLevel(), 'm')}">
									중등 / 
								</c:when>
								<c:when test="${fn:contains(qaqp.getQuestion().getCategory().getCLevel(), 'h')}">
									고등 / 
								</c:when>
							</c:choose>
							${qaqp.question.category.grade}학년 / ${qaqp.question.category.subject}
						</td>
						<td>
							${qaqp.spTitle}
						</td>
						<td>
							<fmt:formatDate value="${qaqp.question.regDate}"  pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<c:set var="boardNo" value="${boardNo + 1}" />
					</tr>
				</c:forEach>
			</table>
			
			<!-- 페이징 -->
			<div class="paging">
		        <div class="paging-box">
		        	<ul class="inner-paging-wrap">
			          <c:choose>
			            <c:when test="${ paging.currentPageNo == '1' }">
			              <li><a style="color:#808080; disabled">◀</a></li>
			            </c:when>
			            <c:otherwise>
			              <li><a href="<c:url value='/admin/admin_question/${paging.currentPageNo - 1}'/>">◀</a></li>
			            </c:otherwise>
			          </c:choose>
			          <c:forEach var="i" begin="${ paging.startPageNo }" end="${ paging.endPageNo }">
			            <li><a class="pageNo ${i}" href="<c:url value="/admin/admin_question/${i}" />">${i}</a></li>
			          </c:forEach>
			          <c:choose>
			            <c:when test="${ paging.currentPageNo == paging.finalPageNo }">
			              <li><a style="color:#808080; disabled">▶</a></li>
			            </c:when>
			            <c:otherwise>
			              <li><a href="<c:url value='/admin/admin_question/${paging.currentPageNo + 1}'/>">▶</a></li>
			            </c:otherwise>
			          </c:choose>
			        </ul>
		        </div>
		     </div>
		     
		     <div class="add-question">
				<button type="button" onclick="location.href='<c:url value="/question/add_question" />'">문제 등록</button>
			</div>
	     </div>
	</div>
	
	<!-- 푸터 부분 -->
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
	
	<!-- 스크립트 -->
	<script>
    $(".pageNo").each(function() {
      if ($(this).hasClass("${paging.currentPageNo}")) {
        $(this).addClass("on");
      } else {
        $(this).removeClass("on");
      }
    });
  </script>
</body>
</html>