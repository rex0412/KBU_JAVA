<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO"%>
<%
String username = request.getParameter("username");
UserDAO userDAO = new UserDAO();
int result = userDAO.checkDuplicate(username);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토담(TO:DAM)</title>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	text-align: center;
	padding: 20px;
}

.success {
	color: green;
	font-weight: bold;
}

.fail {
	color: red;
	font-weight: bold;
}

button {
	padding: 5px 10px;
	cursor: pointer;
}
</style>
<script>
    function useId() {
        opener.document.joinForm.username.value = "<%=username%>";
		self.close();
	}
</script>
</head>
<body>
	<h3>아이디 중복 확인</h3>
	<p>
		입력하신 아이디: <strong><%=username%></strong>
	</p>
	<%
	if (result == 1) {
	%>
	<p class="fail">이미 사용 중인 아이디입니다.</p>
	<button onclick="self.close()">닫기</button>
	<%
	} else {
	%>
	<p class="success">사용 가능한 아이디입니다.</p>
	<button onclick="useId()">사용하기</button>
	<%
	}
	%>
</body>
</html>