<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>bookie</title>
<link rel="stylesheet"
	href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/home/home.css"/>" />
<link rel="stylesheet"
	href="<c:url value="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"/>" />
</head>
<body>
	<header>
		<c:if test="${session eq 'no'}">
			<%@ include file="./incl/no_login_header.jsp"%>
		</c:if>
		<c:if test="${session eq 'yes'}">
			<%@ include file="./incl/header.jsp"%>
		</c:if>
	</header>
	<div id="wrap mh">
		<!-- 메인 배너 -->
		<div class="swiper mySwiper">
			<div class="swiper-wrapper swiper-wrap">
				<div class="swiper-slide">
					<img src="/bookie/resources/img/swiper/swiper01.jpeg"
						id="mainImage" alt="slide" />
				</div>
				<div class="swiper-slide">
					<img src="/bookie/resources/img/swiper/swiper02.jpeg"
						id="mainImage" alt="slide" />
				</div>
				<div class="swiper-slide">
					<img src="/bookie/resources/img/swiper/swiper03.jpeg"
						id="mainImage" alt="slide" />
				</div>
			</div>
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
			<div class="swiper-pagination"></div>
		</div>
		<!-- 컨텐츠 영역 -->
		<div class="container counts">
			<div class="count">
				<span class="counter">12345</span>
				<h4>전체 문제</h4>
			</div>
			<div class="count">
				<span class="counter">12345</span>
				<h4>국어</h4>
			</div>
			<div class="count">
				<span class="counter">12345</span>
				<h4>영어</h4>
			</div>
			<div class="count">
				<span class="counter">12345</span>
				<h4>수학</h4>
			</div>
		</div>
		<div class="container content">
			<div class="qna contents">
				<div class="headline">
					<h2>
						<a href="/">유저 랭킹</a>
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
			</div>
			<div class="question contents">
				<div class="headline">
					<h2>
						<a href="/">새로운 질문</a>
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
			</div>
			<div class="ranking contents">
				<div class="headline">
					<h2>
						<a href="/">새로운 답변</a>
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

			</div>
		</div>
	</div>
	<!--푸터 영역 -->
	<footer id="footer">
		<%@ include file="./incl/footer.jsp"%>
	</footer>
	<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
	<script>
		var swiper = new Swiper(".mySwiper", {
			loop: true,
			effect: 'slide',
			autoplay: {
				delay: 3000,
			},
			pagination : {
				el : ".swiper-pagination",
				type : "fraction",
			},
			navigation : {
				nextEl : ".swiper-button-next",
				prevEl : ".swiper-button-prev",
			},
		});

	</script>
</body>
</html>
