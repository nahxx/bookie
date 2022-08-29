<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bookie</title>
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/user/qnaList.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/qna/paging.css"/>" />

</head>
<body>
	<header>
		<%@ include file="../incl/header.jsp"%>
	</header>
	<div class="wrap mh">
		<div class="title-wrap">
			<h3 class="title">나의 답변 리스트</h3>
		</div>
		<div class="table-wrap">
			<table class="inner-table">
				<c:set var="boardNo" value="${paging.totalCount - (paging.currentPageNo - 1) * paging.pageSize }" />
				<thead>
					<tr>
						<th>번호</th>
						<th>질문(QNA) 제목</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="answerList" items="${answerList}">
						<tr>
							<td>${boardNo}</td>
							<td><a href="<c:url value='/answer/ma${answerList.qna.qnaId}/${ paging.currentPageNo}'/>">${answerList.qna.subject}</a></td>
							<td><fmt:formatDate value="${answerList.regDate}" pattern="yyyy-MM-dd"/></td>
							<c:set var="boardNo" value="${boardNo - 1}" />
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
			<div class="paging">
		<ul class="inner-paging-wrap">
			<c:choose>
				<c:when test="${ paging.currentPageNo == '1' }">
					<li><a style="color: #808080;">◀</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="<c:url value='/user/answerList/${paging.currentPageNo - 1}'/>">◀</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${ paging.startPageNo }" end="${ paging.endPageNo }">
				<li><a class="pageNo ${i}" href="<c:url value="/qna_board/${i}"/>">${i}</a></li>
			</c:forEach>
			<c:choose>
				<c:when test="${ paging.currentPageNo == paging.finalPageNo }">
					<li><a style="color: #808080;">▶</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="<c:url value='/user/answerList/${paging.currentPageNo + 1}'/>">▶</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
	</div>
	<script>
		$(".pageNo").each(function() {
			if ($(this).hasClass("${paging.currentPageNo}")) {
				$(this).addClass("on");
			} else {
				$(this).removeClass("on");
			}
		});
	</script>
	<footer id="footer">
		<%@ include file="../incl/footer.jsp"%>
	</footer>
</body>
</html>