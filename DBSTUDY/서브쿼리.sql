-- 서브쿼리
-- 1. 메인쿼리에 포함되는 하위쿼리를 의미한다.
-- 2. 서브쿼리가 먼저 실행된다.



-- WHERE절의 단일 행 서브쿼리 (single row subquery)
-- 1. 서브쿼리의 결과 행(row)이 1개인 경우
-- 2. 사용 가능 연산자 : =, !=, >, >=, <, <=



-- 단일 행 서브쿼리 예시문제

-- 1. 사원번호가 1001인 사원과 같은 직급을 가진 사원 목록을 조회하시오.
--    서브쿼리 : 사원번호 1001의 직급 구하기 (결과 : '과장') - PK를 사용함으로써 단일 행 보장
SELECT *
  FROM EMPLOYEE
 WHERE POSITION = (SELECT POSITION FROM EMPLOYEE WHERE EMP_NO = 1001);
 
-- 2. 급여가 가장 높은 사원을 조회하시오.
--    서브쿼리 : 가장 높은 급여 구하기 (결과 : 5500000) - 그룹 함수를 사용함으로써 단일 행 보장
SELECT *
  FROM EMPLOYEE
 WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);
 
-- 3. 전체 사원의 평균 급여 이상을 받는 사원을 조회하시오.
--    서브쿼리 : 평균 급여 구하기 (결과 : 3960000) - 그룹 함수를 사용함으로써 단일 행 보장
SELECT *
  FROM EMPLOYEE
 WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE);

-- 4. 부서번호가 1인 부서와 같은 지역에 있는 부서 목록을 조회하시오.
--    서브쿼리 : 부서번호가 1인 부서의 지역 (결과 : 대구) - PK를 사용함으로써 단일 행 보장
SELECT *
  FROM DEPARTMENT
 WHERE LOCATION = (SELECT LOCATION FROM DEPARTMENT WHERE DEPT_NO = 1);

-- 5. 평균 근속개월 이상 근무한 사원들을 조회하시오.
--    근속일   : 오늘 - hire_date
--    근속개월 : MONTHS_BETWEEN(오늘, hire_date)
--    서브쿼리 : 평균 근속개월 구하기 (결과 : 223.810065) - 그룹 함수를 사용함으로써 단일 행 보장
SELECT *
  FROM EMPLOYEE
 WHERE MONTHS_BETWEEN(SYSDATE,HIRE_DATE) >= (SELECT AVG(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) FROM EMPLOYEE);

-- SELECT절에서 사용하는 단일 행 서브쿼리
-- 1. 스칼라 서브쿼리(scalar subquery)라고 한다.
-- 2. 스칼라 서브쿼리는 단일 행 서브쿼리만 가능하다.


-- 1. 전체 사원의 인원수와 평균 급여를 조회하시오.
-- 1) 기본 풀이
SELECT COUNT(*) AS 인원수, AVG(SALARY) AS 평균급여
  FROM EMPLOYEE;
  
-- 2) 스칼라 서브쿼리
SELECT (SELECT COUNT(*) FROM EMPOYEE) AS 인원수,
       (SELECT AVG(SALARY) FROM EMPLOYEE) AS 평균급여
  FROM EMPLOYEE;

-- 2. '대구'에서 근무하는 사원들의 사원번호, 사원명, 부서명을 조회하시오.
-- 1) 기본 풀이 : 외부 조인
SELECT E.EMP_NO, E.EMP_NAME, D.DEPT_NAME
  FROM DEPARTMENT D, EMPLOYEE E
 WHERE D.DEPT_NO(+) = E.DEPART
   AND D.LOCATION = '대구';
   
-- 2) 스칼라 서브쿼리
SELECT E.EMP_NO, E.EMP_NAME, (SELECT D.DEPT_NAME 
                                FROM DEPARTMENT D
                               WHERE D.DEPT_NO = E.DEPART
                                 AND D.LOCATION = '대구')
  FROM EMPLOYEE E;
