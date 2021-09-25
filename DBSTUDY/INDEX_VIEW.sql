
-- 인덱스

-- 1. student 테이블의 name 칼럼에 비고유(중복이 있는 칼럼) 인덱스를 지정하시오.
CREATE INDEX NAME_IX ON STUDENT(NAME);

-- 2. student 테이블의 kor 칼럼에 고유(중복이 없는 칼럼) 인덱스를 지정하시오.
CREATE UNIQUE INDEX KOR_IX ON STUDENT(KOR);

DROP INDEX NAME_IX;
DROP INDEX KOR_IX;

-- 뷰(view)

-- employees 테이블의 first_name, last_name, salary를 자주 참조할 수 있도록 뷰(view)를 생성하시오.
CREATE VIEW MY_VIEW AS (SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES);

-- 생성된 view는 테이블처럼 조회할 수 있다.
SELECT FIRST_NAME, LAST_NAME, SALARY FROM MY_VIEW;
