<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
       <c:forEach var="list" items="${qList}">
       	 <c:if test="${not empty list.getMainText()}">
			<div id="viewer_mText">
				${list.getMainText()}
			</div>
		</c:if>
			<div id="viewer_qText">
				${list.getQText()}
			<p class="qline"></p>
			</div>
		</c:forEach>
      </div>

    </div>
    <div class="side-wrap">
    <c:forEach var="i" begin="1" end="${fn:length(qList)}">
      <div class="question-answer-form">
          <label class="answerLa"><input type="radio" value="1" name="answer" class="sub" checked/>1</label>
          <label class="answerLa"><input type="radio" value="2" name="answer" class="sub" />2</label>
          <label class="answerLa"><input type="radio" value="3" name="answer" class="sub" />3</label>
          <label class="answerLa"><input type="radio" value="4" name="answer" class="sub" />4</label>
          <label class="answerLa"><input type="radio" value="5" name="answer" class="sub" />5</label>
        </div>
    </c:forEach>
    </div>
  </div>
  <footer id="footer">
  	<%@ include file="../incl/footer.jsp"%>
  </footer>
</body>
</html>
