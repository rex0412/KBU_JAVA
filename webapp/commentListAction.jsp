<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CommentDAO" %>
<%@ page import="dto.CommentDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.google.gson.Gson" %>

<%
    // 파라미터 처리
    String reviewIdStr = request.getParameter("reviewId");
    int reviewId = 0;
    
    if(reviewIdStr != null && !reviewIdStr.trim().isEmpty()) {
        try {
            reviewId = Integer.parseInt(reviewIdStr);
        } catch(NumberFormatException e) {
            reviewId = 0;
        }
    }
    
    // DAO 호출
    CommentDAO dao = new CommentDAO();
    ArrayList<CommentDTO> list = dao.getCommentList(reviewId);
    
    // JSON 변환용 리스트 생성 (Map 사용)
    List<Map<String, Object>> jsonList = new ArrayList<>();
    
    if(list != null) {
        for(CommentDTO c : list) {
            Map<String, Object> map = new HashMap<>();
            map.put("commentId", c.getCommentId());
            map.put("userId", c.getUserId()); // [중요] 삭제 권한 체크용
            map.put("userName", c.getUserName());
            map.put("content", c.getContent());
            map.put("level", c.getLevel());
            
            // 날짜 null 체크 및 문자열 변환
            String dateStr = (c.getCreatedAt() != null) ? c.getCreatedAt().toString() : "";
            map.put("createdAt", dateStr);
            
            jsonList.add(map);
        }
    }
    
    // Gson을 사용하여 JSON 문자열로 변환 및 출력
    Gson gson = new Gson();
    String jsonString = gson.toJson(jsonList);
    
    out.print(jsonString);
%>