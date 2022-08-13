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
      <div class="question-title-wrap">
        <div class="question-title">
          <h3 class="question-title-txt">다음 표의 내용과 일치하지 않는 것은?</h3>
        </div>
      </div>
      <div class="question-box-wrap">
        <div class="qeustion-box">
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
          <input type="submit" value="제출" class="submit-btn"/>
        </form>
        <div class="question-answer">

        </div>
      </div>
    </div>
  </section>

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
const Editor = toastui.Editor;
const viewer = Editor.factory({
    el: document.querySelector('#viewer'),
    viewer: true,
    height: '500px',
    initialValue: '<img alt="" src="<c:url value="/resources/temp/27562658-a113-4916-b416-ed59715f5123_image.png"/>" class="qeustion_img" />'
});
</script>
</body>
</html>
