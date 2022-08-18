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
			<div class="qna-title">${subject}</div>		
			<c:choose>
				<c:when  test="${uId_session eq uId}">
					<div class="view_q_user">${name}</div>
				</c:when>
				<c:when  test="${fn:contains(uType, 'e')}">
					<div class="view_q_user">${name}</div>
				</c:when>
				<c:otherwise>
					<div class="view_q_user">
						<c:forEach var="i" begin="1" end="${fn:length(name)}">
							<c:choose>
							  <c:when test="${ i == '1' }">
				            		${fn:substring(name,0,1)}
				        		</c:when>
				        		<c:when test="${ i == fn:length(name)}">
				            		${fn:substring(name,fn:length(name) - 1,fn:length(name))}
				        		</c:when>
				        		 <c:otherwise>
		                  			*
		              			</c:otherwise>
				        	</c:choose>
						</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>				
			<div id="viewer_q">${document_q}</div>
		</div>
		<c:choose>
			<c:when test="${uId_session eq uId}">
				<div class="btn">
				<button onclick="javascript:get('<c:url value='/qna/update/${qnaId}'/>');"
					class="qna-btn">수정</button>
				<button onclick="javascript:submit('<c:url value='/qna/delete/${qnaId}'/>');"
				class="qna-btn">삭제</button>
				</div>
			</c:when>
			<c:when test="${fn:contains(uType, 'e')}">
				<div class="btn">
				<button onclick="javascript:get('<c:url value='/qna/update/${qnaId}'/>');"
					class="qna-btn">수정</button>
				<button onclick="javascript:submit('<c:url value='/qna/delete/${qnaId}'/>');"
				class="qna-btn">삭제</button>
				</div>
			</c:when>
		</c:choose>
		<h3 class="answer-title">댓글</h3>
		<div id="editor"></div>
		<div class="btn">
			<c:choose>
				<c:when test="${not empty update_answer_d}">
					<button onclick="javascript:submit('<c:url value='/answer/update/${qnaId}/${update_answer.getAnId()}'/>');"
					class="submit-btn">등록</button>
					<a href="<c:url value='/answer/${qnaId}'/>" class="in-btn">취소</a>
				</c:when>
				<c:otherwise>
					<button onclick="javascript:submit('<c:url value='/answer/insert/${qnaId}'/>');"
					class="submit-btn">작성</button>
				</c:otherwise>
			</c:choose>
		</div>
		<c:forEach var="answer" items="${answers}" varStatus="status">
			<div class="view_a_wrap">
				<c:choose>
					<c:when  test="${uId_session eq answer.getUser().getUId()}">
						<div class="view_a_user">${answer.getUser().getName()}</div>
					</c:when>
					<c:when test="${fn:contains(uType, 'e')}">
						<div class="view_a_user">${answer.getUser().getName()}</div>
					</c:when>
					<c:otherwise>
						<div class="view_a_user">
							<c:forEach var="i" begin="1" end="${fn:length(answer.getUser().getName())}">
								<c:choose>
								    <c:when test="${ i == '1' }">
					            		${fn:substring(answer.getUser().getName(),0,1)}
					        		</c:when>
					        		<c:when test="${ i == fn:length(answer.getUser().getName())}">
					            		${fn:substring(answer.getUser().getName(),fn:length(answer.getUser().getName()) - 1,fn:length(answer.getUser().getName()))}
					        		</c:when>
					        		 <c:otherwise>
		                   				*
		               				</c:otherwise>
					        	</c:choose>
							</c:forEach>
						</div>
					</c:otherwise>
				</c:choose>			
				<div id="viewer_a">${answer.getDocument()}</div>
			</div>
			<c:if test="${uId_session eq answer.getUser().getUId()}">
				<div class="btn">
					<button onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}'/>');"
					class="qna-btn">수정</button>
					<button onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}'/>');"
					class="qna-btn">삭제</button>
				</div>
			</c:if>
			<c:if test="${fn:contains(uType, 'e')}">
				<div class="btn">
					<button onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}'/>');"
					class="qna-btn">수정</button>
					<button onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}'/>');"
					class="qna-btn">삭제</button>
				</div>
			</c:if>
		</c:forEach>
		<c:choose>
		    <c:when test="${not empty answer}">
				<div class="view_a_wrap">
					<c:choose>
						<c:when  test="${uId_session eq answer.getUser().getUId()}">
							<div class="view_a_user">${answer.getUser().getName()}</div>
						</c:when>
						<c:when test="${fn:contains(uType, 'e')}">
							<div class="view_a_user">${answer.getUser().getName()}</div>
						</c:when>
						<c:otherwise>
							<div class="view_a_user">
								<c:forEach var="i" begin="1" end="${fn:length(answer.getUser().getName())}">
									<c:choose>
									    <c:when test="${ i == '1' }">
						            		${fn:substring(answer.getUser().getName(),0,1)}
						        		</c:when>
						        		<c:when test="${ i == fn:length(answer.getUser().getName())}">
						            		${fn:substring(answer.getUser().getName(),fn:length(answer.getUser().getName()) - 1,fn:length(answer.getUser().getName()))}
						        		</c:when>
						        		 <c:otherwise>
			                   				*
			               				</c:otherwise>
						        	</c:choose>
								</c:forEach>
							</div>
						</c:otherwise>
					</c:choose>	
					<div id="viewer_a">${answer.getDocument()}</div>
				</div>
				<c:if test="${uId_session eq answer.getUser().getUId()}">
					<div class="btn">
						<button onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}'/>');"
						class="qna-btn">수정</button>
						<button onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}'/>');"
						class="qna-btn">삭제</button>
					</div>
				</c:if>
				<c:if test="${fn:contains(uType, 'e')}">
					<div class="btn">
						<button onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}'/>');"
						class="qna-btn">수정</button>
						<button onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}'/>');"
						class="qna-btn">삭제</button>
					</div>
				</c:if>
		    </c:when>
		</c:choose>
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
	
	function get(url){
		let documnet = editor.getHTML();
		
		var form = document.createElement('form');
	    form.setAttribute('method', 'get');
	    form.setAttribute('action', url);
	    document.charset = "UTF-8";
	    
	    document.body.appendChild(form);
	    form.submit();
	}
	
	// 스마트에디터
	const Editor = toastui.Editor;

	const editor = new Editor({
	    el: document.querySelector('#editor'),
		previewStyle: 'tab',
	    previewHighlight: false,
	    height: '200px',
	    initialValue: "",
	    // 사전입력 항목
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
	
	let text = '${update_answer_d}';
    editor.insertText(text);
	
	const viewer = Editor.factory({
		  el: document.querySelector('#viewer_q'),
		  viewer: true,
		  height: '500px',
		  //initialValue: '${document_q}'
	});
	
	const viewer2 = Editor.factory({
		  el: document.querySelector('#viewer_a'),
		  viewer: true,
		  height: '100px'
	});
</script>
</body>
</html>