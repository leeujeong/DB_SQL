-- 자식 테이블 먼저 삭제
DROP TABLE PROCEEDING;
DROP TABLE EMPLOYEE;
DROP TABLE PROJECT;
DROP TABLE DEPARTMENT;


-- 부서(DEPARTMENT)
CREATE TABLE DEPARTMENT(
    DEPT_NO         VARCHAR2(15 BYTE)   NOT NULL,
    DEPT_NAME       VARCHAR2(30 BYTE),
    DEPT_LOCATION   VARCHAR2(50));


-- 사원(EMPLOYEE)
CREATE TABLE EMPLOYEE(
    EMP_NO      NUMBER          NOT NULL,
    DEPT_NO     VARCHAR2(15),
    POSITION    CHAR(10),
    NAME        VARCHAR2(15),
    HIRE_DATE   DATE,
    SALARY      NUMBER);


-- 프로젝트(PROJECT)
CREATE TABLE PROJECT(
    PJT_NO      NUMBER      NOT NULL,
    PJT_NAME    VARCHAR2(30),
    BEGIN_DATE  DATE,
    END_DATE    DATE);


-- 프로젝트진행(PROCEEDING)
CREATE TABLE PROCEEDING(
    PCD_NO      NUMBER      NOT NULL,
    EMP_NO      NUMBER,
    PJT_NO      NUMBER);


-- 기본키, 외래키 추가
ALTER TABLE DEPARTMENT ADD CONSTRAINT DEPARTMENT_PK PRIMARY KEY(DEPT_NO);
ALTER TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE_PK PRIMARY KEY(EMP_NO);
ALTER TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE_DEPARTMENT_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO);
ALTER TABLE PROJECT ADD CONSTRAINT PROJECT_PK PRIMARY KEY(PJT_NO);
ALTER TABLE PROCEEDING ADD CONSTRAINT PROCEEDING_PK PRIMARY KEY(PCD_NO);
ALTER TABLE PROCEEDING ADD CONSTRAINT PROCEEDING_EMPLOYEE_FK FOREIGN KEY(EMP_NO) REFERENCES EMPLOYEE(EMP_NO);
ALTER TABLE PROCEEDING ADD CONSTRAINT PROCEEDING_PROJECT_FK FOREIGN KEY(PJT_NO) REFERENCES PROJECT(PJT_NO);