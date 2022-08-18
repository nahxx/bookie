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
			<input type="number" placeholder="문항 수 입력" class="selec length" maxlength="2" name="numOfquestions" max="30" min="3" id="num"/>
			<a href="javascript:void(0);" onclick="javascript:sendPost('<c:url value='/question/solveProblem'/>');" class="submit-btn search solve">문제풀기</a>
			<span class="red-txt">* 문제는 3문제 이상 30문제 이하로 풀기 가능합니다.</span>
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

	function sendPost(url) {
		//1. 폼생성
		var form = document.createElement('form');
		form.setAttribute('method', 'get');

		document.charset = "UTF-8";

		// 카테고리 넘겨주기
		let input1 = document.createElement('input');
		input1.setAttribute('type', 'hidden');
		input1.setAttribute('name', 'cLevel');
		input1.setAttribute('value', '${realCategory.getCLevel()}');
		form.appendChild(input1);
		let input2 = document.createElement('input');
		input2.setAttribute('type', 'hidden');
		input2.setAttribute('name', 'grade');
		input2.setAttribute('value', '${realCategory.getGrade()}');
		form.appendChild(input2);
		let input3 = document.createElement('input');
		input3.setAttribute('type', 'hidden');
		input3.setAttribute('name', 'subject');
		input3.setAttribute('value', '${realCategory.getSubject()}');
		form.appendChild(input3);

		// 문항 수
		let numOfquestions = document.getElementById("num").value;
		console.log(numOfquestions);


		form.setAttribute('action', url+'/'+numOfquestions);
		document.body.appendChild(form);
		form.submit();
	};
</script>
</body>
</html>