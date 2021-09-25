-- DQL

-- 1. employees 테이블에서 first_name, last_name을 조회하시오.
SELECT FIRST_NAME, LAST_NAME
  FROM EMPLOYEE;


-- 2. employees 테이블에서 salary가 20000 이상인 사원들의 last_name, salary를 조회하시오.
SELECT LAST_NAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY >= 20000;

-- 3. employees 테이블에서 employee_id가 150인 사원의 employee_id, first_name, last_name을 조회하시오.

-- 1) employee_id 칼럼의 타입이 NUMBER
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID =150;
 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID ='150'; --TO_NUMBER('150)으로 처리

-- 2) employee_id 칼럼의 타입이 VARCHAR2, CHAR
SELECT employee_id, first_name, last_name
  FROM employees
 WHERE employee_id = 150;  -- WHERE TO_NUMBER(employee_id) = 150; 으로 처리된다. 문제가 발생함!!!
                           -- employee_id는 PK이다. PK로 사용되는 칼럼을 함수로 처리하면 속도가 떨어진다.

SELECT employee_id, first_name, last_name
  FROM employees
 WHERE employee_id = '150';  -- 문제 없음.


-- 4. employees 테이블에서 commission_pct가 없는 사원들의 employee_id, commission_pct를 조회하시오.
SELECT EMPLOYEE_ID, COMMISSION_PCT
  FROM EMPLOYEES
 WHERE COMMITION_PCT IS NULL;
 
SELECT EMPLOYEE_ID, COMMISSION_PCT
  FROM EMPLOYEES
 WHERE NVL(COMMITSSION_PCT,0) = 0;


-- 5. employees 테이블에서 commission_pct가 있는 사원들의 employee_id, commission_pct를 조회하시오.
SELECT EMPLOYEE_ID, COMMISSION_PCT
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL;
 
SELECT EMPLOYEE_ID, COMMISSION_PCT
  FROM EMPLOYEES
 WHERE NVL(COMMISSION_PCT,0) != 0;

-- 6. employees 테이블에서 모든 사원들의 employee_id와 커미션(salary * commission_pct)을 조회하시오.
--    커미션이 없는 경우 0으로 조회하시오.
SELECT EMPLOYEE_ID, SALARY * NVL(COMMISSION,0) AS COMMISSION
  FROM EMPLOYEES;

-- 7. employees 테이블에서 모든 사원들의 employee_id와 commission_pct를 10% 인상시킨 결과를 조회하시오.
--    commission_pct가 없는 경우에는 인상시키지 않도록 처리하시오.
SELECT EMOLOYEE_ID
     , NVL(COMMISSION * 1.1, 0) AS NEW_COMMISSION_PCT
     , NVL2(COMMISSION_PCT, COMMISSION_PCT * 1.1 ,0) AS NEW_COMMISSION_PCT --COMMISSION_PCT값이 null이 아닐경우
                                                                           -- *1.1 한값이 반환, null일경우 0 반환
  FROM EMPLOYEES;

-- 8. employees 테이블에서 모든 사원들을 salary 기준으로 오름차순 정렬하여 조회하시오.
SELECT *
  FROM EMPLOYEES
 ORDER BY SALARY ASC;
-- 9. employees 테이블에서 모든 사원들을 salary 기준으로 내림차순 정렬하여 조회하시오.
SELECT *
  FROM EMPLOYEES
 ORDER BY SALARY DESC;

-- 10. employees 테이블에서 같은 department_id를 가진 사원끼리 모아서 조회하되, 높은 salary를 가진 사원을 먼저 조회하시오.
--     (부서별로 정렬하되, 급여가 높은 사원을 먼저 조회하시오.)
SELECT *
  FROM EMPLOYEES
 ORDER BY DEPARTMEN_ID ASC, SALARY DESC; -- 1차 정렬 결과가 같은 레코드에만 2차 정렬이 가능

-- SELECT * FROM employees ORDER BY employee_id, salary DESC;  employee_id는 ASC 생략으로 오름차순이다.


-- 11. employees 테이블에서 commission_pct가 없는 사원들을 높은 salary 순으로 조회하시오.
SELECT *
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NULL
 ORDER BY SALARY DESC;


-- 조인 preview

-- 1. 모든 사원들의 first_name, last_name, department_id, department_name 칼럼을 조회하시오.
--    1) employees 테이블   : first_name, last_name
--    2) departments 테이블 : department_name
--    3) 관계 : departments(department_id) - employees(department_id)
SELECT E.first_name, E.last_name, E.department_id, D.department_name 
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPRTMENT_ID;

-- 2. salary가 10000 이상인 사원들의 first_name, last_name, department_id, department_name 칼럼을 조회하시오.
SELECT E.first_name, E.last_name, E.department_id, D.department_name
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
   AND E.SALARY >= 1000;

-- 서브쿼리 preview
-- 하위쿼리 : 쿼리 내부에 포함된 쿼리(SELECT 안에 SELECT)

-- 1. 평균 급여 이상 받는 사원들의 first_name, last_name, salary를 조회하시오.
SELECT first_name, last_name, salary
  FROM EMPLOYEES
 WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES);

