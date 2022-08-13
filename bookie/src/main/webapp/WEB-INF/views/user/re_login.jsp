<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>bookie</title>
<link rel="stylesheet"
	href="<c:url value="/resources/css/default.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/user/login.css"/>" />
</head>
<body>
	<header>
		<%@ include file="../incl/no_login_header.jsp"%>
	</header>
	<section>
		<div class="container">
			<div class="title-wrap">
				<h3 class="title">로그인</h3>
			</div>
			<div id="content-wrapper">
				<div class="content">
					<form action="login" method="post">
						<input name="userId" placeholder="이메일" /> <br> <input
							name="passwd" placeholder="비밀번호" /> <br>
						<div class="content re_login">
							<span class="re_login_txt">* 아이디나 비밀번호가 잘못되었습니다. 다시입력해주세요.</span>
						</div>
						<input class="btn" type="submit" value="로그인" />
					</form>
				</div>
			</div>
		</div>
	</section>
</body>
</html>