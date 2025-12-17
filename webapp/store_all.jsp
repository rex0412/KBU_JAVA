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
</head>
<body>
	<jsp:include page="header.jsp" />
	<jsp:include page="menu.jsp" />

	<%
		// [추가] 검색어 파라미터 받기
		String searchCategory = request.getParameter("searchCategory");
		if (searchCategory == null) searchCategory = ""; // null 방지
	%>

	<div class="store-container">
		<div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #ddd; padding-bottom: 20px; margin-bottom: 40px;">
			<h2 class="page-title" style="margin-bottom: 0; border: none; padding: 0; text-align: left;">
				ALL PRODUCT
			</h2>
			
			<form action="store_all.jsp" method="get" style="display: flex; gap: 5px;">
				<input type="text" name="searchCategory" placeholder="카테고리 검색 (예 : 접시)" value="<%= searchCategory %>" style="width: 200px; padding: 8px;">
				<button type="submit" class="btn" style="padding: 8px 15px; font-size: 0.9rem; white-space: nowrap;">검색</button>
			</form>
		</div>

		<%
            ProductDAO dao = new ProductDAO();
            ArrayList<ProductDTO> list = dao.getAllProducts();
            DecimalFormat formatter = new DecimalFormat("###,###");
            
            boolean hasItem = false; // 검색 결과 유무 체크용
        %>

		<div class="product-grid">
			<%
                for(ProductDTO p : list) {
                	// 1. 숨김 처리 필터링
                	String status = p.getStatus();
                	if (status != null && "숨김".equals(status.trim())) continue;
                	
                	// 2. [추가] 카테고리 검색 필터링
                	// 검색어가 있을 경우, 상품 카테고리에 검색어가 포함되어 있지 않으면 건너뜀
                	if (!"".equals(searchCategory)) {
                		String pCategory = p.getCategory();
                		if (pCategory == null || !pCategory.contains(searchCategory)) {
                			continue;
                		}
                	}
                	
                	hasItem = true; // 출력할 상품이 있음
            %>
			<div class="product-item"
				onclick="location.href='productDetail.jsp?id=<%= p.getProductId() %>'">
				<div class="thumb-box">
					<img src="productImage?id=<%= p.getProductId() %>" alt="thumb">

					<% if("품절".equals(p.getStatus()) || p.getStock() <= 0) { %>
					<span class="badge-label bg-soldout">품절</span>
					<% } else if("Y".equals(p.getIsNew())) { %>
					<span class="badge-label bg-new">새 상품</span>
					<% } %>
				</div>

				<div class="info-box" style="padding: 10px 0;">
					<div class="p-name"><%= p.getName() %>
						(<%= p.getColor() %>)
					</div>
					<div class="p-price">
						<% if(p.getSalePrice() > 0 && p.getSalePrice() < p.getPrice()) { %>
						<span
							style="text-decoration: line-through; color: #aaa; font-size: 0.9rem; margin-right: 5px;">
							<%= formatter.format(p.getPrice()) %>원
						</span> <span class="p-sale"><%= formatter.format(p.getSalePrice()) %>원</span>
						<% } else { %>
						<%= formatter.format(p.getPrice()) %>원
						<% } %>
					</div>
				</div>
			</div>
			<%
                }
			
				// 상품이 하나도 없을 경우 메시지 출력
                if(!hasItem) {
            %>
			<div style="grid-column: 1/-1; text-align: center; padding: 50px; color: #888;">
				<% if("".equals(searchCategory)) { %>
					등록된 상품이 없습니다.
				<% } else { %>
					'<%= searchCategory %>' 카테고리에 해당하는 상품이 없습니다.
				<% } %>
			</div>
			<% } %>
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>