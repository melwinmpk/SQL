
drop table orgders;
create table orders (
 SR_NO number(10),
 USER_ID number(10),
 ITEM VARCHAR2(20)
);

DROP TABLE users;
create table users(
  id number(10),
  name varchar2(20)
);

INSERT ALL
  INTO orders (SR_NO, USER_ID, ITEM) VALUES (1, 2, 'Pizza')
  INTO orders (SR_NO, USER_ID, ITEM) VALUES (2, 2, 'Burger')
  INTO orders (SR_NO, USER_ID, ITEM) VALUES (3, 2, 'Milk Shake')
  INTO orders (SR_NO, USER_ID, ITEM) VALUES (4, 3, 'French Fries')
  INTO orders (SR_NO, USER_ID, ITEM) VALUES (5, 3, 'Burger')
  INTO orders (SR_NO, USER_ID, ITEM) VALUES (6, 5, 'Diet Coke')
  INTO orders (SR_NO, USER_ID, ITEM) VALUES (7, 5, 'Burger')
  INTO orders (SR_NO, USER_ID, ITEM) VALUES (8, 99, 'Burger')
SELECT * FROM DUAL;

INSERT ALL
  INTO users (id, name) VALUES (1, 'Saif')
  INTO users (id, name) VALUES (2, 'Amik')
  INTO users (id, name) VALUES (3, 'Pankag')
  INTO users (id, name) VALUES (4, 'Neeraj')
  INTO users (id, name) VALUES (5, 'Samadhan')
SELECT * FROM DUAL;



-- JOINS --

SELECT o.*,u.*  FROM orders o
INNER JOIN users u ON u.id = o.USER_ID;

SELECT o.*,u.*  FROM orders o
LEFT JOIN users u ON u.id = o.USER_ID;

SELECT o.*,u.*  FROM orders o
RIGHT JOIN users u ON u.id = o.USER_ID;

SELECT * FROM orders;
SELECT * FROM users;


DROP SEQUENCE Melwin;

CREATE SEQUENCE Melwin
START WITH 1
INCREMENT By 1
MAXVALUE 25 
CYCLE 
Cache 20;

SELECT Melwin.NextVal FROM DUAL;

SELECT Melwin.CURRVAL FROM DUAL;

-- In Oracle SQL 
CREATE TABLE col (  
  data varchar2(10) Primary key   
);  
desc col;  
INSERT ALL  
  INTO col (data) VALUES ('101')    
  INTO col (data) VALUES ('Saif')  
  INTO col (data) VALUES ('Shaikh')  
  INTO col (data) VALUES ('Pune')  
  INTO col (data) VALUES ('102')  
  INTO col (data) VALUES ('Ram')   
  INTO col (data) VALUES ('Shirali')  
  INTO col (data) VALUES ('Mumbai')  
SELECT * FROM dual; 

SELECT MOD(ROWNUM,4),  
       DATA,  
       NTILE(2) OVER(order by ROWNUM) no   
FROM col;  
SELECT   
        MAX(CASE WHEN RNO1 = 1 THEN DATA END) AS ID,  
        MAX(CASE WHEN RNO1 = 2 THEN DATA END) AS Fname,  
        MAX(CASE WHEN RNO1 = 3 THEN DATA END) AS Lname,  
        MAX(CASE WHEN RNO1 = 0 THEN DATA END) AS City   
FROM          
(SELECT NTILE(2) OVER(order by ROWNUM) as RNO,   
        MOD(ROWNUM,4) AS RNO1,   
       DATA   
FROM col)  
GROUP BY RNO;

-- in this query 
SELECT   
        MAX(CASE WHEN RNO1 = 1 THEN DATA END) AS ID,  
        MAX(CASE WHEN RNO1 = 2 THEN DATA END) AS Fname,  
        MAX(CASE WHEN RNO1 = 3 THEN DATA END) AS Lname,  
        MAX(CASE WHEN RNO1 = 0 THEN DATA END) AS City   
FROM          
(SELECT NTILE(len) OVER(partition by len order by ROWNUM) as RNO,   
        MOD(ROWNUM,4) AS RNO1,   
       DATA   
FROM col 
CROSS JOIN (SELECT COUNT(*)/4 len FROM col themp) )    
GROUP BY RNO;

