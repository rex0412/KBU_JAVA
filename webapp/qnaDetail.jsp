<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.QnaDAO"%>
<%@ page import="dto.QnaDTO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>토담(TO:DAM)</title>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.min.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<jsp:include page="menu.jsp" />

	<%
        int qnaId = 0;
        if (request.getParameter("qnaId") != null) {
            qnaId = Integer.parseInt(request.getParameter("qnaId"));
        }

        if (qnaId == 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>alert('유효하지 않은 글입니다.'); location.href='qnaList.jsp';</script>");
            return;
        }
        
        QnaDAO qnaDAO = new QnaDAO();
        QnaDTO qna = qnaDAO.getQna(qnaId);
        
        String userID = (String) session.getAttribute("userID");
        String userRole = (String) session.getAttribute("userRole");

        if (qna == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>alert('삭제되거나 존재하지 않는 글입니다.'); location.href='qnaList.jsp';</script>");
            return;
        }
        if ("Y".equals(qna.getIsSecret())) {
            boolean canRead = false;
            if ("ADMIN".equals(userRole)) canRead = true;
            if (userID != null && userID.equals(qna.getUserName())) canRead = true;
            
            if (!canRead) {
                PrintWriter script = response.getWriter();
                script.println("<script>alert('비밀글은 작성자와 관리자만 볼 수 있습니다.'); location.href='qnaList.jsp';</script>");
                return;
            }
        }
    %>
	<div class="board-container">
		<div class="board-header">
			<h2>Q n A 상세</h2>
		</div>
		<table class="view-table">
			<colgroup>
				<col width="15%">
				<col width="35%">
				<col width="15%">
				<col width="35%">
			</colgroup>
			<tr>
				<th>제목</th>
				<td colspan="3"><%= qna.getTitle() %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%= qna.getUserName() %></td>
				<th>작성일</th>
				<td><%= qna.getCreatedAt() %></td>
			</tr>
			<tr>
				<th>문의 제품</th>
				<td><%= qna.getProductName() %></td>
				<th>진행 상태</th>
				<td>
					<% if("COMPLETED".equals(qna.getStatus())) { %> <span
					class="badge completed">답변완료</span> <% } else { %> <span
					class="badge waiting">답변대기</span> <% } %>
				</td>
			</tr>
			<tr>
				<td colspan="4" class="view-content"><%= qna.getQuestionContent() %>
				</td>
			</tr>
		</table>
		<% if (qna.getAnswerContent() != null) { %>
		<div class="answer-section">
			<div class="answer-header">
				관리자 답변 (<%= qna.getAnsweredAt() %>)
			</div>
			<div class="answer-content-view">
				<%= qna.getAnswerContent() %>
			</div>
		</div>
		<% } else if ("ADMIN".equals(userRole)) { %>
		<div class="answer-section">
			<div class="answer-header">답변 작성</div>
			<form action="qnaAnswerAction.jsp" method="post">
				<input type="hidden" name="qnaId" value="<%= qnaId %>">
				<textarea id="summernote" name="answerContent"></textarea>
				<div style="text-align: right; margin-top: 10px;">
					<button type="submit" class="btn-write">답변 등록</button>
				</div>
			</form>
		</div>
		<% } else { %>
		<div class="answer-section" style="text-align: center; color: #888;">
			<p>관리자의 답변을 기다리고 있습니다.</p>
		</div>
		<% } %>
		<div class="btn-group">
			<button type="button" class="btn-cancel"
				onclick="location.href='qnaList.jsp'">목록으로</button>
			<% if (userID != null && userID.equals(qna.getUserName())) { %>
			<button type="button" class="btn-cancel"
				onclick="if(confirm('삭제하시겠습니까?')) location.href='qnaDeleteAction.jsp?qnaId=<%= qnaId %>'">삭제</button>
			<% } %>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
	<script>
        $(document).ready(function() {
            $('#summernote').summernote({
                placeholder: '관리자 답변을 작성해주세요.',
                tabsize: 2,
                height: 200,
                lang: 'ko-KR',
                toolbar: [
                    ['style', ['bold', 'italic', 'underline', 'clear']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['insert', ['link', 'picture']]
                ]
            });
        });
    </script>
</body>
</html>