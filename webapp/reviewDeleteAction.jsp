<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="dto.ReviewDTO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String reviewIdStr = request.getParameter("reviewId");
    String password = request.getParameter("password"); // 익명 비밀번호
    
    if (reviewIdStr == null) {
        response.sendRedirect("reviewList.jsp");
        return;
    }
    int reviewId = Integer.parseInt(reviewIdStr);
    
    String userID = (String) session.getAttribute("userID");
    String userRole = (String) session.getAttribute("userRole");
    
    ReviewDAO dao = new ReviewDAO();
    ReviewDTO review = dao.getReview(reviewId);
    
    boolean canDelete = false;
    
    // 1. 관리자면 무조건 삭제 가능
    if ("ADMIN".equals(userRole)) {
        canDelete = true;
    }
    // 2. 익명 글이면 비밀번호 일치 확인
    else if (review.getUserId() == 0) {
        if (password != null && password.equals(review.getPassword())) {
            canDelete = true;
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
            return;
        }
    }
    // 3. 회원 글이면 본인 확인
    else if (userID != null) {
        UserDAO uDao = new UserDAO();
        int userPK = uDao.getUserPK(userID);
        if (userPK == review.getUserId()) {
            canDelete = true;
        }
    }

    if (canDelete) {
        int result = dao.deleteReview(reviewId);
        if (result > 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>alert('삭제되었습니다.'); location.href='reviewList.jsp';</script>");
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>alert('삭제 실패.'); history.back();</script>");
        }
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>alert('권한이 없습니다.'); history.back();</script>");
    }
%>