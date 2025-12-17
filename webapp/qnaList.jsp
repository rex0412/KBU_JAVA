<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.QnaDAO" %>
<%@ page import="dto.QnaDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="menu.jsp" />

    <%
        int pageNumber = 1;
        if (request.getParameter("pageNumber") != null) pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        String searchCategory = request.getParameter("searchCategory");
        if (searchCategory == null) searchCategory = "";

        String userID = (String) session.getAttribute("userID");
        String userRole = (String) session.getAttribute("userRole");

        QnaDAO qnaDAO = new QnaDAO();
        ArrayList<QnaDTO> list = qnaDAO.getList(pageNumber, searchCategory);
        int totalCount = qnaDAO.getTotalCount(searchCategory);
        int totalPage = (totalCount + 9) / 10;
    %>

    <div class="board-container">
        <h2 class="page-title">Q n A</h2>
        
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:15px;">
            <form action="qnaList.jsp" method="get" style="display:flex; gap:5px;">
                <input type="text" name="searchCategory" placeholder="카테고리 검색" value="<%= searchCategory %>" style="width:200px; padding:8px;">
                <button type="submit" class="btn-search" style="padding:8px 15px;">검색</button>
            </form>
            <a href="<%= (userID != null) ? "qnaWrite.jsp" : "javascript:alert('로그인이 필요합니다.');location.href='login.jsp';" %>" class="btn-write">문의하기</a>
        </div>

        <table class="list-table">
            <colgroup>
                <col width="8%"><col width="15%"><col width="*"><col width="12%"><col width="12%"><col width="10%">
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th><th>카테고리</th><th>제목</th><th>작성자</th><th>작성일</th><th>상태</th>
                </tr>
            </thead>
            <tbody>
                <% if (list.size() == 0) { %>
                    <tr><td colspan="6" style="padding:50px;">등록된 문의가 없습니다.</td></tr>
                <% } else {
                    for (int i = 0; i < list.size(); i++) {
                        QnaDTO qna = list.get(i);
                        int displayNum = totalCount - ((pageNumber - 1) * 10) - i;
                        boolean isSecret = "Y".equals(qna.getIsSecret());
                        boolean canRead = !isSecret || "ADMIN".equals(userRole) || (userID != null && userID.equals(qna.getUserName()));
                %>
                    <tr>
                        <td><%= displayNum %></td>
                        <td><%= qna.getProductName() %></td>
                        <td class="title">
                            <% if (canRead) { %>
                                <a href="qnaDetail.jsp?qnaId=<%= qna.getQnaId() %>">
                                    <%= qna.getTitle() %> <%= isSecret ? "🔒" : "" %>
                                </a>
                            <% } else { %>
                                <span style="color:#999; cursor:not-allowed;">비밀글입니다. 🔒</span>
                            <% } %>
                        </td>
                        <td><%= qna.getUserName() %></td>
                        <td><%= qna.getCreatedAt().toString().substring(0,10) %></td>
                        <td>
                            <% if ("COMPLETED".equals(qna.getStatus())) { %>
                                <span class="badge completed">답변완료</span>
                            <% } else { %>
                                <span class="badge waiting">답변대기</span>
                            <% } %>
                        </td>
                    </tr>
                <% } } %>
            </tbody>
        </table>

        <div class="pagination">
            <%
                int startPage = (pageNumber - 1) / 10 * 10 + 1;
                int endPage = startPage + 9;
                if (endPage > totalPage) endPage = totalPage;
                if (startPage > 10) { %> <a href="qnaList.jsp?pageNumber=<%= startPage - 10 %>">&lt;</a> <% }
                for (int i = startPage; i <= endPage; i++) { %>
                <a href="qnaList.jsp?pageNumber=<%= i %>" class="<%= (i == pageNumber) ? "active" : "" %>"><%= i %></a>
                <% }
                if (endPage < totalPage) { %> <a href="qnaList.jsp?pageNumber=<%= startPage + 10 %>">&gt;</a> <% }
            %>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>