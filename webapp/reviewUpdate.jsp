<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="dto.ReviewDTO" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>

<!-- Summernote & Bootstrap -->
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.min.js"></script>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="menu.jsp" />

    <%
        String reviewIdStr = request.getParameter("reviewId");
        if (reviewIdStr == null) {
            out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
            return;
        }
        int reviewId = Integer.parseInt(reviewIdStr);

        ReviewDAO dao = new ReviewDAO();
        ReviewDTO r = dao.getReview(reviewId);

        if (r == null) {
            out.println("<script>alert('존재하지 않는 게시글입니다.'); history.back();</script>");
            return;
        }
        
        // 권한 체크 (회원인 경우 본인 확인)
        String sessionUserID = (String) session.getAttribute("userID");
        // 익명 글(userId=0)은 누구나 폼에 접근 가능 (비밀번호로 검증)
        // 회원 글(userId>0)은 세션 ID와 비교
        /* (DAO에서 getUserPK 등을 통해 ID 비교 로직이 필요하지만, 여기서는 간단히 처리) */
    %>

    <div class="board-container">
        <div class="board-header">
            <h2>리뷰 수정</h2>
        </div>

        <form action="reviewUpdateAction.jsp" method="post" class="write-form">
            <input type="hidden" name="reviewId" value="<%= reviewId %>">
            
            <table class="write-table">
                <colgroup>
                    <col width="15%">
                    <col width="35%">
                    <col width="15%">
                    <col width="35%">
                </colgroup>
                <tbody>
                    <tr>
                        <th>제목</th>
                        <td colspan="3">
                            <input type="text" name="title" value="<%= r.getTitle() %>" required>
                        </td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td>
                            <input type="text" value="<%= r.getUserName() %>" readonly class="input-readonly">
                        </td>
                        <th>상품 선택</th>
                        <td>
                            <select name="productId" required style="width:100%; padding:10px; border:1px solid #ddd;">
                                <%
                                    Connection conn = null;
                                    PreparedStatement pstmt = null;
                                    ResultSet rs = null;
                                    try {
                                        conn = DBConnection.getConnection();
                                        String sql = "SELECT product_id, name FROM products ORDER BY name ASC";
                                        pstmt = conn.prepareStatement(sql);
                                        rs = pstmt.executeQuery();
                                        
                                        while(rs.next()) {
                                            int pId = rs.getInt("product_id");
                                            String pName = rs.getString("name");
                                            // 기존 상품 선택 상태 유지
                                            String selected = (pId == r.getProductId()) ? "selected" : "";
                                %>
                                            <option value="<%= pId %>" <%= selected %>><%= pName %></option>
                                <%
                                        }
                                    } catch(Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if(rs != null) try { rs.close(); } catch(Exception e) {}
                                        if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
                                        if(conn != null) try { conn.close(); } catch(Exception e) {}
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>별점</th>
                        <td>
                            <select name="rating" required style="width:100%; padding:10px; border:1px solid #ddd;">
                                <option value="5" <%= r.getRating() == 5 ? "selected" : "" %>>★★★★★ (5점)</option>
                                <option value="4" <%= r.getRating() == 4 ? "selected" : "" %>>★★★★☆ (4점)</option>
                                <option value="3" <%= r.getRating() == 3 ? "selected" : "" %>>★★★☆☆ (3점)</option>
                                <option value="2" <%= r.getRating() == 2 ? "selected" : "" %>>★★☆☆☆ (2점)</option>
                                <option value="1" <%= r.getRating() == 1 ? "selected" : "" %>>★☆☆☆☆ (1점)</option>
                            </select>
                        </td>
                        
                        <!-- 익명 글일 경우 비밀번호 확인란 표시 -->
                        <% if (r.getUserId() == 0) { %>
                            <th>비밀번호</th>
                            <td>
                                <input type="password" name="password" placeholder="비밀번호 입력" required>
                            </td>
                        <% } else { %>
                            <th></th><td></td>
                        <% } %>
                    </tr>
                    <tr>
                        <td colspan="4" class="editor-td">
                            <textarea id="summernote" name="content"><%= r.getContent() %></textarea>
                        </td>
                    </tr>
                </tbody>
            </table>

            <div class="btn-group">
                <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
                <button type="submit" class="btn-write">수정 완료</button>
            </div>
        </form>
    </div>

    <jsp:include page="footer.jsp" />

    <script>
        $(document).ready(function() {
            $('#summernote').summernote({
                placeholder: '리뷰 내용을 작성해주세요.',
                tabsize: 2,
                height: 400,
                lang: 'ko-KR',
                toolbar: [
                    ['style', ['bold', 'italic', 'underline', 'clear']],
                    ['font', ['strikethrough', 'superscript', 'subscript']],
                    ['fontsize', ['fontsize']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['insert', ['link', 'picture', 'video']],
                    ['view', ['fullscreen', 'codeview', 'help']]
                ]
            });
        });
    </script>
</body>
</html>