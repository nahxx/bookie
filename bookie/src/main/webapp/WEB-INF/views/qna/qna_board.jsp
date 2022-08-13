<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
	<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<body>
<div id="grid"></div>
<div class="paging">
<c:forEach var="i" begin="${ paging.startPageNo }" end="${ paging.endPageNo }">
	<li><a href="<c:url value="/qna_board/${i}"/>">${i}</a></li>
</c:forEach>
</div>
<!-- 
<div class="pager">
    <ul>
        <c:if test="${ curPageNum > 5 && !empty kwd }">
            <li><a href="/mysite/board?page=${ blockStartNum - 1 }&kwd=${ kwd }">◀</a></li>
        </c:if>
        
        <c:if test="${ curPageNum > 5 }">
            <li><a href="/mysite/board?page=${ blockStartNum - 1 }">◀</a></li>
        </c:if>
        
        <c:forEach var="i" begin="${ blockStartNum }" end="${ blockLastNum }">
            <c:choose>
                <c:when test="${ i > lastPageNum }">
                    <li>${ i }</li>
                </c:when>
                <c:when test="${ i == curPageNum }">
                    <li class="selected">${ i }</li>
                </c:when>
                <c:when test="${ !empty kwd}">
                    <li><a href="/mysite/board?a=search&page=${ i }&kwd=${ kwd }">${ i }</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="/mysite/board?page=${ i }">${ i }</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        
        <c:if test="${ lastPageNum > blockLastNum && !empty kwd }">
            <li><a href="/mysite/board?a=search&page=${ blockLastNum + 1 }&kwd=${ kwd }">▶</a></li>
        </c:if>
        
        <c:if test="${ lastPageNum > blockLastNum }">
            <li><a href="/mysite/board?page=${ blockLastNum + 1 }">▶</a></li>
        </c:if>
    </ul>
</div>
 --> 
<script>
        // GRID 를 생성한다.
        // 나이는 수정할 수 있도록 설정한다.
		var grid = new tui.Grid( {
			el: document.getElementById('grid'),
			columns: [
				{
					header: '이름',
					name: 'name'
				},
				{
					header: '나이',
					name: 'value',
					editor: 'text'
				}
			]
		} );

        // GRID 에 데이터를 입력한다.
		var arrData = [
			{
				name: '홍길동',
				value: '20세'
			},
			{
				name: '이지연',
				value: '26세'
			}
		];

		grid.resetData( arrData );

	</script>
</body>
</html>