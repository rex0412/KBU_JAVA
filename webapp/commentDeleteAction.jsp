<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CommentDAO" %>
<%@ page import="dto.CommentDTO" %>
<%@ page import="dao.UserDAO" %>

<%
    String commentIdStr = request.getParameter("commentId");
    String inputPassword = request.getParameter("password"); // 비회원 삭제 시 입력받은 비번
    
    if(commentIdStr == null) {
        out.print("fail");
        return;
    }
    int commentId = Integer.parseInt(commentIdStr);
    
    String sessionUserID = (String) session.getAttribute("userID");
    String sessionUserRole = (String) session.getAttribute("userRole");
    
    CommentDAO dao = new CommentDAO();
    CommentDTO cmt = dao.getComment(commentId); 
    
    if(cmt == null) {
        out.print("fail");
        return;
    }
    
    boolean canDelete = false;
    
    // 1. 관리자: 무조건 삭제 가능
    if("ADMIN".equals(sessionUserRole)) {
        canDelete = true;
    }
    // 2. 비회원 댓글: 입력받은 비밀번호와 DB 비밀번호 일치 확인
    else if(cmt.getUserId() == 0) {
        if(inputPassword != null && inputPassword.equals(cmt.getPassword())) {
            canDelete = true;
        }
    }
    // 3. 회원 댓글: 세션 ID와 댓글 작성자 ID 일치 확인
    else if(sessionUserID != null) {
        UserDAO uDao = new UserDAO();
        int userPK = uDao.getUserPK(sessionUserID);
        if(userPK == cmt.getUserId()) {
            canDelete = true;
        }
    }
    
    if(canDelete) {
        int result = dao.deleteComment(commentId);
        if(result > 0) out.print("success");
        else out.print("fail");
    } else {
        out.print("auth_fail"); // 권한 없음 또는 비번 불일치
    }
%>