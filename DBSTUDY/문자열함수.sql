-- BUILT_IN FUNCTION

-- 1. 대소문자 변환 함수
--    1) UPPER : 전부 대문자로 변환
--    2) LOWER : 전부 소문자로 변환
--    3) INITCAP : 첫 글자를 대문자로 변환, 나머지 글자를 소문자로 변환
SELECT UPPER(FIRST_NAME) FROM EMPLOYEES;
SELECT LOWER(FIRST_NAME) FRON EMPLOYEES;
SELECT INITCAP(EMAIL) FROM EMPLOYEES;

-- 2. 문자열의 일부 반환
--    SUBSTR('문자열', begin, count)
SELECT SUBSTR(FIRST_NAME, 1, 3)FROM EMPLOYEES; --FIRST_NAME 의 1번째 글자부터 3글자만 반환

-- 3. 문자열의 길이 반환
SELECT FIRST_NAME, LENGTH(FIRST_NAME) FROM EMPLOYEES;


-- 4. 특정 문자열의 위치 반환
--    INSTR('문자열', '찾을문자열')
SELECT FIRST_NAME, INSTR(FIRST_NAME, 'A') FROM EMPLOYEES;

-- 5. 좌우의 공백 제거 (중간 공백은 안 됨)
SELECT LTRIM('   ORACLE') FROM DUAL;
SELECT RTRIM('ORCLAE   ') FROM DUAL;
SELECT TRIM('    ORCLE   ') FROM DUAL;


-- 6. 문자열 연결
--    1) || : 오라클에서는 OR이 아니라 연결(+) 연산자이다.
--    2) CONCAT('문자열1', '문자열2') : CONCATENATE, 인수는 오직 2개만 가능하다.
SELECT FIRST_NAME ||''|| LAST_NAME FROM EMPLOYEES;
SELECT CONCAT(FIRST_NAME, CONCAT('' ,LAST_NAME)) FROM EMPLOYEES;


-- 7. 문자열 채우기
--    1) LPAD('문자열', 전체필드폭, '채울문자')
SELECT LPAD(FIRST_NAME, 10, '*') FROM EMPLOYEES;    --'*****ELLEN'
SELECT LPAD(FIRST_NAME, 10, ' ') FROM EMPLOYEES;    --'     ELLEN'
--    2) RPAD('문자열', 전체필드폭, '채울문자')
SELECT RPAD(FITST_NAME, 10, '*') FROM EMPLOYEESL;   --'ELLEN*****'
