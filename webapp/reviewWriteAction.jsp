<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="dto.ReviewDTO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    // 1. 한글 처리
    request.setCharacterEncoding("UTF-8");

    // 2. 파라미터 받기
    String productIdStr = request.getParameter("productId");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String ratingStr = request.getParameter("rating");
    
    // 작성자 정보 (로그인 여부에 따라 다름)
    String sessionUserID = (String) session.getAttribute("userID");
    String writerName = request.getParameter("writerName"); // 폼에서 넘어온 값 (익명일 경우 직접 입력한 값)
    String password = request.getParameter("password");     // 비회원 비밀번호

    // 3. 유효성 검사
    if (productIdStr == null || title == null || content == null || ratingStr == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안 된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        return;
    }

    int productId = Integer.parseInt(productIdStr);
    int rating = Integer.parseInt(ratingStr);
    
    // 4. 유저 ID(PK) 구하기 (회원인 경우)
    int userPK = 0; // 0이면 비회원(익명)으로 간주
    if (sessionUserID != null) {
        UserDAO userDAO = new UserDAO();
        userPK = userDAO.getUserPK(sessionUserID); // String 아이디 -> int PK 변환 메서드 (이전에 구현함)
    }

    // 5. DTO 객체 생성 및 설정
    ReviewDTO review = new ReviewDTO();
    review.setProductId(productId);
    review.setUserId(userPK);
    review.setWriterName(writerName);
    review.setPassword(password); // 비회원일 때만 값이 있고, 회원이면 null일 수 있음
    review.setTitle(title);
    review.setContent(content);
    review.setRating(rating);

    // 6. DAO를 통해 DB 저장
    ReviewDAO reviewDAO = new ReviewDAO();
    int result = reviewDAO.write(review);

    // 7. 결과 처리
    if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글쓰기에 실패했습니다.');");
        script.println("history.back();");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('리뷰가 등록되었습니다.');");
        script.println("location.href = 'reviewList.jsp';"); // 목록으로 이동
        script.println("</script>");
    }
%>