
--ID 	RECORD_DATE 	TEMEPERATURE 
--
--1 	01-01-2015			10 
--
--2	02-01-2015			25 
--
--3	03-01-2015			20 
--
--4	04-01-2015			30 

CREATE TABLE TEMPTABLE (
ID            NUMBER PRIMARY KEY,
RECORD_DATE   DATE   NOT NULL,
TEMEPERATURE  NUMBER NOT NULL
);
DESC TEMPTABLE;

INSERT ALL 
  INTO TEMPTABLE (ID,RECORD_DATE,TEMEPERATURE) VALUES (1,'01-01-2015',10)
  INTO TEMPTABLE (ID,RECORD_DATE,TEMEPERATURE) VALUES (2,'02-01-2015',25)
  INTO TEMPTABLE (ID,RECORD_DATE,TEMEPERATURE) VALUES (3,'03-01-2015',20)
  INTO TEMPTABLE (ID,RECORD_DATE,TEMEPERATURE) VALUES (4,'04-01-2015',30)
SELECT * FROM DUAL;

SELECT * FROM TEMPTABLE;


SELECT a.ID,a.RECORD_DATE,a.TEMEPERATURE 
FROM TEMPTABLE a,TEMPTABLE b
WHERE (a.RECORD_DATE-b.RECORD_DATE) = 1
AND a.TEMEPERATURE > b.TEMEPERATURE;

DESC dept;
SELECT * FROM dept;
DESC emp;
SELECT * FROM emp;
DESC salgrade;
SELECT * FROM salgrade;

-- 2) List the jobs unique to department 20? 
SELECT DISTINCT(JOB),DEPTNO  FROM emp 
WHERE DEPTNO = 20;

-- 3) List the employees belonging to the department of �MILLER�? 
SELECT a.ENAME FROM emp a
WHERE a.DEPTNO IN (
  SELECT b.DEPTNO 
  FROM emp b 
  WHERE b.ENAME = 'MILLER'
  );
  
-- 4) List all the employees who have the same job as �SCOTT�? 

SELECT a.ENAME FROM emp a
INNER JOIN emp b ON a.JOB = b.JOB 
AND b.ENAME = 'SCOTT';