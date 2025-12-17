<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.QnaDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
    String userRole = (String) session.getAttribute("userRole");
    if (userRole == null || !"ADMIN".equals(userRole)) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('관리자만 답변을 작성할 수 있습니다.');");
        script.println("location.href = 'login.jsp';");
        script.println("</script>");
        return;
    }
    
    String qnaIdStr = request.getParameter("qnaId");
    String answerContent = request.getParameter("answerContent");

    if (qnaIdStr == null || answerContent == null || answerContent.trim().equals("")) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('잘못된 접근이거나 내용이 비어있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        return;
    }

    int qnaId = Integer.parseInt(qnaIdStr);
    
    QnaDAO qnaDAO = new QnaDAO();
    int result = qnaDAO.updateAnswer(qnaId, answerContent);

    if (result != -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('답변이 등록되었습니다.');");
        script.println("location.href = 'qnaDetail.jsp?qnaId=" + qnaId + "';");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('답변 등록 실패');");
        script.println("history.back();");
        script.println("</script>");
    }
%>