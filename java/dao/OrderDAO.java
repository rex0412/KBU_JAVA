package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import dto.OrderDTO;
import util.DBConnection;

public class OrderDAO {

    // 주문 생성
    public int insertOrder(OrderDTO order) {
        String sql = "INSERT INTO orders (order_id, user_id, receiver_name, receiver_phone, address, request_memo, total_price, status, ordered_at, summary, product_id) "
                   + "VALUES (seq_order_id.NEXTVAL, ?, ?, ?, ?, ?, ?, 'ORDERED', SYSDATE, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, order.getUserId());
            pstmt.setString(2, order.getReceiverName());
            pstmt.setString(3, order.getReceiverPhone());
            pstmt.setString(4, order.getAddress());
            pstmt.setString(5, order.getRequestMemo());
            pstmt.setInt(6, order.getTotalPrice());
            pstmt.setString(7, order.getSummary());
            pstmt.setInt(8, order.getProductId());
            
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 내 주문 목록 조회 (상품 정보 조인)
    public ArrayList<OrderDTO> getOrderList(int userId) {
        ArrayList<OrderDTO> list = new ArrayList<>();
        
        // products 테이블과 조인하여 name, color 가져오기
        String sql = "SELECT o.*, p.name AS p_name, p.color "
                   + "FROM orders o "
                   + "JOIN products p ON o.product_id = p.product_id "
                   + "WHERE o.user_id = ? "
                   + "ORDER BY o.ordered_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setProductId(rs.getInt("product_id"));
                order.setReceiverName(rs.getString("receiver_name"));
                order.setReceiverPhone(rs.getString("receiver_phone"));
                order.setAddress(rs.getString("address"));
                order.setRequestMemo(rs.getString("request_memo"));
                order.setTotalPrice(rs.getInt("total_price"));
                order.setStatus(rs.getString("status"));
                order.setOrderedAt(rs.getDate("ordered_at"));
                order.setSummary(rs.getString("summary"));
                
                // 조인된 상품 정보 설정
                order.setPName(rs.getString("p_name"));
                order.setColor(rs.getString("color"));
                
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 주문 내역 삭제
    public int deleteOrder(int orderId) {
        String sql = "DELETE FROM orders WHERE order_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderId);
            
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}