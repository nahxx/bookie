<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bookie</title>
    <!-- Toast UI Editor -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/question/question_solve.css"/>" />
</head>
<body>
<section class="subpage-question-sec">
    <div class="subpage-question">
      <div class="title-wrap">
        <h1 class="title">문제풀기</h1>
      </div>
      <div class="question-box-wrap">
        <div class="qeustion-box">
            <div class="subjectPattern">문제유형 : <span>${subjectPattern.bigPattern}</span> > <span class="sp-txt">${subjectPattern.midPattern}</span></div>
            <div id="viewer"></div>
        </div>
      </div>
      <div class="question-answer-wrap">
        <form action="solveProblem" method="post" class="question-answer-form">
          <label class="answerLa">
						<input type="radio" value="1" name="answer" class="sub" />
						1
					</label>
          <label class="answerLa">
						<input type="radio" value="2" name="answer" class="sub" />
						2
					</label>
          <label class="answerLa">
						<input type="radio" value="3" name="answer" class="sub" />
						3
					</label>
          <label class="answerLa">
						<input type="radio" value="4" name="answer" class="sub" />
						4
					</label>
          <label class="answerLa">
						<input type="radio" value="5" name="answer" class="sub" />
						5
					</label>
          <input type="button" value="제출" class="submit-btn"/>
        </form>
        <div class="question-answer">
            ${question.QComment}
        </div>
      </div>
    </div>
    <c:if test="${session eq 'no'}">
	    <div class="pop">
	      <div class="popbox">
	        <p class="pop-txt">로그인 해주세요 !</p>
	        <a href="/bookie/user/login" class="submit-btn search pop-btn">되돌아가기</a>
	      </div>
	    </div>
    </c:if>
  </section>

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
const Editor = toastui.Editor;
let content = '${mainText.MText}${question.QText}';
<%--let content2 = '${mainText.MText}<c:forEach var="question" items="${questionList}">${question.QText}</c:forEach>';--%>
const viewer = Editor.factory({
    el: document.querySelector('#viewer'),
    viewer: true,
    height: '500px',
    <%--initialValue: '<img alt="" src="<c:url value="/resources/temp/27562658-a113-4916-b416-ed59715f5123_image.png"/>" class="qeustion_img" />'--%>
    initialValue: content
});
let qeustion = document.createElement('input');
qeustion.setAttribute('type', 'hidden');
qeustion.setAttribute('name', 'question');
qeustion.setAttribute('value', '${question.QId}');
document.getElementsByClassName("question-answer-form")[0].appendChild(qeustion);
</script>
</body>
</html>
