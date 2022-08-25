<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
</head>
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/qna/table.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/qna/paging.css"/>" />

<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<style>
:root {
	--sig-color : #607EAA;
	--border-color : #d9d9d9;
	--font-family : 'Noto Sans KR', sans-serif;
}

.table-wrap {
   width: 100%;
   height: calc( 100% - 100px );
   display: flex;
   justify-content: center;
   align-items: center;
   flex-direction: column;
   margin-top: 90px;
   font-family : var(--font-family);
}

.inner-table {
   width: 80%;
   height: 80%;
   border: 0 solid var(--border-color );
   border-collapse: collapse;
   margin: 0 auto;
   text-align: center;
   font-family : var(--font-family);
}

.inner-table thead {
	background-color: var(--sig-color);
	color: white;
}

.inner-table th, .inner-table td {
	border-top: 1px solid var(--border-color );
	border-bottom: 1px solid var(--border-color );
	border-left: 0 solid var(--border-color );
	border-right: 0 solid var(--border-color );
	padding: 10px 0;
}

.inner-table th:first-child,
.inner-table td:first-child {
	border-left: 0;
}

.inner-table th:last-child,
.inner-table td:last-child {
	border-right: 0;
}

.inner-table th:nth-child(1), .inner-table tbody tr td:nth-child(1) {
	width: 5%;
	font-weight: 400;
}

.inner-table th:nth-child(2), .inner-table tbody tr td:nth-child(2) {
	width: 20%;
	font-weight: 400;
}

.inner-table th:nth-child(3), .inner-table tbody tr td:nth-child(3) {
	width: 45%;
	font-weight: 400;
}

.inner-table tbody tr td:nth-child(3) {
	text-align: left;
}

.inner-table th:nth-child(4), .inner-table tbody tr td:nth-child(4) {
	width: 15%;
	font-weight: 400;
}
.inner-table th:nth-child(5), .inner-table tbody tr td:nth-child(5) {
	width: 10%;
	font-weight: 400;
}
.inner-table th:nth-child(6), .inner-table tbody tr td:nth-child(6) {
	width: 5%;
	font-weight: 400;
}

.write-btn {
   width: 80%;
   height: auto;
}
.in-btn{
   float: right;
   width: 80px;
   height: auto;
   font-weight: bold;
   text-align : center;
   border : 2px solid #607EAA;
   background: #607EAA;
   color: white;
   font-weight: 300;
   padding: 5px 5px;
   border-radius : 5px;
   font-family : var(--font-family);
}
</style>
<body>
  <header>
    <c:if test="${session eq 'no'}">
      <%@ include file="../incl/no_login_header.jsp"%>
    </c:if>
    <c:if test="${session eq 'yes'}">
      <%@ include file="../incl/header.jsp"%>
    </c:if>
  </header>
  <div class="mh">
    <div class="title-wrap">
      <h3 class="title">묻고답하기</h3>
    </div>
    <div class="table-wrap">
      <table class="inner-table">
        <c:set var="boardNo" value="${paging.totalCount - (paging.currentPageNo - 1) * paging.pageSize }" />
        <thead>
          <tr>
            <th>번호</th>
            <th>카테고리</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="board" items="${boardList}">
            <tr>
              <td>${boardNo}</td>
              <td>
                <c:if test="${fn:contains(board.category.getCLevel(), 'm')}">
                  중등 /
                </c:if>
                <c:if test="${fn:contains(board.category.getCLevel(), 'h')}">
                  고등 /
                </c:if>
                ${board.category.getGrade()}학년 / ${board.category.getSubject()}
              </td>
              <td><a href="<c:url value='/answer/${board.qnaId}/${paging.currentPageNo}'/>">
              ${board.subject} 
               <c:if test="${board.answerCount ne '0'}">
              	<b style="color:#1C3879;">(${board.answerCount})</b> 
              </c:if>
              </a></td>
              <td>
               <c:choose>
                  <c:when test="${uId eq board.user.getUId()}">
                    ${board.user.name}
                  </c:when>
              		<c:when test="${fn:contains(manager, 'Y')}">
                    ${board.user.name}
                  </c:when>
                  <c:when test="${fn:contains(board.user.getManager(), 'Y')}">
                    ${board.user.name}
                  </c:when>
                  <c:otherwise>
                    <c:forEach var="i" begin="1" end="${fn:length(board.user.name)}">
                      <c:choose>
                        <c:when test="${ i == '1' }">
                          ${fn:substring(board.user.name,0,1)}
                        </c:when>

                        <c:when test="${ i == fn:length(board.user.name)}">
                          ${fn:substring(board.user.name,fn:length(board.user.name) - 1,fn:length(board.user.name))}
                        </c:when>
                        <c:otherwise>
                          *
                        </c:otherwise>
                      </c:choose>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm:ss" />
              </td>
              <td>${board.qcCount}</td>
              <c:set var="boardNo" value="${boardNo - 1}" />
            </tr>
          </c:forEach>

        </tbody>
      </table>
      <div class="paging">
        <ul class="inner-paging-wrap">
          <c:choose>
            <c:when test="${ paging.currentPageNo == '1' }">
              <li><a style="color:#808080; disabled">◀</a></li>
            </c:when>
            <c:otherwise>
              <li><a href="<c:url value='/qna_board/${paging.currentPageNo - 1}'/>">◀</a></li>
            </c:otherwise>
          </c:choose>
          <c:forEach var="i" begin="${ paging.startPageNo }" end="${ paging.endPageNo }">
            <li><a class="pageNo ${i}" href="<c:url value="/qna_board/${i}" />">${i}</a></li>
          </c:forEach>
          <c:choose>
            <c:when test="${ paging.currentPageNo == paging.finalPageNo }">
              <li><a style="color:#808080; disabled">▶</a></li>
            </c:when>
            <c:otherwise>
              <li><a href="<c:url value='/qna_board/${paging.currentPageNo + 1}'/>">▶</a></li>
            </c:otherwise>
          </c:choose>
        </ul>
      </div>
      <div class="write-btn">
        <a href="<c:url value='/qna_write/${paging.currentPageNo}'/>" class="in-btn">글쓰기</a>
      </div>
    </div>
  </div>
  <footer id="footer">
    <%@ include file="../incl/footer.jsp"%>
  </footer>
  <script>
    $(".pageNo").each(function() {
      if ($(this).hasClass("${paging.currentPageNo}")) {
        $(this).addClass("on");
      } else {
        $(this).removeClass("on");
      }
    });
  </script>
</body>

</html>