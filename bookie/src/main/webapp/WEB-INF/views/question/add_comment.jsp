<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="<c:url value="/resources/css/qna/answer.css"/>" />
</head>

<body>
	<header>
		<%@ include file="../incl/header.jsp"%>
	</header>
	<div id="container">
		<div class="viewer_q_wrap">
		<!-- 
			<div class="qna-title">
				답안 해설 등록 화면
			</div>
			 -->		
			<div class="view_q_user">
				${questionText.qtId}번 문제 답변 / 해설 등록!		
					</div>
		
			<div id="viewer_q">${questionText.totalText}</div>
		</div>
		<h3 class="answer-title">해설/답변</h3>
		<div> 
		 <c:forEach var="list" items="${qList}">
		 	<label class="answer"><input type="radio" name="answer1" value="${list.getQId()}" /> 문제 ${list.getQId()}</label>
		 </c:forEach>
		</div>
		<div id="editor"></div>
		<div class="write-btn">
          <a href="javascript:void(0);" onclick="javascript:sendPost('<c:url value='/add_qna'/>');" class="in-btn">글쓰기</a>
          <a href="<c:url value=''/>" class="in-btn">취소</a>
        </div>
	</div>
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
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
	
	const editor = new toastui.Editor({
	    el: document.querySelector('#editor'),
		previewStyle: 'tab',
	    previewHighlight: false,
	    height: '200px',
    	hooks: {
	    	addImageBlobHook: (blob, callback) => {
	    		const formData = new FormData();
	        	formData.append('image', blob);
	        	let url;
	   			$.ajax({
	           		type: 'POST',
	           		enctype: 'multipart/form-data',
	           		url: '/bookie/add_comment',
	           		data: formData,
	           		dataType: "json",
	           		processData: false,
	           		contentType: false,
	           		cache: false,
	           		timeout: 600000,
	           		success: function(data) {
	           			url = Object.values(data)[0] + Object.values(data)[1];
	           			callback(url, '이미지');
	           		},
	           		error: function(e) {
	           			callback(url, '이미지오류!');
	           		}
	           	});
	    	}
	    }
	});
	
    function sendPost(url) {
        //1. 폼생성
        var form = document.createElement('form');
        form.setAttribute('method', 'post');
        form.setAttribute('action', url);
        document.charset = "UTF-8";

        //2. 제목 input Tag 가져오기
        let qnaTitle = document.getElementById('qnaTitle');
        qnaTitle.setAttribute('type', 'hidden');
        form.appendChild(qnaTitle);

        //3. 에디터 안에 있는 html 전체 가져오기
        var getHtml = editor.getHTML();

        //4. 변수 넘겨주는 hidden input tag 만들어서 에디터 안에 있는 콘
        var hf_1 = document.createElement('input');
        hf_1.setAttribute('type', 'hidden');
        hf_1.setAttribute('name', "content");
        hf_1.setAttribute('value', getHtml);
        form.appendChild(hf_1);

        //5. 라디오버튼으로 카테고리 선택한 값을 hiddenfrom으로 값 던져주기.
        let level = document.querySelector('input[name="level"]:checked').value;
        let grade = document.querySelector('input[name="grade"]:checked').value;
        let subject = document.querySelector('input[name="subject"]:checked').value;

        var hf_2 = document.createElement('input');
        hf_2.setAttribute('type', 'hidden');
        hf_2.setAttribute('name', "level");
        hf_2.setAttribute('value', level);
        form.appendChild(hf_2);

        var hf_3 = document.createElement('input');
        hf_3.setAttribute('type', 'hidden');
        hf_3.setAttribute('name', "grade");
        hf_3.setAttribute('value', grade);
        form.appendChild(hf_3);

        var hf_4 = document.createElement('input');
        hf_4.setAttribute('type', 'hidden');
        hf_4.setAttribute('name', "subject");
        hf_4.setAttribute('value', subject);
        form.appendChild(hf_4);

        document.body.appendChild(form);
        form.submit();
      };
</script>
</body>
</html>