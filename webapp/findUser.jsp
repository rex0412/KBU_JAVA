<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String mode = request.getParameter("mode");
if (mode == null)
	mode = "id";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<style>
/* ... 기존 스타일 그대로 유지 ... */
.find-container {
	max-width: 500px;
	margin: 50px auto;
	padding: 20px;
	border: 1px solid #ddd;
	background-color: #fff;
}

.tabs {
	display: flex;
	margin-bottom: 20px;
	border-bottom: 2px solid var(--line-color);
}

.tab {
	flex: 1;
	padding: 15px;
	text-align: center;
	cursor: pointer;
	font-weight: bold;
	color: #999;
}

.tab.active {
	color: var(--text-title);
	border-bottom: 2px solid var(--text-title);
	margin-bottom: -2px;
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: 500;
}

.form-group input {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
}

.btn-find {
	width: 100%;
	padding: 12px;
	background-color: var(--text-title);
	color: white;
	border: none;
	cursor: pointer;
	margin-top: 10px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<jsp:include page="menu.jsp" />

	<div class="find-container">
		<div class="tabs">
			<div class="tab <%="id".equals(mode) ? "active" : ""%>"
				onclick="location.href='findUser.jsp?mode=id'">아이디 찾기</div>
			<div class="tab <%="pw".equals(mode) ? "active" : ""%>"
				onclick="location.href='findUser.jsp?mode=pw'">비밀번호 찾기</div>
		</div>
		
		<%
		if ("id".equals(mode)) {
		%>
		<form action="findUserAction.jsp" method="post">
			<input type="hidden" name="mode" value="id">
			<div class="form-group">
				<label>이름</label> <input type="text" name="name" required>
			</div>
			<div class="form-group">
				<label>휴대전화</label>
				<div style="display: flex; align-items: center; gap: 5px;">
					<input type="text" name="phone1" maxlength="3" value="010"
						style="width: 25%; text-align: center;"> <span>-</span> <input
						type="text" name="phone2" maxlength="4" required
						style="width: 30%; text-align: center;"> <span>-</span> <input
						type="text" name="phone3" maxlength="4" required
						style="width: 30%; text-align: center;">
				</div>
			</div>
			<button type="submit" class="btn-find">아이디 찾기</button>
		</form>
		<%
		}
		%>
		
		<%
		if ("pw".equals(mode)) {
		%>
		<form action="findUserAction.jsp" method="post">
			<input type="hidden" name="mode" value="pw">
			<div class="form-group">
				<label>아이디</label> <input type="text" name="username" required>
			</div>
			<div class="form-group">
				<label>휴대전화</label> 
				<div style="display: flex; align-items: center; gap: 5px;">
					<input type="text" name="phone1" maxlength="3" value="010"
						style="width: 25%; text-align: center;"> <span>-</span> <input
						type="text" name="phone2" maxlength="4" required
						style="width: 30%; text-align: center;"> <span>-</span> <input
						type="text" name="phone3" maxlength="4" required
						style="width: 30%; text-align: center;">
				</div>
			</div>
			<button type="submit" class="btn-find">비밀번호 찾기</button>
		</form>
		<%
		}
		%>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>