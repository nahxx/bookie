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
						<label class="c-level"><input class="category" type="radio" name="cLevel" value="m" />중학교</label>
						<label class="c-level"><input class="category" type="radio" name="cLevel" value="h" />고등학교</label>
					</td>
				</tr>
				<tr>
					<th>학년</th>
					<td>
						<label class="grade"><input class="category" type="radio" name="grade" value="1" />1학년</label>
						<label class="grade"><input class="category" type="radio" name="grade" value="2" />2학년</label>
						<label class="grade"><input class="category" type="radio" name="grade" value="3" />3학년</label>
					</td>
				</tr>
				<tr>
					<th>과목</th>
					<td>
						<label class="subject"><input class="category" type="radio" name="subject" value="국어" onclick="javascript:checkingPattern2('<c:url value="/question/checking_pattern2"/>')"/>국어</label>
						<label class="subject"><input class="category" type="radio" name="subject" value="영어" onclick="javascript:checkingPattern2('<c:url value="/question/checking_pattern2"/>')"/>영어</label>
					</td>
				</tr>
				<tr>
					<th>대분류</th>
					<td>
						<select id='bPattern' name='bPattern' onChange='javascript:checkingMPattern2(this);'>
							<option value="unknown">---선택---</option>
							${bigTag}
						</select>
					</td>
				</tr>
				<tr>
					<th>중분류</th>
					<td>
						<select id='mPattern' name='mPattern'>
							<option value="unknown">---선택---</option>
							${midTag}
						</select>
					</td>
				</tr>
			</table>

		</form>
		
		<!-- 문제 등록 폼 -->
		<div class="question-box">
			<div class="q-box">
				<h6 class="ques">문제입력 ></h6>
				<div class="qBtn-box">
					<button class="submit-btn" onclick="javascript:MainTextLine();" >지문 구분</button>
					<button class="submit-btn" onclick="javascript:QuestionLine();" >문제 구분</button>
				</div>
				<div class="editor" id="qTextEditor"></div>
			</div>
		</div>
		<button class="submit-btn sBtn" onclick="javascript:sendCommonQuestion('<c:url value="/question/add_question2"/>');" >등록</button>
		
	</div>
	
	<!-- 푸터 부분 -->
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
	
	<script>
		// 컨트롤러 다녀올 때 check 표시
	    <c:if test="${not empty category}">
	        let cLevel = document.querySelector('input[value="' + "${category.getCLevel()}" + '"]');
	    	cLevel.checked = true;
	    	cLevel.parentNode.className += ' on';
	    	
	    	let grade = document.querySelector('input[value="' + "${category.getGrade()}" + '"]');
	    	grade.checked = true;
	    	grade.parentNode.className += ' on';
	    	
	    	let subject = document.querySelector('input[value="' + "${category.getSubject()}" + '"]');
	    	subject.checked = true;
	    	subject.parentNode.className += ' on';
	    	
	    	let bp = document.querySelector('#bPattern');
	    	for(let i = 0; i < bp.length; i++) {
				if(bp.options[i].value === "${bigPattern}") {
					bp.options[i].selected = true;
					break;
				}
			}
		</c:if>
		
		// 라디오버튼 없애기
		$(function() {
			$('.category').css("display", "none");
			$('.c-level').click(function() {
				$('input[name=c-level]').removeAttr("checked");
				$(this).find('input[type=radio]').attr("checked", "checked");
				$('.c-level').removeClass("on");
	    		$(this).addClass("on");
			});
			$('.grade').click(function() {
				$('input[name=grade]').removeAttr("checked");
				$(this).find('input[type=radio]').attr("checked", "checked");
				$('.grade').removeClass("on");
	    		$(this).addClass("on");
			});
			$('.subject').click(function() {
				$('input[name=subject]').removeAttr("checked");
				$(this).find('input[type=radio]').attr("checked", "checked");
				$('.subject').removeClass("on");
	    		$(this).addClass("on");
			});
		});

    	let questionImgArr = []; // 질문 이미지 배열

    	
    	// 질문 에디터
    	const qTextEditor = new toastui.Editor({
    		    el: document.querySelector('#qTextEditor'),
    		    previewStyle: 'vertical',
    		    previewHighlight: false,
    		    height: '600px',
    		    hooks: {
    		    	addImageBlobHook: (blob, callback) => {
    		    		const formData = new FormData();
    		        	formData.append('image', blob);
    		        	let url;
    		        	//console.log(url)
    		   			$.ajax({
    		           		type: 'POST',
    		           		enctype: 'multipart/form-data',
    		           		url: '/bookie/question_write',
    		           		data: formData,
    		           		dataType: "json",
    		           		processData: false,
    		           		contentType: false,
    		           		cache: false,
    		           		timeout: 600000,
    		           		success: function(data) {
    		           			url = Object.values(data)[0] + Object.values(data)[1];
    		           			questionImgArr.push(Object.values(data)[1]); // 등록된 이미지 배열에 넣기
    		           			callback(url, '문제이미지');
    		           		},
    		           		error: function(e) {
    		           			console.log(e);
    		           			callback(url, '이미지오류!');
    		           		}
    		           	});
    		    	}
    		    }
    		});
            
            // 폼 생성 후 컨트롤러로 넘어가기
    		function sendCommonQuestion(url) {
            	// 검사
            	let sCheck = document.getElementById("mPattern");
            	let bpCheck = sCheck.options[sCheck.selectedIndex].value;
				if(bpCheck == "unknown") {
					return alert("중분류를 선택해주세요.");
				}
            	
    			// 폼 생성
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
		
    			// input7 추가 - questionImgArr(배열)
    			let input7 = document.createElement('input');
    			input7.setAttribute('type', 'hidden');
    			input7.setAttribute('name', 'questionImgArr');
    			input7.setAttribute('value', questionImgArr);
    			form.appendChild(input7);
    					
    			// input9 추가 - 대분류
    			let input9 = document.createElement('input');
    			let big = document.querySelector('#bPattern');
    			let bPattern = big.options[big.selectedIndex].value;
    			input9.setAttribute('type', 'hidden');
    			input9.setAttribute('name', 'bPattern');
    			input9.setAttribute('value', bPattern);
    			form.appendChild(input9);
    			
    			// input10 추가 - 중분류
    			let input10 = document.createElement('input');
    			let mid = document.querySelector('#mPattern');
    			let mPattern = mid.options[mid.selectedIndex].value;
    			input10.setAttribute('type', 'hidden');
    			input10.setAttribute('name', 'mPattern');
    			input10.setAttribute('value', mPattern);
    			form.appendChild(input10);
    			
    			// 폼 적용
    			document.body.appendChild(form);
    			form.submit();
    			
    		}
            
            // 지문 구분선
            function MainTextLine() {
            	//let text = '<p class="mainText" style="display: none"></p>';
            	let text = '◆지문◆';
            	qTextEditor.insertText(text);
            	let qT = qTextEditor.getHTML;
            }
            
            // 질문 구분선
            function QuestionLine() {
            	//let text = '<p class="question" style="display: none"></p>';
            	let text = '◆문제◆';
            	qTextEditor.insertText(text);
            	let qT = qTextEditor.getHTML;
            }
            
            // 과목유형 가져와서 컨트롤러로 넘기기 (대분류 가져오기)
            function checkingPattern2(url) {
            	// 검사
            	let check = 0;
            	let c1 = document.querySelectorAll('input[name="cLevel"]');
				let c2 = document.querySelectorAll('input[name="grade"]');
				let c3 = document.querySelectorAll('input[name="subject"]');
				for(let i = 0; i < c1.length; i++) {
					if(c1[i].checked == true) {
						console.log(c1[i]);
						check++;
						break;
					}
				}
				if(check == 0) {
					return alert("학력을 선택해주세요.");
				}
				
				check = 0;
				for(let i = 0; i < c2.length; i++) {
					if(c2[i].checked == true) {
						check++;
						break;
					}
				}
				if(check == 0) {
					return alert("학년을 선택해주세요.");
				}
				
				check = 0;
				for(let i = 0; i < c3.length; i++) {
					if(c3[i].checked == true) {
						check++;
						break;
					}
				}
				if(check == 0) {
					return alert("과목을 선택해주세요.");
				} else {
					checke = 0;
				}
            	
            	// 폼 생성
    			let form = document.createElement('form');
    			form.setAttribute('type', 'hidden');
    			form.setAttribute('method', 'post');
    			form.setAttribute('action', url);
    			document.charset = "UTF-8";
    			
    			// 학력
            	let input1 = document.querySelector('input[name="cLevel"]:checked');
            	form.appendChild(input1);
            	
            	// 학년
            	let input2 = document.querySelector('input[name="grade"]:checked');
            	form.appendChild(input2);
            	
            	// 과목
            	let input3 = document.querySelector('input[name="subject"]:checked');
            	form.appendChild(input3);
            	
            	// 폼 추가
            	document.body.appendChild(form);
    			form.submit();
            }
            
            // 대분류 가져와서 컨트롤러로 넘기기 (중분류 가져오기)
            function checkingMPattern2(value) {
            	let sCheck = document.getElementById("bPattern");
            	let bpCheck = sCheck.options[sCheck.selectedIndex].value;
				if(bpCheck == "unknown") {
					return alert("대분류를 선택해주세요.");
				}
            	
            	let url = "checking_pattern_m2";
            	// 폼 생성
    			let form = document.createElement('form');
    			form.setAttribute('type', 'hidden');
    			form.setAttribute('method', 'post');
    			form.setAttribute('action', url);
    			document.charset = "UTF-8";
    			
    			// 대분류
    			let s = document.getElementById("bPattern");
    			let bp = s.options[s.selectedIndex].value;
    			
    			let input1 = document.createElement('input');
    			input1.setAttribute('type', 'hidden');
    			input1.setAttribute('name', 'bp');
    			input1.setAttribute('value', bp);
            	form.appendChild(input1);
            	
            	// 폼 추가
            	document.body.appendChild(form);
    			form.submit();
            }
    </script> 
</body>
</html>