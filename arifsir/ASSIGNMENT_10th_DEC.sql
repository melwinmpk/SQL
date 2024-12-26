drop table DATATABLE;
CREATE TABLE DATATABLE (
ID NUMBER NOT NULL,
TYPE VARCHAR2(10),
DESCRIPTION VARCHAR2(20)
);
DESC DATATABLE;
INSERT ALL
  INTO DATATABLE (ID,TYPE,DESCRIPTION) VALUES (10,'EMAIL','saif.shaikh@db.com')
  INTO DATATABLE (ID,TYPE,DESCRIPTION) VALUES (10,'FAX','1234567890')
  INTO DATATABLE (ID,TYPE,DESCRIPTION) VALUES (10,'MOBILE','1357924680')
SELECT * FROM DUAL;

SELECT * FROM DATATABLE;

-- SELECT CONCAT(a.TYPE,"  ",a.DESCRIPTION,"|",b.TYPE,"|",b.DESCRIPTION,"|",c."TYPE","|",c.DESCRIPTION) 
-- SELECT a.TYPE || "  " || a.DESCRIPTION || "|" || b.TYPE || "|" || b.DESCRIPTION || "|" || c."TYPE" || "|" || c.DESCRIPTION 
SELECT CONCAT(a.TYPE,
        CONCAT('  ',
          CONCAT(a.DESCRIPTION,
            CONCAT('|',
              CONCAT(b.TYPE,
                CONCAT('|',
                  CONCAT(b.DESCRIPTION,
                    CONCAT('|',
                      CONCAT(c.TYPE,
                        CONCAT('|',c.DESCRIPTION)
                      )
                    )
                  )
                )
              )
            ) 
          )
        )
      ) as OUTPUT
FROM DATATABLE a,DATATABLE b,DATATABLE c,DATATABLE d
WHERE a.TYPE = 'EMAIL'
AND b.TYPE = 'FAX' 
AND c.TYPE = 'MOBILE'
AND ROWNUM <= 1;

DESC dept;
SELECT * FROM dept;
DESC emp;
SELECT * FROM emp;
DESC salgrade;
SELECT * FROM salgrade;

-- 2) Display the names of the employees who are working in Sales or Research department?

SELECT emp.ENAME FROM emp 
INNER JOIN dept ON dept.DEPTNO = emp.DEPTNO
WHERE dept.DNAME IN ('RESEARCH','SALES');

-- 3) Display name and salary of the employee who is working in CHICAGO? 
SELECT emp.ENAME, emp.SAL FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO 
WHERE dept.LOC = 'CHICAGO';

-- 4) List the details of employees in department 10 who have the same job  as in department 30?
SELECT a.* FROM emp a  
WHERE 
a.DEPTNO = 10
AND a.JOB IN (
  SELECT b.JOB 
  FROM emp b 
  WHERE b.DEPTNO = 30 
);


