<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<style>
.intro-text-box {
	text-align: center;
	margin-bottom: 50px;
	line-height: 1.8;
	color: #555;
}

.intro-text-box strong {
	color: var(--text-title);
	font-weight: 700;
	font-size: 1.1rem;
}

.intro-text-box p {
	margin-bottom: 20px;
}

.feature-box {
	background-color: #FAFAFA;
	border: 1px solid #eee;
	padding: 30px;
	border-radius: 8px;
	margin-bottom: 50px;
}

.company-features {
	margin-left: 20px;
	list-style-type: decimal; /* 번호 표시 복구 */
}

.company-features li {
	margin-bottom: 10px;
	padding-left: 5px;
}

.company-features strong {
	color: var(--accent-color);
}

/* 모바일 반응형 */
@media ( max-width : 768px) {
	.intro-text-box {
		text-align: left;
		word-break: keep-all;
	}
	.intro-text-box br {
		display: none;
	} /* 모바일에서 강제 줄바꿈 해제 */
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<jsp:include page="menu.jsp" />

	<div class="container">
		<h2 class="page-title">회사소개</h2>

		<div class="intro-text-box">
			<p>
				<strong>토담</strong>은 그릇을 중심으로 다양한 콘텐츠와 커뮤니티를 구축하고 있으며,<br> <strong>양질의
					쇼핑정보</strong>를 제공하고자 합니다.
			</p>
			<p>
				소비자의 구매 결정을 돕고, 다양한 커뮤니티를 통해 자발적으로 정보와 토론의 장을 형성하게 하며<br> 알찬 쇼핑
				콘텐츠와 서비스로 소비자를 만족시키는 것이야말로 사이트의 본질입니다.<br> 이러한 온라인 쇼핑의 관문이자
				첫걸음이 되기 위해<br> 토담은 모든 핵심역량을 고객만족에 집중하고 있습니다.
			</p>
		</div>

		<div class="sec-title">SERVICE n VISION</div>
		<div class="feature-box">
			<ol class="company-features">
				<li><strong>접시, 그릇, 컵, 세트 구성</strong>에 대한 전문적인 쇼핑 서비스를 제공합니다.</li>
				<li>상품에 관한 자세한 스펙과 옵션 별 상세 정보를 제공합니다.</li>
				<li>원하는 상품을 쉽게 찾을 수 있는 통합 검색 서비스를 제공합니다.</li>
			</ol>
		</div>

		<div class="sec-title">COMPANY INFO</div>
		<table class="view-table">
			<colgroup>
				<col width="30%">
				<col width="70%">
			</colgroup>
			<tr>
				<th>회사명</th>
				<td>토담 (TO:DAM)</td>
			</tr>
			<tr>
				<th>대표</th>
				<td>경복대학교</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>(우)12051 경기도 남양주시 진접읍 경복대로 425</td>
			</tr>
			<tr>
				<th>고객센터</th>
				<td>031-570-9901</td>
			</tr>
		</table>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>