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
				<c:set var="questionNo" value='1' />
				<c:forEach var="list" items="${mainList}">
					<c:if test="${list.getMainText().getMtId() ne 0}">
						<c:choose>
							<c:when test='${list.getMainText().getMtId() ne checkNo}'>
								<p class="qline"></p>
								<div id="viewer_mText" class="comment">
								${list.getMainText().getMText()}
								</div>
								<div id="viewer_qText" class="question">
								<span class="questionNo"> ${questionNo}. </span>
								${list.getQText()}
								</div>
								<c:set var="checkNo" value="${list.getMainText().getMtId()}" />
							</c:when>
							<c:otherwise>
								<div id="viewer_qText" class="question">
								<span class="questionNo"> ${questionNo}. </span>
								${list.getQText()}
								</div>
							</c:otherwise>
						</c:choose>
						<c:set var="questionNo" value="${questionNo + 1}" />
					</c:if>

				</c:forEach>
			</div>

		</div>
		<div class="side-wrap">
			<div class="side-title">
				<sapn class="title-txt">답&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;란</sapn>
			</div>
			<div class="answerForm">
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
				<c:choose>
					<c:when test='${empty answerConfirmList}'>
						 <div class="write-btn">
					          <a href="javascript:void(0);" onclick="javascript:sendPost('<c:url value='/test/examSolve'/>');" class="in-btn">제출</a>
					          <a href="<c:url value='경로작성하기'/>" class="in-btn">취소</a>
					      </div>
					</c:when>
					<c:otherwise>
						 <div class="write-btn">
					          <a href="<c:url value='/test/examComment'/>" class="in-btn">해설보기</a>
					      </div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
  <script>
	  // 지문의 마지막 문제의 border-bottom 없애기
	  $(function() {
		  $(".question").each(function() {
			  if($(this).next().hasClass("qline")) {
				  $(this).addClass("off");   
			  }
		  });
	  });
  
	 function sendPost(url) {
      //1. 폼생성
      var form = document.createElement('form');
      form.setAttribute('method', 'post');
      form.setAttribute('action', url);
      document.charset = "UTF-8";

      let answer = [];
      <c:forEach var="list" items="${mainList}">
      	answer.push(document.querySelector('input[name="${list.getQId()}"]:checked').value);
      </c:forEach>

      var hf_1 = document.createElement('input');
      hf_1.setAttribute('type', 'hidden');
      hf_1.setAttribute('name', "answer");
      hf_1.setAttribute('value', answer);
      form.appendChild(hf_1);

      document.body.appendChild(form);
      form.submit();
    };
  </script>
</body>
</html>
