<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<c:if test="${session eq 'no'}">
<div class="pop">
      <div class="popbox">
        <p class="pop-txt">관리자 전용 페이지입니다.</p>
        <a href="/bookie/" class="submit-btn search pop-btn">홈으로가기</a>
      </div>
    </div>
</c:if>
<div class="wrap sub">
	<header>
		<%@ include file="../incl/header.jsp"%>
	</header>
	<div class="container counts solve">
		<div class="category-wrap">
		</div>
	</div>
</div>

<footer id="footer">
	<%@ include file="../incl/footer.jsp"%>
</footer>
</body>
</html>