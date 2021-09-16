--1. SYSTEM 계정으로 접속한 뒤 다음 사용자를 삭제하는 쿼리문을 작성하시오. 쿼리문만 작성하고 실제로 실행하지는 마시오.
   -- 주의. SYSTEM 계정을 삭제하거나, SCOTT 계정을 삭제하는 것이 아님. 쿼리문 작성법을 아는지 점검하는 차원의 문제임.
   --1) 사용자명 : SCOTT
   -- 2) 테이블 : EMPLOYEE가 저장되어 있는 상태
DROP TABLE EMPLOYEE;
DROP USER SCOTT;
DROP USER SCOTT CASCADE;

--2. SYSTEM 계정으로 접속한 뒤 다음 사용자를 생성하는 쿼리문을 작성하시오. 실제 쿼리문을 실행하시오
CREATE USER ADMIN IDENTIFIED BY 1234;
GRANT DBA TO ADMIN;

--3. 모든 고객의 고객아이디, 고객명, 구매횟수를 조회하시오. 외부조인을 사용하시오
SELECT U.USER_ID, U.USER_NAME, COUNT(B.BUY_NO)
  FROM USERS U, BUYS B
 WHERE U.USER_ID = B.USER_ID(+)
 GROUP BY U.USER_ID, U.USER_NAME;
 
--4. 카테고리가 '전자'인 제품을 구매한 고객아이디, 고객명, 총구매액을 조회하시오. 
SELECT U.USER_ID, U.USER_NAME, SUM(B.PROD_ PRICE * B.BUYAMOUNT)
  FROM USERS U, BUYS B
 WHERE U.HSER_ID = B.USER_ID
   AND BUY_CATEGORY ='전자'
 GROUP BY U.USER_ID, U.USER_NAME;
 
--5. 구매횟수가 2회 이상인 고객아이디, 고객명, 구매횟수를 조회하시오. 내부조인을 사용하시오
SELECT U.USER_ID, U.USER_NAME, COUNT(*)
  FROM USERS U INNER JOIN BUYS
    ON U.USER_ID = B.USER_ID
GROUP BY U.USER_ID, U.USER_NAME
HAVING COUNT(*) >=2;

--6. 사용자의 아이디를 전달하면 해당 아이디를 가진 사용자의 구매총액(PROD_PRICE * BUY_AMOUNT)의 합계를 계산한 뒤
--합계가 1000 이상이면 'A', 1000 미만 500 이상이면 'B', 500 미만이면 'C'를 반환하는 get_grade() 사용자 함수를 작성하시오. 
--아이디가 'KHD'인 사용자의 정보를 조회하는 쿼리문을 작성하고 호출하시오.
CREATE OR REPALCE FUNCTION GET_GRADE(ID VARCHAR2)
RETURN CHAR
IS
    TOTAL NUMBER;
    GRADE CHAR(1);
BEGIN
    SELECT SUM(PROD_PRICE * BUY_AMOUNT) FROM BUYS WHERE USER_ID = ID;
    IF TOTAL >=1000 THEN
    GRADE := 'A';
    ELSIF TOTAL >=500 THEN
    GRADE := 'B';
    ELSE
    GRADE := C
    END IF;
    RETURN GRADE;
END;

SELECT USER_NAME, GET_GRADE FROM USERS WHERE USER_ID = 'KHD';