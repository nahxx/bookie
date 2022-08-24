<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/default.css"/>"/>
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/admin/paging.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/admin/admin.css"/>" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Bookie</title>
</head>
<body>
	<!-- 헤더 부분 -->
	<header>
		<%@ include file="../incl/header.jsp"%>
	</header>
	<div class="second-header">
		${adminUser.name} <span>님 환영합니다.</span>
	</div>
	
	<!-- wrap 부분 -->
	<div id="wrap" class="wrap mh">
		<div class="side-menu">
			<div class="only-admin">
				<a href="<c:url value="/admin/admin_service" />">관리자 전용</a>
			</div>
			<ul class="menu-box">
				<li class="menu-item">
					<a href="<c:url value="/admin/admin_user/1" />">회원 관리</a>
				</li>
				<li class="menu-item on">
					<a href="<c:url value="/admin/admin_question/1" />">문제 관리</a>
				</li>
			</ul>
		</div>
		
		<!-- 문제 관리 메인 화면 -->
		<div class="main-box">
			<h3>문제관리</h3>
			<div class="cate-search">
				<select id="cLevel" name="cLevel">
					<option value="unknown">---학력 선택---</option>
					<option value="m">중학생</option>
					<option value="h">고등학생</option>
				</select>
				<select id="grade" name="grade">
					<option value="unknown">---학년 선택---</option>
					<option value="1">1학년</option>
					<option value="2">2학년</option>
					<option value="3">3학년</option>
				</select>
				<select id="subject" name="subject">
					<option value="unknown">---과목 선택---</option>
					<option value="국어">국어</option>
					<option value="영어">영어</option>
					<option value="수학">수학</option>
				</select>
				<button type="button" onclick="javascript:categorySelect('<c:url value="/admin/find_question/1" />');">검색</button>
			</div>
			<!-- 문제 관리 메인 화면 -->
			<table class="question-table">
				<c:if test="${paging.currentPageNo == 1}">
					<c:set var="boardNo" value="${1}" />
				</c:if>
				<c:if test="${paging.currentPageNo > 1}">
					<c:set var="boardNo" value="${(paging.currentPageNo - 1) * 10 + 1}" />
				</c:if>
				<tr>
					<th>No.</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>등록일자</th>
				</tr>
				<c:forEach var="qaqp" items="${qaqpList}">
					<tr>
						<td>${boardNo}</td>
						<td>
							<c:choose>
								<c:when test="${fn:contains(qaqp.getQuestion().getCategory().getCLevel(), 'm')}">
									중등 / 
								</c:when>
								<c:when test="${fn:contains(qaqp.getQuestion().getCategory().getCLevel(), 'h')}">
									고등 / 
								</c:when>
							</c:choose>
							${qaqp.question.category.grade}학년 / ${qaqp.question.category.subject}
						</td>
						<td>
							<a href="<c:url value="/admin/admin_question/${paging.currentPageNo}/${qaqp.question.getQId()}" />">${qaqp.spTitle}</a>
						</td>
						<td>
							<fmt:formatDate value="${qaqp.question.regDate}"  pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<c:set var="boardNo" value="${boardNo + 1}" />
					</tr>
				</c:forEach>
			</table>
			
			<!-- 페이징 -->
			<div class="paging">
		        <div class="paging-box">
		        	<ul class="inner-paging-wrap">
			          <c:choose>
			            <c:when test="${ paging.currentPageNo == '1' }">
			              <li><a style="color:#808080; disabled">◀</a></li>
			            </c:when>
			            <c:otherwise>
			              <li><a href="<c:url value='/admin/find_question/${paging.currentPageNo - 1}'/>">◀</a></li>
			            </c:otherwise>
			          </c:choose>
			          <c:forEach var="i" begin="${ paging.startPageNo }" end="${ paging.endPageNo }">
			            <li><a class="pageNo ${i}" href="<c:url value="/admin/find_question/${i}" />">${i}</a></li>
			          </c:forEach>
			          <c:choose>
			            <c:when test="${ paging.currentPageNo == paging.finalPageNo }">
			              <li><a style="color:#808080; disabled">▶</a></li>
			            </c:when>
			            <c:otherwise>
			              <li><a href="<c:url value='/admin/find_question/${paging.currentPageNo + 1}'/>">▶</a></li>
			            </c:otherwise>
			          </c:choose>
			        </ul>
		        </div>
		     </div>
		     
		     <div class="add-question">
				<button type="button" onclick="location.href='<c:url value="/question/add_question" />'">문제 등록</button>
			</div>
	     </div>
	</div>
	
	<!-- 푸터 부분 -->
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
	
	<!-- 스크립트 -->
	<script>
		// 컨트롤러 다녀올 때 check 표시
		<c:if test="${not empty cate}">
			let cLevel = document.querySelector('#cLevel');
			for(let i = 0; i < cLevel.length; i++) {
				if(cLevel.options[i].value == "${cate.getCLevel()}") {
					cLevel.options[i].selected = true;
					break;
				}
			}
			let grade = document.querySelector('#grade');
			for(let i = 0; i < grade.length; i++) {
				if(grade.options[i].value == "${cate.getGrade()}") {
					grade.options[i].selected = true;
					break;
				}
			}
			let subject = document.querySelector('#subject');
			for(let i = 0; i < subject.length; i++) {
				if(subject.options[i].value == "${cate.getSubject()}") {
					subject.options[i].selected = true;
					break;
				}
			}
		</c:if>
		
	    $(".pageNo").each(function() {
	      if ($(this).hasClass("${paging.currentPageNo}")) {
	        $(this).addClass("on");
	      } else {
	        $(this).removeClass("on");
	      }
	    });
    
	    function categorySelect(url) {
	    	// 검사
	    	let c1 = document.querySelector('#cLevel');
	    	let cLevel = c1.options[c1.selectedIndex].value;
	    	let c2 = document.querySelector('#grade');
   			let grade = c2.options[c2.selectedIndex].value;
   			let c3 = document.querySelector('#subject');
   			let subject = c3.options[c3.selectedIndex].value;
   			if(cLevel == "unknown" || grade == "unknown" || subject == "unknown") {
   				return alert("카테고리를 선택해주세요.");
   			}
   			
	    	
	    	// 폼 생성
			let form = document.createElement('form');
			form.setAttribute('method', 'post');
			form.setAttribute('action', url);
			document.charset = "UTF-8";
			
			// input1 추가 - cLevel
			let input1 = document.createElement('input');
   			input1.setAttribute('type', 'hidden');
   			input1.setAttribute('name', 'cLevel');
   			input1.setAttribute('value', cLevel);
   			form.appendChild(input1);
			
			// input2 추가 - grade
			let input2 = document.createElement('input');
   			input2.setAttribute('type', 'hidden');
   			input2.setAttribute('name', 'grade');
   			input2.setAttribute('value', grade);
   			form.appendChild(input2);
			
			// input3 추가 - subject
			let input3 = document.createElement('input');
   			input3.setAttribute('type', 'hidden');
   			input3.setAttribute('name', 'subject');
   			input3.setAttribute('value', subject);
   			form.appendChild(input3);
			
			// 폼 적용
			document.body.appendChild(form);
			form.submit();
	    }
  </script>
</body>
</html>