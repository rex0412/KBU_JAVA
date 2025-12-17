<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO"%>
<%@ page import="dto.UserDTO"%>
<%@ page import="dao.ProductDAO"%>
<%@ page import="dto.ProductDTO"%>
<%@ page import="dao.CartDAO"%>
<%@ page import="dto.CartDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.DecimalFormat"%>
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
        UserDTO user = uDao.getUser(userID);
        int userPK = user.getUserId();
        
        String type = request.getParameter("type");
        ArrayList<CartDTO> orderList = new ArrayList<>();
        int totalPrice = 0;
        String summaryName = ""; 
        
        // 1. 주문 목록 구성 로직
        if("direct".equals(type)) {
            // 바로 구매
            try {
                int pId = Integer.parseInt(request.getParameter("productId"));
                int qty = Integer.parseInt(request.getParameter("quantity"));
                ProductDAO pDao = new ProductDAO();
                ProductDTO p = pDao.getProductById(pId);
                
                if(p == null) throw new Exception("상품 정보 없음");
                
                int price = (p.getSalePrice() > 0) ? p.getSalePrice() : p.getPrice();
                
                CartDTO item = new CartDTO();
                item.setProductId(pId); 
                item.setProductName(p.getName()); 
                item.setColor(p.getColor());
                item.setProductPrice(price); 
                item.setQuantity(qty);
                orderList.add(item);
                
                totalPrice = price * qty;
                summaryName = p.getName() + " (" + qty + "개)";
            } catch(Exception e) {
                out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
                return;
            }
        } else {
            // 장바구니 구매
            CartDAO cDao = new CartDAO();
            orderList = cDao.getCartList(userPK);
            
            // [보완 1] 장바구니가 비어있는 경우 체크
            if (orderList == null || orderList.size() == 0) {
                out.println("<script>alert('장바구니에 담긴 상품이 없습니다.'); location.href='store_all.jsp';</script>");
                return;
            }
            
            summaryName = orderList.get(0).getProductName();
            if (orderList.size() > 1) summaryName += " 외 " + (orderList.size() - 1) + "건";
            for (CartDTO c : orderList) totalPrice += c.getProductPrice() * c.getQuantity();
        }
        
        // 5만원 이상 무료배송 로직
        int shipping = (totalPrice >= 50000 || totalPrice == 0) ? 0 : 3000;
        DecimalFormat fmt = new DecimalFormat("###,###");
    %>

    <div class="order-container">
        <h2 class="page-title">주문하기</h2>

        <form action="orderAction.jsp" method="post" name="orderForm" onsubmit="return validateForm()">
            <input type="hidden" name="type" value="<%= type %>">
            <input type="hidden" name="totalPrice" value="<%= totalPrice + shipping %>">
            <input type="hidden" name="productName" value="<%= summaryName %>">
            
            <% if("direct".equals(type)) { %>
                <input type="hidden" name="productId" value="<%= request.getParameter("productId") %>">
                <input type="hidden" name="quantity" value="<%= request.getParameter("quantity") %>">
            <% } %>

            <div class="sec-title">주문 상품 정보</div>
            <table class="list-table">
                <colgroup>
                    <col width="15%"><col width="*"><col width="20%"><col width="15%">
                </colgroup>
                <thead>
                    <tr>
                        <th>이미지</th>
                        <th>상품정보</th>
                        <th>판매가/수량</th>
                        <th>합계</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(CartDTO item : orderList) { %>
                    <tr>
                        <td>
                            <img src="productImage?id=<%= item.getProductId() %>" width="80" style="border-radius: 4px;" onerror="this.src='image/no_image.png'">
                        </td>
                        <td style="text-align: left; padding-left: 20px;">
                            <strong><%= item.getProductName() %></strong><br>
                            <span style="color: #888; font-size: 0.9rem;">Color: <%= item.getColor() %></span>
                        </td>
                        <td><%= fmt.format(item.getProductPrice()) %>원 / <%= item.getQuantity() %>개</td>
                        <td style="font-weight: bold;"><%= fmt.format(item.getProductPrice() * item.getQuantity()) %>원</td>
                    </tr>
                    <% } %>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" style="text-align:right; background-color:#FAFAFA; padding: 20px 30px; border-bottom:1px solid #ddd; color:#555;">
                            <span>상품금액 <strong><%= fmt.format(totalPrice) %>원</strong></span>
                            <span style="margin: 0 10px;">+</span>
                            <span>배송비 <strong><%= fmt.format(shipping) %>원</strong></span>
                            <span style="margin: 0 10px;">=</span>
                            <span style="font-weight:bold; color:#D32F2F; font-size: 1.1rem;">
                                총 결제예정금액 <%= fmt.format(totalPrice + shipping) %>원
                            </span>
                        </td>
                    </tr>
                </tfoot>
            </table>

            <div class="sec-title">배송지 정보</div>
            <table class="form-table">
                <tr>
                    <th>받으시는 분</th>
                    <td><input type="text" name="receiverName" value="<%= user.getName() %>" required style="width: 200px;"></td>
                </tr>
                <tr>
                    <th>휴대전화</th>
                    <td><input type="text" name="phone" value="<%= user.getPhone() %>" required style="width: 200px;" placeholder="010-0000-0000"></td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td>
                        <input type="text" name="address" value="<%= user.getAddress() %>" required style="width: 100%; margin-bottom: 5px; background-color:#f9f9f9;" readonly placeholder="기본 주소">
                        <input type="text" name="addressDetail" value="<%= user.getAddressDetail() %>" required style="width: 100%;" placeholder="상세 주소를 입력해주세요 (동, 호수 등)">
                    </td>
                </tr>
                <tr>
                    <th>배송메모</th>
                    <td>
                        <select onchange="document.getElementById('memo').value = this.value" style="width: 200px; margin-bottom:5px;">
                            <option value="">직접 입력</option>
                            <option value="부재 시 문 앞에 놓아주세요">부재 시 문 앞에 놓아주세요</option>
                            <option value="배송 전 연락바랍니다">배송 전 연락바랍니다</option>
                            <option value="경비실에 맡겨주세요">경비실에 맡겨주세요</option>
                        </select>
                        <input type="text" name="memo" id="memo" placeholder="배송 메세지를 입력해주세요" style="width: 100%;">
                    </td>
                </tr>
            </table>

            <div class="sec-title">결제 수단</div>
            <div style="padding: 20px; border: 1px solid #ddd; border-top: 2px solid #333; display:flex; gap:30px; align-items:center;">
                <label style="cursor:pointer;">
                    <input type="radio" name="payMethod" value="CARD" checked> 신용/체크카드
                </label>
                <label style="cursor:pointer;">
                    <input type="radio" name="payMethod" value="BANK"> 무통장입금
                </label>
                <label style="cursor:pointer;">
                    <input type="radio" name="payMethod" value="KAKAO"> 카카오페이
                </label>
            </div>

            <div style="margin-top: 50px; text-align: center;">
                <h3 style="margin-bottom: 20px; color: #D32F2F;">
                    최종 결제금액 : <%= fmt.format(totalPrice + shipping) %>원
                </h3>
                <button type="submit" class="btn-pay" style="width: 300px; height: 50px; font-size: 1.1rem;">결제하기</button>
            </div>
        </form>
    </div>

    <jsp:include page="footer.jsp" />

    <script>
        function validateForm() {
            var form = document.orderForm;
            if(!form.receiverName.value.trim()) {
                alert('받으시는 분 성함을 입력해주세요.'); return false;
            }
            if(!form.phone.value.trim()) {
                alert('연락처를 입력해주세요.'); return false;
            }
            if(!form.addressDetail.value.trim()) {
                alert('상세 주소를 입력해주세요.'); return false;
            }
            return confirm('주문하시겠습니까?');
        }
    </script>
</body>
</html>