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
				<li class="menu-item on">
					<a href="<c:url value="admin_user/1" />">회원 관리</a>
				</li>
				<li class="menu-item">
					<a href="<c:url value="admin_question" />">문제 관리</a>
				</li>
			</ul>
		</div>
		<div class="main-box">
			<h3>회원관리</h3>
			<!-- 회원관리 메인 화면 -->
			<table class="user-table">
				<c:set var="boardNo" value="${1}" />
				<tr>
					<th>No.</th>
					<th>회원번호</th>
					<th>회원아이디</th>
					<th>회원명</th>
					<th>학년</th>
					<th>회원타입</th>
					<th>가입일자</th>
				</tr>
				<c:forEach var="user" items="${userList}">
					<tr>
						<td>${boardNo}</td>
						<td>${user.getUId()}</td>
						<td>${user.userId}</td>
						<td>${user.name}</td>
						<td>
							<c:if test="${fn:contains(user.getUType(), 'e')}">
								기타
							</c:if>
							<c:if test="${fn:contains(user.getUType(), 'h')}">
								고등학생
							</c:if>
							<c:if test="${fn:contains(user.getUType(), 'm')}">
								중학생
							</c:if>
						</td>
						<td>
							<c:if test="${fn:contains(user.getManager(), 'Y')}">
								관리자
							</c:if>
							<c:if test="${fn:contains(user.getManager(), 'N')}">
								일반회원
							</c:if>
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
			              <li><a href="<c:url value='/admin_user/${paging.currentPageNo - 1}'/>">◀</a></li>
			            </c:otherwise>
			          </c:choose>
			          <c:forEach var="i" begin="${ paging.startPageNo }" end="${ paging.endPageNo }">
			            <li><a class="pageNo ${i}" href="<c:url value="/admin_user/${i}" />">${i}</a></li>
			          </c:forEach>
			          <c:choose>
			            <c:when test="${ paging.currentPageNo == paging.finalPageNo }">
			              <li><a style="color:#808080; disabled">▶</a></li>
			            </c:when>
			            <c:otherwise>
			              <li><a href="<c:url value='/admin_user/${paging.currentPageNo + 1}'/>">▶</a></li>
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