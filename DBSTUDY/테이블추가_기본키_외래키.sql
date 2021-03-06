--1.PRODUCT 테이블 생성
--1)
    CREATE TABLE PRODUCT(
        PRODUCT_NO NUMBER PRIMARY KEY,
        PRODYCT_NAME VARCHAR2(20),
        PRICE NUMBER,
        STOCK NUMBER);
        
--2)
    CREATE TABLE PRODUCT(
        PRODUCT_NO NUMBER,
        PRODUCT_NAME VARCHAR2(20),
        PRICE NUMBER,
        STOCK NUMBER,
        PRIMARY KEY(PRODUCT_NO));
        
--3)
    CREATE TABLE PRODUCT(
        PRODUCT_NO NUMBER,
        PRODUCT_NAME VARCHAR2(20),
        PRICE NUMBER,
        STOCK NUMBER,
        CONSTRAINT PRODUCT_PK PRIMARY KEY(PRODUCT_NO));
        
--2.ORDER 테이블 생성
--1)
    CREATE TABLE ORDERS(
        ORDER_NO NUMBER PRIMARY KEY,
        ORDER_NAME VARCHAR2(20),
        ORDER_PRODUCT NUMBER REFERENCES PRODUCT(PRODUCT_NO),
        ORDER_DATE DATE);
--2)
    CREATE TABLE ORDERS(
        ORDER_NO NUMBER,
        ORDER_NAME VARCHAR2(20),
        ORDER_PRODUCT NUMBER,
        ORDER_DATE DATE,
        PRIMARY KEY (ORDER_NO),
        FOREIGN KEY (ORDER_PRODUCT) REFERENCES PRODUCT(PRODUCT_NO));
        
--3)
    CREATE TABLE ORDERS(
        ORDER_NO NUMBER,
        ORDER_NAME VARCHAR2(20),
        ORDER_PRODUCT NUMBER,
        ORDER_DATE DATE,
        CONSTRAINTS ORDERS_PK PRIMARY KEY(ORDER_NO),
        CONSTRAINTS ORDERS_FK FOREIGN KEY(ORDER_PRODUCT) REFERENCES PRODUCT(PRODUCT_NO));
        
--3.PRODUCT 테이블 삭제
    DROP TABLE PRODUCT;

--4.ORDER 테이블 삭제
    DROP TABLE ORDERS;
    
--행(ROW) 추가
    INSERT INTO PRODUCT(PRODUCT_NO, PRODUCT_NAME, PRICE,STOCK) VALUES (1, 'AAA', 1000, 15);
    INSERT INTO PRODUCT VALUES (2, 'BBB', 20000, 15);