<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bookie</title>
<link rel="stylesheet"
	href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/resources/css//user/qnaList.css"/>" />
</head>
<body>
	<header>
		<%@ include file="../incl/header.jsp"%>
	</header>
	<div class="wrap mh">
		<div class="title-wrap">
			<h3 class="title">나의 질문 리스트</h3>
		</div>
		<div class="rezInfo">
			<table class="highlight">
				<thead>
					<tr>
						<th>질문 제목</th>
						<th>질문 내용</th>
					</tr>
				</thead>
				<c:forEach var="qnaList" items="${qnaList}">
					<tbody>
						<tr>
							<td>${qnaList.subject}</td>
							<td>${qnaList.document}</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</div>
	</div>
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
</body>
</html>