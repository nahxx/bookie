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
<style>
:root {
	--font-family : 'Noto Sans KR', sans-serif;
}

#container{
	width: 100%;
	margin: 0 auto;
	min-height: calc(100vh - 60px);
}
.viewer_q_wrap{
	padding-top: 100px;
}
.back{
	width: 70%;
	margin: 0 auto;
	margin-bottom: 5px;
}
.qna-title{	
	border: 0;
	background: none;
	width: 70%;
	margin: 0 auto;
	color: #251c3b;
    padding: 5px 15px;
    font-family : var(--font-family);
    display: flow-root;
  	margin-top: 5px;
}
.answer-title{
	width: 70%;
	margin: 0 auto;
	text-align: left;
	margin-top: 30px;
}
#editor{
	width: 70%;
	margin: 0 auto;
	margin-top: 10px;
}
#contents {
	width: 50%;
	height: 100px;
	margin: 30px auto;
	border: 1px solid;
}
#viewer_q {
	border : 0;
	border-top: 8px solid #f5f5f5;
	border-bottom: 8px solid #f5f5f5;
	width: 70%;
	margin: 0 auto;
	border-color: #ddd;
	padding: 20px 0;
}
#viewer_a {
	border : 0;
	width: 70%;
	height: 50%;
	margin: 0 auto;
	border-color: #ddd;
	padding: 10px 0;
}
.view_a_wrap:last-child {
	margin-bottom: 50px;
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
.view_a_user{
	position: relative;
	border : 0;
	border-top : 1px solid #ddd;
	background: none;
	width: 70%;
	margin: 0 auto;
	color: #333;
    padding-left: 10px;
    padding-right: 10px;
    padding-top: 10px;
    padding-bottom: 5px;
    font-family : var(--font-family);
}
.user_name{
	font-weight: 700;
	font-size: 15px;
	display: inline-block;
}
.view_q_user{
	font-size: 13px;
	padding: 5px 10px;
	display: inline-block;
	float: right;
}
.button{
	display: inline-block;
	position: absolute;
	right: 15px;
    top: 5px;
}
.btn-wrap{
	width: 110%;
	margin: 0 auto;
	text-align: right;
	padding-top: 5px;
}
.update-btn{
  	float: left;
  	font-family : var(--font-family); 	
  	padding: 2px 10px 3px;
    font-size: 13px;
    color: #fff;
    background: #607EAA;
    border: 1px solid #607EAA;
    border-radius: 20px;
}
.delete-btn{
  	display: inline-block;
  	font-family : var(--font-family);
  	padding: 2px 10px 3px;
    font-size: 13px;
    color: #fff;
  	background: #565c69;
    border: 1px solid #565c69;
    border-radius: 20px;
}
.submit-btn {
  	width: 6%;
  	margin: 10px 0;
  	outline: none;
  	border: none;
  	background: #607EAA;
  	height: 30px;
  	line-height: 30px;
  	border-radius: 10px;
 	color: white;
  	font-size: 15px;
  	font-family : var(--font-family);
  	cursor: pointer;
}
.delete{
	width: 6%;
  	margin: 10px 0;
  	outline: none;
  	border: none;
  	background: #565c69;
  	height: 30px;
  	line-height: 30px;
  	border-radius: 10px;
 	color: white;
  	font-size: 15px;
  	font-family : var(--font-family);
  	cursor: pointer;
}
.delete-a{
	color: white;
}
.qna-btn{
  	width: 6%;
  	margin: 10px 0;
 	outline: none;
  	border: none;
  	background: #607EAA;
  	height: 30px;
  	line-height: 30px;
  	border-radius: 10px;
  	color: white;
  	font-size: 15px;
  	font-family : var(--font-family);
  	cursor: pointer;
}
.qna-btn-delete{
	width: 6%;
  	margin: 10px 0;
 	outline: none;
  	border: none;
  	background: #565c69;
  	height: 30px;
  	line-height: 30px;
  	border-radius: 10px;
  	color: white;
  	font-size: 15px;
  	font-family : var(--font-family);
  	cursor: pointer;
}
.qna-update-btn{
  	width: 6%;
  	margin: 10px 0;
  	outline: none;
  	border: none;
  	background: #607EAA;
  	height: 30px;
  	line-height: 30px;
  	border-radius: 10px;
  	color: white;
  	font-size: 15px;
  	font-family : var(--font-family);
  	cursor: pointer;
}
.toastui-editor-contents {
    font-family: 'IM_Hyemin-Regular';
    font-size: 15px;
    margin: 0;
}
.toastui-editor-contents p {	
    color: #222;
    margin: 0;
    text-align: center;
}
#viewer_q p{
	text-align: center;
	font-family : var(--font-family);
}
#viewer_a p{
	text-align: left;
	padding: 0px 10px;
	font-family : var(--font-family);
}
#viewer_a p > img{
	margin-left: 500px;
}
.delete-btn{
	font-family : var(--font-family);
}
.subject{
	display: inline-block;
	float: left;
}
.date{
	font-size: 13px;
	padding: 5px 10px;
	display: inline-block;
	float: right;
}
.date_a{
	font-size: 13px;
	display: inline-block;
  	margin: 5px;
}
</style>
<body>
	<header>
		<%@ include file="../incl/header.jsp"%>
	</header>
	<div id="container">
		<div class="viewer_q_wrap">
			<div class="back">
				<h5><a href="<c:url value='/qna_board/${page}'/>"> < 목록으로 </a></h5>
			</div>
			<div class="qna-title">
			<div class="subject">${subject}</div>
			<div class="date">${date}</div>		
			<c:choose>
				<c:when  test="${uId_session eq uId}">
					<div class="view_q_user">${name}</div>
				</c:when>
				<c:when  test="${fn:contains(manager, 'Y')}">
					<div class="view_q_user">${name}</div>
				</c:when>
				<c:otherwise>
					<c:if test="${fn:contains(manager_q, 'Y')}">
						<div class="view_q_user">${name}</div>
					</c:if>
					<c:if test="${fn:contains(manager_q, 'N')}">
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
					</c:if>
				</c:otherwise>
			</c:choose>
			</div>				
			<div id="viewer_q">${document_q}</div>
		</div>
		<c:choose>
			<c:when test="${uId_session eq uId}">
				<div class="btn">
				<button onclick="javascript:get('<c:url value='/qna/update/${qnaId}/${page}'/>');"
					class="qna-btn">수정</button>
				<c:choose>
					<c:when test="${form eq 'ma'}">
						<button onclick="javascript:submit('<c:url value='/qna/delete/ma${qnaId}/${page}'/>');"
						class="qna-btn-delete">삭제</button>
					</c:when>
					<c:when test="${form eq 'mq'}">
						<button onclick="javascript:submit('<c:url value='/qna/delete/mq${qnaId}/${page}'/>');"
						class="qna-btn-delete">삭제</button>
					</c:when>
					<c:otherwise>
						<button onclick="javascript:submit('<c:url value='/qna/delete/${qnaId}/${page}'/>');"
						class="qna-btn-delete">삭제</button>
					</c:otherwise>
				</c:choose>
				</div>
			</c:when>
			<c:when test="${fn:contains(manager, 'Y')}">
				<div class="btn">
				<button onclick="javascript:get('<c:url value='/qna/update/${qnaId}/${page}'/>');"
					class="qna-btn">수정</button>
				<c:choose>
					<c:when test="${form eq 'ma'}">
						<button onclick="javascript:submit('<c:url value='/qna/delete/ma${qnaId}/${page}'/>');"
						class="qna-btn-delete">삭제</button>
					</c:when>
					<c:when test="${form eq 'mq'}">
						<button onclick="javascript:submit('<c:url value='/qna/delete/mq${qnaId}/${page}'/>');"
						class="qna-btn-delete">삭제</button>
					</c:when>
					<c:otherwise>
						<button onclick="javascript:submit('<c:url value='/qna/delete/${qnaId}/${page}'/>');"
						class="qna-btn-delete">삭제</button>
					</c:otherwise>
				</c:choose>
				</div>
			</c:when>
		</c:choose>
		<h4 class="answer-title">댓글</h4>
		<div id="editor">
			<c:choose>
				<c:when test="${not empty update_answer_d}">
					${update_answer_d}
				</c:when>
			</c:choose>
		</div>
		<div class="btn">
			<c:choose>
				<c:when test="${not empty update_answer_d}">
					<button onclick="javascript:post('<c:url value='/answer/update/${qnaId}/${update_answer.getAnId()}/${page}'/>');"
					class="submit-btn">등록</button>
					<button class="delete"><a href="<c:url value='/answer/${qnaId}/${page}'/>" class="delete-a">취소</a></button>
				</c:when>
				<c:otherwise>
					<button onclick="javascript:post('<c:url value='/answer/insert/${qnaId}/${page}'/>');"
					class="submit-btn">작성</button>
				</c:otherwise>
			</c:choose>
		</div>
		<c:forEach var="answer" items="${answers}" varStatus="status">
			<div class="view_a_wrap">
				<c:choose>
					<c:when  test="${uId_session eq answer.getUser().getUId()}">
						<div class="view_a_user">
							<div class="user_name">${answer.getUser().getName()}</div>
							<div class="date_a">${answer.getRegDate()}</div>	
							<div class="button">
								<c:if test="${uId_session eq answer.getUser().getUId() && fn:contains(manager, 'N')}">
									<div class="btn-wrap">
										<a onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}/${page}'/>');"
										class="update-btn">수정</a>
										<a onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}/${page}'/>');"
										class="delete-btn">삭제</a>
									</div>
								</c:if>
								<c:if test="${fn:contains(manager, 'Y')}">
									<div class="btn-wrap">
										<a onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}/${page}'/>');"
										class="update-btn">수정</a>
										<a onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}/${page}'/>');"
										class="delete-btn">삭제</a>
									</div>
								</c:if>
							</div>
						</div>
					</c:when>
					<c:when test="${fn:contains(manager, 'Y')}">
						<div class="view_a_user">
							<div class="user_name">${answer.getUser().getName()}</div>
							<div class="date_a">${answer.getRegDate()}</div>	
							<div class="button">
								<c:if test="${uId_session eq answer.getUser().getUId() && fn:contains(manager, 'N')}">
									<div class="btn-wrap">
										<a onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}/${page}'/>');"
										class="update-btn">수정</a>
										<a onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}/${page}'/>');"
										class="delete-btn">삭제</a>
									</div>
								</c:if>
								<c:if test="${fn:contains(manager, 'Y')}">
									<div class="btn-wrap">
										<a onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}/${page}'/>');"
										class="update-btn">수정</a>
										<a onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}/${page}'/>');"
										class="delete-btn">삭제</a>
									</div>
								</c:if>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="view_a_user">
							<c:if test="${fn:contains(answer.getUser().getManager(), 'Y')}">
								<div class="user_name">${answer.getUser().getName()}</div>
								<div class="date_a">${answer.getRegDate()}</div>	
							</c:if>
							<c:if test="${fn:contains(answer.getUser().getManager(), 'N')}">
								<div class="user_name">
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
								<div class="date_a">${answer.getRegDate()}</div>	
							</c:if>
							<div class="button">
								<c:if test="${uId_session eq answer.getUser().getUId() && fn:contains(manager, 'N')}">
									<div class="btn-wrap">
										<a onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}/${page}'/>');"
										class="update-btn">수정</a>
										<a onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}/${page}'/>');"
										class="delete-btn">삭제</a>
									</div>
								</c:if>
								<c:if test="${fn:contains(manager, 'Y')}">
									<div class="btn-wrap">
										<a onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}/${page}'/>');"
										class="update-btn">수정</a>
										<a onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}/${page}'/>');"
										class="delete-btn">삭제</a>
									</div>
								</c:if>
							</div>
						</div>
					</c:otherwise>
				</c:choose>			
				<div id="viewer_a">${answer.getDocument()}</div>
			</div>
		</c:forEach>
		<!-- 
		<c:choose>
		    <c:when test="${not empty answer}">
				<div class="view_a_wrap">
					<c:choose>
						<c:when  test="${uId_session eq answer.getUser().getUId()}">
							<div class="view_a_user">
								<div class="user_name">${answer.getUser().getName()}</div>
								<div class="button">
									<c:if test="${uId_session eq answer.getUser().getUId() && fn:contains(manager, 'N')}">
										<div class="btn-wrap">
											<a onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}/${page}'/>');"
											class="update-btn">수정</a>
											<a onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}/${page}'/>');"
											class="delete-btn">삭제</a>
										</div>
									</c:if>
									<c:if test="${fn:contains(manager, 'Y')}">
										<div class="btn-wrap">
											<a onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}/${page}'/>');"
											class="update-btn">수정</a>
											<a onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}/${page}'/>');"
											class="delete-btn">삭제</a>
										</div>
									</c:if>
								</div>
							</div>
						</c:when>
						<c:when test="${fn:contains(manager, 'Y')}">
							<div class="view_a_user">
								<div class="user_name">${answer.getUser().getName()}</div>
								<div class="button">
									<c:if test="${uId_session eq answer.getUser().getUId() && fn:contains(manager, 'N')}">
										<div class="btn-wrap">
											<a onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}/${page}'/>');"
											class="update-btn">수정</a>
											<a onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}/${page}'/>');"
											class="delete-btn">삭제</a>
										</div>
									</c:if>
									<c:if test="${fn:contains(manager, 'Y')}">
										<div class="btn-wrap">
											<a onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}/${page}'/>');"
											class="update-btn">수정</a>
											<a onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}/${page}'/>');"
											class="delete-btn">삭제</a>
										</div>
									</c:if>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="view_a_user">
								<div class="user_name">
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
								<div class="button">
									<c:if test="${uId_session eq answer.getUser().getUId() && fn:contains(manager, 'N')}">
										<div class="btn-wrap">
											<a onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}/${page}'/>');"
											class="update-btn">수정</a>
											<a onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}/${page}'/>');"
											class="delete-btn">삭제</a>
										</div>
									</c:if>
									<c:if test="${fn:contains(manager, 'Y')}">
										<div class="btn-wrap">
											<a onclick="javascript:get('<c:url value='/answer/update/${qnaId}/${answer.getAnId()}/${page}'/>');"
											class="update-btn">수정</a>
											<a onclick="javascript:submit('<c:url value='/answer/delete/${qnaId}/${answer.getAnId()}/${page}'/>');"
											class="delete-btn">삭제</a>
										</div>
									</c:if>
								</div>
							</div>
						</c:otherwise>
					</c:choose>			
					<div id="viewer_a">${answer.getDocument()}</div>
				</div>
		    </c:when>
		</c:choose>
		 -->
	</div>
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
<script>
	// 폼 생성
	function post(url){
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
	    
	    var hiddenField2 = document.createElement('input');
	    hiddenField2.setAttribute('type', 'hidden');
	    hiddenField2.setAttribute('name', "answerImgArr");
	    hiddenField2.setAttribute('value', answerImgArr);
	    form.appendChild(hiddenField2);
	    
	    document.body.appendChild(form);   
	    form.submit();
	}
	
	function submit(url){
		var result = confirm("삭제하시겠습니까?");
		
		if(result == true){
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
		    
		    var hiddenField2 = document.createElement('input');
		    hiddenField2.setAttribute('type', 'hidden');
		    hiddenField2.setAttribute('name', "answerImgArr");
		    hiddenField2.setAttribute('value', answerImgArr);
		    form.appendChild(hiddenField2);
		    
		    document.body.appendChild(form);   
		    form.submit();
		}
	}
	
	function get(url){
		var result = confirm("수정하시겠습니까?");
		
		if(result == true){
			let documnet = editor.getHTML();
			
			var form = document.createElement('form');
		    form.setAttribute('method', 'get');
		    form.setAttribute('action', url);
		    document.charset = "UTF-8";
		    
		    document.body.appendChild(form);
		    form.submit();
		}	
	}
	
	let answerImgArr = []; // 댓글 이미지 배열
	
	// 댓글 스마트에디터
	const editor = new toastui.Editor({
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
	           		url: '/bookie/add_answer',
	           		data: formData,
	           		dataType: "json",
	           		processData: false,
	           		contentType: false,
	           		cache: false,
	           		timeout: 600000,
	           		success: function(data) {	           			
	           			//url += "image.png"//data.filename;
	           			url = Object.values(data)[0] + Object.values(data)[1];
	           			answerImgArr.push(Object.values(data)[1]); // 등록된 이미지 배열에 넣기
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
	});
	
	const viewer2 = Editor.factory({
		  el: document.querySelector('#viewer_a'),
		  viewer: true,
		  height: '100px'
	});
</script>
</body>
</html>