--1.사용자 추가
CREATE USER 사용자 IDENTIFIED BY 비밀번호;

--2.권한부여
GRANT CONNECT, RESOURCE TO 사용자; --접속 및 자원 사용 권한
GRANT DBA TO 사용자; -- 관리자 권한

--3.사용자 제거
DROP USER 사용자;
DROP USER 사용자 CASCADE; --사용자가 테이블 등 데이터를 가진 경우

--4.권한 해제
REVOKE CONNECT, RESOURCE FROM 사용자;
REVOKE DBA FROM 사용자;