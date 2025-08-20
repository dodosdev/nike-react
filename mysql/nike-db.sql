CREATE DATABASE  IF NOT EXISTS `nike-db`;
USE `nike-db`;
SHOW FULL TABLES WHERE Table_type = 'VIEW';




-- 나이키 회원 목록
CREATE TABLE `nike_member` (
  `ID` varchar(30) NOT NULL,
  `PWD` varchar(50) NOT NULL,
  `NAME` varchar(10) NOT NULL,
  `PHONE` char(13) NOT NULL,
  `EMAILNAME` varchar(20) NOT NULL,
  `EMAILDOMAIN` varchar(20) NOT NULL,
  `ZIPCODE` char(5) DEFAULT NULL,
  `ADDRESS` varchar(80) DEFAULT NULL,
  `MDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from nike_member;

-- 상품 정보
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pid VARCHAR(10) UNIQUE,
    img VARCHAR(255),
    new_title VARCHAR(100),
    card_title VARCHAR(100),
    card_subtitle VARCHAR(255),
    card_item VARCHAR(100),
    card_price DECIMAL(10, 2)
);

select * from products;


CREATE TABLE product_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id VARCHAR(10),
    image_url VARCHAR(255),
    type ENUM('imgList', 'detailImgList'),
    FOREIGN KEY (product_id) REFERENCES products(pid)
);

DROP TABLE nike_cart;

-- 나이키 장바구니
CREATE TABLE nike_cart (
    CID INT NOT NULL AUTO_INCREMENT,       
    SIZE VARCHAR(10) NOT NULL,            
    QTY INT NOT NULL,                      
    TPRICE INT NOT NULL,                   
    ODATE DATE,   
    TYPE VARCHAR(30) NOT NULL,             
    TID VARCHAR(50) NOT NULL,             
    ID VARCHAR(30) NOT NULL,             
	PID INT NOT NULL AUTO_INCREMENT,

    PRIMARY KEY (CID),                     -- Primary Key
    FOREIGN KEY (ID) REFERENCES nike_member(ID),    -- 사용자 테이블과 연결
    FOREIGN KEY (PID) REFERENCES nike_product(PID) -- 상품 테이블과 연결
);

INSERT INTO nike_cart (size, qty, tprice, type, tid, id, pid, odate)
VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_DATE());


 show tables;




-- 전체 주문 리스트 뷰 생성
CREATE VIEW view_order_list AS
SELECT 
    sc.cid,
    sc.size,
    sc.qty,
    sm.id,
    sm.name,
    sm.phone,
    CONCAT(sm.emailname, '@', sm.emaildomain) AS email,
    sm.zipcode,
    sm.address,
    sp.pid,
    sp.pname,
    sp.price,
    sp.description AS info,
    CONCAT('http://localhost:9000/', sp.upload_file->>'$[0]') AS image
FROM 
    nike_cart sc,
    nike_member sm,
    nike_product sp
WHERE 
    sc.id = sm.id
    AND sc.pid = sp.pid;


               
SELECT * FROM view_order_list
WHERE id = 'test1';

SELECT DATABASE();
DESCRIBE nike_product;




CREATE TABLE `nike_order` (
  `PID` int NOT NULL AUTO_INCREMENT,
  `SIZE` varchar(10) NOT NULL,
  `QTY` int NOT NULL,
  `TPRICE` int NOT NULL,
  `ODATE` date DEFAULT NULL,
  `TYPE` varchar(30) NOT NULL,
  `TID` varchar(50) NOT NULL,
  `ID` varchar(30) NOT NULL,
  `PID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ORDER_ID_NIKE_MEMBER_ID` (`ID`),
  KEY `FK_ORDER_PID_NIKE_PRODUCT_PID` (`PID`),
  CONSTRAINT `FK_ORDER_ID_NIKE_MEMBER_ID` FOREIGN KEY (`ID`) REFERENCES `nike_member` (`ID`),
  CONSTRAINT `FK_ORDER_PID_NIKE_PRODUCT_PID` FOREIGN KEY (`PID`) REFERENCES `nike_product` (`PID`)
);



CREATE TABLE nike_product (
    PID INT NOT NULL AUTO_INCREMENT,
    PNAME VARCHAR(100) NOT NULL,
    PRICE INT NOT NULL,
    DESCRIPTION TEXT,
    UPLOAD_FILE JSON,
    PRIMARY KEY (PID)
);




CREATE VIEW view_cart_list AS
SELECT 
    sc.cid,
    sc.size,
    sc.qty,
    sm.id,
    sm.zipcode,
    sm.address,
    sp.pid,
    sp.pname,
    sp.price,
    sp.description AS info,
    CONCAT('http://localhost:9000/', sp.upload_file->>'$[0]') AS image
FROM 
    nike_cart sc,
    nike_member sm,
    nike_product sp
WHERE 
    sc.id = sm.id 
    AND sc.pid = sp.pid;


SHOW FULL TABLES WHERE Table_type = 'VIEW';


INSERT INTO nike_product (PNAME, PRICE, DESCRIPTION, UPLOAD_FILE)
VALUES 
('나이키 스위프트 탱크탑', 65000, '여성 드라이 핏 러닝 탱크 탑', 
 '[ "/images/products/newpd01.JPG", "/images/products/newpd02.JPG" ]');



SHOW TABLES;
SELECT DATABASE();
DESCRIBE nike_cart;






