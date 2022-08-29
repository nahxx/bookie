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
				<c:choose>
					<c:when test="${list.getMainText().getMtId() ne 0}">
						<c:choose>
							<c:when test='${list.getMainText().getMtId() ne checkNo}'>
								<p class="qline"></p>
								<div id="viewer_mText" class="comment">
								${list.getMainText().getMText()}
								</div>
								<div id="viewer_qText" class="question">
								<span class="questionNo"> ${questionNo} </span>
								${list.getQText()}
								</div>
								<c:set var="checkNo" value="${list.getMainText().getMtId()}" />
							</c:when>
							<c:otherwise>
								<div id="viewer_qText" class="question">
								<span class="questionNo"> ${questionNo} </span>
								${list.getQText()}
								</div>
							</c:otherwise>
						</c:choose>
						<c:set var="questionNo" value="${questionNo + 1}" />
					</c:when>
					<c:otherwise>
						<div id="viewer_qText" class="question">
						<span class="questionNo"> ${questionNo} </span>
						${list.getQText()}
						</div>
						<c:set var="questionNo" value="${questionNo + 1}" />
					</c:otherwise>
				</c:choose>
				</c:forEach>
			</div>

		</div>
		<div class="side-wrap">
			<div class="side-title">
				<span class="title-txt">답&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;란</span>
			</div>
			<div class="answerForm">
				<c:set var="answerNo" value='1' />
				<c:forEach var="list" items="${mainList}">
					<div class="question-answer-form">
						<div class="answerConfirm" id=${answerNo}></div>
						<span class="question-number">${answerNo}</span>
						 <input type="radio" value="1" name="${list.getQId()}" class="sub" checked><label class="answerLa">1</label>
						 <input type="radio" value="2" name="${list.getQId()}" class="sub" ><label class="answerLa">2</label>
						 <input type="radio" value="3" name="${list.getQId()}" class="sub" ><label class="answerLa">3</label>
						 <input type="radio" value="4" name="${list.getQId()}" class="sub" ><label class="answerLa">4</label>
						 <input type="radio" value="5" name="${list.getQId()}" class="sub" ><label class="answerLa">5</label>
					</div>
						<c:set var="answerNo" value='${answerNo + 1}' />
				</c:forEach>
				<c:choose>
					<c:when test='${empty answerConfirmList}'>
						 <div id="time-check"></div>
						 <div class="write-btn">
					          <a href="javascript:void(0);" onclick="javascript:sendPost('<c:url value='/test/examSolve'/>');" class="in-btn">제출</a>
					          <a href="<c:url value='/test/createExam'/>" class="in-btn">취소</a>
					      </div>
					</c:when>
					<c:otherwise>
						<div id="time-check">${timer}</div>
						 <div class="write-btn">
					          <a href="<c:url value='/test/examComment'/>" class="in-btn">해설보기</a>
					          <a href="<c:url value='/test/createExam'/>" class="in-btn">끝내기</a>
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

	  // 이미지 너비 체크
	  $('img').each(function() {
		 if($(this).width() > 900) {
			 $(this).css("width", "70%");
		 }
	  });

	  // 타이머
	  let onOffCheck = '';
	  let count = 0; // 초단위 카운트 담는 변수
	  let m = 0; // 분단위 카운트 담는 변수
	  let t = null; // setTimeout을 담는 변수
	  onOffCheck = "${timer}"
	  function timeCount() { //setTimeout 실행 함수
		  // 1초마다 한번씩 count 증가시키는 함수
		  if (m > 0) {
		    document.getElementById('time-check').innerHTML = m+" 분 " + count+" 초 ";
		  } else {
		    document.getElementById('time-check').innerHTML = m+" 분 " + count+" 초 ";
		  }
		  count += 1;
		  if (count == 60) {
		    m += 1;
		    count = 0;
		  }
		  t = setTimeout(timeCount, 1000);
	  }

	  if(onOffCheck == ''){
		  window.onload = function() {
			  timeCount();
		  };
	  }else{
		  clearTimeout(t);
	  }

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

      var hf_2 = document.createElement('input');
      hf_2.setAttribute('type', 'hidden');
      hf_2.setAttribute('name', "timer");
      hf_2.setAttribute('value', m+"분" + count+"초");
      form.appendChild(hf_2);

      document.body.appendChild(form);
      form.submit();
    };

    /*
    	정답제출 후 돌아온 페이지에서 정답을 다시 체크 해준다.
    */
	let returnAnswer = '';
	returnAnswer = "${answer}";
    let answerForm = document.querySelectorAll('.question-answer-form');
    returnAnswer = returnAnswer.split(",");
    for(var i=0; i<returnAnswer.length; i++){
    	returnAnswer[i] = returnAnswer[i].substr(1,1);
    }

    for (var i = 0; i < answerForm.length; i++) {
    	let childForm = answerForm[i].childNodes;
    	for (var j = 0; j < childForm.length; j++) {
			if(returnAnswer != '' && childForm[j].nodeName =="INPUT"){
				let inputFrom = childForm[j];
				if(returnAnswer[i] == inputFrom.value){
					inputFrom.checked = true;
				}
			}
    	}
      };

      var ranswer = [];
  	<c:forEach var="list" items="${answerConfirmList}">
  		ranswer.push(${list});
	</c:forEach>

	 for(var i=0; i<${fn:length(answerConfirmList)}; i++) {
	    document.getElementById((i+1)).classList.add(ranswer[i]);
	 }

  </script>
</body>
</html>
