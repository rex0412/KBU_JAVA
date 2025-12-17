package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import dto.CommentDTO;
import util.DBConnection;

public class CommentDAO {

    // 댓글 목록 조회
    public ArrayList<CommentDTO> getCommentList(int reviewId) {
        ArrayList<CommentDTO> list = new ArrayList<>();
        
        // user_id가 있으면 users 테이블 조인, 없으면 writer_name 사용
        String sql = "SELECT LEVEL, c.*, u.username "
                   + "FROM comments c "
                   + "LEFT JOIN users u ON c.user_id = u.user_id "
                   + "WHERE c.review_id = ? "
                   + "START WITH c.parent_comment_id IS NULL "
                   + "CONNECT BY PRIOR c.comment_id = c.parent_comment_id "
                   + "ORDER SIBLINGS BY c.created_at ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, reviewId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                CommentDTO comment = new CommentDTO();
                comment.setLevel(rs.getInt("LEVEL"));
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setReviewId(rs.getInt("review_id"));
                comment.setUserId(rs.getInt("user_id"));
                
                // 작성자 이름 결정 (회원 vs 익명)
                String uName = rs.getString("username");
                if(uName == null) {
                    // 비회원이면 직접 입력한 이름 사용
                    comment.setUserName(rs.getString("writer_name"));
                } else {
                    comment.setUserName(uName);
                }
                // 이름이 둘 다 없으면 '익명' 처리
                if(comment.getUserName() == null) comment.setUserName("익명");
                
                comment.setPassword(rs.getString("password")); // 삭제 시 검증용
                comment.setContent(rs.getString("content"));
                comment.setParentCommentId(rs.getInt("parent_comment_id"));
                comment.setCreatedAt(rs.getDate("created_at"));
                list.add(comment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 댓글 작성 (회원/익명 공용)
    public int writeComment(CommentDTO comment) {
        String sql = "INSERT INTO comments (comment_id, review_id, user_id, writer_name, password, content, parent_comment_id, created_at) "
                   + "VALUES (seq_comment_id.NEXTVAL, ?, ?, ?, ?, ?, ?, SYSDATE)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, comment.getReviewId());
            
            // 회원 여부에 따라 분기
            if(comment.getUserId() > 0) {
                pstmt.setInt(2, comment.getUserId()); // 회원 ID
            } else {
                pstmt.setNull(2, java.sql.Types.INTEGER); // 비회원
            }
            
            pstmt.setString(3, comment.getWriterName()); // 비회원 이름
            pstmt.setString(4, comment.getPassword());   // 비회원 비번
            pstmt.setString(5, comment.getContent());
            
            if(comment.getParentCommentId() > 0) {
                pstmt.setInt(6, comment.getParentCommentId());
            } else {
                pstmt.setNull(6, java.sql.Types.INTEGER);
            }
            
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 댓글 삭제
    public int deleteComment(int commentId) {
        String sql = "DELETE FROM comments WHERE comment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, commentId);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    // 댓글 상세 조회 (삭제 시 비밀번호 확인용)
    public CommentDTO getComment(int commentId) {
        String sql = "SELECT * FROM comments WHERE comment_id = ?";
        CommentDTO comment = null;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, commentId);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                comment = new CommentDTO();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setUserId(rs.getInt("user_id"));
                comment.setPassword(rs.getString("password"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return comment;
    }
}