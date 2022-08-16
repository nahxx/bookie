<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>개발자 페이지</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    
    <!-- 디자인 수정용 CSS 추가 -->
    <style>
        #editor {
            /* border : 1px solid; */
            width: 70%;
            margin: 0 auto;
        }
        /* editor content 받을 div태그 스타일 추가. */
        #contents {
            width:50%;
            height: 100px;
            margin: 30px auto;
            border: 1px solid;
        }
        #accordion {
        	width: 70%;
        	margin: 0 auto;
        }
    </style>
    
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
	
</head>
<body>
    <h1> 개발자페이지 </h1>
    
	<div class="btn">
		<a href="<c:url value='/devel/addQna'/>" class="in-btn">QNA데이터 입력하기</a>
	</div>
    <!-- TOAST UI Editor가 들어갈 div태그 -->
    <div id="editor"></div>
	<input type="button" value="등록" onclick="javascript:sendPost()"> 
    <!-- TOAST UI Editor 생성 JavaScript 코드 -->
    <script>
    
		const editor = new toastui.Editor({
		    el: document.querySelector('#editor'),
		    previewStyle: 'vertical',
		    previewHighlight: false,
		    height: '700px',
		    // 사전입력 항목
		    initialValue: "처음입력하는 공간 el 넣으면 될듯",
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

         //editor.getHtml()을 사용해서 에디터 내용 수신
        //document.querySelector('#contents').insertAdjacentHTML('afterbegin' ,editor.getHTML());
         //콘솔창에 표시
       console.log(editor.getHTML());
         
       function sendPost() {
    	  console.log(editor.getHTML());
    	   }
    </script>   
</body>
</html>