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
<link rel="stylesheet" href="<c:url value="/resources/css/admin/admin.css"/>" />
<!-- 구글 차트 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
				<a href="<c:url value="admin_service" />">관리자 전용</a>
			</div>
			<ul class="menu-box">
				<li class="menu-item">
					<a href="<c:url value="admin_user/1" />">회원 관리</a>
				</li>
				<li class="menu-item">
					<a href="<c:url value="admin_question/1" />">문제 관리</a>
				</li>
			</ul>
		</div>
		
		<!-- 메인 화면 -->
		<div class="main">
			<h3>일주일간 회원가입 추이</h3>
			<div class="user-flex">
				<div class="user-chart">
					<div id="linechart-section"></div>
				</div>
			</div>
			<h3>학년/과목별 문제등록 현황</h3>
			<div class="question-flex">
				<div class="question-chart">
					<p>등록된 문제수</p>
					<div id="barchart-section"></div>
				</div>
				<div class="today-qhistory">
					<p>오늘의 문제풀이 카운트</p>
					<p class="count"><span>${todayQHistory}</span>회</p>
				</div>
			</div>
		</div>
	</div>
	<!-- 푸터 부분 -->
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
	
	<!-- 스크립트 부분 -->
	<script>
		google.charts.load('current', {'packages' : [ 'bar', 'corechart' ] });
		google.charts.setOnLoadCallback(drawChart);
		
		let cntList = new Array();
		<c:forEach var="cnt" items="${cntList}">
			cntList.push("${cnt.grade}");
			cntList.push(${cnt.kor});
			cntList.push(${cnt.eng});
			cntList.push(${cnt.math});
		</c:forEach>
		
		let userCntList = new Array();
		<c:forEach var="cnt" items="${userCntList}">
			userCntList.push("${cnt.day}");
			userCntList.push(${cnt.userCnt});
		</c:forEach>
		
		function drawChart() {
			// 학년/과목별 등록된 문제수
			var data = new google.visualization.DataTable();
			data.addColumn('string', '학년');
			data.addColumn('number', '국어');
			data.addColumn('number', '영어');
			data.addColumn('number', '수학');
			
			for(let i = 0; i < cntList.length; i++) {
				data.addRow([cntList[i], cntList[++i], cntList[++i], cntList[++i]]);
			}
			
			var options = {
				series: {
					0: {color: '#A66CFF'},
					1: {color: '#9C9EFE'},
					2: {color: '#B1E1FF'}
				}
			};
			
			var chart = new google.charts.Bar(document.getElementById('barchart-section'));
			chart.draw(data, google.charts.Bar.convertOptions(options));
			
			// 일주일간 회원가입자 수
			var data = new google.visualization.DataTable();
			data.addColumn('string', 'days');
			data.addColumn('number', '가입자수');
			
			for(let i = 0; i < userCntList.length; i++) {
				data.addRow([userCntList[i], userCntList[++i]]);
			}
			
			var options = {
				colors: ['#0096FF']
			};
			
			var chart = new google.visualization.LineChart(document.getElementById('linechart-section'));
	        chart.draw(data, options);
		}
	</script>
</body>
</html>