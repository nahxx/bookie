<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<title>bookie</title>
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/user/user_update.css"/>" />
</head>
<body>
	<header>
		<%@ include file="../incl/header.jsp"%>
	</header>
	<section>
		<div class="container">
			<div class="title-wrap">
				<h3 class="title">회원정보 수정</h3>
			</div>
			
			<div id="content-wrapper">
				<div class="content">
					<form:form method="post" modelAttribute="user">
					<input type=hidden name=uId value="${user.getUId()}" />
						<label>e-mail</label>
						<tr>
						<td><input type=text name=userId value="${user.getUserId()}" readonly/></td>
						</tr>
						<label>비밀번호</label>
						<tr>
						<input type=hidden name=old_passwd value= "${user.getPasswd()}"/></td>
						<td><input type=text name=new_passwd value= ""/></td>
						</tr>
						<label>이름</label>
						<tr>
						<td><input type=text name=name value= "${user.getName()}"/></td>
						</tr>
						<label>중/고등학생</label>
						<form:select path="uType">
						<c:choose>
							<c:when test="${fn:contains(user.getUType(), 'm')}">
								<option value="unknown">---선택---</option>
								<option value="m" selected>중학생</option>
								<option value="h">고등학생</option>
								<option value="e">기타</option>
							</c:when>
							<c:when test="${fn:contains(user.getUType(), 'h')}">
								<option value="unknown">---선택---</option>
								<option value="m">중학생</option>
								<option value="h" selected>고등학생</option>
								<option value="e">기타</option>
							</c:when>
							<c:when test="${fn:contains(user.getUType(), 'e')}">
								<option value="unknown">---선택---</option>
								<option value="m">중학생</option>
								<option value="h">고등학생</option>
								<option value="e" selected>기타</option>
							</c:when>	
						</c:choose>
						</form:select>
						<br>
						<label>연락처</label>
						<tr>
						<td><input type=text name=phone value= "${user.getPhone()}"/></td>
						</tr>
						<br>
						<label>주소</label>
						<tr>
						<td><input type=text name=addr value= "${user.getAddr()}"/></td>
						</tr>
						<input class="btn" type="submit" value="수정하기" />
					</form:form>
				</div>
			</div>
		</div>
	</section>
</body>
</html>