<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dao.OrderDAO"%>
<%@ page import="dto.OrderDTO"%>
<%@ page import="dao.UserDAO"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<style>
/* 주문 내역 카드 스타일 */
.order-card {
	border: 1px solid #ddd;
	border-radius: 8px;
	background-color: #fff;
	margin-bottom: 30px;
	overflow: hidden;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

/* 카드 헤더 (날짜, 주문번호, 상세보기 버튼) */
.card-header {
	background-color: #f9f9f9;
	padding: 15px 20px;
	border-bottom: 1px solid #eee;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.order-date-no {
	font-weight: 700;
	color: var(--text-title);
	font-size: 1rem;
}

.btn-toggle-detail {
	background-color: none;
	border: 1px solid #ccc;
	padding: 5px 12px;
	border-radius: 4px;
	font-size: 0.85rem;
	cursor: pointer;
	transition: all 0.2s;
}

.btn-toggle-detail:hover {
	background-color: var(--text-title);
	color: #fff;
	border-color: var(--text-title);
}

/* 상품 정보 영역 (이미지, 정보, 버튼그룹) */
.product-section {
	padding: 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.product-info-group {
	display: flex;
	align-items: center;
	flex: 1;
}

.p-img {
	width: 100px;
	height: 100px;
	border-radius: 4px;
	object-fit: cover;
	border: 1px solid #eee;
	margin-right: 20px;
}

.p-text div {
	margin-bottom: 5px;
}

.p-name {
	font-size: 1.1rem;
	font-weight: bold;
	color: #333;
}

.p-price-qty {
	font-size: 0.95rem;
	color: #666;
}

/* 우측 버튼 그룹 (리뷰, 문의) */
.btn-action-group {
	display: flex;
	flex-direction: column;
	gap: 10px;
	min-width: 120px;
}

.btn-action {
	padding: 8px 0;
	text-align: center;
	border-radius: 4px;
	font-size: 0.9rem;
	text-decoration: none;
	display: block;
	transition: 0.3s;
}

.btn-review {
	border: 1px solid var(--accent-color);
	color: var(--accent-color);
	background: #fff;
}

.btn-review:hover {
	background-color: var(--accent-color);
	color: #fff;
}

.btn-qna {
	border: 1px solid #ccc;
	color: #555;
	background: #fff;
}

.btn-qna:hover {
	background-color: #f5f5f5;
}

/* 상세보기 영역 (숨김/표시) */
.detail-section {
	display: none; /* 기본 숨김 */
	padding: 20px;
	background-color: #fafafa;
	border-top: 1px dashed #ddd;
}

.detail-row {
	display: flex;
	margin-bottom: 8px;
	font-size: 0.95rem;
}

.detail-label {
	width: 120px;
	font-weight: bold;
	color: #555;
}

.detail-value {
	color: #333;
	flex: 1;
}

.payment-info {
	margin-top: 20px;
	padding-top: 20px;
	border-top: 1px solid #eee;
	text-align: right;
}

.total-pay-text {
	font-size: 1.2rem;
	font-weight: bold;
	color: #D32F2F;
	margin-bottom: 15px;
}

.btn-delete-order {
	padding: 8px 15px;
	background-color: #fff;
	border: 1px solid #ccc;
	color: #666;
	cursor: pointer;
	font-size: 0.85rem;
	border-radius: 4px;
}

.btn-delete-order:hover {
	background-color: #f5f5f5;
	color: #333;
	border-color: #999;
}

/* 모바일 반응형 */
@media ( max-width : 768px) {
	.product-section {
		flex-direction: column;
		align-items: flex-start;
	}
	.product-info-group {
		margin-bottom: 20px;
	}
	.btn-action-group {
		width: 100%;
		flex-direction: row;
	}
	.btn-action {
		flex: 1;
	}
}
</style>
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
        OrderDAO orderDao = new OrderDAO();
        ArrayList<OrderDTO> list = orderDao.getOrderList(userPK);
        DecimalFormat fmt = new DecimalFormat("###,###");
    %>

	<div class="container">
		<h2 class="page-title">주문 내역</h2>

		<% if(list.size() == 0) { %>
		<div
			style="text-align: center; padding: 80px; background: #f9f9f9; border-radius: 8px; color: #888;">
			주문한 내역이 없습니다.</div>
		<% } else { 
             for(OrderDTO order : list) { 
                 // 배송비 계산 로직 (5만원 이상 무료 가정)
                 int itemPrice = order.getTotalPrice(); // DTO 구조에 따라 조정 필요 (여기선 전체가격이라 가정)
                 int shipping = (itemPrice >= 50000) ? 0 : 3000;
                 int finalPrice = itemPrice; // DB에 이미 배송비 포함인지 미포함인지에 따라 + shipping 로직 추가 필요
        %>
		<div class="order-card">

			<div class="card-header">
				<div class="order-date-no">
					<%= order.getOrderedAt().toString().substring(0, 10) %>
					주문
				</div>
				<button type="button" class="btn-toggle-detail"
					onclick="toggleDetail('detail-<%= order.getOrderId() %>')">
					주문 상세보기 ▾</button>
			</div>

			<div class="product-section">
				<div class="product-info-group">
					<img src="productImage?id=<%= order.getProductId() %>"
						class="p-img" onerror="this.src='image/no_image.png'">

					<div class="p-text">
						<div class="p-name"><%= order.getSummary() != null ? order.getSummary() : order.getPName() %></div>
						<div class="p-price-qty">
							<%= fmt.format(order.getTotalPrice()) %>원
						</div>
						<div style="font-size: 0.85rem; color: #888;">
							옵션:
							<%= order.getColor() %></div>
					</div>
				</div>

				<div class="btn-action-group">
					<a href="reviewWrite.jsp?orderId=<%= order.getOrderId() %>"
						class="btn-action btn-review">리뷰 작성하기</a> <a href="qnaList.jsp"
						class="btn-action btn-qna">판매자 문의</a>
				</div>
			</div>

			<div id="detail-<%= order.getOrderId() %>" class="detail-section">
				<div
					style="margin-bottom: 15px; font-weight: bold; border-bottom: 1px solid #ddd; padding-bottom: 5px;">받는
					사람 정보</div>
				<div class="detail-row">
					<span class="detail-label">받는사람</span> <span class="detail-value"><%= order.getReceiverName() %></span>
				</div>
				<div class="detail-row">
					<span class="detail-label">연락처</span> <span class="detail-value"><%= order.getReceiverPhone() %></span>
				</div>
				<div class="detail-row">
					<span class="detail-label">주소</span> <span class="detail-value"><%= order.getAddress() %></span>
				</div>
				<div class="detail-row">
					<span class="detail-label">배송요청사항</span> <span class="detail-value"><%= order.getRequestMemo() == null ? "-" : order.getRequestMemo() %></span>
				</div>

				<div class="payment-info">
					<div style="font-size: 0.9rem; color: #666; margin-bottom: 5px;">
						총 상품 금액
						<%= fmt.format(itemPrice) %>원 + 배송비
						<%= fmt.format(shipping) %>원
					</div>
					<div class="total-pay-text">
						총 결제 금액 :
						<%= fmt.format(itemPrice + shipping) %>원
					</div>

					<button type="button" class="btn-delete-order"
						onclick="deleteOrder(<%= order.getOrderId() %>)">주문 내역 삭제
					</button>
				</div>
			</div>
		</div>
		<%   } 
           } %>
	</div>

	<jsp:include page="footer.jsp" />

	<script>
        // 상세보기 토글 함수
        function toggleDetail(elementId) {
            var detailBox = document.getElementById(elementId);
            if (detailBox.style.display === "block") {
                detailBox.style.display = "none";
            } else {
                detailBox.style.display = "block";
            }
        }

        // 주문 삭제 함수
        function deleteOrder(orderId) {
            if (confirm("정말로 이 주문 내역을 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
                location.href = "orderDeleteAction.jsp?orderId=" + orderId;
            }
        }
    </script>
</body>
</html>