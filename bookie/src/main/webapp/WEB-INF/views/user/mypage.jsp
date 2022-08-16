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
	<section>
		<div class="container">
			<div class="title-wrap">
				<h3 class="title">MY PAGE</h3>
			</div>
			<div class="content-wrapper">
				<div class="content">
					<label><h4>${userId }</h4></label>
				</div>

				<div class="content list">
					<ul class="info-list">
						<li><img src="<c:url value="/resources/img/update.png"/>"><a
							href="/" class="mypage_list">정보 수정하기</a></li>
						<li><img src="<c:url value="/resources/img/history.png"/>"><a
							href="/" class="mypage_list">푼 문제 확인</a></li>
						<li><img src="<c:url value="/resources/img/que.png"/>"><a
							href="/" class="mypage_list">질문 목록</a></li>
						<li><img src="<c:url value="/resources/img/answer.png"/>"><a
							href="/" class="mypage_list">답변 목록</a></li>
					</ul>
				</div>
			</div>
		</div>
		<footer id="footer">
			<%@ include file="../incl/footer.jsp"%>
		</footer>
	</section>
</body>
</html>