package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import dto.CartDTO;
import util.DBConnection;

public class CartDAO {

    // 장바구니 담기 (이미 있으면 수량 추가, 없으면 새로 추가)
    public int addToCart(int userId, int productId, int quantity) {
        // 1. 이미 있는지 확인
        String checkSql = "SELECT quantity FROM carts WHERE user_id = ? AND product_id = ?";
        int existingQty = 0;
        boolean exists = false;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(checkSql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, productId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                existingQty = rs.getInt(1);
                exists = true;
            }
        } catch (Exception e) { e.printStackTrace(); }
        
        // 2. 분기 처리
        String sql;
        try (Connection conn = DBConnection.getConnection()) {
            if (exists) {
                // 수량 업데이트
                sql = "UPDATE carts SET quantity = ? WHERE user_id = ? AND product_id = ?";
                try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, existingQty + quantity);
                    pstmt.setInt(2, userId);
                    pstmt.setInt(3, productId);
                    return pstmt.executeUpdate();
                }
            } else {
                // 새로 추가
                sql = "INSERT INTO carts (cart_id, user_id, product_id, quantity, created_at) VALUES (seq_cart_id.NEXTVAL, ?, ?, ?, SYSDATE)";
                try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, userId);
                    pstmt.setInt(2, productId);
                    pstmt.setInt(3, quantity);
                    return pstmt.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
 // 장바구니 목록 조회
    public ArrayList<CartDTO> getCartList(int userId) {
        ArrayList<CartDTO> list = new ArrayList<>();
        
        // [수정] p.color 추가 조회
        String sql = "SELECT c.cart_id, c.user_id, c.product_id, c.quantity, c.created_at, "
                   + "p.name, p.price, p.sale_price, p.color " 
                   + "FROM carts c "
                   + "JOIN products p ON c.product_id = p.product_id "
                   + "WHERE c.user_id = ? "
                   + "ORDER BY c.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                CartDTO cart = new CartDTO();
                cart.setCartId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setProductId(rs.getInt("product_id"));
                cart.setQuantity(rs.getInt("quantity"));
                cart.setCreatedAt(rs.getDate("created_at"));
                
                cart.setProductName(rs.getString("name"));
                cart.setColor(rs.getString("color")); // [추가] 색상 설정
                
                int price = rs.getInt("price");
                int salePrice = rs.getInt("sale_price");
                cart.setProductPrice(salePrice > 0 ? salePrice : price);
                
                list.add(cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // 장바구니 삭제
    public int deleteCart(int cartId) {
        String sql = "DELETE FROM carts WHERE cart_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, cartId);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    // 장바구니 전체 비우기 (주문 완료 시)
    public int clearCart(int userId) {
        String sql = "DELETE FROM carts WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}