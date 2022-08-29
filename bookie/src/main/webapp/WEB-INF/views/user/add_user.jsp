<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<title>Bookie</title>
<link rel="stylesheet"
	href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/user/add_user.css"/>" />
</head>
<body>
	<header>
		<%@ include file="../incl/no_login_header.jsp"%>
	</header>
	<div class="wrap mh">
		<div class="container">
			<div class="title-wrap">
				<h3 class="title">회원가입</h3>
			</div>
			<div id="content-wrapper">
				<div class="content">
					<form:form method="post" modelAttribute="user">
						<label>e-mail</label>
						<form:input path="email1" />@
						<form:select path="email2">
							<option value="unknown">---선택---</option>
							<form:options itemValue="emailHost" itemLabel="emailCode"
								items="${emailProviderList }" />
						</form:select>
						<br>
						<label>비밀번호</label>
						<form:password path="passwd" />
						<br>
						<label>이름</label>
						<form:input path="name" />
						<br>
						<label>중/고등학생</label>
						<form:select path="uType">
							<option value="unknown">---선택---</option>
							<option value="m">중학생</option>
							<option value="h">고등학생</option>
							<option value="e">기타</option>
						</form:select>
						<br>
						<label>연락처</label>
						<form:select path="phone1">
							<option value="unknown">---선택---</option>
							<form:options items="${PhoneProviderList }" />
						</form:select> -
						<form:input path="phone2" /> - <form:input path="phone3" />
						<br>
						<label>주소</label>
						<form:input path="addr" />
						<br>
						<input class="btn" type="submit" value="가입하기" />
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>