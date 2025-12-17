<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="dto.ReviewDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<style>
    /* 검색창 디자인 추가 */
    .search-container {
        display: flex;
        justify-content: space-between; /* 양끝 정렬 (검색창 vs 글쓰기버튼) */
        align-items: center;
        margin-bottom: 15px;
    }
    .search-form {
        display: flex;
        gap: 5px;
    }
    .search-input {
        padding: 8px 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        width: 200px;
    }
    .btn-search {
        padding: 8px 15px;
        background-color: var(--text-title);
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn-search:hover {
        background-color: var(--accent-color);
    }
</style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="menu.jsp" />

    <%
        // 1. 페이지 번호 받기
        int pageNumber = 1;
        if (request.getParameter("pageNumber") != null) {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }

        // 2. [추가] 검색어 받기 (null이면 빈 문자열 처리)
        String searchTitle = request.getParameter("searchTitle");
        if (searchTitle == null) searchTitle = "";

        // 3. DAO 호출 (검색어 파라미터 전달)
        // 주의: ReviewDAO에 getList(int page, String search) 메서드가 있어야 함
        ReviewDAO reviewDAO = new ReviewDAO();
        ArrayList<ReviewDTO> list = reviewDAO.getList(pageNumber, searchTitle); 
        int totalCount = reviewDAO.getTotalCount(searchTitle); 
        int totalPage = (totalCount + 9) / 10;
    %>

    <div class="board-container">
        <h2 class="page-title">REVIEW</h2>
        
        <div class="search-container">
            <form action="reviewList.jsp" method="get" class="search-form">
                <input type="text" name="searchTitle" class="search-input" 
                       placeholder="제목 검색" value="<%= searchTitle %>">
                <button type="submit" class="btn-search">검색</button>
            </form>

            <a href="reviewWrite.jsp" class="btn-write">글쓰기</a>
        </div>

        <table class="list-table">
            <colgroup>
                <col width="8%"><col width="15%"><col width="*"><col width="12%"><col width="12%"><col width="8%"><col width="8%">
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th><th>별점</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회</th><th>추천</th>
                </tr>
            </thead>
            <tbody>
                <% if (list.size() == 0) { %>
                    <tr><td colspan="7" style="padding: 50px;">
                        <% if(searchTitle.equals("")) { %>
                            등록된 리뷰가 없습니다.
                        <% } else { %>
                            '<%= searchTitle %>' 검색 결과가 없습니다.
                        <% } %>
                    </td></tr>
                <% } else {
                        for (int i = 0; i < list.size(); i++) {
                            ReviewDTO review = list.get(i);
                            int displayNum = totalCount - ((pageNumber - 1) * 10) - i;
                            String stars = "";
                            for(int s=0; s<review.getRating(); s++) stars += "★";
                            for(int s=review.getRating(); s<5; s++) stars += "☆";
                %>
                    <tr>
                        <td><%= displayNum %></td>
                        <td style="color:#FFD700; letter-spacing:2px;"><%= stars %></td>
                        <td class="title">
                            <a href="reviewDetail.jsp?reviewId=<%= review.getReviewId() %>">
                                <%= review.getTitle() %>
                            </a>
                        </td>
                        <td><%= review.getUserName() != null ? review.getUserName() : "익명" %></td>
                        <td><%= review.getCreatedAt() %></td>
                        <td><%= review.getViews() %></td>
                        <td><%= review.getLikeCount() %></td>
                    </tr>
                <% } } %>
            </tbody>
        </table>

        <div class="pagination">
            <%
                int startPage = (pageNumber - 1) / 10 * 10 + 1;
                int endPage = startPage + 9;
                if (endPage > totalPage) endPage = totalPage;
                
                // 검색어가 있을 경우 링크에 추가할 파라미터 문자열 생성
                String searchParam = "";
                if(!searchTitle.equals("")) {
                    // 한글 검색어 깨짐 방지를 위해 인코딩이 필요할 수 있으나, 기본적으로 톰캣 설정이 되어있다면 그대로 전송
                    searchParam = "&searchTitle=" + searchTitle;
                }

                if (startPage > 10) { 
            %> 
                <a href="reviewList.jsp?pageNumber=<%= startPage - 10 %><%= searchParam %>">&lt;</a> 
            <% } %>
            
            <% for (int i = startPage; i <= endPage; i++) { %>
                <a href="reviewList.jsp?pageNumber=<%= i %><%= searchParam %>" 
                   class="<%= (i == pageNumber) ? "active" : "" %>"><%= i %></a>
            <% } %>
            
            <% if (endPage < totalPage) { %> 
                <a href="reviewList.jsp?pageNumber=<%= startPage + 10 %><%= searchParam %>">&gt;</a> 
            <% } %>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>