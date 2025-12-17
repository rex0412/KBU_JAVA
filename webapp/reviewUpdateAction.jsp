<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="dto.ReviewDTO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");

    String reviewIdStr = request.getParameter("reviewId");
    if (reviewIdStr == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }
    int reviewId = Integer.parseInt(reviewIdStr);
    
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    int productId = Integer.parseInt(request.getParameter("productId"));
    int rating = Integer.parseInt(request.getParameter("rating"));
    String password = request.getParameter("password"); // 익명용

    String sessionUserID = (String) session.getAttribute("userID");
    
    ReviewDAO dao = new ReviewDAO();
    ReviewDTO origin = dao.getReview(reviewId);
    
    boolean canUpdate = false;

    // 권한 체크
    // 1. 익명 글: 입력한 비밀번호와 DB 비밀번호 일치 여부 확인
    if (origin.getUserId() == 0) {
        if (password != null && password.equals(origin.getPassword())) {
            canUpdate = true;
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
            return;
        }
    }
    // 2. 회원 글: 세션 ID와 작성자 ID 일치 여부 확인
    else if (sessionUserID != null) {
        UserDAO uDao = new UserDAO();
        int userPK = uDao.getUserPK(sessionUserID);
        if (userPK == origin.getUserId()) {
            canUpdate = true;
        }
    }
    // 3. 관리자: 무조건 수정 가능 (필요 시 추가)
    String userRole = (String) session.getAttribute("userRole");
    if ("ADMIN".equals(userRole)) canUpdate = true;


    if (canUpdate) {
        ReviewDTO updateDto = new ReviewDTO();
        updateDto.setReviewId(reviewId);
        updateDto.setProductId(productId);
        updateDto.setTitle(title);
        updateDto.setContent(content);
        updateDto.setRating(rating);
        
        int result = dao.updateReview(updateDto);
        
        if (result > 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('수정되었습니다.');");
            script.println("location.href = 'reviewDetail.jsp?reviewId=" + reviewId + "';");
            script.println("</script>");
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>alert('수정 실패.'); history.back();</script>");
        }
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>alert('수정 권한이 없습니다.'); history.back();</script>");
    }
%>