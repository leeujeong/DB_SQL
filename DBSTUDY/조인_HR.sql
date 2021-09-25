-- 1. 내부조인
--SELECT 조회할 칼럼
--  FROM 테이블1, 테이블2
-- WHERE 테이블1.칼럼 = 테이블2.칼럼  :  테이블1.PK = 테이블2.FK
--   AND 일반조건;

--SELECT 조회할 칼럼
--  FROM 테이블1 INNER JOIN 테이블2
--    ON 테이블1.칼럼 = 테이블2.칼럼  :  테이블1.PK = 테이블2.FK
-- WHERE 일반조건;


-- 1. 부서 위치(location_id)가 1700인 사원들의 employee_id, first_name, department_id를 조회하시오.
SELECT E.employee_id, E.first_name, D.department_id
  FROM DEPARTMNETS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
   AND D.LOCATION_ID = 1700;

SELECT E.employee_id, E.first_name, D.department_id
  FROM DEPARTMNETS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 WHERE D.LOCATION_ID = 1700;

-- 2. 부서명이 'Executive'인 부서에 근무하는 모든 사원들의 employee_id, last_name, department_name을 조회하시오.
SELECT E.employee_id, E.last_name, D.department_name
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 WHERE D.DEPARTMENT_NAME = 'Executive';
 
 SELECT E.employee_id, E.last_name, D.department_name
  FROM DEPARTMENTS D ,EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
   AND D.DEPARTMENT_NAME = 'Executive';

-- 3. job_id가 변하지 않은 사원들의 employee_id, last_name, job_id를 조회하시오.
--    현재 job_id(employees)와 과거 job_id(job_history)가 일치하는 사원을 조회하시오.
SELECT E.EMPLOYEE_ID, E.LAST_NAME JH.JOB_ID
  FROM EMPLOYEES E, JOB_HISTORY JH
 WHERE E.EMPLOYEE_ID = JH.EMPLOYEE_ID
   AND E.JOB_ID = JH.JOB_ID;
   
-- 4. 각 부서별 사원수와 평균연봉을 department_name과 함께 조회하시오.
--    사원수의 오름차순 정렬하시오.
SELECT AVG(E.SALARY) AS 평균연봉 , D.DEPARTMENT_NAME, COUNT(*) AS 사원수 
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
 GROUP BY D.DEPARTMENT_NAME
 ORDER BY 사원수;

-- 5. city가 'S'로 시작하는 지역에 근무하는 사원들의 employee_id, first_name, department_name, city를 조회하시오.
/*
    locations           departments         employees
    location_id(PK)  -  location_id(FK)
                        department_id(PK) - department_id(FK)
*/
SELECT E.employee_id, E.first_name, D.department_name, L.city
  FROM DEPARTMENTS D, EMPLOYEES E, LOCATIONS L
 WHERE L.LOCATION_ID = D.LOACTION_ID
   AND D.DEPARTMENT = E.DEPARTMENT_ID
   AND L.CITY LIKE '%S';
   
SELECT e.employee_id, e.first_name, d.department_name, l.city
  FROM locations l INNER JOIN departments d
    ON l.location_id = d.location_id INNER JOIN employees e
    ON d.department_id = e.department_id
 WHERE l.city LIKE 'S%';

-- 6. 모든 사원들의 employee_id, first_name, department_name, city, country_name을 조회하시오.
SELECT E.employee_id, E.first_name, D.department_name, L.city, C.country_name
  FROM COUNTREIS C, LOACTIONS L , DEPARTMENTS D, EMPLOYEES E
 WHERE C.COUNTRY_ID = L.COUNTRY_ID
   AND L.LOCATION_ID = D.LOCATION_ID
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;
   
SELECT E.employee_id, E.first_name, D.department_name, L.city, C.country_name
  FROM COUNTRIES C INNER JOIN LOCATIONS L
    ON C.COUNTRY_ID = L.COUNTRY_ID INNER JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN EMPLOYEES E
    ON D.DEPARETMENT_ID = E.DEAPRTMENT_ID;
    
-- 7. manager보다 먼저 입사한 사원들의 employee_id, first_name, hire_date과 manager의 hire_date를 조회하시오.
--    사원의 hire_date가 manager의 hire_date보다 작은 사원을 조회하시오.
-- 사원 테이블    : employees e
-- manager 테이블 : employees m
SELECT E.employee_id, E.first_name, E.hire_date, M.hire_date
  FROM EMPLOYEES M, EMPLOYEES E
 WHERE M.EMPLOYEE_ID = E.MANAGER_ID
   AND TO_DATE(M.HIRE_DATE) > TO_DATE(E.DIRE_DATE);

-- 8. 같은 부서의 사원들 중에서 나보다 늦게 입사하였으나 연봉을 더 많이 받는 사원이 있는 사원들의
--    department_id, first_name, salary, hire_date와 높은 연봉을 받는 사원의 first_name, salary, hire_date를 조회하시오.
-- 나의 정보 : employees me
-- 너의 정보 : employees you
-- 조인 조건 : 같은 부서인가?
SELECT ME.department_id, ME.first_name, ME.salary, ME.hire_date,YOU.first_name, YOU.salary, YOU.hire_date 
  FROM EMPLOYEES ME, EMPLOYEES YOU
 WHERE ME.DEPARETMENT_ID = YOU.DEPARTMENT_ID
   AND TO_DATE(ME.HIRE_DATE)<TO_DATE(YOU.HIRE_DATE)
   AND ME.SALARY < YOU.SALARY;

-- 외부 조인
-- 한 테이블의 정보는 일치하면 조회, 다른 테이블의 정보는 일치하지 않아도 모두 조회하는 경우에 사용
-- 모든 정보를 조회할 테이블이 왼쪽에 있으면 왼쪽 조인, 오른쪽에 있으면 오른쪽 조인

-- 9. 모든 사원들의 employee_id, first_name, department_name을 조회하시오.
--    employee_id순으로 오름차순 정렬하시오.
--    모든 사원 : 부서가 없는 사원도 조회하시오.
SELECT E.employee_id, E.first_name, NVL(D.department_name,'부서없음')
  FROM DEPARTMENTS D , EMPLOYEES E
 WHERE D.DEPARTMENT_ID(+) = E.DEPARTMNET_ID
 ORDER BY E.EMPLOYEE_ID ASC;
-- 10. 부서별 근무하는 사원수를 조회하시오.
--     단, 근무하는 사원이 없으면 0으로 조회하시오.
SELECT D.department_name, NVL(COUNT(E.EMPLOYEE_ID), 0)
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID(+)
 GROUP BY D.DEPARTMENT_NAME;