<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
<script
	src="<c:url value='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js'/>"></script>
<script src="<c:url value="/resources/js/countup.js"/>"></script>
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
	<div class="wrap mh">
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
			<c:forEach var="qCountList" items="${qCountList}" varStatus="status">
				<div class="counters">
					<span class="count">${qCountList}</span>
					<h4>${queList[status.index]}</h4>
				</div>
			</c:forEach>
		</div>
		<div class="container content">
			<div class="user contents">
				<div class="headline">
					<h2>
						<a href="/">유저 랭킹</a>
					</h2>
				</div>
				<div class="user table-wrap">
					<table class="user inner-table">
						<thead>
							<tr>
								<th>이름</th>
								<th>정답률</th>
								<th>맞춘 개수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="ranking" items="${rankig}" begin="0" end="4">
								<tr>
									<td>${ranking.uName}</td>
									<td>${ranking.percent}%</td>
									<td>${ranking.total}</td>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="qna contents">
				<div class="headline">
					<h2>
						<a href="/">새로운 질문</a>
					</h2>
				</div>
				<div class="qna table-wrap">
					<table class="qna inner-table">
						<thead>
							<tr>
								<th>학력/과목</th>
								<th>질문 제목</th>
								<th>질문 유저</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="qnaList" items="${qnaList}" begin="0" end="4">
								<a href="/bookie/qna_board/1">
									<tr>
										<td><c:if
												test="${fn:contains(qnaList.getCategory().getCLevel(), 'm')}">
                  								중등 /
                							</c:if> <c:if
												test="${fn:contains(qnaList.getCategory().getCLevel(), 'h')}">
                  								고등 /
                							</c:if> ${qnaList.getCategory().getSubject()}</td>
										<td>${qnaList.subject}</td>
										<td>${qnaList.getUser().getName()}</td>
									</tr>
								</a>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="answer contents">
				<div class="headline">
					<h2>
						<a href="/">새로운 답변</a>
					</h2>
				</div>
				<div class="answer table-wrap">
					<table class="answer inner-table">
						<thead>
							<tr>
								<th>질문 번호</th>
								<th>질문 내용</th>
								<th>답변 유저</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="answerList" items="${answerList}" begin="0"
								end="4">
								<a href="/bookie/answer/${answerList.qna.qnaId}/1">
									<tr>
										<td>${answerList.qna.qnaId}</td>
										<td>${answerList.document}</td>
										<td>${answerList.getUser().getName()}</td>
									</tr>
								</a>
							</c:forEach>
						</tbody>
					</table>
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
			loop : true,
			effect : 'slide',
			autoplay : {
				delay : 3000,
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
