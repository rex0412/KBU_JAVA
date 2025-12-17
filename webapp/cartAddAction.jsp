<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CartDAO" %>
<%@ page import="dao.UserDAO" %>

<%
    // 1. 세션에서 로그인된 사용자 ID 가져오기
    String userID = (String) session.getAttribute("userID");
    
    // 로그인이 안 된 경우
    if (userID == null) {
        out.print("로그인이 필요합니다."); // login_required 대신 한글 메시지 출력
        return;
    }

    // 2. 요청 파라미터 받기 (상품 ID, 수량)
    String productIdStr = request.getParameter("productId");
    String quantityStr = request.getParameter("quantity");

    // 파라미터 누락 체크
    if (productIdStr == null || quantityStr == null) {
        out.print("잘못된 요청입니다."); // fail 대신 한글 메시지 출력
        return;
    }

    try {
        int productId = Integer.parseInt(productIdStr);
        int quantity = Integer.parseInt(quantityStr);
        
        // 3. 사용자 고유 번호(PK) 조회
        UserDAO uDao = new UserDAO();
        int userPK = uDao.getUserPK(userID);

        // 4. 장바구니에 추가 (이미 있으면 수량 업데이트, 없으면 신규 추가)
        CartDAO dao = new CartDAO();
        int result = dao.addToCart(userPK, productId, quantity);

        // 5. 결과 반환
        if (result > 0) {
            out.print("장바구니에 상품을 담았습니다."); // success 대신 한글 메시지 출력
        } else {
            out.print("장바구니 담기에 실패했습니다."); // fail 대신 한글 메시지 출력
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("오류가 발생했습니다.");
    }
%>