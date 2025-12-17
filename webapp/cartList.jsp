<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.CartDAO" %>
<%@ page import="dto.CartDTO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="menu.jsp" />

    <%
        String userID = (String) session.getAttribute("userID");
        if (userID == null) {
            out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
            return;
        }
        UserDAO uDao = new UserDAO();
        int userPK = uDao.getUserPK(userID);
        CartDAO dao = new CartDAO();
        ArrayList<CartDTO> list = dao.getCartList(userPK);
        DecimalFormat formatter = new DecimalFormat("###,###");
        int totalPrice = 0;
        int shippingFee = 3000;
    %>

    <div class="cart-container">
        <h2 class="page-title">CART</h2>
        
        <table class="cart-table list-table"> <colgroup>
                <col width="5%">
                <col width="10%">
                <col width="*">
                <col width="10%">
                <col width="15%">
                <col width="15%">
                <col width="10%">
            </colgroup>
            <thead>
                <tr>
                    <th><input type="checkbox" checked disabled></th>
                    <th>이미지</th>
                    <th>상품정보</th>
                    <th>수량</th>
                    <th>상품금액</th>
                    <th>합계</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (list.size() == 0) {
                %>
                    <tr><td colspan="7" style="padding: 50px;">장바구니가 비어있습니다.</td></tr>
                <%
                    } else {
                        for (CartDTO c : list) {
                            int itemTotal = c.getProductPrice() * c.getQuantity();
                            totalPrice += itemTotal;
                %>
                    <tr>
                        <td><input type="checkbox" checked disabled></td>
                        <td>
                            <img src="productImage?id=<%= c.getProductId() %>" class="cart-img-thumb" onerror="this.src='image/no_image.png'">
                        </td>
                        <td style="text-align:left; padding-left:20px;">
                            <%= c.getProductName() %> (<%= c.getColor() %>)
                        </td>
                        <td><%= c.getQuantity() %>개</td>
                        <td><%= formatter.format(c.getProductPrice()) %>원</td>
                        <td style="font-weight:bold;"><%= formatter.format(itemTotal) %>원</td>
                        <td>
                            <button type="button" class="btn-cancel btn-small" onclick="if(confirm('삭제하시겠습니까?')) location.href='cartDeleteAction.jsp?cartId=<%= c.getCartId() %>'">삭제</button>
                        </td>
                    </tr>
                <%
                        }
                    }
                    if (totalPrice >= 50000 || totalPrice == 0) shippingFee = 0;
                %>
            </tbody>
        </table>
        
        <div style="background:#F9F8F5; padding:30px; text-align:right; border-top:2px solid #333; margin-top:30px; font-size:1.1rem;">
            상품금액 <strong><%= formatter.format(totalPrice) %>원</strong> + 
            배송비 <strong><%= formatter.format(shippingFee) %>원</strong> = 
            총 결제금액 <span style="color:#D32F2F; font-weight:bold; font-size:1.5rem; margin-left:10px;"><%= formatter.format(totalPrice + shippingFee) %>원</span>
        </div>
        
        <div class="btn-group" style="margin-top:40px;">
            <a href="store_all.jsp" class="btn-white">쇼핑 계속하기</a>
            <% if(list.size() > 0) { %>
                <button type="button" class="btn-pay" onclick="location.href='orderForm.jsp?type=cart'">전체상품 주문하기</button>
            <% } %>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>