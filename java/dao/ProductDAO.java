package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import dto.ProductDTO;
import util.DBConnection;

public class ProductDAO {

    // 상품 등록 (BLOB 이미지 저장)
    public int insertProduct(ProductDTO product) {
        String sql = "INSERT INTO products (product_id, name, category, color, price, sale_price, stock, status, description, image_data, is_new, created_at) "
                   + "VALUES (seq_product_id.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getCategory());
            pstmt.setString(3, product.getColor());
            pstmt.setInt(4, product.getPrice());
            pstmt.setInt(5, product.getSalePrice());
            pstmt.setInt(6, product.getStock());
            pstmt.setString(7, product.getStatus());
            pstmt.setString(8, product.getDescription());
            pstmt.setBytes(9, product.getImageData()); // BLOB 저장
            pstmt.setString(10, product.getIsNew());
            
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 상품 목록 조회 (이미지 데이터는 무거우므로 제외하고 조회 - 썸네일은 별도 서블릿 호출)
    public ArrayList<ProductDTO> getAllProducts() {
        ArrayList<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT product_id, name, category, color, price, sale_price, stock, status, is_new, created_at FROM products ORDER BY product_id DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                ProductDTO p = new ProductDTO();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setCategory(rs.getString("category"));
                p.setColor(rs.getString("color"));
                p.setPrice(rs.getInt("price"));
                p.setSalePrice(rs.getInt("sale_price"));
                p.setStock(rs.getInt("stock"));
                p.setStatus(rs.getString("status"));
                p.setIsNew(rs.getString("is_new"));
                p.setCreatedAt(rs.getDate("created_at"));
                
                // 목록 조회 시에는 BLOB 데이터를 가져오지 않음 (속도 향상)
                // 이미지는 <img> 태그에서 ProductImageController를 통해 개별 로딩
                
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 상품 상세 조회 (수정 페이지 등에서 사용 - 이미지 데이터 포함)
    public ProductDTO getProductById(int productId) {
        ProductDTO p = null;
        String sql = "SELECT * FROM products WHERE product_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, productId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                p = new ProductDTO();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setCategory(rs.getString("category"));
                p.setColor(rs.getString("color"));
                p.setPrice(rs.getInt("price"));
                p.setSalePrice(rs.getInt("sale_price"));
                p.setStock(rs.getInt("stock"));
                p.setStatus(rs.getString("status"));
                p.setDescription(rs.getString("description"));
                p.setIsNew(rs.getString("is_new"));
                p.setCreatedAt(rs.getDate("created_at"));
                p.setImageData(rs.getBytes("image_data")); // BLOB 데이터 읽기
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    // 상품 수정
    public int updateProduct(ProductDTO product) {
        // 새 이미지가 있을 때만 image_data 업데이트
        String sql = "UPDATE products SET name=?, category=?, color=?, price=?, sale_price=?, stock=?, status=?, description=?, is_new=?";
        
        if(product.getImageData() != null) {
            sql += ", image_data=?";
        }
        sql += " WHERE product_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            int idx = 1;
            pstmt.setString(idx++, product.getName());
            pstmt.setString(idx++, product.getCategory());
            pstmt.setString(idx++, product.getColor());
            pstmt.setInt(idx++, product.getPrice());
            pstmt.setInt(idx++, product.getSalePrice());
            pstmt.setInt(idx++, product.getStock());
            pstmt.setString(idx++, product.getStatus());
            pstmt.setString(idx++, product.getDescription());
            pstmt.setString(idx++, product.getIsNew());
            
            if(product.getImageData() != null) {
                pstmt.setBytes(idx++, product.getImageData());
            }
            
            pstmt.setInt(idx++, product.getProductId());
            
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 상품 삭제
    public int deleteProduct(int productId) {
        String sql = "DELETE FROM products WHERE product_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, productId);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    public int decreaseStock(int productId, int quantity) {
        // 재고가 주문 수량보다 많거나 같을 때만 차감 (음수 방지)
        String sql = "UPDATE products SET stock = stock - ? WHERE product_id = ? AND stock >= ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, quantity);
            pstmt.setInt(2, productId);
            pstmt.setInt(3, quantity); // 재고 확인용
            
            return pstmt.executeUpdate(); // 성공 시 1, 실패(재고부족) 시 0 반환
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 오류
    }
    
 // [추가] 판매량 기준 베스트 상품 3개 조회
    public ArrayList<ProductDTO> getBestProducts() {
        ArrayList<ProductDTO> list = new ArrayList<>();
        
        // 서브쿼리 설명:
        // 1. orders 테이블에서 product_id별로 주문 횟수(cnt)를 셉니다.
        // 2. 주문 횟수가 많은 순(DESC)으로 정렬합니다.
        // 3. 상위 3개만 자릅니다 (ROWNUM <= 3).
        // 4. 그 3개의 ID와 products 테이블을 조인하여 상품 정보를 가져옵니다.
        String sql = "SELECT p.product_id, p.name, p.price, p.sale_price, p.status, p.image_data "
                   + "FROM products p "
                   + "JOIN ( "
                   + "    SELECT product_id, COUNT(*) as cnt "
                   + "    FROM orders "
                   + "    GROUP BY product_id "
                   + "    ORDER BY cnt DESC "
                   + ") o ON p.product_id = o.product_id "
                   + "WHERE ROWNUM <= 3";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                ProductDTO p = new ProductDTO();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getInt("price"));
                p.setSalePrice(rs.getInt("sale_price"));
                p.setStatus(rs.getString("status"));
                // 이미지는 리스트에서 직접 뿌리지 않고 서블릿 호출용 ID만 있으면 되지만, 
                // 상세 조회 로직과 통일성을 위해 일단 비워두거나 필요한 경우 bytes를 읽습니다.
                // 여기선 썸네일 서블릿을 쓰므로 ID만 있으면 됩니다.
                
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}