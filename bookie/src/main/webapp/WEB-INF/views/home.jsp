<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bookie</title>
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
		<div class="container counts">
			<c:forEach var="qCountList" items="${qCountList}" varStatus="status">
				<div class="counters">
					<span class="count">${qCountList}</span>
					<h4>${queList[status.index]}</h4>
				</div>
			</c:forEach>
		</div>
		<!-- 컨텐츠 영역 -->
		<div class="container main_gallery">
			<div class="main_schedule" id="proMainMonthArea">
				<h2 class="main_section_title">이달의 교재·강좌·입시설명회</h2>
				<div class="main_gallery_list slider">
					<div class="main_gallery_item">
						<a
							href="https://promotion.ebsi.co.kr/goPromotion.do?promotion_cd=hsp.main.g3-month.1.1">
							<div class="main_gallery_thumb img_fit">
								<img src="<c:url value="/resources/img/gallery/1.jpeg"/>">
							</div>
							<div class="main_gallery_text">
								<div class="main_gallery_subject">입시</div>
								<div class="main_gallery_headline">
									[2022 최신 입결]<br>서울대학교 수시 등급컷
								</div>
							</div>
						</a>
					</div>
					<div class="main_gallery_item">
						<a
							href="https://promotion.ebsi.co.kr/goPromotion.do?promotion_cd=hsp.main.g3-month.1.2">
							<div class="main_gallery_thumb img_fit">
								<img src="<c:url value="/resources/img/gallery/2.jpeg"/>">
							</div>
							<div class="main_gallery_text">
								<div class="main_gallery_subject">교재</div>
								<div class="main_gallery_headline">
									수능대비 연계교재<br>필수 기본서 2023 수능특강
								</div>
							</div>
						</a>
					</div>
					<div class="main_gallery_item">
						<a
							ref="https://promotion.ebsi.co.kr/goPromotion.do?promotion_cd=hsp.main.g3-month.1.3">
							<div class="main_gallery_thumb img_fit">
								<img src="<c:url value="/resources/img/gallery/3.jpeg"/>">
							</div>
							<div class="main_gallery_text">
								<div class="main_gallery_subject">입시</div>
								<div class="main_gallery_headline">
									[2023 대입]<br>수능 D-3개월 시기별 학습전략
								</div>
							</div>
						</a>
					</div>
					<div class="main_gallery_item">
						<a
							href="https://promotion.ebsi.co.kr/goPromotion.do?promotion_cd=hsp.main.g3-month.1.4">
							<div class="main_gallery_thumb img_fit">
								<img src="<c:url value="/resources/img/gallery/4.jpeg"/>">
							</div>
							<div class="main_gallery_text">
								<div class="main_gallery_subject">교재</div>
								<div class="main_gallery_headline">
									수능연계 필수학습<br>완벽한 수능비책 2023 수능완성
								</div>
							</div>
						</a>
					</div>
					<div class="main_gallery_item">
						<a
							href="https://promotion.ebsi.co.kr/goPromotion.do?promotion_cd=hsp.main.g3-month.1.5">
							<div class="main_gallery_thumb img_fit">
								<img src="<c:url value="/resources/img/gallery/5.jpeg"/>">
							</div>
							<div class="main_gallery_text">
								<div class="main_gallery_subject">입시</div>
								<div class="main_gallery_headline">
									[2023 수시]<br>성공적 수시 위한 N수생 필수확인사항
								</div>
							</div>
						</a>
					</div>

				</div>
			</div>
		</div>
		<div class="container content">
			<div class="user contents">
				<div class="headline">
					<h2>유저 랭킹</h2>
				</div>
				<div class="user table-wrap">
					<table class="user inner-table">
						<thead>
							<tr>
								<th>이름</th>
								<th>정답률</th>
								<th>정답 수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="ranking" items="${rankig}" begin="0" end="4">
								<tr>
									<td><c:choose>
											<c:when test="${uId eq checkUId}">
                    						${ranking.uName}
                  							</c:when>
											<c:when test="${fn:contains(manager, 'Y')}">
						                    ${ranking.uName}
						                  </c:when>
											<c:when test="${fn:contains(ranking.uManager, 'Y')}">
							                 ${ranking.uName}
							              </c:when>
											<c:otherwise>
												<c:forEach var="i" begin="1"
													end="${fn:length(ranking.uName)}">
													<c:choose>
														<c:when test="${ i == '1' }">
                          								${fn:substring(ranking.uName,0,1)}
                        								</c:when>
														<c:when test="${ i == fn:length(ranking.uName)}">
                         								${fn:substring(ranking.uName,fn:length(ranking.uName) - 1,fn:length(ranking.uName))}
                        								</c:when>
														<c:otherwise>*</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:otherwise>
										</c:choose></td>
									<td>${ranking.percent}%</td>
									<td>${ranking.total}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="qna contents">
				<div class="headline">
					<h2>새로운 질문</h2>
				</div>
				<div class="qna table-wrap">
					<table class="qna inner-table">
						<thead>
							<tr>
								<th>학력/과목</th>
								<th>제목</th>
								<th>작성자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="qnaList" items="${qnaList}" begin="0" end="4">
								<tr
									onClick="location.href='/bookie/answer/${qnaList.qnaId}/${paging.currentPageNo + 1}'"
									style="cursor: pointer;">
									<td><c:if
											test="${fn:contains(qnaList.getCategory().getCLevel(), 'm')}">
                  								중등 /
                							</c:if> <c:if
											test="${fn:contains(qnaList.getCategory().getCLevel(), 'h')}">
                  								고등 /
                							</c:if> ${qnaList.getCategory().getSubject()}</td>
									<td>${qnaList.subject}</td>
									<td><c:choose>
											<c:when test="${uId eq qnaList.getUser().getUId()}">
						                    ${qnaList.getUser().getName()}
						                  </c:when>
											<c:when test="${fn:contains(manager, 'Y')}">
						                    ${qnaList.getUser().getName()}
						                  </c:when>
											<c:when
												test="${fn:contains(qnaList.getUser().getManager(), 'Y')}">
							                 ${qnaList.getUser().getName()}
							              </c:when>
											<c:otherwise>
												<c:forEach var="i" begin="1"
													end="${fn:length(qnaList.getUser().getName())}">
													<c:choose>
														<c:when test="${ i == '1' }">
                          								${fn:substring(qnaList.getUser().getName(),0,1)}
                        								</c:when>
														<c:when
															test="${ i == fn:length(qnaList.getUser().getName())}">
                         								${fn:substring(qnaList.getUser().getName(),fn:length(qnaList.getUser().getName()) - 1,fn:length(qnaList.getUser().getName()))}
                        								</c:when>
														<c:otherwise>*</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="answer contents">
				<div class="headline">
					<h2>새로운 답변</h2>
				</div>
				<div class="answer table-wrap">
					<table class="answer inner-table">
						<thead>
							<tr>
								<th>번호</th>
								<th>내용</th>
								<th>작성자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="answerList" items="${answerList}" begin="0"
								end="4">
								<tr
									onClick="location.href='/bookie/answer/${answerList.qna.qnaId}/${paging.currentPageNo + 1}'"
									style="cursor: pointer;">
									<td>${answerList.qna.qnaId}</td>
									<td>${answerList.document}</td>
									<td><c:choose>
											<c:when test="${uId eq answerList.getUser().getUId()}">
						                    ${answerList.getUser().getName()}
						                  </c:when>
											<c:when test="${fn:contains(manager, 'Y')}">
						                    	${answerList.getUser().getName()}
						                  	</c:when>
											<c:when
												test="${fn:contains(answerList.getUser().getManager(), 'Y')}">
							                    ${answerList.getUser().getName()}
							                </c:when>
											<c:otherwise>
												<c:forEach var="i" begin="1"
													end="${fn:length(answerList.getUser().getName())}">
													<c:choose>
														<c:when test="${ i == '1' }">
                          								${fn:substring(answerList.getUser().getName(),0,1)}
                        								</c:when>
														<c:when
															test="${ i == fn:length(answerList.getUser().getName())}">
                         								${fn:substring(answerList.getUser().getName(),fn:length(answerList.getUser().getName()) - 1,fn:length(answerList.getUser().getName()))}
                        								</c:when>
														<c:otherwise>*</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:otherwise>
										</c:choose></td>
								</tr>
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
