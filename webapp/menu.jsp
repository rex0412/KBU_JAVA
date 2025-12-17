<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userID_menu = (String) session.getAttribute("userID");
    String userRole_menu = (String) session.getAttribute("userRole");
%>

<nav id="main-nav">
    <div class="nav-logo">
        <a href="index.jsp"><img src="image/Logo.png" alt="CompanyLogoImage"></a>
    </div>

    <button class="hamburger-btn" id="hamburger-btn" type="button" onclick="toggleMobileMenu()" aria-label="메뉴 열기">
        <span></span><span></span><span></span>
    </button>

    <ul class="nav-menu" id="mobile-menu">
        <li class="mobile-login-item dropdown" style="display: none;">
            <% if(userID_menu == null){ %>
                <a href="login.jsp">로그인 / 회원가입</a>
            <% } else { %>
                <a href="javascript:void(0)" onclick="toggleSubMenu(this)">
                    <%=userID_menu%>님 환영합니다 ▾
                </a>
                <ul class="submenu">
                    <li><a href="cartList.jsp">장바구니</a></li>
                    <li><a href="orderList.jsp">주문내역</a></li>
                    <li><a href="userUpdate.jsp">회원정보수정</a></li>
                    <li><a href="logoutAction.jsp">로그아웃</a></li>
                </ul>
            <% } %>
        </li>

        <li class="dropdown">
            <a href="javascript:void(0)" onclick="toggleSubMenu(this)">회사 소개</a>
            <ul class="submenu">
                <li><a href="company.jsp">회사소개</a></li>
                <li><a href="map.jsp">오시는 길</a></li>
                <li><a href="contact.jsp">연락망</a></li>
                <li><a href="notice.jsp">공지사항</a></li>
                <li><a href="faq.jsp">FAQ</a></li>
                <li><a href="qnaList.jsp">문의하기</a></li>
            </ul>
        </li>

        <li class="dropdown">
            <a href="javascript:void(0)" onclick="toggleSubMenu(this)">스토어</a>
            <ul class="submenu">
            	<li><a href="best_products.jsp" style="color:var(--accent-color); font-weight:bold;">BEST SELLERS</a></li>
                <li><a href="store_all.jsp">모든 제품</a></li>
                <li><a href="store_plate.jsp">접시</a></li>
                <li><a href="store_bowl.jsp">그릇</a></li>
                <li><a href="store_cup.jsp">컵</a></li>
                <li><a href="store_set.jsp">세트 구성</a></li>
                <% if("ADMIN".equals(userRole_menu)) { %>
                    <li><a href="productInsert.jsp">제품 등록</a></li>
                    <li><a href="productList.jsp">제품 목록</a></li>
                <% } %>
            </ul>
        </li>

        <li class="dropdown">
            <a href="javascript:void(0)" onclick="toggleSubMenu(this)">커뮤니티</a>
            <ul class="submenu">
                <li><a href="reviewList.jsp">토담하기</a></li>
            </ul>
        </li>
    </ul>

    <div class="nav-login">
        <% if(userID_menu == null){ %>
            <a href="login.jsp">로그인 / 회원가입</a>
        <% } else { %>
            <ul style="display:inline-block;">
                <li class="dropdown" style="list-style:none;">
                    <a href="javascript:void(0)" style="font-weight: bold;">
                        <%=userID_menu%>님 환영합니다 ▾
                    </a>
                    <ul class="submenu" style="left:auto; right:0; transform:none;">
                        <li><a href="cartList.jsp">장바구니</a></li>
                        <li><a href="orderList.jsp">주문내역</a></li>
                        <li><a href="userUpdate.jsp">회원정보수정</a></li>
                        <li><a href="logoutAction.jsp" style="color:#888;">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
        <% } %>
    </div>
</nav>

<script>
    // 모바일 메뉴 스크립트
    function toggleMobileMenu() {
        var menu = document.getElementById('mobile-menu');
        var btn = document.getElementById('hamburger-btn');
        if (menu) menu.classList.toggle('active');
        if (btn) btn.classList.toggle('active');
    }
    function toggleSubMenu(element) {
        var btn = document.getElementById('hamburger-btn');
        // 모바일 상태인지 체크 (버튼이 보이면 모바일)
        var isMobile = window.getComputedStyle(btn).display !== 'none';
        if(isMobile){
            var submenu = element.nextElementSibling;
            if(submenu){
                submenu.style.display = (submenu.style.display === 'block') ? 'none' : 'block';
            }
        }
    }
</script>