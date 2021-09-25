
-- 서브쿼리


-- 1. department_id가 20인 사원중에서 전체 평균 연봉(salary) 이상을 받는 사원의
--    employee_id, first_name, department_id, salary를 조회하시오.
SELECT E.employee_id, E.first_name, E.department_id, E.salary
  FROM EMPLOYEE E
 WHERE E.DEPARTMNET_ID =20
   AND E.SALARY >= (SELECT AVG(E.SALARY) FROM EMPLOYEE);
   
-- 2. job_id가 'IT_PROG'인 사원의 최대 연봉(salary)보다 더 많은 연봉을 받는 사원의
--    employee_id, first_name, job_id, salary를 조회하시오.
SELECT employee_id, first_name, job_id, salary
  FROM EMPLOYEES
 WHERE SALARY >= (SELECT MAX(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

-- 3. employee_id가 115인 사원과 같은 job_id, department_id를 가진 사원의
--    employee_id, first_name, job_id, department_id를 조회하시오.
SELECT employee_id, first_name, job_id, department_id 
  FROM EMPLOYEES
 WHERE (JOB_ID, DEPARTMENT_ID) = (SELECT JOB_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 115);

-- 4. location_id가 1000~1900인 국가들의 country_id, country_name을 조회하시오.
SELECT COUNTRY_ID, COUNTRY_NAME
  FROM COUNTRIES C
 WHERE COUNTRY_ID IN (SELECT COUNTRY_ID FROM LOCATIONS WHERE LOCATION_ID BETWEEN 1000 AND 1900);

-- 5. manager가 아닌 사원들의 employee_id, first_name을 조회하시오.
--    서브쿼리 결과는 null을 포함하면 안 된다.

-- manager
SELECT EMPLOYEE_ID, FIRST_NAME
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE MANAGER_ID IS NOT NULL);
 
-- manager 아님
SELECT EMPLOYEE_ID, FIRST_NAME
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID NOT IN (SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE MANAGER_ID IS NOT NULL);
 
-- 6. city가 'Southlake'인 사원들의 employee_id, first_name를 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
                          FROM DEPARTMENTS 
                         WHERE LOCATION_ID = (SELECT LOCATION_ID FROM LOCATIOINS WHERE CITY = 'Southlake'));


-- 7. 가장 많은 사원이 근무 중인 부서의 department_id, 근무 인원 수를 조회하시오.
SELECT DEPARTMNET_ID, COUNT(*) AS 사원수
  FROM EMPLOYEE
 GROUP BY DEPARTMNET_ID
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM EMPLOYEE GROUP BY DEPARTMENT_ID);

-- 8. department_name의 오름차순 정렬 기준으로 사원의
--    employee_id, first_name, department_id를 조회하시오.
SELECT E.employee_id, E.first_name, E.department_id
  FROM EMPLOYEES E
 ORDER BY (SELECT D.DEPARTMNET_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID);

-- 9. 최대 연봉 사원의 employee_id, first_name, salary를 조회하시오.
--    ROWNUM 활용
--    1) 높은 연봉이 가장 위로 오도록 정렬한다. (연봉 내림차순 정렬)
--    2) 정렬 결과에서 ROWNUM이 1인 데이터를 조회한다.
SELECT A.employee_id, A.first_name, A.salary
  FROM (SELECT employee_id, first_name, salary FROM EMPLOYEES ORDER BY SALARY DESC) A
 WHERE ROUWNUM =1;

-- 10. 연봉 TOP 11 ~ 20 사원의 employee_id, first_name, salary를 조회하시오.
--    ROWNUM 활용
--    1) 높은 연봉이 가장 위로 오도록 정렬한다. (연봉 내림차순 정렬)
--    2) 정렬 결과에 ROWNUM 칼럼을 추가한다. 반드시 ROWNUM 칼럼에 별명을 부여한다.
--    3) 부여된 ROWNUM의 별명으로 11 ~ 20 사이를 조회한다.
SELECT B.EMPLOYEE_ID, B.FIRST_NAME, B.SALARY 
  FROM (SELECT ROWNUM AS R , A.EMPLOYEE_ID, A.FIRST_NAME, A.SALARY 
          FROM (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY FROM EMPLOYEE ORDER BY SALARY DESC)A)B
 WHERE B.R BETWEEN 11 AND 20;