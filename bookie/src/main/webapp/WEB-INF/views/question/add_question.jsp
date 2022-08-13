<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/default.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/question/question.css"/>"/>

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

	<!-- wrap 부분 -->
	<div class="wrap">
		<h3>문제 등록</h3>
		<!-- 카테고리/문제유형 선택 폼 -->
		<form class="select-type" action="select_type" method="post">
			<label class="cate">카테고리</label>
			<div class="cate-box">
				<label class="c-level"><input type="radio" name="cLevel" value="m" />중학교</label>
				<label class="c-level"><input type="radio" name="cLevel" value="h" />고등학교</label>
			</div> ${cateErrMsg1}
			<div class="cate-box">
				<label class="grade"><input type="radio" name="grade" value="1" />1학년</label>
				<label class="grade"><input type="radio" name="grade" value="2" />2학년</label>
				<label class="grade"><input type="radio" name="grade" value="3" />3학년</label>
			</div> ${cateErrMsg2}
			<div class="cate-box">
				<label class="c-level"><input type="radio" name="subject" value="국어" />국어</label>
				<label class="c-level"><input type="radio" name="subject" value="영어" />영어</label>
				<label class="c-level"><input type="radio" name="subject" value="수학" />수학</label>
			</div> ${cateErrMsg3}
			<label class="type">문제 유형</label>
			<div class="type-box">
				<select name="question-type">
					<option value="1">일반문제</option>
					<option value="2">통합문제</option>
				</select>
			</div>
			<input type="submit" value="적용하기">
		</form>
		
		<!-- 문제 등록 폼 -->
		<!-- 일반문제 폼 -->
		<c:if test="${qType eq 1}">
			<h4>일반 문제</h4>
			<h5>제목</h5> ${errMsg1}
			<input type="text" name="qTitle" id="qTitle"/>
			<h5>문제</h5> ${errMsg2}
			<div class="editor" id="qTextEditor"></div>
			<h5>답</h5> ${errMsg3}${errMsg4}
			<input type="text" name="answer" id="answer"/>
			<h5>해설</h5> ${errMsg5}
			<div class="editor" id="qCommentEditor"></div>
			<button class="submit-btn" onclick="javascript:sendCommonQuestion('<c:url value="/question/add_common_question"/>', ${qType});" >등록</button>
		</c:if>
		<!-- 통합문제 폼 -->
		<c:if test="${qType eq 2}">
			22222
		</c:if>
	</div>
	
	<!-- 푸터 부분 -->
	
	<script>
		// 문제유형 selected 표시
		$(function() {
			
		});
		
    	let questionImgArr = []; // 질문 이미지 배열
    	let commentImgArr = []; // 해설 이미지 배열
    	
    	// qText 에디터
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
		           			console.log('ajax 이미지 업로드 성공');
		           			console.log(data)
		           			console.log(Object.values(data)[0])
		           			//url += "image.png"//data.filename;
		           			url = Object.values(data)[0] + Object.values(data)[1];
		           			questionImgArr.push(Object.values(data)[1]); // 등록된 이미지 배열에 넣기
		           			console.log(questionImgArr[0]);
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
		
		// qComment 에디터
		const qCommentEditor = new toastui.Editor({
		    el: document.querySelector('#qCommentEditor'),
		    previewStyle: 'tab',
		    previewHighlight: false,
		    height: '300px',
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
		           			console.log('ajax 이미지 업로드 성공');
		           			console.log(data)
		           			console.log(Object.values(data)[0])
		           			//url += "image.png"//data.filename;
		           			url = Object.values(data)[0] + Object.values(data)[1];
		           			commentImgArr.push(Object.values(data)[1]); // 등록된 이미지 배열에 넣기
		           			console.log(commentImgArr[0]);
		           			// callback : 에디터(마크다운 편집기)에 표시할 텍스트, 뷰어에는 imageUrl 주소에 저장된 사진으로 나옴
		        			// 형식 : ![대체 텍스트](주소)
		           			callback(url, '해설이미지');
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

         //editor.getHtml()을 사용해서 에디터 내용 수신
        //document.querySelector('#contents').insertAdjacentHTML('afterbegin' ,editor.getHTML());
         //콘솔창에 표시
       // console.log(editor.getHTML());
        
        // 폼 생성 후 컨트롤러로 넘어가기
		function sendCommonQuestion(url, qType) {
			// 폼 생성
			console.log(url);
			let form = document.createElement('form');
			form.setAttribute('method', 'post');
			form.setAttribute('action', url);
			document.charset = "UTF-8";
			
			// input1 추가 - qType
			let input1 = document.createElement('input');
			input1.setAttribute('type', 'hidden');
			input1.setAttribute('name', 'qType');
			input1.setAttribute('value', qType);
			form.appendChild(input1);
			
			// input2 추가 - qTitle
			let input2 = document.getElementById('qTitle');
			input2.setAttribute('type', 'hidden');
			form.appendChild(input2);
			
			// input3 추가 - qTextEditor
			let input3 = document.createElement('input');
			let qText = qTextEditor.getHTML();

			input3.setAttribute('type', 'hidden');
			input3.setAttribute('name', 'qText');
			input3.setAttribute('value', qText);
			form.appendChild(input3);
			
			// input4 추가 - answer
			let input4 = document.getElementById('answer');
			input4.setAttribute('type', 'hidden');
			form.appendChild(input4);
			
			// input5 추가 - qCommentEditor
			let input5 = document.createElement('input');
			let qComment = qCommentEditor.getHTML();
			input5.setAttribute('type', 'hidden');
			input5.setAttribute('name', 'qComment');
			input5.setAttribute('value', qComment);
			form.appendChild(input5);
			
			// input6 추가 - questionImgArr
			let input6 = document.createElement('input');
			input6.setAttribute('type', 'hidden');
			input6.setAttribute('name', 'questionImgArr');
			input6.setAttribute('value', questionImgArr);
			form.appendChild(input6);
			
			// input7 추가 - commentImgArr
			let input7 = document.createElement('input');
			input7.setAttribute('type', 'hidden');
			input7.setAttribute('name', 'commentImgArr');
			input7.setAttribute('value', commentImgArr);
			form.appendChild(input7);
			
			
			document.body.appendChild(form);
			form.submit();
		}

    </script> 
</body>
</html>