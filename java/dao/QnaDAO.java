package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import dto.QnaDTO;
import util.DBConnection;

public class QnaDAO {

    // 기존 getList 메서드 (전체 목록 - 검색어 없음)
    public ArrayList<QnaDTO> getList(int pageNumber) {
        return getList(pageNumber, null);
    }

    // [수정] 검색 기능이 포함된 getList 메서드
    public ArrayList<QnaDTO> getList(int pageNumber, String searchCategory) {
        ArrayList<QnaDTO> list = new ArrayList<>();
        String sql = "";

        // 검색어가 있는 경우 (LIKE 검색)
        if (searchCategory != null && !searchCategory.trim().isEmpty()) {
            sql = "SELECT * FROM ( "
                + "  SELECT rownum rnum, A.* FROM ( "
                + "    SELECT q.qna_id, q.product_id, p.name AS product_name, p.category, " // category 추가
                + "           q.user_id, u.username, "
                + "           q.title, q.question_content, q.status, q.is_secret, q.created_at "
                + "    FROM qna q "
                + "    JOIN users u ON q.user_id = u.user_id "
                + "    JOIN products p ON q.product_id = p.product_id "
                // [핵심] 부분 일치 검색 (카테고리에 검색어가 포함되면 조회)
                + "    WHERE p.category LIKE ? " 
                + "    ORDER BY q.qna_id DESC "
                + "  ) A WHERE rownum <= ? "
                + ") WHERE rnum > ?";
        } else {
            // 검색어가 없는 경우 (전체 목록)
            sql = "SELECT * FROM ( "
                + "  SELECT rownum rnum, A.* FROM ( "
                + "    SELECT q.qna_id, q.product_id, p.name AS product_name, p.category, "
                + "           q.user_id, u.username, "
                + "           q.title, q.question_content, q.status, q.is_secret, q.created_at "
                + "    FROM qna q "
                + "    JOIN users u ON q.user_id = u.user_id "
                + "    JOIN products p ON q.product_id = p.product_id "
                + "    ORDER BY q.qna_id DESC "
                + "  ) A WHERE rownum <= ? "
                + ") WHERE rnum > ?";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            int paramIndex = 1;

            // 검색어가 있으면 첫 번째 파라미터에 검색어 설정
            if (searchCategory != null && !searchCategory.trim().isEmpty()) {
                // [핵심] 앞뒤로 %를 붙여서 '포함된 단어' 검색 구현
                pstmt.setString(paramIndex++, "%" + searchCategory.trim() + "%");
            }

            // 페이징 파라미터 설정
            pstmt.setInt(paramIndex++, pageNumber * 10);
            pstmt.setInt(paramIndex++, (pageNumber - 1) * 10);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                QnaDTO qna = new QnaDTO();
                qna.setQnaId(rs.getInt("qna_id"));
                qna.setProductId(rs.getInt("product_id"));
                qna.setProductName(rs.getString("product_name"));
                // qna.setCategory(rs.getString("category")); // 필요하다면 DTO에 category 필드 추가 후 사용 가능
                qna.setUserName(rs.getString("username"));
                qna.setTitle(rs.getString("title"));
                qna.setQuestionContent(rs.getString("question_content"));
                qna.setStatus(rs.getString("status"));
                qna.setIsSecret(rs.getString("is_secret"));
                qna.setCreatedAt(rs.getDate("created_at"));
                list.add(qna);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 기존 getTotalCount (전체 개수)
    public int getTotalCount() {
        return getTotalCount(null);
    }

    // [수정] 검색된 결과의 총 개수 가져오기
    public int getTotalCount(String searchCategory) {
        String sql = "";
        if (searchCategory != null && !searchCategory.trim().isEmpty()) {
            sql = "SELECT COUNT(*) FROM qna q JOIN products p ON q.product_id = p.product_id WHERE p.category LIKE ?";
        } else {
            sql = "SELECT COUNT(*) FROM qna";
        }

        int count = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            if (searchCategory != null && !searchCategory.trim().isEmpty()) {
                // [핵심] 여기도 동일하게 % 추가
                pstmt.setString(1, "%" + searchCategory.trim() + "%");
            }

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // 글쓰기 메서드
    public int write(int productId, int userId, String title, String content, String isSecret) {
        String sql = "INSERT INTO qna (qna_id, product_id, user_id, title, question_content, is_secret, status, created_at) "
                   + "VALUES (seq_qna_id.NEXTVAL, ?, ?, ?, ?, ?, 'WAITING', SYSDATE)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, productId);
            pstmt.setInt(2, userId);
            pstmt.setString(3, title);
            pstmt.setString(4, content);
            pstmt.setString(5, isSecret);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 상세 조회 메서드
    public QnaDTO getQna(int qnaId) {
        String sql = "SELECT q.*, u.username, p.name AS product_name FROM qna q JOIN users u ON q.user_id = u.user_id JOIN products p ON q.product_id = p.product_id WHERE q.qna_id = ?";
        QnaDTO qna = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, qnaId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                qna = new QnaDTO();
                qna.setQnaId(rs.getInt("qna_id"));
                qna.setProductId(rs.getInt("product_id"));
                qna.setProductName(rs.getString("product_name"));
                qna.setUserId(rs.getInt("user_id"));
                qna.setUserName(rs.getString("username"));
                qna.setTitle(rs.getString("title"));
                qna.setQuestionContent(rs.getString("question_content"));
                qna.setAnswerContent(rs.getString("answer_content"));
                qna.setStatus(rs.getString("status"));
                qna.setIsSecret(rs.getString("is_secret"));
                qna.setCreatedAt(rs.getDate("created_at"));
                qna.setAnsweredAt(rs.getDate("answered_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return qna;
    }

    // 답변 등록 메서드
    public int updateAnswer(int qnaId, String answerContent) {
        String sql = "UPDATE qna SET answer_content = ?, status = 'COMPLETED', answered_at = SYSDATE WHERE qna_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, answerContent);
            pstmt.setInt(2, qnaId);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 삭제 메서드
    public int deleteQna(int qnaId) {
        String sql = "DELETE FROM qna WHERE qna_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, qnaId);
            return pstmt.executeUpdate(); // 삭제된 행의 개수 반환 (성공 시 1)
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 오류 발생
    }
}