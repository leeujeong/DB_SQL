-- DQL
-- Data Query Language


-- 1. employee 테이블의 모든 칼럼을 조회하시오.
SELECT * FROM employee;  -- 실무에서는 * 사용 금지


-- 2. department 테이블의 부서위치를 중복 제거해서 조회하시오.
SELECT DISTINCT location FROM department;


-- 3. employee 테이블에서 '과장'의 이름을 조회하시오.
-- (칼럼 앞에 오너(칼럼이 속한 테이블)를 명시할 수 있다.)
SELECT employee_name FROM employee WHERE employee_position ='과장';


-- 4. employee 테이블에서 급여가 5000000 이상인 사원들의 이름과 직급을 조회하시오.
SELECT employee_name, position FEOM employee WHERE salary >=500000;

-- 5. employee 테이블에서 200000~4000000 사이의 급여를 받는 사원의 이름과 급여를 조회하시오.
SELECT EMPLOYEE_NAME, SALARY FROM EMPLOYEE WHERE SALARY BETWEEN 200000 AND 400000;
SELECT EMPLOYEE_NAME, SALARY FROM EMPLOYEE WHERE SALARY >=200000 AND SALARY <=4000000;


-- 6. employee 테이블에서 고용일이 '90/01/01'~'99/12/31' 사이인 사원의 이름과 직급을 조회하시오.
SELECT EMPOLYEE_NAME, POSITION FROM EMPLOYEE WHERE HIRE_DATE BETWEEN '90/01/01'AND '00/12/31';
SELECT EMPOLYEE_NAME, POSITION FROM EMPLOYEE WHERE TO_DATE(HIRE_DATE, 'YY/MM/DD') BETWEEN TO_DATE('90/01/01','YY/MM/DD') AND TO_DATE('99/12/31','YY/MM/DD');

-- 7. employee 테이블에서 직급이 '과장'과 '부장'인 사원의 이름과 부서번호를 조회하시오.
SELECT EMPLOYEE_NAME, DEPART FROM EMPLOYEE WHERE POSITION ='과장' OR POSITION ='부장';
SELECT EMPLOYEE_NAME, DEPART FROM EMPLOIYE WHERE POSITION IN ('과장','부장');

-- 8. department 테이블에서 부서위치가 '대구'인 지점의 부서명을 조회하시오.
-- AS : Alias (별명), 본래 명칭 대신 사용할 이름을 지정 (칼럼, 테이블)
-- 칼럼 AS 별명
SELECT DISTINCT DEPT_NAME AS "부서명" FROM DEPARTMENT WHERE LOCATION = '대구';