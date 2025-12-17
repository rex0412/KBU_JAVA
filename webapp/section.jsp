<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
/* 메인 비주얼 이미지 영역 */
.main-visual-grid {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	margin-bottom: 60px;
}

.visual-item {
	flex: 1;
	overflow: hidden;
	border-radius: 8px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
}

.visual-item img {
	width: 100%;
	height: 300px;
	object-fit: cover;
	transition: transform 0.5s ease;
}

.visual-item:hover img {
	transform: scale(1.05);
}

/* 정보 박스 영역 (Notice, Service, Store) */
.main-info-grid {
	display: flex;
	gap: 30px;
}

.info-box {
	flex: 1;
	background-color: #fff;
	border: 1px solid #eee;
	padding: 40px 30px;
	text-align: center;
	border-radius: 8px;
	transition: transform 0.3s, border-color 0.3s;
}

.info-box:hover {
	transform: translateY(-5px);
	border-color: var(--accent-color);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.03);
}

.info-box h3 {
	font-family: 'Noto Serif KR', serif;
	font-size: 1.4rem;
	color: var(--text-title);
	margin-bottom: 20px;
	position: relative;
	display: inline-block;
}

.info-box h3::after {
	content: '';
	display: block;
	width: 40px;
	height: 2px;
	background-color: var(--line-color);
	margin: 10px auto 0;
}

.info-box p {
	color: #666;
	line-height: 1.8;
	font-size: 0.95rem;
}

/* 반응형 (Mobile) */
@media ( max-width : 768px) {
	/* 이미지 세로 나열 */
	.main-visual-grid {
		flex-direction: column;
		gap: 15px;
		margin-bottom: 40px;
	}
	.visual-item img {
		height: 200px; /* 모바일에서는 높이 축소 */
	}

	/* 정보 박스 세로 나열 */
	.main-info-grid {
		flex-direction: column;
		gap: 20px;
	}
	.info-box {
		padding: 30px 20px;
	}
}
</style>

<div class="container">
	<div class="main-visual-grid">
		<div class="visual-item">
			<img src="image/Pottery.png" alt="Pottery Class">
		</div>
		<div class="visual-item">
			<img src="image/WorkShop.png" alt="Workshop Interior">
		</div>
		<div class="visual-item">
			<img src="image/Ceramic.png" alt="Ceramic Art">
		</div>
	</div>

	<div class="main-info-grid">
		<div class="info-box">
			<h3>Notice</h3>
			<p>
				주문 전 공지 사항<br> 확인 후 신중한 구매 부탁드립니다.
			</p>
		</div>
		<div class="info-box">
			<h3>Customer Service</h3>
			<p>
				<strong>Kakao</strong> @kbu<br> 10:00 ~ 22:00 / 7 days a week<br>
				<br> <span style="font-size: 0.85rem; color: #999;">(주말은
					답변이 늦어질 수 있습니다.)</span>
			</p>
		</div>
		<div class="info-box">
			<h3>Store Info</h3>
			<p>
				<strong>Tel.</strong> 031-570-9901<br> 경기도 남양주시 진접읍 경복대로 425<br>
				<br> OPEN 10:00 - CLOSE 22:00
			</p>
		</div>
	</div>
</div>