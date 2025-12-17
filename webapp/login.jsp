<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="menu.jsp" />
    <div class="container" style="max-width: 500px; padding-top:100px;">
        <h2 class="page-title">LOGIN</h2>
        <div style="background:#fff; padding:40px; border:1px solid #ddd; text-align:center;">
            <form action="loginAction.jsp" method="post">
                <input type="text" name="username" placeholder="아이디" required style="margin-bottom:15px;"> 
                <input type="password" name="password" placeholder="비밀번호" required style="margin-bottom:20px;">
                <button type="submit" class="btn-login" style="width:100%;">로그인</button>
            </form>
            <div style="margin-top:20px; font-size:0.9rem; color:#666; display:flex; justify-content:space-between;">
                <a href="join.jsp">회원가입</a>
                <div>
                    <a href="findUser.jsp?mode=id">아이디 찾기</a> | <a href="findUser.jsp?mode=pw">비밀번호 찾기</a>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>