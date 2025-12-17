<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dao.ProductDAO"%>
<%@ page import="dto.ProductDTO"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<style>
/* 베스트 상품 전용 뱃지 스타일 */
.rank-badge {
	position: absolute;
	top: 0;
	left: 0;
	width: 40px;
	height: 40px;
	background-color: var(--accent-color);
	color: #fff;
	font-weight: bold;
	font-size: 1.2rem;
	display: flex;
	justify-content: center;
	align-items: center;
	border-bottom-right-radius: 10px;
	z-index: 5;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
}

/* 1등은 금색, 2등 은색, 3등 동색 느낌 주기 */
.rank-1 {
	background-color: #FFD700;
	color: #fff;
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
} /* Gold */
.rank-2 {
	background-color: #C0C0C0;
	color: #fff;
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
} /* Silver */
.rank-3 {
	background-color: #CD7F32;
	color: #fff;
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
} /* Bronze */
.best-crown {
	font-size: 2rem;
	color: #FFD700;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<jsp:include page="menu.jsp" />

	<div class="store-container">
		<div style="text-align: center; margin-bottom: 40px;">
			<div class="best-crown">
				<i class="fa-solid fa-crown"></i>
			</div>
			<h2 class="page-title" style="margin-bottom: 10px; border: none;">BEST
				SELLERS</h2>
			<p style="color: #666;">토담에서 가장 사랑받는 인기 상품 TOP 3</p>
		</div>

		<%
            ProductDAO dao = new ProductDAO();
            ArrayList<ProductDTO> list = dao.getBestProducts();
            DecimalFormat formatter = new DecimalFormat("###,###");
        %>

		<div class="product-grid" style="justify-content: center;">
			<%
                if (list.size() == 0) {
            %>
			<div
				style="width: 100%; text-align: center; padding: 50px; color: #888;">
				아직 집계된 베스트 상품이 없습니다.</div>
			<%
                } else {
                    for (int i = 0; i < list.size(); i++) {
                        ProductDTO p = list.get(i);
                        int rank = i + 1;
                        String rankClass = "rank-" + rank;
            %>
			<div class="product-item"
				onclick="location.href='productDetail.jsp?id=<%= p.getProductId() %>'">
				<div class="thumb-box">
					<div class="rank-badge <%= rankClass %>"><%= rank %></div>

					<img src="productImage?id=<%= p.getProductId() %>"
						alt="<%= p.getName() %>">

					<% if("품절".equals(p.getStatus())) { %>
					<span class="badge-label bg-soldout"
						style="left: auto; right: 10px;">품절</span>
					<% } %>
				</div>

				<div class="info-box" style="padding: 15px 0; text-align: center;">
					<div class="p-name" style="font-size: 1.1rem; font-weight: bold;"><%= p.getName() %></div>
					<div class="p-price">
						<% if(p.getSalePrice() > 0 && p.getSalePrice() < p.getPrice()) { %>
						<span
							style="text-decoration: line-through; color: #aaa; font-size: 0.9rem; margin-right: 5px;">
							<%= formatter.format(p.getPrice()) %>원
						</span> <span class="p-sale" style="font-size: 1.1rem;"><%= formatter.format(p.getSalePrice()) %>원</span>
						<% } else { %>
						<span style="font-size: 1.1rem;"><%= formatter.format(p.getPrice()) %>원</span>
						<% } %>
					</div>
				</div>
			</div>
			<%
                    }
                }
            %>
		</div>

		<div class="btn-group" style="margin-top: 60px;">
			<a href="store_all.jsp" class="btn-white"
				style="border-radius: 30px; padding: 15px 40px;">전체 상품 보러가기</a>
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>