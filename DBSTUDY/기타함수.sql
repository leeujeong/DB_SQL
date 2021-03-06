-- 1. 순위 함수

-- 1) 같은 값이면 동점 처리
-- RANK() OVER (ORDER BY 칼럼 ASC)  : 칼럼의 오름차순 순서대로 순위
-- RANK() OVER (ORDER BY 칼럼 DESC) : 칼럼의 내림차순 순서대로 순위


-- 연봉의 오름차순 순위 (낮은 연봉이 1등)
SELECT RANK()OVER (ORDER BY SALARY) AS 순위, EMPLOYEE_ID, FIRST_NAME, SALARY
  FROM EMPLOYEE;


-- 연봉의 내림차순 순위 (높은 연봉이 1등)
SELECT RANK()OVER (ORDER BY SALARY DESC) AS 연봉순위, EMPLOYEE_ID, FIRST_NAME, SALARY
  FROM EMPLOYEE;
  
-- 2) 그룹 내 순위 함수
-- RANK() OVER (PARTITION BY 그룹칼럼 ORDER BY 칼럼 ASC|DESC)
-- 부서내 연봉 순위
SELECT RANK()OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY ASC), DEPARTMENT, DEMPLOYEE_ID, FIRST_NAME, SALATY
  FROM EMPLOYEEL;

-- OVER 활용
-- 부서별 최고연봉
SELECT DISTINCT DEPARTMNET_ID, MAX(SALARY) OVER(PARTITION BY DEPARTMET_ID) AS 연봉순위
  FROM EMPLOYEE;

-- 2. 분기 함수
-- DECODE(표현식, 값1, 결과1, 값2, 결과2, ...)
-- 표현식과 값을 비교할 때 동등 비교(=)만 수행

-- salary       분기
-- >=20000       A
-- 19999~10000   B
-- <10000        C

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DECODE(TRUNC(SALARY/10000), 2, 'A', 1, 'B', 0, 'C') AS 등급
  FROM EMPLOYEES;
  
-- phone_number 분기
-- 011          HP
-- 515          WEST
-- 590          EAST
-- 650          NORTH
-- 나머지       SOUTH

SELECT EMPLOYEE_ID, 
       SUBSTR(PHONE_NUMBER, 1, 3),
       NVL(DECODE(SUBSTR(PHONE_NUMBER, 1, 3), 011, 'HP', 515,'WEST', 590, 'EAST', 650, 'NORTH'),SOUTH) AS 지역
  FROM EMPLOYEE
 ORDER BY 지역;
 
-- departments 테이블의 조인 없이 department_name을 조회하는 DECODE() 함수
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
      ,DECODE(DEPARTMENT_ID, 10, 'Administration', 20, 'Marketing', 30 ,'Purchasing') AS department_name
  FROM EMPLOYEES;


-- 3. 분기 표현식
/*
    CASE 표현식
        WHEN 비교식 THEN 결과값
        WHEN 비교식 THEN 결과값
        WHEN 비교식 THEN 결과값
        ELSE 결과값
    END
*/

-- 근무 개월 수  분기
-- >=240         A
-- >=180         B
-- 나머지        C

SELECT EMPLOYEE_ID
      ,TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))|| '월' AS 근무개월수
      ,CASE
        WHEN MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240 THEN 'A'
        WHEN MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 180 THEN 'B'
        ELSE 'C'
       END AS 구분
  FROM EMPLOYEES;
