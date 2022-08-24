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
		<div class="question-chart">
			<div id="barchart-section" style="width: 800px; height: 500px;"></div>
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
		
		function drawChart() {
			// 학년/과목별 등록된 문제수
			var data = new google.visualization.DataTable();
			data.addColumn('string', '학년');
			data.addColumn('number', '국어');
			data.addColumn('number', '영어');
			data.addColumn('number', '수학');
			
			
			var options = {
				series: {
					0: {color: '#A66CFF'},
					1: {color: '#9C9EFE'},
					2: {color: '#B1E1FF'}
				}
			};
			
			var chart = new google.charts.Bar(document.getElementById('barchart-section'));
			chart.draw(data, google.charts.Bar.convertOptions(options));
		}
	</script>
</body>
</html>