<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.OrderDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    // 1. 로그인 확인
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인이 필요합니다.');");
        script.println("location.href = 'login.jsp';");
        script.println("</script>");
        return;
    }

    // 2. 파라미터 확인
    int orderId = 0;
    if (request.getParameter("orderId") != null) {
        orderId = Integer.parseInt(request.getParameter("orderId"));
    }

    if (orderId == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 주문 번호입니다.');");
        script.println("history.back();");
        script.println("</script>");
        return;
    }

    // 3. 삭제 수행
    OrderDAO orderDAO = new OrderDAO();
    // OrderDAO에 deleteOrder 메서드가 있다고 가정합니다.
    // 만약 없다면 OrderDAO에 "DELETE FROM orders WHERE order_id = ?" 쿼리를 실행하는 메서드를 추가해야 합니다.
    int result = orderDAO.deleteOrder(orderId);

    if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('주문 내역 삭제에 실패했습니다.');");
        script.println("history.back();");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('주문 내역이 삭제되었습니다.');");
        script.println("location.href = 'orderList.jsp';");
        script.println("</script>");
    }
%>