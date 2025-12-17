DROP TABLE carts CASCADE CONSTRAINTS;
DROP TABLE review_likes CASCADE CONSTRAINTS;
DROP TABLE comments CASCADE CONSTRAINTS;
DROP TABLE qna CASCADE CONSTRAINTS;
DROP TABLE reviews CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE products CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;


DROP SEQUENCE seq_user_id;
DROP SEQUENCE seq_product_id;
DROP SEQUENCE seq_review_id;
DROP SEQUENCE seq_like_id;
DROP SEQUENCE seq_qna_id;
DROP SEQUENCE seq_comment_id;
DROP SEQUENCE seq_cart_id;
DROP SEQUENCE seq_order_id;




-- =============================================
-- 1. 시퀀스 생성
-- =============================================
CREATE SEQUENCE seq_user_id START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_product_id START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_review_id START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_like_id START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_qna_id START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_comment_id START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_cart_id START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_order_id START WITH 1 INCREMENT BY 1 NOCACHE;

-- =============================================
-- 2. USERS 테이블
-- =============================================
CREATE TABLE users (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(20) NOT NULL UNIQUE,
    password VARCHAR2(255) NOT NULL,
    name VARCHAR2(50) NOT NULL,
    birthdate DATE,
    gender VARCHAR2(1),
    email VARCHAR2(100) NOT NULL UNIQUE,
    phone VARCHAR2(20) NOT NULL,
    zipcode VARCHAR2(10),
    address VARCHAR2(255),
    address_detail VARCHAR2(255),
    role VARCHAR2(10) DEFAULT 'USER',
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT chk_user_gender CHECK (gender IN ('M', 'F', 'O')),
    CONSTRAINT chk_user_role CHECK (role IN ('USER', 'ADMIN'))
);

-- =============================================
-- 3. PRODUCTS 테이블
-- =============================================
CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    description CLOB,
    price NUMBER NOT NULL,
    stock NUMBER DEFAULT 0,
    status VARCHAR2(20) DEFAULT '판매중',
    category VARCHAR2(50),
    color VARCHAR2(50),
    sale_price NUMBER DEFAULT 0,
    is_new CHAR(1) DEFAULT 'N',
    image_data BLOB,
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT chk_product_status CHECK (status IN ('판매중', '품절', '숨김'))
);

-- =============================================
-- 4. REVIEWS 테이블
-- =============================================
CREATE TABLE reviews (
    review_id NUMBER PRIMARY KEY,
    product_id NUMBER NOT NULL,
    user_id NUMBER,
    title VARCHAR2(200) NOT NULL,
    content CLOB NOT NULL,
    rating NUMBER,
    views NUMBER DEFAULT 0,
    like_count NUMBER DEFAULT 0,
    writer_name VARCHAR2(50),
    password VARCHAR2(50),
    created_at DATE DEFAULT SYSDATE,

    CONSTRAINT fk_review_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT chk_review_rating CHECK (rating BETWEEN 1 AND 5)
);

-- =============================================
-- 5. REVIEW_LIKES 테이블
-- =============================================
CREATE TABLE review_likes (
    like_id NUMBER PRIMARY KEY,
    review_id NUMBER NOT NULL,
    user_id NUMBER NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_like_review FOREIGN KEY (review_id) REFERENCES reviews(review_id) ON DELETE CASCADE,
    CONSTRAINT fk_like_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT uk_review_user_like UNIQUE (review_id, user_id)
);

-- =============================================
-- 6. QNA 테이블
-- =============================================
CREATE TABLE qna (
    qna_id NUMBER PRIMARY KEY,
    product_id NUMBER NOT NULL,
    user_id NUMBER NOT NULL,
    title VARCHAR2(200),
    question_content CLOB NOT NULL,
    answer_content CLOB,
    status VARCHAR2(20) DEFAULT 'WAITING',
    is_secret CHAR(1) DEFAULT 'N',
    created_at DATE DEFAULT SYSDATE,
    answered_at DATE,
    CONSTRAINT fk_qna_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    CONSTRAINT fk_qna_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT chk_qna_status CHECK (status IN ('WAITING', 'COMPLETED')),
    CONSTRAINT chk_qna_secret CHECK (is_secret IN ('Y', 'N'))
);

-- =============================================
-- 7. COMMENTS 테이블
-- =============================================
CREATE TABLE comments (
    comment_id NUMBER PRIMARY KEY,
    review_id NUMBER NOT NULL,
    user_id NUMBER,
    content CLOB NOT NULL,
    parent_comment_id NUMBER,
    writer_name VARCHAR2(50),
    password VARCHAR2(50),
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_comment_review FOREIGN KEY (review_id) REFERENCES reviews(review_id) ON DELETE CASCADE,
    CONSTRAINT fk_comment_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_comment_parent FOREIGN KEY (parent_comment_id) REFERENCES comments(comment_id) ON DELETE CASCADE
);

-- =============================================
-- 8. CARTS 테이블
-- =============================================
CREATE TABLE carts (
    cart_id NUMBER PRIMARY KEY,
    user_id NUMBER NOT NULL,
    product_id NUMBER NOT NULL,
    quantity NUMBER DEFAULT 1,
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_cart_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- =============================================
-- 9. ORDERS 테이블
-- =============================================
CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    user_id NUMBER NOT NULL,
    product_id NUMBER,
    receiver_name VARCHAR2(50),
    receiver_phone VARCHAR2(20),
    address VARCHAR2(255),
    request_memo VARCHAR2(255),
    total_price NUMBER,
    status VARCHAR2(20) DEFAULT 'ORDERED',
    summary VARCHAR2(200),
    ordered_at DATE DEFAULT SYSDATE
);

-- =============================================
-- 초기 데이터 삽입
-- =============================================
INSERT INTO users (user_id, username, password, name, email, phone, role)
VALUES (seq_user_id.NEXTVAL, 'admin', 'admin12', '관리자', 'admin@todam.com', '010-0000-0000', 'ADMIN');

COMMIT;
