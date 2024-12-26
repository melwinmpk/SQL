DROP TABLE sales;
CREATE TABLE sales (
  customer_id VARCHAR2(1),
  order_date DATE,
  product_id NUMBER
);

DROP TABLE members;
CREATE TABLE members (
  customer_id Varchar2(1),
  join_date DATE
);


DROP TABLE menu;
CREATE TABLE menu (
  product_id varchar2(1),
  product_name varchar2(5),
  price number
);

DESC menu;
DESC members;
DESC sales;



INSERT ALL
  INTO sales (customer_id, order_date, product_id) VALUES ('A', TO_DATE('2021-01-01','YYYY-MM-DD'), 1)
  INTO sales (customer_id, order_date, product_id) VALUES ('A', TO_DATE('2021-01-01','YYYY-MM-DD'), 2)
  INTO sales (customer_id, order_date, product_id) VALUES ('A', TO_DATE('2021-01-07','YYYY-MM-DD'), 2)
  INTO sales (customer_id, order_date, product_id) VALUES ('A', TO_DATE('2021-01-10','YYYY-MM-DD'), 3)
  INTO sales (customer_id, order_date, product_id) VALUES ('A', TO_DATE('2021-01-11','YYYY-MM-DD'), 3)
  INTO sales (customer_id, order_date, product_id) VALUES ('A', TO_DATE('2021-01-11','YYYY-MM-DD'), 3)
  INTO sales (customer_id, order_date, product_id) VALUES ('B', TO_DATE('2021-01-01','YYYY-MM-DD'), 2)
  INTO sales (customer_id, order_date, product_id) VALUES ('B', TO_DATE('2021-01-02','YYYY-MM-DD'), 2)
  INTO sales (customer_id, order_date, product_id) VALUES ('B', TO_DATE('2021-01-04','YYYY-MM-DD'), 1)
  INTO sales (customer_id, order_date, product_id) VALUES ('B', TO_DATE('2021-01-11','YYYY-MM-DD'), 1)
  INTO sales (customer_id, order_date, product_id) VALUES ('B', TO_DATE('2021-01-16','YYYY-MM-DD'), 3)
  INTO sales (customer_id, order_date, product_id) VALUES ('B', TO_DATE('2021-02-01','YYYY-MM-DD'), 3)
  INTO sales (customer_id, order_date, product_id) VALUES ('C', TO_DATE('2021-01-01','YYYY-MM-DD'), 3)
  INTO sales (customer_id, order_date, product_id) VALUES ('C', TO_DATE('2021-01-01','YYYY-MM-DD'), 3)
  INTO sales (customer_id, order_date, product_id) VALUES ('C', TO_DATE('2021-01-07','YYYY-MM-DD'), 3)
SELECT * FROM DUAL;

SELECT * FROM sales;
TRUNCATE TABLE menu; 
INSERT ALL 
  INTO menu (PRODUCT_ID,PRODUCT_NAME,PRICE) VALUES (1,'sushi',10)
  INTO menu (PRODUCT_ID,PRODUCT_NAME,PRICE) VALUES (2,'curry',15)
  INTO menu (PRODUCT_ID,PRODUCT_NAME,PRICE) VALUES (3,'ramen',12)
SELECT * FROM DUAL;

SELECT * FROM menu;

TRUNCATE TABLE members; 
INSERT ALL
  INTO members (CUSTOMER_ID,JOIN_DATE) VALUES ('A', TO_DATE('2021-01-07','YYYY-MM-DD') )
  INTO members (CUSTOMER_ID,JOIN_DATE) VALUES ('B', TO_DATE('2021-01-09','YYYY-MM-DD') )
SELECT * FROM DUAL;

SELECT * FROM members;

-- 1) What is the total amount each customer spent at the restaurant? 
SELECT CUSTOMER_ID, SUM(menu.PRICE) FROM sales
JOIN menu ON sales.PRODUCT_ID = menu.PRODUCT_ID
GROUP BY CUSTOMER_ID;

-- 2) How many days has each customer visited the restaurant? 
SELECT CUSTOMER_ID, COUNT(DISTINCT(ORDER_DATE)) AS NO_DAYS FROM sales
GROUP BY CUSTOMER_ID;



--3) What was the first item from the menu purchased by each customer? 

SELECT a.customer_Id, a.order_date, a.PRODUCT_NAME
FROM (
	SELECT 
    sales.customer_Id, 
    sales.order_date,
		(RANK() over(PARTITION by sales.customer_Id order by sales.order_date ASC)) as rowno,
    menu.PRODUCT_NAME
	FROM 
		sales
  JOIN menu ON menu.PRODUCT_ID = sales.PRODUCT_ID  
) a
WHERE a.rowno = 1;


-- 4) What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT  sales.customer_id, COUNT(sales.product_id)
FROM sales 
JOIN menu ON menu.product_id = sales.product_id 
AND sales.product_id IN (
                          SELECT product_id FROM
                          (
                            SELECT product_id, COUNT(product_id) as count_ordered FROM sales
                            GROUP BY product_id
                            ORDER BY count_ordered DESC
                          )
                          where ROWNUM = 1
                        )
GROUP BY customer_id;

-- 5) Which item was the most popular for each customer?

SELECT a.customer_id, a.product_id, a.count1 as ordercount, menu.product_name, a.rowno
FROM
(
  SELECT sales.customer_id, sales.product_id , COUNT(*) as count1
  ,(ROW_NUMBER() OVER(partition by sales.customer_id ORDER BY sales.customer_id)) as rowno
  FROM sales
  GROUP BY customer_id, product_id
  ORDER BY customer_id,count1 DESC
) a
JOIN menu ON a.PRODUCT_ID = menu.PRODUCT_ID
WHERE rowno = 1;



-- 6) Which item was purchased first by the customer after they became a member?
SELECT CUSTOMER_ID,ORDER_DATE,PRODUCT_ID,PRODUCT_NAME,JOIN_DATE
FROM(
  SELECT sales.CUSTOMER_ID, sales.ORDER_DATE, sales.PRODUCT_ID, menu.PRODUCT_NAME, members.JOIN_DATE,
  (RANK() OVER(partition by sales.CUSTOMER_ID ORDER BY sales.ORDER_DATE ASC)) AS rank_no
  FROM sales
  INNER JOIN menu ON menu.PRODUCT_ID = sales.PRODUCT_ID
  INNER JOIN members ON members.CUSTOMER_ID = sales.CUSTOMER_ID
  AND members.JOIN_DATE <= sales.ORDER_DATE
) 
WHERE rank_no = 1;

-- 7) Which item was purchased just before the customer became a member?
SELECT CUSTOMER_ID,ORDER_DATE,PRODUCT_ID,PRODUCT_NAME,JOIN_DATE
FROM(
  SELECT sales.CUSTOMER_ID, sales.ORDER_DATE, sales.PRODUCT_ID, menu.PRODUCT_NAME, members.JOIN_DATE,
  (RANK() OVER(partition by sales.CUSTOMER_ID ORDER BY sales.ORDER_DATE DESC)) AS rank_no
  FROM sales
  INNER JOIN menu ON menu.PRODUCT_ID = sales.PRODUCT_ID
  INNER JOIN members ON members.CUSTOMER_ID = sales.CUSTOMER_ID
  AND members.JOIN_DATE > sales.ORDER_DATE
) 
WHERE rank_no = 1;


-- 8) What is the total items and amount spent for each member before they became a member?

  SELECT sales.CUSTOMER_ID, COUNT(sales.PRODUCT_ID), SUM(menu.price)
  FROM sales
  INNER JOIN menu ON menu.PRODUCT_ID = sales.PRODUCT_ID
  INNER JOIN members ON members.CUSTOMER_ID = sales.CUSTOMER_ID
  AND sales.ORDER_DATE < members.JOIN_DATE 
  GROUP BY sales.CUSTOMER_ID

-- 9) If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT CUSTOMER_ID, SUM(POINTS)  FROM 
(
  SELECT sales.CUSTOMER_ID, sales.PRODUCT_ID , menu.price, menu.PRODUCT_NAME,
  CASE
    WHEN menu.PRODUCT_NAME = 'sushi' THEN menu.price*20 
    ELSE menu.price*10 
  END as POINTS
  FROM sales
  INNER JOIN menu ON menu.PRODUCT_ID = sales.PRODUCT_ID
)
GROUP BY CUSTOMER_ID;

DESC menu;
DESC members;
DESC sales;

-- 10)In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not 
--    just sushi - how many points do customer A and B have at theend of January? 

SELECT CUSTOMER_ID, SUM(POINTS)  FROM 
(
  SELECT sales.CUSTOMER_ID, sales.PRODUCT_ID , menu.price, menu.PRODUCT_NAME, sales.ORDER_DATE,
  CASE
    WHEN (members.JOIN_DATE - sales.ORDER_DATE) < 7 THEN menu.price*20
    WHEN menu.PRODUCT_NAME = 'sushi' THEN menu.price*20 
    ELSE menu.price*10 
  END as POINTS
  FROM sales
  INNER JOIN menu ON menu.PRODUCT_ID = sales.PRODUCT_ID
  INNER JOIN members ON members.CUSTOMER_ID = sales.CUSTOMER_ID
  AND sales.ORDER_DATE < TO_DATE('2021-02-01','YYYY-MM-DD')
)
GROUP BY CUSTOMER_ID;

SELECT * FROM SALES;


