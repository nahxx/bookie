<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/default.css"/>"/>
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/question/add_question.css"/>"/>

<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- jQuery UI CDN -->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<!-- jQuery UI CSS CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>
<!-- codemirror CDN URL -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<!-- TOAST UI Editor CDN URL(CSS) -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<!-- TOAST UI Editor CDN URL(JS) -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<title>Bookie</title>
</head>
<body>
	<!-- 헤더 부분 -->
	<header>
		<%@ include file="../incl/header.jsp"%>
	</header>
	<!-- wrap 부분 -->
	<div id="wrap" class="wrap mh">
		<h3 class="title">문제 등록</h3>
		<!-- 카테고리/문제유형 선택 폼 -->
		<form class="select-type" action="select_type" method="post">
			<table>
				<tr>
					<th class="cate" colspan="2"><label class="cate">카테고리 선택</label></th>
				</tr>
				<tr>
					<th>학력 구분</th>
					<td>
						<label class="c-level"><input type="radio" name="cLevel" value="m" />중학교</label>
						<label class="c-level"><input type="radio" name="cLevel" value="h" />고등학교</label>
					</td>
				</tr>
				<tr>
					<th>학년</th>
					<td>
						<label class="grade"><input type="radio" name="grade" value="1" />1학년</label>
						<label class="grade"><input type="radio" name="grade" value="2" />2학년</label>
						<label class="grade"><input type="radio" name="grade" value="3" />3학년</label>
					</td>
				</tr>
				<tr>
					<th>과목</th>
					<td>
						<label class="subject"><input type="radio" name="subject" value="국어" />국어</label>
						<label class="subject"><input type="radio" name="subject" value="영어" />영어</label>
						<label class="subject"><input type="radio" name="subject" value="수학" />수학</label>
					</td>
				</tr>
			</table>

		</form>
		
		<!-- 문제 등록 폼 -->
		<div class="question-box">
			<div class="q-box">
				<h6>문제입력</h6>
				<div class="editor" id="qTextEditor"></div>
			</div>
			<button class="submit-btn" onclick="javascript:MainTextLine();" >지문 구분</button>
			<button class="submit-btn" onclick="javascript:QuestionLine();" >문제 구분</button>
			
			<button class="submit-btn" onclick="javascript:addAnswer();" >답안 추가</button>
			<div id="answer-wrap">
				<div class="a-box">
					<h6>문제1</h6>
					<div class="answer-box">
						<span>답</span>
						<label class="answer"><input type="radio" name="answer1" value="1" />1</label>
						<label class="answer"><input type="radio" name="answer1" value="2" />2</label>
						<label class="answer"><input type="radio" name="answer1" value="3" />3</label>
						<label class="answer"><input type="radio" name="answer1" value="4" />4</label>
						<label class="answer"><input type="radio" name="answer1" value="5" />5</label>
					</div>
					<h6>해설</h6>
					<textarea class="qComment" cols="50" rows="10"></textarea>
				</div>
			</div>
			
		</div>
		<button class="submit-btn" onclick="javascript:sendCommonQuestion('<c:url value="/question/add_question"/>');" >등록</button>
		
	</div>
	
	<!-- 푸터 부분 -->
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
	
	<script>
		/* 
		해결해야할 것
		1. 유효성 검사
		2. css
		*/
    	let questionImgArr = []; // 질문 이미지 배열
    	// let commentImgArr = []; // 해설 이미지 배열
    	// let mainTextImgArr = []; // 지문 이미지 배열
    	
    	// 질문 에디터
    	const qTextEditor = new toastui.Editor({
    		    el: document.querySelector('#qTextEditor'),
    		    previewStyle: 'tab',
    		    previewHighlight: false,
    		    height: '500px',
    		    // 사전입력 항목
    		    initialValue: "",
    		    // 이미지가 Base64 형식으로 입력되는 것 가로채주는 옵션

    		    hooks: {
    		    	addImageBlobHook: (blob, callback) => {
    		    		// blob : Java Script 파일 객체
    		    		//console.log("진입" +blob);
    		    		
    		    		const formData = new FormData();
    		        	formData.append('image', blob);
    		        	
    		        	let url; //= "http://localhost:8080/bookie/upload/";
    		        	//console.log(url)
    		   			$.ajax({
    		           		type: 'POST',
    		           		enctype: 'multipart/form-data',
    		           		url: '/bookie/testdg',
    		           		data: formData,
    		           		dataType: "json",
    		           		processData: false,
    		           		contentType: false,
    		           		cache: false,
    		           		timeout: 600000,
    		           		success: function(data) {
    		           			//url += "image.png"//data.filename;
    		           			url = Object.values(data)[0] + Object.values(data)[1];
    		           			questionImgArr.push(Object.values(data)[1]); // 등록된 이미지 배열에 넣기
    		           			// callback : 에디터(마크다운 편집기)에 표시할 텍스트, 뷰어에는 imageUrl 주소에 저장된 사진으로 나옴
    		        			// 형식 : ![대체 텍스트](주소)
    		           			callback(url, '문제이미지');
    		           		},
    		           		error: function(e) {
    		           			console.log(e);
    		           			//console.log(e.abort([statusText]));
    		           			callback(url, '사진 대체 텍스트 입력2');
    		           		}
    		           	});
    		    	}
    		    }
    		});
            
            // 폼 생성 후 컨트롤러로 넘어가기
    		function sendCommonQuestion(url) {
    			// 폼 생성
    			console.log(url);
    			let form = document.createElement('form');
    			form.setAttribute('method', 'post');
    			form.setAttribute('action', url);
    			document.charset = "UTF-8";
    			
    			// input1 추가 - cLevel
    			let input1 = document.querySelector('input[name="cLevel"]:checked');
    			//input1.setAttribute('type', 'hidden');
    			form.appendChild(input1);
    			
    			// input2 추가 - grade
    			let input2 = document.querySelector('input[name="grade"]:checked');
    			//input2.setAttribute('type', 'hidden');
    			form.appendChild(input2);
    			
    			// input3 추가 - subject
    			let input3 = document.querySelector('input[name="subject"]:checked');
    			//input3.setAttribute('type', 'hidden');
    			form.appendChild(input3);
    			
    			// input4 추가 - qTextEditor
    			let input4 = document.createElement('input');
    			let qText = qTextEditor.getHTML();
    			
    			input4.setAttribute('type', 'hidden');
    			input4.setAttribute('name', 'qText');
    			input4.setAttribute('value', qText);
    			form.appendChild(input4);
    			
    			// input5 추가 - answer(배열)
    			let aBoxs = document.querySelectorAll('.a-box'); // 답,해설 포함하는 클래스 가져오기
    			let answerList = []; // 답 담을 배열
    			for(let i = 0; i < aBoxs.length; i++) {
    				let answer = document.querySelector('input[name="answer' + (i+1) + '"]:checked');
    				answerList.push(answer.value);
    			}
    			let input5 = document.createElement('input');
    			input5.setAttribute('type', 'hidden');
    			input5.setAttribute('name', 'answerList');
    			input5.setAttribute('value', answerList);
    			form.appendChild(input5);
    			
    			// input6 추가 - qComment(배열)
    			let qComments = document.querySelectorAll('.qComment'); // qCommant
    			let qCommentList = [];
    			for(let i = 0; i < qComments.length; i++) {
    				qCommentList.push(qComments[i].value);
    			}
    			let input6 = document.createElement('input');
    			input6.setAttribute('type', 'hidden');
    			input6.setAttribute('name', 'qCommentList');
    			input6.setAttribute('value', qCommentList);
    			form.appendChild(input6);
    			
    			// input7 추가 - questionImgArr(배열)
    			let input7 = document.createElement('input');
    			input7.setAttribute('type', 'hidden');
    			input7.setAttribute('name', 'questionImgArr');
    			input7.setAttribute('value', questionImgArr);
    			form.appendChild(input7);
    			
    			// input8 추가 - 질문(답,해설) 개수
    			let input8 = document.createElement('input');
    			input8.setAttribute('type', 'hidden');
    			input8.setAttribute('name', 'questionCount');
    			input8.setAttribute('value', aBoxs.length);
    			form.appendChild(input8);
    			
    			document.body.appendChild(form);
    			form.submit();
    			
    		}
    		
            // 답안 추가하는 함수
            function addAnswer() {
            	let index = document.querySelectorAll('.a-box').length + 1;
            	let aBox = '<div class="a-box">'
    						+ '<h6>문제2</h6>'
    						+ '<div class="answer-box">'
    						+ '<span>답</span>'
    						+ '<label class="answer"><input type="radio" name="answer' + index + '" value="1" />1</label>'
    						+ '<label class="answer"><input type="radio" name="answer' + index + '" value="2" />2</label>'
    						+ '<label class="answer"><input type="radio" name="answer' + index + '" value="3" />3</label>'
    						+ '<label class="answer"><input type="radio" name="answer' + index + '" value="4" />4</label>'
    						+ '<label class="answer"><input type="radio" name="answer' + index + '" value="5" />5</label>'
    						+ '</div>'
    						+ '<h6>해설</h6>'
    						+ '<textarea class="qComment" cols="50" rows="10"></textarea>'
    						+ '</div>';
    			let answerWrap = document.getElementById('answer-wrap');
    			answerWrap.innerHTML += aBox;
            }
            
            // 지문 구분선
            function MainTextLine() {
            	//let text = '<p class="mainText" style="display: none"></p>';
            	let text = '◆지문◆';
            	qTextEditor.insertText(text);
            	let qT = qTextEditor.getHTML;
            	console.log(qT);
            }
            
            // 질문 구분선
            function QuestionLine() {
            	//let text = '<p class="question" style="display: none"></p>';
            	let text = '◆문제◆';
            	qTextEditor.insertText(text);
            	let qT = qTextEditor.getHTML;
            	console.log(qT);
            }
    </script> 
</body>
</html>