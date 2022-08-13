<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script>	
    	
</script>
<!-- 디자인 수정용 CSS 추가 -->
<style>
#container{
	width: 100%;
	margin: 0 auto;
}
.title{
 	width: 70%;
 	margin: 0 auto;
 	text-align: center;
 	padding : 30px 0;
}
.answer-title{
	width: 70%;
	margin: 0 auto;
	text-align: left;
	margin-bottom: 10px;
}
#editor {
	/* border : 1px solid; */
	width: 70%;
	margin: 0 auto;
	margin-top: 20px;
}
/* editor content 받을 div태그 스타일 추가. */
#contents {
	width: 50%;
	height: 100px;
	margin: 30px auto;
	border: 1px solid;
}
#viewer_q {
	border : 1px solid;
	width: 70%;
	height: 500px;
	margin: 0 auto;
	margin-bottom: 30px;
	border-color: #ddd;
}
#viewer_a {
	border : 1px solid;
	width: 70%;
	height: 50%;
	margin: 0 auto;
	border-color: #ddd;
}
.btn{
	width: 70%;
	margin: 0 auto;
	text-align: right;
}
.toastui-editor-contents img {
    box-sizing: border-box;
    margin: 4px 0 10px;
    max-width: 100%;
    vertical-align: top;
}
p{
	text-align: center;
}
.view_q_user, .view_a_user{
	border : 1px solid;
	width: 70%;
	margin: 0 auto;
	color: #333;
    background-color: #f5f5f5;
    border-color: #ddd;
    padding: 5px 15px;
}
</style>
</head>
<body>
	<header>
		<%@ include file="../incl/no_login_header.jsp"%>
	</header>
	<div id="container">
		<h1 class="title">질문</h1>
		<div class="viewer_q_wrap">
			<div class="view_q_user">${userId}</div>
			<div id="viewer_q"></div>
		</div>
		<h3 class="answer-title">댓글</h3>
		<c:forEach var="answer" items="${answer}">
			<div class="view_a_wrap">
				<div class="view_a_user">유저아이디</div>
				<div id="viewer_a"></div>
			</div>
		</c:forEach>
		<div id="editor"></div>
		<div class="btn">
			<button onclick="javascript:submit('<c:url value='/answer'/>');"
				class="submit-btn">작성</button>
		</div>	
	</div>
<script>
	// 폼 생성
	function submit(url){
		let documnet = editor.getHTML();
		
		var form = document.createElement('form');
	    form.setAttribute('method', 'post');
	    form.setAttribute('action', url);
	    document.charset = "UTF-8";
	    
	    var hiddenField = document.createElement('input');
	    hiddenField.setAttribute('type', 'hidden');
	    hiddenField.setAttribute('name', "documnet");
	    hiddenField.setAttribute('value', documnet);
	    form.appendChild(hiddenField);
	    
	    document.body.appendChild(form);   
	    form.submit();
	}
	
	// 스마트에디터
	const Editor = toastui.Editor;

	const editor = new Editor({
	    el: document.querySelector('#editor'),
	    previewStyle: 'vertical',
	    previewHighlight: false,
	    height: '200px',
	    // 사전입력 항목
	    initialValue: '글을 작성해주세요.',
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
	           			// callback : 에디터(마크다운 편집기)에 표시할 텍스트, 뷰어에는 imageUrl 주소에 저장된 사진으로 나옴
	        			// 형식 : ![대체 텍스트](주소)
	           			callback(url, '이미지');
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
	
	const viewer = Editor.factory({
		  el: document.querySelector('#viewer_q'),
		  viewer: true,
		  height: '500px',
		  initialValue: '${document_q}'
	});
	
	const viewer2 = Editor.factory({
		  el: document.querySelector('#viewer_a'),
		  viewer: true,
		  height: '100px',
		  initialValue: '${documnet}'
	});
</script>
</body>
</html>