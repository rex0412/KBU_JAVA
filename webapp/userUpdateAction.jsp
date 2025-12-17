<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.io.PrintWriter" %>

<%
    request.setCharacterEncoding("UTF-8");

    String userID = (String) session.getAttribute("userID");
    if(userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    // 파라미터 받기
    String username = request.getParameter("username"); // readonly지만 넘어옴
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String birthdateStr = request.getParameter("birthdate");
    String gender = request.getParameter("gender");
    String email = request.getParameter("email");
    String p1 = request.getParameter("phone1");
    String p2 = request.getParameter("phone2");
    String p3 = request.getParameter("phone3");
    String phone = p1 + "-" + p2 + "-" + p3;
    String zipcode = request.getParameter("zipcode");
    String address = request.getParameter("address");
    String addressDetail = request.getParameter("addressDetail");

    // 본인 확인 (세션 ID와 넘어온 ID 비교)
    if(!userID.equals(username)) {
        PrintWriter script = response.getWriter();
        script.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    // DTO 설정
    UserDTO user = new UserDTO();
    user.setUsername(username);
    user.setPassword(password); // 없으면 빈 문자열일 수 있음
    user.setName(name);
    user.setGender(gender);
    user.setEmail(email);
    user.setPhone(phone);
    user.setZipcode(zipcode);
    user.setAddress(address);
    user.setAddressDetail(addressDetail);
    
    if(birthdateStr != null && !birthdateStr.isEmpty()) {
        user.setBirthdate(Date.valueOf(birthdateStr));
    }

    // DAO 호출
    UserDAO dao = new UserDAO();
    int result = dao.updateUser(user);

    if (result > 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원 정보가 수정되었습니다.');");
        script.println("location.href = 'index.jsp';");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원 정보 수정 실패.');");
        script.println("history.back();");
        script.println("</script>");
    }
%>