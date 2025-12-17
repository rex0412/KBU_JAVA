<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO"%>
<%@ page import="dto.ProductDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.min.js"></script>
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

	String productIdStr = request.getParameter("productId");
	if (productIdStr == null) {
		out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
		return;
	}

	ProductDAO dao = new ProductDAO();
	ProductDTO p = dao.getProductById(Integer.parseInt(productIdStr));

	if (p == null) {
		out.println("<script>alert('존재하지 않는 상품입니다.'); history.back();</script>");
		return;
	}
	%>

	<div class="admin-container">
		<h2 class="admin-title">상품 관리</h2>
		<h3 class="admin-sub-title">상품 정보 수정</h3>
		<form action="productUpdate" method="post"
			enctype="multipart/form-data">
			<input type="hidden" name="productId" value="<%=p.getProductId()%>">

			<!-- [수정됨] original_image 히든값 삭제 (DB 저장 방식이므로 불필요) -->

			<table class="admin-form-table">
				<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="15%">
					<col width="35%">
				</colgroup>
				<tr>
					<th>카테고리</th>
					<td><select name="category" required>
							<option value="접시"
								<%="접시".equals(p.getCategory()) ? "selected" : ""%>>접시</option>
							<option value="그릇"
								<%="그릇".equals(p.getCategory()) ? "selected" : ""%>>그릇</option>
							<option value="컵"
								<%="컵".equals(p.getCategory()) ? "selected" : ""%>>컵</option>
							<option value="세트"
								<%="세트".equals(p.getCategory()) ? "selected" : ""%>>세트
								구성</option>
							<option value="기타"
								<%="기타".equals(p.getCategory()) ? "selected" : ""%>>기타</option>
					</select></td>
					<th>상태</th>
					<td><select name="status">
							<option value="판매중"
								<%="판매중".equals(p.getStatus()) ? "selected" : ""%>>판매중</option>
							<option value="품절"
								<%="품절".equals(p.getStatus()) ? "selected" : ""%>>품절</option>
							<option value="숨김"
								<%="숨김".equals(p.getStatus()) ? "selected" : ""%>>숨김</option>
					</select></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><input type="text" name="name" required
						value="<%=p.getName()%>"></td>
					<th>컬러</th>
					<td><select name="color">
							<option value="None"
								<%="None".equals(p.getColor()) ? "selected" : ""%>>None</option>
							<option value="Candy Pink"
								<%="Candy Pink".equals(p.getColor()) ? "selected" : ""%>>Candy
								Pink</option>
							<option value="Girasol Yellow"
								<%="Girasol Yellow".equals(p.getColor()) ? "selected" : ""%>>Girasol
								Yellow</option>
							<option value="Summit White"
								<%="Summit White".equals(p.getColor()) ? "selected" : ""%>>Summit
								White</option>
					</select></td>
				</tr>
				<tr>
					<th>정상가</th>
					<td><input type="number" name="price" required
						value="<%=p.getPrice()%>"></td>
					<th>할인가</th>
					<td><input type="number" name="sale_price"
						value="<%=p.getSalePrice()%>"></td>
				</tr>
				<tr>
					<th>재고</th>
					<td colspan="3"><input type="number" name="stock"
						value="<%=p.getStock()%>"></td>
				</tr>
				<tr>
					<th>목록 썸네일</th>
					<td colspan="3">
						<div style="margin-bottom: 10px;">
							<!-- [수정됨] 서블릿을 통해 미리보기 이미지 로드 -->
							현재 이미지: <img src="productImage?id=<%=p.getProductId()%>"
								width="50"
								style="vertical-align: middle; border: 1px solid #ddd;"
								onerror="this.src='image/no_image.png'">
						</div> <input type="file" name="thumbnail" accept="image/*">
						<p style="font-size: 0.8rem; color: #888; margin-top: 5px;">*
							새로운 파일을 선택하면 이미지가 교체됩니다. 선택하지 않으면 기존 이미지가 유지됩니다.</p>
					</td>
				</tr>

				<tr>
					<th>옵션 설정</th>
					<td colspan="3"><label class="checkbox-label"
						style="font-weight: 500; cursor: pointer;"> <input
							type="checkbox" name="is_new" value="Y"
							<%="Y".equals(p.getIsNew()) ? "checked" : ""%>
							style="width: auto; margin-right: 8px;"> <span
							style="color: #B07C5D; font-weight: bold;">NEW 표시</span>
					</label></td>
				</tr>

				<tr>
					<th>상세 설명</th>
					<td colspan="3"><textarea id="summernote" name="description"><%=p.getDescription()%></textarea>
					</td>
				</tr>
			</table>

			<div class="btn-group" style="margin-top: 30px;">
				<button type="button" class="btn-cancel" onclick="history.back()">취소</button>
				<button type="button" class="btn-cancel"
					style="background-color: #d32f2f; color: white; border: none;"
					onclick="deleteProduct()">삭제</button>
				<button type="submit" class="btn-write">수정 완료</button>
			</div>
		</form>
	</div>
	<jsp:include page="footer.jsp" />
	<script>
		$(document)
				.ready(
						function() {
							$('#summernote')
									.summernote(
											{
												placeholder : '상품 상세 설명을 입력하세요.',
												tabsize : 2,
												height : 400,
												lang : 'ko-KR',
												toolbar : [
														[
																'style',
																[
																		'bold',
																		'italic',
																		'underline',
																		'clear' ] ],
														[
																'para',
																[ 'ul', 'ol',
																		'paragraph' ] ],
														[
																'insert',
																[ 'picture',
																		'link',
																		'video' ] ],
														[
																'view',
																[ 'fullscreen',
																		'codeview' ] ] ]
											});
						});
		function deleteProduct() {
			if (confirm('정말로 이 상품을 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.')) {
				location.href = 'productDelete?productId=<%=p.getProductId()%>';
            }
        }
    </script>
</body>
</html>