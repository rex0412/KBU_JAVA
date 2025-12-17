<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.QnaDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    // 1. 관리자 권한 체크 (또는 본인 글 삭제 기능 추가 시 수정 가능)
    String userRole = (String) session.getAttribute("userRole");
    String userID = (String) session.getAttribute("userID");
    
    // 파라미터 확인
    String qnaIdStr = request.getParameter("qnaId");
    if (qnaIdStr == null || qnaIdStr.isEmpty()) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('잘못된 접근입니다.');");
        script.println("history.back();");
        script.println("</script>");
        return;
    }
    
    int qnaId = Integer.parseInt(qnaIdStr);
    
    // 2. 삭제 권한 검증 (관리자이거나, 글 작성자 본인일 경우 허용하도록 확장 가능)
    // 여기서는 관리자만 삭제 가능하도록 구현 (필요시 작성자 본인 체크 로직 추가 가능)
    // 작성자 본인 체크 로직 예시:
    /*
    QnaDAO dao = new QnaDAO();
    QnaDTO qna = dao.getQna(qnaId);
    if (!"ADMIN".equals(userRole) && (userID == null || !userID.equals(qna.getUserName()))) {
        // 권한 없음 처리
    }
    */
    
    if (userRole == null || !"ADMIN".equals(userRole)) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.');");
        script.println("location.href = 'qnaList.jsp';");
        script.println("</script>");
        return;
    }

    // 3. 삭제 실행
    QnaDAO qnaDAO = new QnaDAO();
    int result = qnaDAO.deleteQna(qnaId);

    // 4. 결과 처리
    if (result > 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('게시글이 삭제되었습니다.');");
        script.println("location.href = 'qnaList.jsp';");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('게시글 삭제에 실패했습니다.');");
        script.println("history.back();");
        script.println("</script>");
    }
%>