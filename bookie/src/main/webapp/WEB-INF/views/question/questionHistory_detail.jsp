<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<title>bookie</title>
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/home/home.css"/>" />
<meta name='viewport' content='width=device-width, initial-scale=1'>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- jQuery UI CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<!-- jQuery UI CSS CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />
<!-- codemirror CDN URL -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css" />
<!-- TOAST UI Editor CDN URL(CSS) -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<!-- TOAST UI Editor CDN URL(JS) -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/2.0.0/toastui-editor.min.css">
<script src="https://uicdn.toast.com/editor/2.0.0/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/question/question_history.css"/>" />
</head>
<style>
span{
	color: blue;
}
.back{
	width: 95%;
	margin: 0 auto;
	margin-bottom: 5px;
	padding-top: 120px;
	display: flex;
  	justify-content: space-between;
}
</style>
<body>
	<header>
		<%@ include file="../incl/header.jsp"%>
	</header>
	<div id="container">
		<div class="back">
			<a href="<c:url value='/question/questionHistory_list/${page}'/>"> < 목록으로</a>
			<a class="question" href="<c:url value='/qna_write/1'/>"><span>질문</span>이 있으신가요?</a>
		</div>
		<div class="viewer_q_wrap">
			<c:if test="${not empty m}">
				<div id="viewer_mText">
					${m.getMText()}
				</div>
			</c:if>
			<div id="viewer_qText">
				${q.getQText()}
			</div>
			<div id="viewer_qComment">
				<p>정답
				<span>
				<c:choose>
					<c:when test="${q.getAnswer() eq '1'}">①</c:when>
					<c:when test="${q.getAnswer() eq '2'}">②</c:when>
					<c:when test="${q.getAnswer() eq '3'}">③</c:when>
					<c:when test="${q.getAnswer() eq '4'}">④</c:when>
					<c:when test="${q.getAnswer() eq '5'}">⑤</c:when>					
				</c:choose>
				</span>
				</p>
				${q.getQComment()}
			</div>
		</div>
	</div>
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
<script>
</script>
</body>
</html>