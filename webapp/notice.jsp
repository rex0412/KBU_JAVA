<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<style>
.notice-list li {
	position: relative;
	padding-left: 15px;
	margin-bottom: 8px;
	line-height: 1.6;
	color: #555;
}

.notice-list li::before {
	content: '•';
	position: absolute;
	left: 0;
	color: var(--text-title);
}

.notice-warning {
	background: #FFF5F5;
	color: #D32F2F;
	padding: 15px;
	border-radius: 4px;
	margin-top: 15px;
	font-weight: 500;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<jsp:include page="menu.jsp" />

	<div class="container">
		<h2 class="page-title">구매 전 필독 사항</h2>
		<p style="text-align: center; color: #888; margin-bottom: 50px;">2025.11.07
			| 관리자</p>

		<div class="sec-title">CAUTION (주의사항)</div>
		<ul class="notice-list">
			<li>전자레인지 및 오븐 사용은 권장하지 않습니다. 수분이나 열로 인해 파손될 수 있습니다.</li>
			<li>금속 제품(커트러리 등)과의 충격은 스크래치를 유발할 수 있습니다.</li>
			<li>무광 유약 제품은 음식물 착색에 취약하므로 사용 후 즉시 세척해주세요.</li>
			<li>커피, 와인 등 진한 색소 음료는 착색의 원인이 됩니다.</li>
			<li>식기세척기 사용 가능하나, 다른 그릇과의 충돌에 주의해주세요.</li>
		</ul>

		<div class="sec-title">CHECK LIST (자연스러운 현상)</div>
		<p style="margin-bottom: 15px; color: #666;">수공예 도자기 특성상 아래 현상은
			불량이 아닙니다.</p>
		<ul class="notice-list">
			<li>유약의 흐름, 기포, 맺힘 자국</li>
			<li>표면의 미세한 요철이나 흑점(철분)</li>
			<li>가마 소성 과정에서의 미세한 크기 차이</li>
			<li>무광 제품의 미세한 빙렬(거미줄 같은 금)</li>
		</ul>
		<div class="notice-warning">위와 같은 사유는 수공예 도자기 고유의 특성이므로 교환/반품
			사유가 되지 않습니다.</div>

		<div class="sec-title">NOTICE (배송/반품)</div>
		<ul class="notice-list">
			<li>배송사: 로젠택배 (기본 3,000원 / 7만원 이상 무료)</li>
			<li>배송기간: 영업일 기준 3~5일 소요</li>
			<li>반품/교환: 수령 후 7일 이내, 카카오톡 @kbu 또는 고객센터로 연락주세요.</li>
			<li>단순 변심 반품 시 왕복 배송비(6,000원)는 고객 부담입니다.</li>
		</ul>

		<div class="sec-title">COLOR INFO</div>
		<table class="list-table" style="margin-top: 20px;">
			<thead>
				<tr>
					<th>색상명</th>
					<th>광도</th>
					<th>착색주의</th>
					<th>스크래치</th>
					<th>전자레인지</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Candy Pink</td>
					<td>Semi-Matte</td>
					<td>O</td>
					<td>O</td>
					<td>X</td>
				</tr>
				<tr>
					<td>Girasol Yellow</td>
					<td>Semi-Matte</td>
					<td>O</td>
					<td>O</td>
					<td>X</td>
				</tr>
				<tr>
					<td>Summit White</td>
					<td>Semi-Matte</td>
					<td>O</td>
					<td>O</td>
					<td>X</td>
				</tr>
			</tbody>
		</table>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>