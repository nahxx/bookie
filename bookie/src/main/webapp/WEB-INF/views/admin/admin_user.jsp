<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
				<li class="menu-item on">
					<a href="<c:url value="admin_user/1" />">회원 관리</a>
				</li>
				<li class="menu-item">
					<a href="<c:url value="admin_question" />">문제 관리</a>
				</li>
			</ul>
		</div>
		
		<!-- 회원관리 메인 화면 -->
		
	</div>
	
	<!-- 푸터 부분 -->
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
</body>
</html>