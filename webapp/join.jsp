<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

	<div class="join-container">
		<h2 class="page-title">SIGN UP</h2>
		<form name="joinForm" action="joinAction.jsp" method="post"
			onsubmit="return validateForm()">
			<table class="join-table">
				<tr>
					<th>* 아이디</th>
					<td>
						<div style="display: flex; gap: 10px;">
							<input type="text" name="username" placeholder="영문, 숫자 4~12자"
								required style="width: 200px;">
							<button type="button" class="btn-check" onclick="openIdCheck()">중복확인</button>
						</div>
					</td>
				</tr>
				<tr>
					<th>* 비밀번호</th>
					<td><input type="password" name="password" required
						style="width: 300px;"></td>
				</tr>
				<tr>
					<th>* 비밀번호 확인</th>
					<td><input type="password" name="passwordConfirm" required
						style="width: 300px;"></td>
				</tr>
				<tr>
					<th>* 이름</th>
					<td><input type="text" name="name" required
						style="width: 200px;"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="date" name="birthdate" style="width: 200px;"></td>
				</tr>
				<tr>
					<th>성별</th>
					<td><label style="margin-right: 15px;"><input
							type="radio" name="gender" value="M"> 남성</label> <label><input
							type="radio" name="gender" value="F"> 여성</label></td>
				</tr>
				<tr>
					<th>* 이메일</th>
					<td><input type="email" name="email" required
						style="width: 300px;"></td>
				</tr>
				<tr>
					<th>* 휴대전화</th>
					<td>
						<div style="display: flex; align-items: center; gap: 5px;">
							<input type="text" name="phone1" maxlength="3" value="010"
								style="width: 60px; text-align: center;"> <span>-</span>
							<input type="text" name="phone2" maxlength="4" required
								style="width: 70px; text-align: center;"> <span>-</span>
							<input type="text" name="phone3" maxlength="4" required
								style="width: 70px; text-align: center;">
						</div>
					</td>
				</tr>
				<tr>
					<th>* 주소</th>
					<td>
						<div style="display: flex; gap: 10px; margin-bottom: 8px;">
							<input type="text" id="zipcode" name="zipcode" placeholder="우편번호"
								readonly style="width: 120px;">
							<button type="button" class="btn-addr"
								onclick="execDaumPostcode()">검색</button>
						</div> <input type="text" id="address" name="address" placeholder="기본주소"
						readonly style="margin-bottom: 8px;"><br> <input
						type="text" id="addressDetail" name="addressDetail"
						placeholder="상세주소를 입력하세요" required>
					</td>
				</tr>
			</table>
			<div class="btn-group">
				<button type="submit" class="btn-join" style="padding: 15px 50px;">회원가입</button>
			</div>
		</form>
	</div>

	<jsp:include page="footer.jsp" />

	<script>
		function openIdCheck() {
			var id = document.joinForm.username.value;
			if (!id) {
				alert("아이디를 입력해주세요.");
				return;
			}
			window.open("checkId.jsp?username=" + id, "idCheck",
					"width=400,height=250");
		}
		function validateForm() {
			var pw = document.joinForm.password.value;
			var pwConfirm = document.joinForm.passwordConfirm.value;
			var zipcode = document.joinForm.zipcode.value;
			if (pw != pwConfirm) {
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			if (!zipcode) {
				alert("주소를 검색해주세요.");
				return false;
			}
			return true;
		}
		function execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							var addr = (data.userSelectedType === 'R') ? data.roadAddress
									: data.jibunAddress;
							document.getElementById('zipcode').value = data.zonecode;
							document.getElementById("address").value = addr;
							document.getElementById("addressDetail").focus();
						}
					}).open();
		}
	</script>
</body>
</html>