<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/default.css"/>"/>
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/admin/adminInfo.css"/>" />
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
				<li class="menu-item on">
					<a href="<c:url value="admin_user/1" />">회원 관리</a>
				</li>
				<li class="menu-item">
					<a href="<c:url value="/admin/admin_question/1" />">문제 관리</a>
				</li>
			</ul>
		</div>
		<div class="main-box">
			<h3>회원정보</h3>
			<!-- 회원정보 확인 메인 화면 -->
				<form:form method="get" modelAttribute="aui">
				<table class="user-table" >
					<tr>
						<th>회원번호</th>
						<td>${aui.user.getUId()}</td>
						<th>회원아이디</th>
						<td>${aui.user.getUserId()}</td>
					</tr>
					<tr>
						<th>회원명</th>
						<td>${aui.user.getName()}</td>
						<th>학년</th>
						<td>
							<c:if test="${fn:contains(aui.user.getUType(), 'e')}">
								기타
							</c:if>
							<c:if test="${fn:contains(aui.user.getUType(), 'h')}">
								고등학생
							</c:if>
							<c:if test="${fn:contains(aui.user.getUType(), 'm')}">
								중학생
							</c:if>
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${aui.user.getPhone()}</td>
						<th>주소</th>
						<td>${aui.user.getAddr()}</td>
					</tr>
					<tr>
						<th>회원타입</th>
						<td>
							<c:if test="${fn:contains(aui.user.getManager(), 'Y')}">
								관리자
							</c:if>
							<c:if test="${fn:contains(aui.user.getManager(), 'N')}">
								일반회원
							</c:if>
						</td>
						<th>가입 날짜</th>
						<td>${aui.user.getRegDate()}</td>
					</tr>
					<tr>
						<th>푼 문제 개수</th>
						<td>${aui.getCount()}</td>
						<th>정답률</th>
						<td>${aui.getRate()}%</td>
				</table>					
			</form:form>
	     </div>
	</div>
	
	<!-- 푸터 부분 -->
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
</body>
</html>