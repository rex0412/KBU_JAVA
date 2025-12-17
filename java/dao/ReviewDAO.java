package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import dto.ReviewDTO;
import util.DBConnection;

public class ReviewDAO {

    // 1. 리뷰 목록 가져오기 (기본 - 검색어 없음)
    // JSP에서 검색어 없이 호출할 때 사용됨
    public ArrayList<ReviewDTO> getList(int pageNumber) {
        return getList(pageNumber, ""); // 아래의 검색 메서드에 빈 문자열을 보내서 처리
    }

    // [추가됨] 1-2. 리뷰 목록 가져오기 (검색어 포함)
    // JSP에서 reviewDAO.getList(pageNumber, searchTitle)로 호출할 때 사용됨
    public ArrayList<ReviewDTO> getList(int pageNumber, String searchTitle) {
        ArrayList<ReviewDTO> list = new ArrayList<>();
        
        // 검색어(title LIKE ?) 조건을 포함한 SQL
        String sql = "SELECT * FROM ( "
                   + "  SELECT rownum rnum, A.* FROM ( "
                   + "    SELECT r.*, u.username "
                   + "    FROM reviews r "
                   + "    LEFT JOIN users u ON r.user_id = u.user_id "
                   + "    WHERE r.title LIKE ? " // [중요] 제목 검색 조건
                   + "    ORDER BY r.review_id DESC "
                   + "  ) A WHERE rownum <= ? "
                   + ") WHERE rnum > ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // ? 파라미터 세팅
            pstmt.setString(1, "%" + searchTitle + "%"); // 검색어 부분 일치
            pstmt.setInt(2, pageNumber * 10);
            pstmt.setInt(3, (pageNumber - 1) * 10);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setReviewId(rs.getInt("review_id"));
                review.setProductId(rs.getInt("product_id"));
                review.setUserId(rs.getInt("user_id"));
                
                String uName = rs.getString("username");
                if(uName == null) {
                    review.setUserName(rs.getString("writer_name"));
                } else {
                    review.setUserName(uName);
                }
                
                review.setTitle(rs.getString("title"));
                review.setContent(rs.getString("content"));
                review.setRating(rs.getInt("rating"));
                review.setViews(rs.getInt("views"));
                review.setLikeCount(rs.getInt("like_count"));
                review.setCreatedAt(rs.getDate("created_at"));
                list.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. 총 게시글 수 (기본)
    public int getTotalCount() {
        return getTotalCount("");
    }

    // [추가됨] 2-2. 총 게시글 수 (검색어 포함)
    // 검색된 결과의 페이지 수를 계산하기 위해 필요함
    public int getTotalCount(String searchTitle) {
        String sql = "SELECT COUNT(*) FROM reviews WHERE title LIKE ?";
        int count = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + searchTitle + "%");
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    // ---------------------------------------------------------
    // 아래 메서드들은 기존 코드 그대로 유지
    // ---------------------------------------------------------

    // 리뷰 작성
    public int write(ReviewDTO review) {
        String sql = "INSERT INTO reviews (review_id, product_id, user_id, writer_name, password, title, content, rating, created_at) "
                   + "VALUES (seq_review_id.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, review.getProductId());
            
            if(review.getUserId() > 0) {
                pstmt.setInt(2, review.getUserId());
            } else {
                pstmt.setNull(2, java.sql.Types.INTEGER);
            }
            
            pstmt.setString(3, review.getWriterName());
            pstmt.setString(4, review.getPassword());
            pstmt.setString(5, review.getTitle());
            pstmt.setString(6, review.getContent());
            pstmt.setInt(7, review.getRating());
            
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    // 리뷰 상세 보기
    public ReviewDTO getReview(int reviewId) {
        String sql = "SELECT r.*, u.username "
                   + "FROM reviews r "
                   + "LEFT JOIN users u ON r.user_id = u.user_id "
                   + "WHERE r.review_id = ?";
        ReviewDTO review = null;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, reviewId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                review = new ReviewDTO();
                review.setReviewId(rs.getInt("review_id"));
                review.setProductId(rs.getInt("product_id"));
                review.setUserId(rs.getInt("user_id"));
                
                String uName = rs.getString("username");
                if(uName == null) {
                    review.setUserName(rs.getString("writer_name"));
                } else {
                    review.setUserName(uName);
                }
                
                review.setPassword(rs.getString("password"));
                review.setTitle(rs.getString("title"));
                review.setContent(rs.getString("content"));
                review.setRating(rs.getInt("rating"));
                review.setViews(rs.getInt("views"));
                review.setLikeCount(rs.getInt("like_count"));
                review.setCreatedAt(rs.getDate("created_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return review;
    }

    // 조회수 증가
    public int increaseViews(int reviewId) {
        String sql = "UPDATE reviews SET views = views + 1 WHERE review_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, reviewId);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 좋아요 여부 확인
    public boolean isLiked(int reviewId, int userId) {
        String sql = "SELECT 1 FROM review_likes WHERE review_id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, reviewId);
            pstmt.setInt(2, userId);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 좋아요 토글
    public int toggleLike(int reviewId, int userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int resultStatus = -1; 

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            boolean alreadyLiked = false;
            String checkSql = "SELECT 1 FROM review_likes WHERE review_id = ? AND user_id = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setInt(1, reviewId);
            pstmt.setInt(2, userId);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) alreadyLiked = true;
            pstmt.close();

            if (alreadyLiked) {
                String deleteSql = "DELETE FROM review_likes WHERE review_id = ? AND user_id = ?";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setInt(1, reviewId);
                pstmt.setInt(2, userId);
                pstmt.executeUpdate();
                pstmt.close();

                String updateSql = "UPDATE reviews SET like_count = like_count - 1 WHERE review_id = ?";
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setInt(1, reviewId);
                pstmt.executeUpdate();
                
                resultStatus = 0;
            } else {
                String insertSql = "INSERT INTO review_likes (like_id, review_id, user_id, created_at) VALUES (seq_like_id.NEXTVAL, ?, ?, SYSDATE)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setInt(1, reviewId);
                pstmt.setInt(2, userId);
                pstmt.executeUpdate();
                pstmt.close();

                String updateSql = "UPDATE reviews SET like_count = like_count + 1 WHERE review_id = ?";
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setInt(1, reviewId);
                pstmt.executeUpdate();
                
                resultStatus = 1;
            }

            conn.commit();

        } catch (Exception e) {
            e.printStackTrace();
            try { if(conn != null) conn.rollback(); } catch(Exception ex) {}
        } finally {
            try { if(pstmt != null) pstmt.close(); if(conn != null) conn.close(); } catch(Exception e) {}
        }
        return resultStatus;
    }
    
    // 리뷰 삭제
    public int deleteReview(int reviewId) {
        String sql = "DELETE FROM reviews WHERE review_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, reviewId);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    // 리뷰 수정
    public int updateReview(ReviewDTO review) {
        String sql = "UPDATE reviews SET product_id=?, title=?, content=?, rating=? WHERE review_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, review.getProductId());
            pstmt.setString(2, review.getTitle());
            pstmt.setString(3, review.getContent());
            pstmt.setInt(4, review.getRating());
            pstmt.setInt(5, review.getReviewId());
            
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}