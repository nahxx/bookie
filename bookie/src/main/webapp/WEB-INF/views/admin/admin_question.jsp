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
<link rel="stylesheet" href="<c:url value="/resources/css/admin/admin.css"/>" />
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
				<a href="<c:url value="admin_service" />">관리자 전용</a>
			</div>
			<ul class="menu-box">
				<li class="menu-item">
					<a href="<c:url value="admin_user/1" />">회원 관리</a>
				</li>
				<li class="menu-item on">
					<a href="<c:url value="admin_question" />">문제 관리</a>
				</li>
			</ul>
		</div>
		
		<!-- 문제 관리 메인 화면 -->
		<div class="main-box">
			<h3>문제관리</h3>
			<!-- 문제 관리 메인 화면 -->
			<table class="user-table">
				<c:set var="boardNo" value="${1}" />
				<tr>
					<th>No.</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>등록일자</th>
				</tr>
				<c:forEach var="question" items="${questionList}">
					<tr>
						<td>${boardNo}</td>
						<td>
							<c:choose>
								<c:when test="${fn:contains(question.category.cLevel(), 'm')}">
									중등/
								</c:when>
								<c:when test="${fn:contains(question.category.cLevel(), 'm')}">
									고등/
								</c:when>
							</c:choose>
							${question.category.grade}/${question.category.subject}
						</td>
						<td>
							${spTitleList}
						</td>
						<td>
							<fmt:formatDate value="${user.regDate}"  pattern="yyyy-MM-dd HH:mm:ss" />
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
			              <li><a href="<c:url value='/admin_question/${paging.currentPageNo - 1}'/>">◀</a></li>
			            </c:otherwise>
			          </c:choose>
			          <c:forEach var="i" begin="${ paging.startPageNo }" end="${ paging.endPageNo }">
			            <li><a class="pageNo ${i}" href="<c:url value="/admin_question/${i}" />">${i}</a></li>
			          </c:forEach>
			          <c:choose>
			            <c:when test="${ paging.currentPageNo == paging.finalPageNo }">
			              <li><a style="color:#808080; disabled">▶</a></li>
			            </c:when>
			            <c:otherwise>
			              <li><a href="<c:url value='/admin_question/${paging.currentPageNo + 1}'/>">▶</a></li>
			            </c:otherwise>
			          </c:choose>
			        </ul>
		        </div>
		     </div>
	     </div>
	</div>
	
	<!-- 푸터 부분 -->
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
</body>
</html>