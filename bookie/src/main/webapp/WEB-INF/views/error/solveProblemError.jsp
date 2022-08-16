<%@ page import="org.springframework.ui.Model" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bookie</title>
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/home/home.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/question/question_solve.css"/>" />
</head>
<body>
<div class="wrap sub">
	<header>
		<%@ include file="../incl/header.jsp"%>
	</header>
	<div class="container counts solve">
		<div class="category-wrap">
			<span class="errorMsg">${str}</span>
		</div>
	</div>
	<div class="container counts">
		<a href="/bookie/user/login" class="submit-btn search solve">되돌아가기</a>
	</div>
</div>
<footer id="footer">
	<%@ include file="../incl/footer.jsp"%>
</footer>
</body>
</html>