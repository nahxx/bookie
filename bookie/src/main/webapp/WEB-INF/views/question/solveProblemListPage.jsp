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
	<div class="container counts select-wrap">
		<div class="select-questionNum">
			<form method="get" action="/bookie/question/solveProblem/" class="listForm">
				<input type="number" placeholder="문항 수 입력" class="selec length" maxlength="2" name="numOfquestions" max="30" min="3"/>
				<input type="submit" value="문제풀기" class="submit-btn search solve"/>
				<span class="red-txt">* 문제는 3문제 이상 30문제 이하로 풀기 가능합니다.</span>
			</form>
		</div>
	</div>
</div>

<footer id="footer">
	<%@ include file="../incl/footer.jsp"%>
</footer>
<script>
	let wrap = document.getElementsByClassName("select-wrap")[0];


	let nowLocation = decodeURI(document.location.href);
	nowLocation = nowLocation.split("/");

	if(nowLocation.length >= 7) {
		wrap.style.display = 'block';
	}

	let input1 = document.createElement('input');
	input1.setAttribute('type', 'hidden');
	input1.setAttribute('name', 'cLevel');
	input1.setAttribute('value', '${realCategory.getCLevel()}');
	document.getElementsByClassName("listForm")[0].appendChild(input1);
	let input2 = document.createElement('input');
	input2.setAttribute('type', 'hidden');
	input2.setAttribute('name', 'grade');
	input2.setAttribute('value', '${realCategory.getGrade()}');
	document.getElementsByClassName("listForm")[0].appendChild(input2);
	let input3 = document.createElement('input');
	input3.setAttribute('type', 'hidden');
	input3.setAttribute('name', 'subject');
	input3.setAttribute('value', '${realCategory.getSubject()}');
	document.getElementsByClassName("listForm")[0].appendChild(input3);
	
	
</script>
</body>
</html>