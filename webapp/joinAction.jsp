<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.Date"%>
<%-- 날짜 변환을 위해 import 추가 --%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="dto.UserDTO" />

<%
    user.setUsername(request.getParameter("username"));
    user.setPassword(request.getParameter("password"));
    user.setName(request.getParameter("name"));
    user.setGender(request.getParameter("gender"));
    user.setEmail(request.getParameter("email"));
    String p1 = request.getParameter("phone1");
    String p2 = request.getParameter("phone2");
    String p3 = request.getParameter("phone3");
    String fullPhone = p1 + "-" + p2 + "-" + p3;
    user.setPhone(fullPhone);    
    user.setZipcode(request.getParameter("zipcode"));
    user.setAddress(request.getParameter("address"));
    user.setAddressDetail(request.getParameter("addressDetail"));
    
    String birthdateStr = request.getParameter("birthdate");
    if (birthdateStr != null && !birthdateStr.equals("")) {
        try {
            user.setBirthdate(Date.valueOf(birthdateStr));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    if(user.getUsername() == null || user.getPassword() == null || 
       user.getName() == null || user.getEmail() == null || user.getPhone() == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안 된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        return;
    }

    UserDAO userDAO = new UserDAO();
    
    if(userDAO.checkDuplicate(user.getUsername()) == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 존재하는 아이디입니다.');");
        script.println("history.back();");
        script.println("</script>");
        return;
    }

    int result = userDAO.join(user);

    if (result == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입이 완료되었습니다! 로그인해주세요.');");
        script.println("location.href = 'login.jsp';");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입에 실패했습니다.');");
        script.println("history.back();");
        script.println("</script>");
    }
%>