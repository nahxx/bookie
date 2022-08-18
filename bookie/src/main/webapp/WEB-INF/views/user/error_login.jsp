<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<title>bookie</title>
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/user/login.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/user/error.css"/>" />
</head>
<body>
	<header>
		<%@ include file="../incl/no_login_header.jsp"%>
	</header>
	<div class="wrap mh">
		<div class="container">
			<div class="title-wrap">
				<h3 class="title">로그인</h3>
			</div>
			<div id="content-wrapper">
				<div class="content">
					<form action="login" method="post">
						<c:set var="result" value="${result }" />
						<c:if test="${result eq 2 }">
							<p class="error" style = "text-align: center;">아이디 또는 비밀번호를 잘못 입력했습니다.</p>
						</c:if>
						<input type="text" name="userId" placeholder="이메일" /> <br>
						<input type="password" name="passwd" placeholder="비밀번호" /> <br>
						<input class="btn" type="submit" value="로그인" />
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</body>
</html>