<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	%>

	<div class="container">
		<h2 class="page-title">상품 등록</h2>

		<form action="productInsert" method="post"
			enctype="multipart/form-data">
			<table class="form-table">
				<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="15%">
					<col width="35%">
				</colgroup>
				<tr>
					<th>카테고리</th>
					<td><select name="category" required>
							<option value="접시">접시</option>
							<option value="그릇">그릇</option>
							<option value="컵">컵</option>
							<option value="세트">세트 구성</option>
							<option value="기타">기타</option>
					</select></td>
					<th>상태</th>
					<td><select name="status">
							<option value="판매중">판매중</option>
							<option value="품절">품절</option>
							<option value="숨김">숨김</option>
					</select></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><input type="text" name="name" required></td>
					<th>컬러</th>
					<td><select name="color">
							<option value="None">None</option>
							<option value="Candy Pink">Candy Pink</option>
							<option value="Girasol Yellow">Girasol Yellow</option>
							<option value="Summit White">Summit White</option>
					</select></td>
				</tr>
				<tr>
					<th>정상가</th>
					<td><input type="number" name="price" required></td>
					<th>할인가</th>
					<td><input type="number" name="sale_price" value="0"></td>
				</tr>
				<tr>
					<th>재고</th>
					<td colspan="3"><input type="number" name="stock" value="0"></td>
				</tr>
				<tr>
					<th>썸네일</th>
					<td colspan="3"><input type="file" name="thumbnail" required
						accept="image/*">
						<div style="font-size: 0.8rem; color: #888; margin-top: 5px;">*
							목록에 보여질 대표 이미지</div></td>
				</tr>
				<tr>
					<th>옵션</th>
					<td colspan="3"><label><input type="checkbox"
							name="is_new" value="Y"> <span
							style="font-weight: bold; color: #B07C5D;">NEW 표시</span></label></td>
				</tr>
				<tr>
					<th>상세설명</th>
					<td colspan="3" class="editor-td"><textarea id="summernote"
							name="description"></textarea></td>
				</tr>
			</table>

			<div class="btn-group">
				<button type="button" class="btn-cancel" onclick="history.back()">취소</button>
				<button type="submit" class="btn-write">상품 등록</button>
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
														[ 'insert',
																[ 'picture' ] ] ]
											});
						});
	</script>
</body>
</html>