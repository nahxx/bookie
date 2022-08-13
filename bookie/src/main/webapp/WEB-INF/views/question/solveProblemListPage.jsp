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
<div class="wrap">
	<header>
		<%@ include file="../incl/no_login_header.jsp"%>
	</header>
	<div class="container counts">
		<div class="category-wrap">
			<form:form method="get" modelAttribute="category" action="/bookie/question/solveProblemList/list">
				<form:select path="cLevel" class="selec">
					<form:options itemValue="categoryHost" itemLabel="categoryCode" items="${categoryProviderList }" class="opt"/>
				</form:select>
				<form:select path="grade" class="selec">
					<form:options itemValue="categoryHost" itemLabel="categoryCode" items="${gradeProviderList }" class="opt"/>
				</form:select>
				<form:select path="subject" class="selec">
					<form:options itemValue="categoryHost" itemLabel="categoryCode" items="${subjectProviderList }" class="opt"/>
				</form:select>
				<input type="submit" value="찾기" class="submit-btn search"/>
			</form:form>
		</div>
	</div>
</div>
<footer id="footer">
	<%@ include file="../incl/footer.jsp"%>
</footer>
</body>
</html>