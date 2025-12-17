<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<style>
/* 페이지 설명 텍스트 */
.page-desc {
	text-align: center;
	margin-bottom: 50px;
	color: #555;
	font-size: 1.1rem;
}

/* 연락처 카드 그리드 (PC: 3열 / 모바일: 1열) */
.contact-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 30px;
	margin-bottom: 50px;
}

/* 카드 디자인 */
.contact-card {
	background-color: #fff;
	border: 1px solid #eee;
	border-radius: 8px;
	padding: 50px 20px;
	text-align: center;
	transition: transform 0.3s, border-color 0.3s;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
}

.contact-card:hover {
	transform: translateY(-10px);
	border-color: var(--accent-color);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
}

.icon-text {
	font-size: 3rem;
	display: block;
	margin-bottom: 20px;
	color: var(--text-title);
}

.contact-card h3 {
	font-size: 1.3rem;
	margin-bottom: 15px;
	font-family: 'Noto Serif KR', serif;
	color: var(--text-title);
}

.highlight {
	font-size: 1.2rem;
	font-weight: bold;
	color: var(--accent-color);
	margin-bottom: 15px;
	display: block;
}

.contact-card p {
	color: #666;
	font-size: 0.95rem;
	line-height: 1.6;
}

/* 하단 안내 박스 */
.consult-box {
	background-color: #FAFAFA;
	border-top: 2px solid var(--text-title);
	padding: 30px;
	text-align: center;
	color: #555;
	line-height: 1.8;
	border-radius: 4px;
}

/* 반응형 (Mobile) */
@media ( max-width : 768px) {
	.contact-grid {
		grid-template-columns: 1fr; /* 모바일에서는 1열로 변경 */
		gap: 20px;
	}
	.contact-card {
		padding: 30px 20px;
	}
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<jsp:include page="menu.jsp" />

	<div class="container">
		<h2 class="page-title">CONTACT US</h2>
		<p class="page-desc">토담은 언제나 여러분의 목소리에 귀 기울이고 있습니다.</p>

		<div class="contact-grid">
			<div class="contact-card">
				<span class="icon-text">☎</span>
				<h3>Customer Center</h3>
				<span class="highlight">031-570-9901</span>
				<p>평일 10:00 - 22:00</p>
			</div>

			<div class="contact-card">
				<span class="icon-text">💬</span>
				<h3>Kakao Talk</h3>
				<span class="highlight">ID : @kbu</span>
				<p>
					카카오톡 채널을 추가하시면<br>빠른 상담이 가능합니다.
				</p>
			</div>

			<div class="contact-card">
				<span class="icon-text">✉</span>
				<h3>E-mail</h3>
				<span class="highlight">todam@gmail.com</span>
				<p>
					대량 구매 및 제휴 문의는<br>메일로 보내주세요.
				</p>
			</div>
		</div>

		<div class="consult-box">
			주말 및 공휴일은 전화 상담이 어려울 수 있습니다.<br> 게시판이나 카카오톡을 남겨주시면 영업일에 순차적으로
			빠르게 답변 드리겠습니다.
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>