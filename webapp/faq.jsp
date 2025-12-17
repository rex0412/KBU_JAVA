<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<style>
/* 질문 항목 스타일 */
details {
	border-bottom: 1px solid var(--line-color);
	margin-bottom: 5px;
}

summary {
	padding: 20px 10px;
	cursor: pointer;
	font-weight: 500;
	list-style: none; /* 기본 삼각형 제거 */
	display: flex;
	justify-content: space-between;
	align-items: center;
	color: var(--text-title);
	transition: color 0.3s, background 0.3s;
}

/* 크롬/사파리 기본 삼각형 제거 */
summary::-webkit-details-marker {
	display: none;
}

/* 화살표 아이콘 (FontAwesome 활용) */
summary::after {
	content: '\f078'; /* fa-chevron-down */
	font-family: 'Font Awesome 6 Free';
	font-weight: 900;
	font-size: 0.9rem;
	color: #ccc;
	transition: transform 0.3s;
}

/* 열렸을 때 스타일 */
details[open] summary {
	color: var(--accent-color);
	font-weight: 700;
	background-color: #fafafa;
}

details[open] summary::after {
	transform: rotate(180deg);
	color: var(--accent-color);
}

/* 답변 영역 스타일 */
.answer {
	background-color: #fafafa;
	padding: 20px;
	color: #555;
	line-height: 1.8;
	font-size: 0.95rem;
	border-top: 1px dashed #eee;
}

/* 섹션 간격 */
.faq-section {
	margin-bottom: 50px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<jsp:include page="menu.jsp" />

	<div class="container">
		<h2 class="page-title">자주 묻는 질문 (FAQ)</h2>

		<div class="faq-section">
			<h3 class="sec-title">🚚 배송 관련</h3>

			<details class="faq-item">
				<summary>배송은 얼마나 걸리나요?</summary>
				<div class="answer">
					<p>
						평균적으로 <strong>3 ~ 5일 이내에 출고</strong> (영업일 기준)되며,<br> 출고일로부터
						보통 1 ~ 2일(영업일 기준) 이내에 수령하실 수 있습니다.<br> <span
							style="font-size: 0.85rem; color: #888;">(단, 택배사 사정이나 지역에
							따라 1 ~ 2일 추가 소요될 수 있습니다.)</span>
					</p>
				</div>
			</details>

			<details class="faq-item">
				<summary>배송비는 얼마인가요?</summary>
				<div class="answer">
					<p>
						기본 배송비는 <strong>3,000원</strong>이며, <strong>5만 원 이상 구매 시
							무료배송</strong>입니다.<br> <span style="font-size: 0.85rem; color: #888;">(제주
							및 도서산간 지역은 3,000 ~ 5,000원의 추가 배송료가 발생합니다.)</span>
					</p>
				</div>
			</details>
		</div>

		<div class="faq-section">
			<h3 class="sec-title">🔄 반품 / 교환 / 환불</h3>

			<details class="faq-item">
				<summary>반품 및 교환은 어떻게 신청하나요?</summary>
				<div class="answer">
					<p>
						제품 수령 후 7일 이내에 신청 가능합니다.<br> 빠른 처리를 위해 <strong>카카오톡
							@kbu</strong> 또는 <strong>031-570-9901</strong>로 연락 부탁드립니다.
					</p>
				</div>
			</details>

			<details class="faq-item">
				<summary>환불은 언제 처리되나요?</summary>
				<div class="answer">
					<p>
						반품 수거가 완료되고 제품 검수가 끝난 후,<br> <strong>1 ~ 3 영업일 이내</strong>에
						결제하신 수단으로 환불 처리가 진행됩니다.
					</p>
				</div>
			</details>
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>