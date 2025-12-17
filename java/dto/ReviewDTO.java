package dto;

import java.sql.Date;

public class ReviewDTO {
    private int reviewId;
    private int productId;
    private int userId; // 0 또는 NULL이면 익명
    
    private String userName; // 회원 이름 (조인용)
    private String writerName; // [추가] 익명 작성자 이름 (직접 입력)
    private String password;   // [추가] 익명 글 비밀번호
    
    private String title;
    private String content;
    private int rating;
    private int views;
    private int likeCount;
    private Date createdAt;

    public ReviewDTO() {}

    // Getters and Setters
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    // [추가]
    public String getWriterName() { return writerName; }
    public void setWriterName(String writerName) { this.writerName = writerName; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }

    public int getLikeCount() { return likeCount; }
    public void setLikeCount(int likeCount) { this.likeCount = likeCount; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}