<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.teamecho.bookie.user.*"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<title>bookie</title>
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/user/add_user.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/user/error.css"/>" />
</head>

<body>
	<header>
		<%@ include file="../incl/no_login_header.jsp"%>
	</header>
	<div class="wrap mh">
		<div class="container" style = "margin-top: 90px;">
			<div class="title-wrap">
				<h3 class="title">회원가입</h3>
			</div>
			<div id="content-wrapper">
				<div class="content">
					<form:form method="post" modelAttribute="user">
						<label>e-mail</label>
						<form:input path="email1" />
							@
							<form:select path="email2">
							<option value="unknown">---선택---</option>
							<form:options itemValue="emailHost" itemLabel="emailCode"
								items="${emailProviderList }" />
						</form:select>
						<c:set var="idResult" value="${idResult }" />
						<c:if test="${idResult eq 1 }">
							<p class=error>해당 이메일은 중복된 이메일입니다.</p>
						</c:if>
						<c:set var="id" value="${user.email }" />
						<c:if test="${empty id }">
							<p class=error>이메일은 필수입력 정보입니다.</p>
						</c:if>
						<br>
						<label>비밀번호</label>
						<form:password path="passwd" />
						<c:set var="passwd" value="${passwd }" />
						<c:if test="${empty passwd }">
							<p class=error>비빌번호는 필수입력 정보입니다.</p>
						</c:if>
						<br>
						<label>이름</label>
						<form:input path="name" />
						<c:set var="name" value="${name }" />
						<c:if test="${empty name }">
							<p class=error>이름은 필수입력 정보입니다.</p>
						</c:if>
						<br>
						<label>중/고등학생</label>
						<form:select path="uType">
							<option value="unknown">---선택---</option>
							<option value="m">중학생</option>
							<option value="h">고등학생</option>
							<option value="e">기타</option>
						</form:select>
						<c:set var="uType" value="${uType }" />
						<c:if test="${empty uType }">
							<p class=error>중/고등학생 필수입력 정보입니다.</p>
						</c:if>
						<br>
						<label>연락처</label>
						<form:select path="phone1">
							<option value="unknown">---선택---</option>
							<form:options items="${PhoneProviderList }" />
						</form:select>
							-
							<form:input path="phone2" />
							-
							<form:input path="phone3" />
						<c:set var="phone" value="${phone }" />
						<c:if test="${empty phone }">
							<p class=error>연락처는 필수입력 정보입니다.</p>
						</c:if>
						<br>
						<label>주소</label>
						<form:input path="addr" />
						<c:set var="addr" value="${addr }" />
						<c:if test="${empty addr }">
							<p class=error>연락처는 필수입력 정보입니다.</p>
						</c:if>
						<br>
						<input class="btn" type="submit" value="가입하기" />
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>