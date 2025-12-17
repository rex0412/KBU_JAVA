<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO" %>
<%@ page import="dto.ProductDTO" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="menu.jsp" />

    <%
        String productIdStr = request.getParameter("id");
        if (productIdStr == null) {
            out.println("<script>alert('잘못된 접근입니다.'); location.href='store_all.jsp';</script>");
            return;
        }

        ProductDAO dao = new ProductDAO();
        ProductDTO p = dao.getProductById(Integer.parseInt(productIdStr));

        if (p == null) {
            out.println("<script>alert('존재하지 않는 상품입니다.'); history.back();</script>");
            return;
        }

        // [추가] 숨김 처리된 상품은 상세 페이지 접근도 차단
        String status = (p.getStatus() != null) ? p.getStatus().trim() : "판매중";
        if ("숨김".equals(status)) {
            out.println("<script>alert('판매가 중지된 상품입니다.'); history.back();</script>");
            return;
        }

        DecimalFormat formatter = new DecimalFormat("###,###");
        int realPrice = (p.getSalePrice() > 0) ? p.getSalePrice() : p.getPrice();
        
        // [중요] 품절 여부 판단 (DB값이 '품절'이거나 재고가 0 이하)
        boolean isSoldOut = "품절".equals(status) || p.getStock() <= 0;
    %>

    <div class="container"> 
        <div class="product-detail-wrapper">
            <div class="detail-img-area">
                <img src="productImage?id=<%= p.getProductId() %>" alt="<%= p.getName() %>" onerror="this.src='image/no_image.png'">
            </div>

            <div class="detail-info-area">
                <div style="color:var(--accent-color); font-weight:bold; margin-bottom:10px;"><%= p.getCategory() %></div>
                <h2 class="detail-title"><%= p.getName() %></h2>
                
                <div class="detail-price">
                    <% if(p.getSalePrice() > 0 && p.getSalePrice() < p.getPrice()) { %>
                        <span style="text-decoration:line-through; color:#999; font-size:1rem; margin-right:10px;">
                            <%= formatter.format(p.getPrice()) %>원
                        </span>
                        <span style="color:#D32F2F; font-weight:bold;"><%= formatter.format(p.getSalePrice()) %>원</span>
                    <% } else { %>
                        <span style="font-weight: bold;"><%= formatter.format(p.getPrice()) %>원</span>
                    <% } %>
                </div>

                <div class="detail-option-row">
                    <span class="detail-label">색상</span>
                    <span><%= p.getColor() %></span>
                </div>
                
                <div class="detail-option-row">
                    <span class="detail-label">재고</span>
                    <span>
                        <%-- [수정] 영문 상태값(SOLD_OUT) 대신 변수(isSoldOut) 활용 --%>
                        <% if(isSoldOut) { %>
                            <span style="color: red; font-weight:bold;">[품절]</span>
                        <% } else { %>
                            <%= p.getStock() %>개
                        <% } %>
                    </span>
                </div>
                
                <div class="detail-option-row">
                    <span class="detail-label">배송비</span>
                    <span>기본 3,000원 (5만 원 이상 무료배송)</span>
                </div>

                <%-- [수정] 품절이 아닐 때만 수량 조절 박스 표시 --%>
                <% if(!isSoldOut) { %>
                    <div class="quantity-row">
                        <span class="detail-label">주문수량</span>
                        <div class="quantity-box">
                            <button type="button" onclick="changeQuantity(-1)">-</button>
                            <input type="text" id="quantity" value="1" readonly>
                            <button type="button" onclick="changeQuantity(1)">+</button>
                        </div>
                    </div>

                    <div class="total-price-area">
                        <div style="font-size:0.8rem; color:#888; font-weight:normal;">총 상품금액</div>
                        <span id="totalPrice"><%= formatter.format(realPrice) %>원</span>
                    </div>
                <% } %>

                <div class="btn-group-detail">
                    <%-- [수정] 품절 상태에 따른 버튼 처리 --%>
                    <% if(isSoldOut) { %>
                        <button class="btn-buy" style="background-color:#ccc; cursor:not-allowed; border:1px solid #ccc; color:#666;" disabled>품절된 상품입니다</button>
                    <% } else { %>
                        <button class="btn-cart" onclick="addToCart()">장바구니</button>
                        <button class="btn-buy" onclick="buyNow()">구매하기</button>
                    <% } %>
                </div>
            </div>
        </div>

        <div class="sub-title">DETAIL VIEW</div>
        <div style="text-align: center; margin-top: 30px;">
            <%= p.getDescription() %>
        </div>
    </div>

    <jsp:include page="footer.jsp" />

    <script>
        const unitPrice = <%= realPrice %>;
        const maxStock = <%= p.getStock() %>;
        const productId = <%= p.getProductId() %>;
        // JS에서도 품절 상태를 알 수 있게 변수 전달
        const isSoldOut = <%= isSoldOut %>;

        function changeQuantity(change) {
            if(isSoldOut) return; // 안전장치

            const qtyInput = document.getElementById('quantity');
            let currentQty = parseInt(qtyInput.value);
            let newQty = currentQty + change;
            
            if (newQty < 1) { alert('최소 1개 이상이어야 합니다.'); return; }
            if (newQty > maxStock) { alert('재고 부족 (최대 ' + maxStock + '개)'); return; }
            
            qtyInput.value = newQty;
            updateTotalPrice(newQty);
        }

        function updateTotalPrice(qty) {
            const total = unitPrice * qty;
            document.getElementById('totalPrice').innerText = total.toLocaleString() + '원';
        }

        function addToCart() {
            if(isSoldOut) { alert('품절된 상품입니다.'); return; }

            const qty = document.getElementById('quantity').value;
            
            $.ajax({
                url: 'cartAddAction.jsp', 
                type: 'POST',
                data: { productId: productId, quantity: qty },
                success: function(res) {
                    if (res.trim().includes('담았습니다')) {
                        if(confirm('장바구니에 담았습니다. 장바구니로 이동하시겠습니까?')) {
                            location.href = 'cartList.jsp'; // 이동 페이지 수정 (보통 장바구니 목록으로 감)
                        }
                    } else { 
                        alert(res.trim()); 
                        if(res.includes('로그인')) location.href='login.jsp'; 
                    }
                },
                error: function() {
                    alert('장바구니 담기 중 오류가 발생했습니다.');
                }
            });
        }

        function buyNow() {
            if(isSoldOut) { alert('품절된 상품입니다.'); return; }

            const qty = document.getElementById('quantity').value;
            
            <% if (session.getAttribute("userID") == null) { %>
                alert('로그인이 필요합니다.'); 
                location.href = 'login.jsp'; 
                return;
            <% } %>
            
            // 바로 구매 페이지로 이동
            location.href = 'orderForm.jsp?type=direct&productId=' + productId + '&quantity=' + qty;
        }
    </script>
</body>
</html>