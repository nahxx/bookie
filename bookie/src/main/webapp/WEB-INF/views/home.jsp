<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>bookie</title>
<link rel="stylesheet"
	href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/home/home.css"/>" />
</head>

<body>
	<div id="wrap">
		<header>
			<c:if test="${session eq 'no'}">
				<%@ include file="./incl/no_login_header.jsp"%>
			</c:if>
			<c:if test="${session eq 'yes'}">
				<%@ include file="./incl/header.jsp"%>
			</c:if>

		</header>
		<!-- 메인 배너 -->
		<div class="swiper">
			<div class="swiper-wrapper">
				<div class="swiper-slide mainbanner"></div>
				<div class="swiper-slide mainbanner"></div>
				<div class="swiper-slide mainbanner"></div>
			</div>
			<div class="swiper-button slick-arrow next"></div>
			<div class="swiper-button num"></div>
			<div class="swiper-button slick-arrow prev"></div>

		</div>
		<!-- 컨텐츠 영역 -->
		<div class="container counts">
			<div class="count">
				<span class="counter">12345</span>
				<h4>전체 문제</h4>
			</div>
			<div class="count">
				<span class="counter">12345</span>
				<h4>전체 문제</h4>
			</div>
			<div class="count">
				<span class="counter">12345</span>
				<h4>전체 문제</h4>
			</div>
			<div class="count">
				<span class="counter">12345</span>
				<h4>전체 문제</h4>
			</div>
		</div>
		<div class="container content">
			<div class="qna contents">
				<div class="headline">
					<h2>
						<a href="/">새로운 QNA</a>
					</h2>
				</div>
				<div class="qna inner">
					<ul>
						<li><a href="/">
								<div class="article-username">username</div>
								<div class="article-subject">subject</div>
								<div class="article-text">text</div>
						</a></li>
					</ul>
				</div>
				<div class="qna inner">
					<ul>
						<li><a href="/">
								<div class="article-username">username</div>
								<div class="article-subject">subject</div>
								<div class="article-text">text</div>
						</a></li>
					</ul>
				</div>
			</div>
			<div class="question contents">
				<div class="headline">
					<h2>
						<a href="/">추가된 문제</a>
					</h2>
				</div>
				<div class="question inner">
					<ul>
						<li><a href="/">
								<div class="article-level">고1</div>
								<div class="article-subject">subject</div>
								<div class="article-text">text</div>
						</a></li>
					</ul>
				</div>
				<div class="question inner">
					<ul>
						<li><a href="/">
								<div class="article-level">고1</div>
								<div class="article-subject">subject</div>
								<div class="article-text">text</div>
						</a></li>
					</ul>
				</div>
			</div>
			<div class="ranking contents">
				<div class="headline">
					<h2>
						<a href="/">문제 순위</a>
					</h2>
				</div>
				<div class="ranking inner">
					<ul>
						<li><a href="/">
								<div class="rank-num">1</div>
								<div class="article-subject">subject</div>
								<div class="article-text">text</div>
						</a></li>
					</ul>
				</div>
				<div class="ranking inner">
					<ul>
						<li><a href="/">
								<div class="rank-num">1</div>
								<div class="article-subject">subject</div>
								<div class="article-text">text</div>
						</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!--푸터 영역 -->
	<footer id="footer">
		<%@ include file="./incl/footer.jsp"%>
	</footer>
</body>
</html>
