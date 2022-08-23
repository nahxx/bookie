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
    <div class="end-btn-wrap"><input type="button" class="end-btn"/><span class="cross-r"></span><span class="cross-l"></span></div>
    <div class="subpage-question">
      <div class="title-wrap">
        <h1 class="title">문제풀기</h1>
      </div>
      <div class="question-box-wrap">
        <div class="qeustion-box">
            <div class="subjectPattern">문제유형 : <span>${subjectPattern.bigPattern}</span> > <span class="sp-txt">${subjectPattern.midPattern}</span></div>
            <div id="viewer"></div>
        </div>
        <span class="answerChecking"></span>
      </div>
      <div class="question-answer-wrap">
        <div class="question-answer-form">
          <label class="answerLa">
						<input type="radio" value="1" name="answer" class="sub" checked/>
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
          <input type="button" value="제출" class="submit-btn subBtn"/>
        </div>
        <div class="question-answer">
            <span class="qcomment">해설</span>
            <div id="viewer_answer"></div>
            <div class="btn-wrap">
                <a href="javascript:void(0);" onclick="javascript:sendPost('<c:url value='/question/solveProblem'/>');" class="submit-btn search nextBtn">다음문제</a>
            </div>
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
    <c:if test="${againProblem eq 'on'}">
	    <div class="pop">
	      <div class="popbox">
	        <p class="pop-txt">문제 더 푸시겠습니까?</p>
            <div class="select-wrap">
               <a class="submit-btn search btn2" href="javascript:void(0);" onclick="javascript:sendGet('<c:url value='/question/solveProblem'/>');">예</a>
               <a href="/bookie/question/solveProblemList" class="submit-btn search btn2">되돌아가기</a>
            </div>
          </div>
        </div>
    </c:if>
    <div class="pop end-pop">
        <div class="popbox">
            <p class="pop-txt">끝내시겠습니까?</p>
            <div class="select-wrap">
                <a href="javascript:void(0);" onclick="javascript:sendBack('<c:url value='/question/solveProblemList'/>');" class="submit-btn search btn2">예</a>
                <input type="button" class="submit-btn search btn2 cancellBtn" value="아니요"/>
            </div>
        </div>
    </div>
  </section>

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
const Editor = toastui.Editor;
let content = '${question.mainText.MText}${question.QText}';
<%--let content2 = '${mainText.MText}<c:forEach var="question" items="${questionList}">${question.QText}</c:forEach>';--%>
const viewer = Editor.factory({
    el: document.querySelector('#viewer'),
    viewer: true,
    height: '500px',
    <%--initialValue: '<img alt="" src="<c:url value="/resources/temp/27562658-a113-4916-b416-ed59715f5123_image.png"/>" class="qeustion_img" />'--%>
    initialValue: content
});
const viewer2 = Editor.factory({
    el: document.querySelector('#viewer_answer'),
    viewer: true,
    height: '500px',
    <%--initialValue: '<img alt="" src="<c:url value="/resources/temp/27562658-a113-4916-b416-ed59715f5123_image.png"/>" class="qeustion_img" />'--%>
    initialValue: '${question.QComment}'
});

let submitBtn = document.getElementsByClassName("subBtn")[0];
let comment = document.getElementsByClassName("question-answer")[0];
let checkedBtn = document.getElementsByClassName("sub");
let checkButton = null;
let answerLa = document.getElementsByClassName("answerLa");

submitBtn.addEventListener('click', function(){

    comment.style.display = 'block';
    Array.prototype.forEach.call(checkedBtn, (item, i) => {
        if(item.checked == true) {
            checkButton = item;
            if(checkButton.value == '${question.answer}'){
                let check = document.getElementsByClassName("answerChecking")[0];
                check.style.display = 'block';
            } else {
                let check = document.getElementsByClassName("answerChecking")[0];
                check.classList.add('false');
            }
        }
    });

    this.setAttribute('disabled', 'true');
});

function sendPost(url) {

    //1. 폼생성
    var form = document.createElement('form');
    form.setAttribute('method', 'post');
    form.setAttribute('action', url);
    document.charset = "UTF-8";

    // 문제 qId 넘겨주기
    let qeustion = document.createElement('input');
    qeustion.setAttribute('type', 'hidden');
    qeustion.setAttribute('name', 'question');
    qeustion.setAttribute('value', '${question.QId}');
    form.appendChild(qeustion);

    // 카테고리 넘겨주기
    let input1 = document.createElement('input');
    input1.setAttribute('type', 'hidden');
    input1.setAttribute('name', 'cLevel');
    input1.setAttribute('value', '${realCategory.getCLevel()}');
    form.appendChild(input1);
    let input2 = document.createElement('input');
    input2.setAttribute('type', 'hidden');
    input2.setAttribute('name', 'grade');
    input2.setAttribute('value', '${realCategory.getGrade()}');
    form.appendChild(input2);
    let input3 = document.createElement('input');
    input3.setAttribute('type', 'hidden');
    input3.setAttribute('name', 'subject');
    input3.setAttribute('value', '${realCategory.getSubject()}');
    form.appendChild(input3);

    // 문제 답 던져주기
    form.appendChild(checkButton);

    document.body.appendChild(form);
    form.submit();
};

function sendGet(url) {

    //1. 폼생성
    var form = document.createElement('form');
    form.setAttribute('method', 'get');
    form.setAttribute('action', url);
    document.charset = "UTF-8";

    // 카테고리 넘겨주기
    let input1 = document.createElement('input');
    input1.setAttribute('type', 'hidden');
    input1.setAttribute('name', 'cLevel');
    input1.setAttribute('value', '${realCategory.getCLevel()}');
    form.appendChild(input1);
    let input2 = document.createElement('input');
    input2.setAttribute('type', 'hidden');
    input2.setAttribute('name', 'grade');
    input2.setAttribute('value', '${realCategory.getGrade()}');
    form.appendChild(input2);
    let input3 = document.createElement('input');
    input3.setAttribute('type', 'hidden');
    input3.setAttribute('name', 'subject');
    input3.setAttribute('value', '${realCategory.getSubject()}');
    form.appendChild(input3);

    let requestion = document.createElement('input');
    requestion.setAttribute('type', 'hidden');
    requestion.setAttribute('name', 'requestionState');
    requestion.setAttribute('value', 'Y');
    form.appendChild(requestion);

    document.body.appendChild(form);
    form.submit();
};
function sendBack(url) {
    console.log(comment.style.display);
    // if()
    //1. 폼생성
    var form = document.createElement('form');
    form.setAttribute('method', 'post');
    form.setAttribute('action', url);
    document.charset = "UTF-8";

    // 문제 qId 넘겨주기
    let qeustion = document.createElement('input');
    qeustion.setAttribute('type', 'hidden');
    qeustion.setAttribute('name', 'question');
    qeustion.setAttribute('value', '${question.QId}');
    form.appendChild(qeustion);

    let requestion = document.createElement('input');
    requestion.setAttribute('type', 'hidden');
    requestion.setAttribute('name', 'requestionState');
    requestion.setAttribute('value', 'Y');
    form.appendChild(requestion);

    document.body.appendChild(form);
    form.submit();
};

// 끝내는 버튼 눌렀을 때
let endBtn = document.getElementsByClassName("end-btn")[0];
let endPop = document.getElementsByClassName("end-pop")[0];

endBtn.addEventListener('click', function(){
    endPop.style.display = 'flex';
});

let cencellBtn = document.getElementsByClassName("cancellBtn")[0];

cencellBtn.addEventListener('click', function(){
   endPop.style.display = 'none';
});
</script>
</body>
</html>
