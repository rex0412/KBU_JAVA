<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO"%>
<%@ page import="dto.UserDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    System.out.println("========================================");
    System.out.println("[로그인 시도] 아이디: " + username);
    System.out.println("[로그인 시도] 비밀번호: " + password);
    
    UserDAO userDAO = new UserDAO();

    int result = userDAO.login(username, password);
    
    System.out.println("[로그인 결과 코드] result : " + result);

    if (result == 1) {
        UserDTO user = userDAO.getUser(username);
        
        if (user != null) {
            session.setAttribute("userID", user.getUsername());
            session.setAttribute("userRole", user.getRole());
            System.out.println("[성공] 세션 설정 완료: " + user.getUsername() + " / " + user.getRole());
            
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'index.jsp'");
            script.println("</script>");
        } else {
            System.out.println("[오류] 로그인 성공했으나 회원정보(DTO)를 가져오지 못함");
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('회원 정보를 불러오는데 실패했습니다.');");
            script.println("history.back();");
            script.println("</script>");
        }

    } else if (result == 0) {
        System.out.println("[실패] 비밀번호 불일치");
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 일치하지 않습니다.');");
        script.println("history.back();");
        script.println("</script>");

    } else if (result == -1) {
        System.out.println("[실패] 존재하지 않는 아이디");
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 아이디입니다.');");
        script.println("history.back();");
        script.println("</script>");

    } else {
        System.out.println("[실패] 데이터베이스 오류 (UserDAO.login 예외 발생)");
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류가 발생했습니다. 콘솔을 확인하세요.');");
        script.println("history.back();");
        script.println("</script>");
    }
    System.out.println("========================================");
%>