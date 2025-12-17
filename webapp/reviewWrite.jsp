<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>

<!-- Summernote & Bootstrap (CDN) -->
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- Summernote Lite -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.min.js"></script>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="menu.jsp" />

    <%
        // 로그인 여부 확인
        String userID = (String) session.getAttribute("userID");
        String writerValue = (userID != null) ? userID : "익명";
    %>

    <div class="board-container">
        <div class="board-header">
            <h2>리뷰(게시글) 작성</h2>
        </div>

        <form action="reviewWriteAction.jsp" method="post" class="write-form">
            <table class="write-table">
                <colgroup>
                    <col width="15%">
                    <col width="35%">
                    <col width="15%">
                    <col width="35%">
                </colgroup>
                <tbody>
                    <!-- 제목 -->
                    <tr>
                        <th>제목</th>
                        <td colspan="3">
                            <input type="text" name="title" placeholder="제목을 입력해주세요." required>
                        </td>
                    </tr>

                    <!-- 작성자 & 상품 선택 -->
                    <tr>
                        <th>User ID</th>
                        <td>
                            <!-- 로그인 여부에 따라 readonly 설정 -->
                            <% if(userID != null) { %>
                                <input type="text" name="writerName" value="<%= userID %>" readonly class="input-readonly">
                            <% } else { %>
                                <input type="text" name="writerName" value="익명" placeholder="작성자 이름">
                            <% } %>
                        </td>
                        <th>Product ID</th>
                        <td>
                            <!-- [수정] DB에서 카테고리 목록을 가져와서 동적으로 옵션 생성 -->
                            <select name="productId" required style="width:100%; padding:10px; border:1px solid #ddd;">
                                <option value="">상품 선택</option>
                                <%
                                    Connection conn = null;
                                    PreparedStatement pstmt = null;
                                    ResultSet rs = null;
                                    try {
                                        conn = DBConnection.getConnection();
                                        // 카테고리별 정렬을 위해 CASE WHEN 사용 (중복 제거)
                                        // 실제로는 productId가 필요하므로, 각 카테고리의 대표 상품 하나씩만 가져오거나, 
                                        // 카테고리가 아닌 개별 상품을 보여주고 싶다면 DISTINCT 제거하고 product_id도 가져와야 함.
                                        // 여기서는 사용자가 '상품'을 선택하는 것이므로 개별 상품 목록을 보여줍니다.
                                        String sql = "SELECT product_id, name, category FROM products "
                                                   + "ORDER BY "
                                                   + "  CASE category "
                                                   + "    WHEN '접시' THEN 1 "
                                                   + "    WHEN '그릇' THEN 2 "
                                                   + "    WHEN '컵' THEN 3 "
                                                   + "    WHEN '세트' THEN 4 "
                                                   + "    ELSE 5 " 
                                                   + "  END, name ASC";
                                        
                                        pstmt = conn.prepareStatement(sql);
                                        rs = pstmt.executeQuery();
                                        
                                        while(rs.next()) {
                                            int pId = rs.getInt("product_id");
                                            String pName = rs.getString("name");
                                            String pCategory = rs.getString("category");
                                            
                                            if(pCategory == null) {
                                                if("기타 문의".equals(pName)) continue; // 기타 문의 상품은 리뷰 대상 아님
                                                pCategory = "기타";
                                            }
                                %>
                                            <option value="<%= pId %>"><%= pCategory %></option>
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

                    <!-- 별점 & 비밀번호(비회원용) -->
                    <tr>
                        <th>별점 (1~5)</th>
                        <td>
                            <select name="rating" required style="width:100%; padding:10px; border:1px solid #ddd;">
                                <option value="5">★★★★★ (5점)</option>
                                <option value="4">★★★★☆ (4점)</option>
                                <option value="3">★★★☆☆ (3점)</option>
                                <option value="2">★★☆☆☆ (2점)</option>
                                <option value="1">★☆☆☆☆ (1점)</option>
                            </select>
                        </td>
                        
                        <!-- 비회원일 경우 비밀번호 입력칸 노출 -->
                        <% if(userID == null) { %>
                            <th>비밀번호</th>
                            <td>
                                <input type="password" name="password" placeholder="수정/삭제용 비밀번호" required>
                            </td>
                        <% } else { %>
                            <!-- 회원은 빈칸으로 채움 -->
                            <th></th>
                            <td></td>
                        <% } %>
                    </tr>

                    <!-- 본문 내용 -->
                    <tr>
                        <td colspan="4" class="editor-td">
                            <div style="padding: 10px 0; font-weight: bold;">본문 내용</div>
                            <textarea id="summernote" name="content"></textarea>
                        </td>
                    </tr>
                </tbody>
            </table>

            <div class="btn-group">
                <button type="button" class="btn-cancel" onclick="history.back()">목록으로</button>
                <button type="submit" class="btn-write">작성 완료</button>
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
                    ['height', ['height']],
                    ['insert', ['link', 'picture', 'video']],
                    ['view', ['fullscreen', 'codeview', 'help']]
                ]
            });
        });
    </script>
</body>
</html>