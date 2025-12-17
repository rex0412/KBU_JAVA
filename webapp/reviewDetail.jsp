<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="dto.ReviewDTO" %>
<%@ page import="dao.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<!-- CSS 캐시 방지 -->
<link rel="stylesheet" type="text/css" href="css/Style.css?v=<%=System.currentTimeMillis()%>">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- jQuery 로드 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="menu.jsp" />

    <%
        String reviewIdStr = request.getParameter("reviewId");
        if (reviewIdStr == null) {
            out.println("<script>alert('잘못된 접근입니다.'); location.href='reviewList.jsp';</script>");
            return;
        }
        int reviewId = Integer.parseInt(reviewIdStr);

        ReviewDAO dao = new ReviewDAO();

        // 조회수 중복 방지 (세션)
        if (session.getAttribute("viewed_review_" + reviewId) == null) {
            dao.increaseViews(reviewId);
            session.setAttribute("viewed_review_" + reviewId, true);
        }

        ReviewDTO r = dao.getReview(reviewId);

        if (r == null) {
            out.println("<script>alert('삭제되었거나 존재하지 않는 게시글입니다.'); location.href='reviewList.jsp';</script>");
            return;
        }

        String currentUserID = (String) session.getAttribute("userID");
        String currentUserRole = (String) session.getAttribute("userRole");
        int userPK = 0;
        
        boolean isLiked = false;
        if (currentUserID != null) {
            UserDAO uDao = new UserDAO();
            userPK = uDao.getUserPK(currentUserID);
            isLiked = dao.isLiked(reviewId, userPK);
        }
        
        String stars = "";
        for(int i=0; i<r.getRating(); i++) stars += "★";
        for(int i=r.getRating(); i<5; i++) stars += "☆";
    %>

    <div class="board-container">
        <!-- 헤더 영역 -->
        <div class="review-detail-header">
            <div class="rd-title"><%= r.getTitle() %></div>
            <div class="rd-stars">
                <%= stars %> <span style="color:#888; font-size:0.9rem;">(<%= r.getRating() %>점)</span>
            </div>
        </div>

        <!-- 메타 정보 & 관리 버튼 -->
        <div class="rd-meta-row">
            <div class="rd-meta-info">
                <span>작성자 : <strong><%= r.getUserName() %></strong></span>
                <span>작성일 : <%= r.getCreatedAt() %></span>
                <span>조회 : <%= r.getViews() %></span>
                <span>추천 : <span id="likeCountDisplay"><%= r.getLikeCount() %></span></span>
            </div>
            
            <div class="rd-btn-area">
                <% 
                    boolean canEdit = false;
                    // 관리자거나, 본인(회원)이거나, 익명글이면 수정/삭제 버튼 표시
                    if("ADMIN".equals(currentUserRole)) {
                        canEdit = true;
                    } else if(currentUserID != null && userPK == r.getUserId()) {
                        canEdit = true;
                    } else if(r.getUserId() == 0) { 
                        canEdit = true; 
                    }
                    
                    if(canEdit) {
                %>
                    <% if(r.getUserId() == 0) { %>
                        <button class="btn-edit" onclick="checkPass('update')">수정</button>
                        <button class="btn-delete" onclick="checkPass('delete')">삭제</button>
                    <% } else { %>
                        <a href="reviewUpdate.jsp?reviewId=<%= reviewId %>" class="btn-edit">수정</a>
                        <a href="reviewDeleteAction.jsp?reviewId=<%= reviewId %>" class="btn-delete" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
                    <% } %>
                <% } %>
            </div>
        </div>

        <!-- 본문 내용 -->
        <div class="rd-content">
            <%= r.getContent() %>
        </div>

        <!-- 하단 버튼 -->
        <div class="rd-footer">
            <div>
                <a href="reviewList.jsp" class="btn-list">목록으로</a>
            </div>
            
            <div style="position: absolute; left: 50%; transform: translateX(-50%);">
                <button type="button" class="btn-like <%= isLiked ? "active" : "" %>" onclick="toggleLike()">
                    <i class="fa-solid fa-thumbs-up"></i> 
                    <span id="likeText"><%= isLiked ? "추천 취소" : "추천" %></span> 
                    (<span id="likeCountBtn"><%= r.getLikeCount() %></span>)
                </button>
            </div>
            
            <div></div>
        </div>

        <!-- 댓글 섹션 -->
        <div class="comment-section">
            <div class="comment-count">댓글 <span id="cmtCount">0</span>개</div>

            <!-- 댓글 작성 폼 -->
            <div class="comment-form-wrapper" style="background:#f9f9f9; padding:15px; border-radius:4px;">
                
                <!-- 비회원일 경우 이름/비밀번호 입력칸 표시 -->
                <% if(currentUserID == null) { %>
                <div class="guest-inputs" style="margin-bottom:10px; display:flex; gap:10px;">
                    <input type="text" id="guestName" placeholder="이름" style="width:120px; padding:5px; border:1px solid #ddd;">
                    <input type="password" id="guestPw" placeholder="비밀번호" style="width:120px; padding:5px; border:1px solid #ddd;">
                </div>
                <% } %>

                <div class="comment-form" style="display:flex; gap:10px;">
                    <textarea id="cmtContent" class="comment-input" placeholder="댓글을 남겨보세요"></textarea>
                    <button type="button" class="btn-comment-submit" onclick="addComment(0)">등록</button>
                </div>
            </div>

            <!-- 댓글 목록 -->
            <ul id="commentList" class="comment-list">
                <li style="text-align:center; padding:20px; color:#999;">댓글을 불러오는 중...</li>
            </ul>
        </div>

    </div>

    <jsp:include page="footer.jsp" />

    <script>
    // 추천 버튼 토글 (이 부분은 로그인 필요 유지)
    function toggleLike() {
        <% if (currentUserID == null) { %>
            alert('로그인이 필요한 기능입니다.');
            location.href = 'login.jsp';
            return;
        <% } %>
        location.href = 'reviewLikeAction.jsp?reviewId=<%= reviewId %>';
    }

    // 비밀번호 확인 및 수정/삭제 이동
    function checkPass(mode) {
        var pass = prompt("게시글 비밀번호를 입력하세요:");
        if(pass != null) {
            if(mode === 'delete') {
                location.href = 'reviewDeleteAction.jsp?reviewId=<%= reviewId %>&password=' + pass;
            } else if(mode === 'update') {
                location.href = 'reviewUpdate.jsp?reviewId=<%= reviewId %>'; 
            }
        }
    }

    // ==========================================
    // 댓글 관련 Ajax 스크립트 (수정됨)
    // ==========================================
    
    $(document).ready(function() {
        loadComments(); 
    });

    // 1. 댓글 목록 불러오기
    function loadComments() {
        $.ajax({
            url: 'commentListAction.jsp',
            type: 'GET',
            data: { reviewId: <%= reviewId %> },
            dataType: 'json',
            success: function(data) {
                var html = "";
                var count = data.length;
                $('#cmtCount').text(count);
                
                var myUserPK = <%= userPK %>; 
                var isAdmin = <%= "ADMIN".equals(currentUserRole) %>;
                
                // [수정 1] 로그인 여부를 JS 변수로 저장
                var isLoggedIn = <%= currentUserID != null %>;

                if(count > 0) {
                    $.each(data, function(index, cmt) {
                        var replyClass = cmt.level > 1 ? "reply" : "";
                        
                        html += '<li class="comment-item ' + replyClass + '">';
                        html += '  <div class="comment-header">';
                        html += '    <span class="comment-writer">' + cmt.userName + '</span>';
                        html += '    <span class="comment-date">' + cmt.createdAt + '</span>';
                        html += '  </div>';
                        html += '  <div class="comment-content">' + cmt.content.replace(/\n/g, "<br>") + '</div>';
                        
                        html += '  <div class="comment-actions">';
                        
                        // [수정 2] 로그인 여부 상관없이 "답글" 버튼 항상 표시
                        html += '    <button class="btn-reply" onclick="toggleReplyForm(' + cmt.commentId + ')">답글</button>';
                        
                        // 삭제 버튼 (관리자, 본인, 익명글일 경우)
                        var isAnonymous = (cmt.userId === 0);
                        if (isAdmin || (myUserPK > 0 && myUserPK === cmt.userId) || isAnonymous) {
                            html += ' <button class="btn-delete-cmt" onclick="deleteComment(' + cmt.commentId + ', ' + isAnonymous + ')">삭제</button>';
                        }
                        
                        html += '  </div>';
                        
                        // [수정 3] 대댓글 입력 폼 (비회원 입력창 추가)
                        html += '  <div id="replyForm-' + cmt.commentId + '" class="reply-form-container">';
                        
                        // 로그인이 안 된 상태라면 이름/비밀번호 입력창을 보여줌
                        if (!isLoggedIn) {
                            html += '    <div class="guest-inputs" style="margin-bottom:10px; display:flex; gap:10px;">';
                            html += '      <input type="text" id="replyGuestName-' + cmt.commentId + '" placeholder="이름" style="width:120px; padding:5px; border:1px solid #ddd; border-radius:4px;">';
                            html += '      <input type="password" id="replyGuestPw-' + cmt.commentId + '" placeholder="비밀번호" style="width:120px; padding:5px; border:1px solid #ddd; border-radius:4px;">';
                            html += '    </div>';
                        }

                        html += '    <div class="comment-form" style="margin-bottom:0;">';
                        html += '      <textarea id="replyContent-' + cmt.commentId + '" class="comment-input" placeholder="답글을 작성하세요"></textarea>';
                        html += '      <button type="button" class="btn-comment-submit" onclick="addComment(' + cmt.commentId + ')">등록</button>';
                        html += '    </div>';
                        html += '  </div>';
                        
                        html += '</li>';
                    });
                } else {
                    html = '<li style="text-align:center; padding:20px; color:#999;">등록된 댓글이 없습니다.</li>';
                }
                $('#commentList').html(html);
            },
            error: function(xhr, status, error) {
                console.error("댓글 로딩 실패: " + error);
            }
        });
    }

    // 2. 댓글/답글 등록
    function addComment(parentId) {
        var isLoggedIn = <%= currentUserID != null %>;
        var content = "";
        var writerName = "";
        var password = "";

        // 메인 댓글 작성 시
        if (parentId === 0) {
            content = $('#cmtContent').val();
            if (!isLoggedIn) {
                writerName = $('#guestName').val();
                password = $('#guestPw').val();
            }
        } 
        // [수정 4] 대댓글 작성 시 (로그인 체크 제거 및 게스트 정보 수집)
        else {
            content = $('#replyContent-' + parentId).val();
            if (!isLoggedIn) {
                // 대댓글 폼에 있는 비회원 이름/비번 가져오기
                writerName = $('#replyGuestName-' + parentId).val();
                password = $('#replyGuestPw-' + parentId).val();
            }
        }
        
        // 유효성 검사 (비회원인데 이름/비번 없으면 경고)
        if(!isLoggedIn && (!writerName || !password)) {
            alert("이름과 비밀번호를 입력해주세요.");
            return;
        }
        
        if(!content || content.trim() === "") {
            alert("내용을 입력해주세요.");
            return;
        }

        $.ajax({
            url: 'commentWriteAction.jsp',
            type: 'POST',
            data: {
                reviewId: <%= reviewId %>,
                content: content,
                parentCommentId: parentId,
                writerName: writerName,
                password: password
            },
            success: function(response) {
                if(response.trim() === "success") {
                    // 입력창 초기화
                    if(parentId === 0) {
                        $('#cmtContent').val('');
                        $('#guestName').val('');
                        $('#guestPw').val('');
                    } else {
                        $('#replyContent-' + parentId).val('');
                        $('#replyGuestName-' + parentId).val('');
                        $('#replyGuestPw-' + parentId).val('');
                        $('#replyForm-' + parentId).hide();
                    }
                    loadComments(); // 목록 갱신
                } else {
                    alert("댓글 등록에 실패했습니다.");
                }
            },
            error: function() {
                alert("서버 통신 오류");
            }
        });
    }

    // 3. 댓글 삭제
    function deleteComment(commentId, isAnonymous) {
        var password = null;
        if(isAnonymous) {
            password = prompt("댓글 비밀번호를 입력하세요:");
            if(password == null) return; 
        } else {
            if(!confirm("정말 삭제하시겠습니까?")) return;
        }
        
        $.ajax({
            url: 'commentDeleteAction.jsp',
            type: 'POST',
            data: {
                commentId: commentId,
                password: password
            },
            success: function(response) {
                var res = response.trim();
                if(res === "success") {
                    loadComments();
                } else if(res === "auth_fail") {
                    alert("삭제 권한이 없거나 비밀번호가 일치하지 않습니다.");
                } else {
                    alert("삭제 실패");
                }
            }
        });
    }

    // 답글 폼 토글
    function toggleReplyForm(commentId) {
        var form = $('#replyForm-' + commentId);
        $('.reply-form-container').not(form).hide();
        form.toggle();
    }
</script>
</body>
</html>