DESC dept;
SELECT * FROM dept;
DESC emp;
SELECT * FROM emp;
DESC salgrade;
SELECT * FROM salgrade;



--SELECT c.MGR, count(*) FROM emp c GROUP BY c.MGR;
 SELECT a.EMPNO, a.ENAME, b.ENAME, c.count1  AS MANAGER FROM 
 emp a, emp b 
 JOIN (SELECT c.MGR, count(*) as count1 FROM emp c GROUP BY c.MGR) c ON c.MGR = b.EMPNO
 AND a.MGR = b.EMPNO;


DROP VIEW reportingmanager;
create view reportingmanager AS
  select e.ename emp_name, m.ename as mgr_name, count(m.empno) over(partition by m.ename) as reportees
  from emp e
  left join emp m 
  on e.mgr = m.empno
  AND m.ename = 'BLAKE' 
  order by e.empno;

SELECT * from reportingmanager;


SET serveroutput ON;

CREATE OR REPLACE PROCEDURE SUM (a IN NUMBER, b IN NUMBER) IS
BEGIN 
    dbms_output.put_line('Sum od two no ='||(a+b));
END Sum;

DECLARE
  x number;
  y number;
BEGIN
  x :=&x;
  y :=&y;
  Sum(x,y);
END;  
      







