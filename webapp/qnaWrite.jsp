<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.min.js"></script>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="menu.jsp" />

    <%
        String userID = (String) session.getAttribute("userID");
        if (userID == null) {
            out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
            return;
        }
    %>

    <div class="board-container">
        <h2 class="page-title">Q n A 작성</h2>
        <form action="qnaWriteAction.jsp" method="post">
            <table class="form-table">
                <colgroup><col width="20%"><col width="*"></colgroup>
                <tr>
                    <th>작성자</th>
                    <td><input type="text" value="<%= userID %>" readonly class="input-readonly"></td>
                </tr>
                <tr>
                    <th>카테고리</th>
                    <td>
                        <select name="productID" required>
                            <option value="">문의하실 제품 선택</option>
                            <%
                                Connection conn = null; PreparedStatement pstmt = null; ResultSet rs = null;
                                try {
                                    conn = DBConnection.getConnection();
                                    String sql = "SELECT product_id, name, category FROM products ORDER BY category, name";
                                    pstmt = conn.prepareStatement(sql);
                                    rs = pstmt.executeQuery();
                                    while(rs.next()) {
                                        String cat = rs.getString("category");
                                        if(cat == null) cat = "기타";
                            %>
                                <option value="<%= rs.getInt("product_id") %>">[<%= cat %>] <%= rs.getString("name") %></option>
                            <%      }
                                } catch(Exception e) { e.printStackTrace(); } finally { if(conn!=null) conn.close(); }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="title" required placeholder="제목을 입력하세요"></td>
                </tr>
                <tr>
                    <th>옵션</th>
                    <td><label><input type="checkbox" name="isSecret" value="Y"> 비밀글 설정 🔒</label></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td class="editor-td"><textarea id="summernote" name="content"></textarea></td>
                </tr>
            </table>

            <div class="btn-group">
                <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
                <button type="submit" class="btn-submit">등록하기</button>
            </div>
        </form>
    </div>
    <jsp:include page="footer.jsp" />
    <script>
        $(document).ready(function() {
            $('#summernote').summernote({
                placeholder: '문의 내용을 입력해주세요.', tabsize: 2, height: 400, lang: 'ko-KR',
                toolbar: [['style', ['bold', 'italic', 'underline', 'clear']], ['para', ['ul', 'ol', 'paragraph']], ['insert', ['picture']]]
            });
        });
    </script>
</body>
</html>