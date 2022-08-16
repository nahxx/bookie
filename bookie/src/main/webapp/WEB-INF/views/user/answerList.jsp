<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bookie</title>
</head>
<body>
	<header>
		<c:if test="${session eq 'no'}">
			<%@ include file="../incl/no_login_header.jsp"%>
		</c:if>
		<c:if test="${session eq 'yes'}">
			<%@ include file="../incl/header.jsp"%>
		</c:if>
	</header>
	<div class="wrap">
		<div class="title-wrap">
			<h3 class="title">나의 질문 리스트
			</h3>
		</div>
		<div class="rezInfo">
			<c:forEach var="voucher" items="${voucherList}">
				<table>
					<tbody>
						<tr>
							<th>구매한 주차권</th>
							<td><c:if test="${voucher.vType eq 'A'}">
								${voucher.buyTime}시간 주차권
							</c:if> <c:if test="${voucher.vType eq 'B'}">
								종일권
							</c:if> <c:if test="${voucher.vType eq 'C'}">
								정기권
							</c:if></td>
						</tr>
						<tr>
							<th>구매한 시간</th>
							<td>${voucher.regDate}</td>
						</tr>
						<tr>
							<th>사용유무</th>
							<td><c:if test="${voucher.vuse eq 'N'}">
									사용가능
								</c:if> <c:if test="${voucher.vuse eq 'Y'}">
									사용완료
								</c:if></td>
						</tr>
					</tbody>
				</table>
			</c:forEach>
		</div>
	</div>
	<footer>
		<%@ include file="../incl/footer.jsp"%>
	</footer>
</body>
</html>