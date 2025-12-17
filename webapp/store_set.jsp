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

	<div class="store-container">
		<h2 class="page-title"
			style="text-align: left; border-bottom: 1px solid #ddd; padding-bottom: 20px;">
			SET</h2>

		<%
		ProductDAO dao = new ProductDAO();
		ArrayList<ProductDTO> list = dao.getAllProducts();
		DecimalFormat formatter = new DecimalFormat("###,###");
		%>

		<div class="product-grid">
			<%
			boolean hasItem = false;
			for (ProductDTO p : list) {
				String status = p.getStatus();
				if (status != null && "숨김".equals(status.trim())) continue;
				if (!"세트".equals(p.getCategory()))
					continue;
				hasItem = true;
			%>
			<div class="product-item"
				onclick="location.href='productDetail.jsp?id=<%=p.getProductId()%>'">
				<div class="thumb-box">
					<img src="productImage?id=<%=p.getProductId()%>" alt="thumb">

					<%
					if ("품절".equals(p.getStatus()) || p.getStock() <= 0) {
					%>
					<span class="badge-label bg-soldout">품절</span>
					<%
					} else if ("Y".equals(p.getIsNew())) {
					%>
					<span class="badge-label bg-new">새 상품</span>
					<%
					}
					%>
				</div>

				<div class="info-box" style="padding: 10px 0;">
					<div class="p-name"><%=p.getName()%>
						(<%=p.getColor()%>)
					</div>
					<div class="p-price">
						<%
						if (p.getSalePrice() > 0 && p.getSalePrice() < p.getPrice()) {
						%>
						<span
							style="text-decoration: line-through; color: #aaa; font-size: 0.9rem; margin-right: 5px;">
							<%=formatter.format(p.getPrice())%>원
						</span> <span class="p-sale"><%=formatter.format(p.getSalePrice())%>원</span>
						<%
						} else {
						%>
						<%=formatter.format(p.getPrice())%>원
						<%
						}
						%>
					</div>
				</div>
			</div>
			<%
			}
			if (list.size() == 0) {
			%>
			<div style="grid-column: 1/-1; text-align: center; padding: 50px;">등록된
				상품이 없습니다.</div>
			<%
			}
			%>
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>