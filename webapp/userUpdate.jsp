<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO"%>
<%@ page import="dto.UserDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<jsp:include page="menu.jsp" />

	<%
        String userID = (String) session.getAttribute("userID");
        if (userID == null) {
            out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
            return;
        }
        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.getUser(userID);
        String originPhone = user.getPhone();
        String[] phoneParts = {"", "", ""};
        if(originPhone != null && originPhone.contains("-")) {
            phoneParts = originPhone.split("-");
        } else if (originPhone != null && originPhone.length() >= 10) {
            phoneParts[0] = originPhone.substring(0, 3);
            phoneParts[1] = originPhone.substring(3, 7);
            phoneParts[2] = originPhone.substring(7);
        }
    %>

	<div class="container" style="max-width: 800px;">
		<h2 class="page-title">회원 정보 수정</h2>

		<form name="updateForm" action="userUpdateAction.jsp" method="post"
			onsubmit="return validateForm()">
			<table class="update-table form-table">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="username"
						value="<%= user.getUsername() %>" class="input-readonly" readonly
						style="width: 200px;"></td>
				</tr>
				<tr>
					<th>비밀번호 변경</th>
					<td><input type="password" name="password"
						placeholder="변경 시에만 입력" style="width: 300px;"></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="passwordConfirm"
						placeholder="변경 시에만 입력" style="width: 300px;"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name"
						value="<%= user.getName() %>" required style="width: 200px;"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="email"
						value="<%= user.getEmail() %>" required style="width: 300px;"></td>
				</tr>
				<tr>
					<th>휴대전화</th>
					<td>
						<div style="display: flex; align-items: center; gap: 5px;">
							<input type="text" name="phone1" maxlength="3"
								value="<%= phoneParts.length > 0 ? phoneParts[0] : "010" %>"
								style="width: 60px; text-align: center;"> <span>-</span>
							<input type="text" name="phone2" maxlength="4"
								value="<%= phoneParts.length > 1 ? phoneParts[1] : "" %>"
								required style="width: 70px; text-align: center;"> <span>-</span>
							<input type="text" name="phone3" maxlength="4"
								value="<%= phoneParts.length > 2 ? phoneParts[2] : "" %>"
								required style="width: 70px; text-align: center;">
						</div>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<div style="display: flex; gap: 10px; margin-bottom: 8px;">
							<input type="text" id="zipcode" name="zipcode"
								value="<%= user.getZipcode() %>" readonly style="width: 120px;">
							<button type="button" class="btn-addr"
								onclick="execDaumPostcode()">검색</button>
						</div> <input type="text" id="address" name="address"
						value="<%= user.getAddress() %>" readonly
						style="margin-bottom: 8px;"><br> <input type="text"
						id="addressDetail" name="addressDetail"
						value="<%= user.getAddressDetail() %>">
					</td>
				</tr>
			</table>

			<div class="btn-group">
				<button type="button" class="btn-cancel" onclick="history.back()">취소</button>
				<button type="submit" class="btn-submit">수정 완료</button>
			</div>
		</form>
	</div>

	<jsp:include page="footer.jsp" />
	<script>
        function validateForm() {
            var pw = document.updateForm.password.value;
            var pwConfirm = document.updateForm.passwordConfirm.value;
            if (pw != "" && pw != pwConfirm) { alert("비밀번호가 일치하지 않습니다."); return false; }
            return true;
        }
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
                    document.getElementById('zipcode').value = data.zonecode;
                    document.getElementById("address").value = addr;
                    document.getElementById("addressDetail").focus();
                }
            }).open();
        }
    </script>
</body>
</html>