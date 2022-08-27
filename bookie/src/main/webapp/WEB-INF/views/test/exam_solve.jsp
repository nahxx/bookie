<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bookie</title>
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/test/exam_solve.css"/>" />

<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- TOAST UI Editor CDN URL(CSS) -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<!-- TOAST UI Editor CDN URL(JS) -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/2.0.0/toastui-editor.min.css">
<script src="https://uicdn.toast.com/editor/2.0.0/toastui-editor-all.min.js"></script>

</head>
<body>
	<div class="wrap">
		<div class="inner-wrap">
			<div class="exam-wrap">
				<c:set var="checkNo" value='0' />
				<c:forEach var="list" items="${mainList}">
					<c:if test="${list.getMainText().getMtId() ne 0}">
						<c:choose>
							<c:when test='${list.getMainText().getMtId() ne checkNo}'>
								<p class="qline"></p>
								<div id="viewer_mText" class="comment">${list.getMainText().getMText()}</div>
								<div id="viewer_qText" class="question">${list.getQText()}</div>
								<c:set var="checkNo" value="${list.getMainText().getMtId()}" />
							</c:when>
							<c:otherwise>
								<div id="viewer_qText" class="question">${list.getQText()}</div>
							</c:otherwise>
						</c:choose>
					</c:if>

				</c:forEach>
			</div>

		</div>
		<div class="side-wrap">
			<div class="side-title">
				<sapn class="title-txt">답&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;란</sapn>
			</div>
			<form class="answerForm" action="/test/examSolve" method="post">
				<c:set var="answerNo" value='1' />
				<c:forEach var="list" items="${mainList}">
					<div class="question-answer-form">
						<span class="question-number">${answerNo}</span>
						 <label class="answerLa"><input type="radio" value="1" name="${list.getQId()}" class="sub" checked />1</label>
						 <label class="answerLa"><input type="radio" value="2" name="${list.getQId()}" class="sub" />2</label>
						 <label class="answerLa"><input type="radio" value="3" name="${list.getQId()}" class="sub" />3</label>
						 <label class="answerLa"><input type="radio" value="4" name="${list.getQId()}" class="sub" />4</label>
						 <label class="answerLa"><input type="radio" value="5" name="${list.getQId()}" class="sub" />5</label>
					</div>
						<c:set var="answerNo" value='${answerNo + 1}' />
				</c:forEach>
				<div class="write-btn">
					<input type="submit" class="in-btn" value="제출">
					<input type="reset" class="in-btn" value="취소">
				</div>
			</form>
		</div>
	</div>
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
</body>
</html>
