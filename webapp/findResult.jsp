<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String findResult = (String) request.getAttribute("findResult");
String mode = (String) request.getAttribute("mode");
if (findResult == null) {
	response.sendRedirect("findUser.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<style>
.result-wrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 60vh;
	background-color: #f9f9f9;
	padding: 20px;
}

.result-card {
	background-color: #fff;
	width: 100%;
	max-width: 400px;
	padding: 50px 30px;
	border-radius: 8px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.icon-area {
	margin-bottom: 20px;
	font-size: 3rem;
}

.result-title {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 1.3rem;
	font-weight: 600;
	color: #333;
	margin-bottom: 30px;
}

.result-box {
	background-color: #F8F9FA;
	border: 1px solid #E0E0E0;
	border-radius: 4px;
	padding: 20px;
	margin-bottom: 30px;
}

.result-text {
	color: #D32F2F;
	font-size: 1.5rem;
	font-weight: 700;
	letter-spacing: 1px;
}

.btn-go-login {
	display: block;
	width: 100%;
	padding: 15px 0;
	background-color: var(--text-title);
	color: #fff;
	border: none;
	border-radius: 4px;
	font-size: 1.1rem;
	font-weight: 500;
	cursor: pointer;
	transition: background-color 0.3s;
	text-decoration: none;
}

.btn-go-login:hover {
	background-color: var(--accent-color);
	color: #fff;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<jsp:include page="menu.jsp" />
	<div class="result-wrapper">
		<div class="result-card">
			<%
			if ("pw".equals(mode)) {
			%>
			<div class="icon-area">🔓</div>
			<div class="result-title">비밀번호를 찾았습니다.</div>
			<%
			} else {
			%>
			<div class="result-title">회원님의 아이디를 찾았습니다.</div>
			<%
			}
			%>
			<div class="result-box">
				<span class="result-text"><%=findResult%></span>
			</div>
			<a href="login.jsp" class="btn-go-login">로그인 하러가기</a>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>