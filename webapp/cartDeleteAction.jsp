<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CartDAO" %>

<%
    String cartIdStr = request.getParameter("cartId");
    if (cartIdStr != null) {
        int cartId = Integer.parseInt(cartIdStr);
        CartDAO dao = new CartDAO();
        dao.deleteCart(cartId);
    }
    
    response.sendRedirect("cartList.jsp");
%>