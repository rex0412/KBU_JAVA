package dto;

import java.sql.Date;

public class CommentDTO {
    private int commentId;
    private int reviewId;
    private int userId; // 0 또는 NULL이면 익명
    
    private String userName;   // 회원 이름 (조인용)
    private String writerName; // [추가] 익명 작성자 이름
    private String password;   // [추가] 익명 비밀번호
    
    private String content;
    private int parentCommentId;
    private Date createdAt;
    private int level;

    public CommentDTO() {}

    // Getters and Setters
    public int getCommentId() { return commentId; }
    public void setCommentId(int commentId) { this.commentId = commentId; }
    
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    
    public String getWriterName() { return writerName; }
    public void setWriterName(String writerName) { this.writerName = writerName; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public int getParentCommentId() { return parentCommentId; }
    public void setParentCommentId(int parentCommentId) { this.parentCommentId = parentCommentId; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    
    public int getLevel() { return level; }
    public void setLevel(int level) { this.level = level; }
}