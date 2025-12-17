<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CommentDAO" %>
<%@ page import="dto.CommentDTO" %>
<%@ page import="dao.UserDAO" %>

<%
    request.setCharacterEncoding("UTF-8");
    
    String userID = (String) session.getAttribute("userID");
    int userPK = 0;
    
    // 회원이면 PK 조회
    if(userID != null) {
        UserDAO uDao = new UserDAO();
        userPK = uDao.getUserPK(userID);
    }

    int reviewId = Integer.parseInt(request.getParameter("reviewId"));
    String content = request.getParameter("content");
    int parentId = Integer.parseInt(request.getParameter("parentCommentId"));
    
    // 익명 사용자 정보 수신
    String writerName = request.getParameter("writerName");
    String password = request.getParameter("password");
    
    CommentDTO comment = new CommentDTO();
    comment.setReviewId(reviewId);
    comment.setUserId(userPK); // 0이면 비회원
    comment.setContent(content);
    comment.setParentCommentId(parentId);
    
    // 비회원 정보 설정
    if(userPK == 0) {
        comment.setWriterName(writerName);
        comment.setPassword(password);
    }
    
    CommentDAO dao = new CommentDAO();
    int result = dao.writeComment(comment);
    
    if(result > 0) {
        out.print("success");
    } else {
        out.print("fail");
    }
%>