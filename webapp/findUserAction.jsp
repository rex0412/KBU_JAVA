<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
    
    String mode = request.getParameter("mode");
    String name = request.getParameter("name");       // 아이디 찾기 시 이름
    String username = request.getParameter("username"); // 비번 찾기 시 아이디

    // 전화번호 3개 받기
    String p1 = request.getParameter("phone1");
    String p2 = request.getParameter("phone2");
    String p3 = request.getParameter("phone3");
    
    String phone = "";
    if(p1 != null && p2 != null && p3 != null) {
        phone = p1 + "-" + p2 + "-" + p3;
    }

    // ==========================================
    // [디버깅] 콘솔에서 값을 확인하기 위한 코드
    System.out.println("============== 찾기 요청 디버깅 ==============");
    System.out.println("모드: " + mode);
    System.out.println("입력한 이름: " + name);
    System.out.println("입력한 아이디: " + username);
    System.out.println("입력한 전화번호(조립후): " + phone);
    // ==========================================

    UserDAO userDAO = new UserDAO();
    String foundResult = null;
    
    if ("id".equals(mode)) {
        foundResult = userDAO.findId(name, phone);
    } else if ("pw".equals(mode)) {
        foundResult = userDAO.findPw(username, phone);
    }
    
    // 디버깅: 결과가 나왔는지 확인
    System.out.println("DB 조회 결과: " + foundResult);
    System.out.println("=============================================");
    
    if (foundResult != null) {
        request.setAttribute("findResult", foundResult);
        request.setAttribute("mode", mode);
        
        RequestDispatcher rd = request.getRequestDispatcher("findResult.jsp");
        rd.forward(request, response);
        
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('일치하는 회원 정보를 찾을 수 없습니다.\\n(콘솔 로그를 확인해보세요)');");
        script.println("history.back();");
        script.println("</script>");
    }
%>