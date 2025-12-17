<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    String reviewIdStr = request.getParameter("reviewId");
    if (reviewIdStr == null) {
        response.sendRedirect("reviewList.jsp");
        return;
    }
    
    int reviewId = Integer.parseInt(reviewIdStr);

    // User PK 가져오기
    UserDAO uDao = new UserDAO();
    int userPK = uDao.getUserPK(userID);

    // 추천 토글 실행
    ReviewDAO dao = new ReviewDAO();
    int result = dao.toggleLike(reviewId, userPK);
    
    // 결과에 따라 메시지 없이 바로 상세 페이지로 리다이렉트 (새로고침 효과)
    if (result != -1) {
        response.sendRedirect("reviewDetail.jsp?reviewId=" + reviewId);
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>alert('오류가 발생했습니다.'); history.back();</script>");
    }
%>