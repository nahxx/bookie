<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <%@ page import="com.teamecho.bookie.user.domain.User"%> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>bookie</title>
<link rel="stylesheet"
	href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/user/mypage.css"/>" />
</head>
<header>
	<%@ include file="../incl/header.jsp"%>
</header>
<body>
	<div class="wrap mh">
		<div class="container">
			<div class="title-wrap">
				<h3 class="title">MY PAGE</h3>
			</div>
			<div class="content-wrapper">
				<div class="content">
					<label><h4>${name }</h4></label>
				</div>
				<div class="content">
					<label><h4>${userId }</h4></label>
				</div>

				<div class="content list">
					<ul class="info-list">
						<li><a href="/bookie/user/user_update" class="mypage_list"><img
								src="<c:url value="/resources/img/update.png"/>">정보 수정하기</a></li>
						<li><a href="/bookie/question/questionHistory_list/1"
							class="mypage_list"><img
								src="<c:url value="/resources/img/history.png"/>">푼 문제 확인</a></li>
						<li><a href="/bookie/user/answerList/1" class="mypage_list"><img
								src="<c:url value="/resources/img/que.png"/>">답변 목록</a></li>
						<li><a href="/bookie/user/qnaList/1" class="mypage_list">
								<img src="<c:url value="/resources/img/answer.png"/>">질문
								목록
						</a></li>
					</ul>
				</div>
				<c:if test="${adminPage eq 'adminPage'}">
					<div class="admin">
						<a href="<c:url value="/admin/admin_service" />">관리자 페이지</a>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
</body>
</html>