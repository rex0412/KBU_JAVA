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
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null || !"ADMIN".equals(userRole)) {
            out.println("<script>alert('관리자만 접근 가능합니다.'); location.href='login.jsp';</script>");
            return;
        }
        ProductDAO dao = new ProductDAO();
        ArrayList<ProductDTO> list = dao.getAllProducts();
        DecimalFormat formatter = new DecimalFormat("###,###");
    %>

	<div class="container">
		<h2 class="page-title">상품 관리</h2>
		<div style="text-align: right; margin-bottom: 10px;">
			<a href="productInsert.jsp" class="btn-write">상품 등록</a>
		</div>

		<table class="list-table">
			<thead>
				<tr>
					<th>No.</th>
					<th>이미지</th>
					<th>카테고리</th>
					<th>상품명</th>
					<th>컬러</th>
					<th>가격</th>
					<th>상태</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<% for (int i = 0; i < list.size(); i++) { 
                    ProductDTO p = list.get(i); 
                %>
				<tr>
					<td><%= list.size() - i %></td>
					<td><img src="productImage?id=<%= p.getProductId() %>"
						width="50" style="border-radius: 4px;"
						onerror="this.src='image/no_image.png'"></td>
					<td><%= p.getCategory() %></td>
					<td style="text-align: center; padding-left: 20px;"><%= p.getName() %></td>
					<td><%= p.getColor() %></td>
					<td><%= formatter.format(p.getPrice()) %>원</td>
					<td><%= p.getStatus() %></td>
					<td><a
						href="productUpdate.jsp?productId=<%= p.getProductId() %>"
						class="btn-small btn-white">수정</a></td>
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>