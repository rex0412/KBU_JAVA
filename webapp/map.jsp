<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<style>
/* 지도 이미지 영역 */
.map-visual {
	margin-bottom: 50px;
	border: 1px solid #ddd;
	padding: 10px;
	background-color: #fff;
	border-radius: 4px;
}

.map-visual img {
	width: 100%;
	height: auto;
	display: block;
}

/* 정보 그리드 (PC: 2열 / 모바일: 1열) */
.map-info-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr); /* 기본 2열 */
	gap: 30px;
}

/* 정보 카드 스타일 */
.info-item {
	background-color: #fff;
	border: 1px solid #eee;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.03);
	transition: transform 0.3s;
}

.info-item:hover {
	transform: translateY(-5px);
	border-color: var(--accent-color);
}

.info-item h3 {
	font-size: 1.2rem;
	font-family: 'Noto Serif KR', serif;
	border-bottom: 2px solid var(--text-title);
	padding-bottom: 10px;
	margin-bottom: 20px;
	color: var(--text-title);
}

.info-item p, .info-item address {
	font-style: normal;
	margin-bottom: 10px;
	color: #555;
	line-height: 1.6;
}

.info-item strong {
	color: #333;
	font-weight: 600;
	display: inline-block;
	min-width: 60px; /* 라벨 너비 고정 */
}

/* 교통편 강조 */
.transport-label {
	display: inline-block;
	background-color: #f0f0f0;
	padding: 2px 8px;
	border-radius: 4px;
	font-size: 0.9rem;
	margin-bottom: 5px;
	font-weight: bold;
	color: var(--text-title);
}

/* 반응형 (Mobile) */
@media ( max-width : 768px) {
	.map-info-grid {
		grid-template-columns: 1fr; /* 모바일에서는 1열로 변경 */
		gap: 20px;
	}
	.info-item {
		padding: 20px;
	}
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<jsp:include page="menu.jsp" />

	<div class="container">
		<h2 class="page-title">LOCATION</h2>

		<div class="map-visual">
			<img src="image/Map.png" alt="토담 공방 위치: 경기도 남양주시 진접읍 경복대로 425">
		</div>

		<div class="map-info-grid">
			<div class="info-item">
				<h3>ADDRESS</h3>
				<address>
					경기도 남양주시 진접읍 경복대로 425<br> (우) 12051
				</address>
				<p style="margin-top: 15px; font-size: 0.9rem; color: #888;">*
					주차 가능 공간이 협소하오니 대중교통 이용을 권장합니다.</p>
			</div>

			<div class="info-item">
				<h3>CONTACT</h3>
				<p>
					<strong>Tel</strong> 031-570-9901
				</p>
				<p>
					<strong>Email</strong> TODAM@gmail.com
				</p>
				<p>
					<strong>Kakao</strong> @kbu
				</p>
			</div>

			<div class="info-item">
				<h3>OPENING HOURS</h3>
				<p>
					<strong>Mon - Fri</strong> 10:00 - 22:00
				</p>
				<p style="color: #D32F2F;">* 공휴일 및 명절 당일 휴무</p>
			</div>

			<div class="info-item">
				<h3>WAY TO COME</h3>
				<div style="margin-bottom: 15px;">
					<span class="transport-label">Subway</span>
					<p>
						4호선 <strong>진접역</strong> 하차 후 버스 환승
					</p>
				</div>
				<div>
					<span class="transport-label">Bus</span>
					<p>
						일반: 9, 92, 202, 땡큐60/70/72<br> 직행: 100, 105, 2000, 8012
					</p>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>