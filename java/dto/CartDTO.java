package dto;

import java.sql.Date;

public class CartDTO {
    private int cartId;
    private int userId;
    private int productId;
    private int quantity;
    private Date createdAt;
    
    // 상품 정보
    private String productName;
    private String productImage;
    private int productPrice;
    private String color; // [추가] 색상 정보
    
    public CartDTO() {}

    // Getters and Setters
    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    
    public String getProductImage() { return productImage; }
    public void setProductImage(String productImage) { this.productImage = productImage; }
    
    public int getProductPrice() { return productPrice; }
    public void setProductPrice(int productPrice) { this.productPrice = productPrice; }

    // [추가]
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
}