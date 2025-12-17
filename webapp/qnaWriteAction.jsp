<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.QnaDAO"%>
<%@ page import="dao.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인이 필요합니다.');");
        script.println("location.href = 'login.jsp';");
        script.println("</script>");
        return;
    }
    
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String productIDStr = request.getParameter("productID");
    String isSecret = request.getParameter("isSecret");
    
    if (isSecret == null) {
        isSecret = "N";
    }
    
    if (title == null || title.trim().equals("")) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('제목을 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        return;
    }
    
    if (content == null || content.trim().equals("")) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('내용을 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        return;
    }
    
    if (productIDStr == null || productIDStr.equals("")) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('문의할 제품을 선택해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        return;
    }
    
    UserDAO userDAO = new UserDAO();
    QnaDAO qnaDAO = new QnaDAO();

    int userPK = userDAO.getUserPK(userID);
    int productID = Integer.parseInt(productIDStr);

    if (userPK == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유저 정보를 찾을 수 없습니다.');");
        script.println("location.href = 'login.jsp';");
        script.println("</script>");
        return;
    }
    
    int result = qnaDAO.write(productID, userPK, title, content, isSecret);
    
    if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글쓰기에 실패했습니다. 잠시 후 다시 시도해주세요.');");
        script.println("history.back();");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('문의가 성공적으로 등록되었습니다.');");
        script.println("location.href = 'qnaList.jsp';");
        script.println("</script>");
    }
%>