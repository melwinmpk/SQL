CREATE TABLE medium_1045_Customer 
(
	customer_id int,
	product_key int
);

CREATE TABLE medium_1045_Product
(
	product_key int
);

INSERT INTO medium_1045_Customer VALUES 
(1,5),
(2,6),
(3,5),
(3,6),
(1,6);

INSERT INTO medium_1045_Product VALUES 
(5),(6);

	
SELECT  c.customer_id  
FROM medium_1045_Customer c 
GROUP BY c.customer_id
HAVING COUNT(DISTINCT c.product_key) = (
	SELECT DISTINCT COUNT(product_key) 
	FROM medium_1045_Product
);

CREATE TABLE medium_1070_Sales 
(
	sale_id    int,
	product_id int,
	year       int,
	quantity   int,
	price      int	
);

CREATE TABLE medium_1070_Product
(
	product_id   int    ,
	product_name varchar(7)	
);

INSERT INTO medium_1070_Sales VALUES 
(1,100,2008,10,5000),
(2,100,2009,12,5000),
(7,200,2011,15,9000);

INSERT INTO medium_1070_Product VALUES
(100,'Nokia'  ),
(200,'Apple'  ),
(300,'Samsung');

WITH TEMP AS (
	SELECT product_id, MIN(year) as first_year
	FROM medium_1070_Sales
	GROUP BY product_id
)
SELECT t1.product_id,year,quantity,price 
FROM medium_1070_Sales t1 
INNER JOIN TEMP t2 ON t1.product_id = t2.product_id
AND t1.year = t2.first_year;

CREATE TABLE medium_1164 
(
	product_id  int ,
	new_price   int ,
	change_date date
);

INSERT INTO medium_1164 VALUES 
(1,20,'2019-08-14'),
(2,50,'2019-08-14'),
(1,30,'2019-08-15'),
(1,35,'2019-08-16'),
(2,65,'2019-08-17'),
(3,20,'2019-08-18');

WITH TEMP AS (
	SELECT product_id, new_price, change_date as start_date, 
	LAG(change_date,1,NULL) 
	OVER (PARTITION BY product_id ORDER BY change_date desc) as end_date
	FROM medium_1164
	)
, temp_1 as ( 
SELECT product_id, new_price 
FROM TEMP 
WHERE   start_date<='2019-08-16' 
AND (end_date>'2019-08-16' OR end_date IS NULL))
, temp_2 as (
SELECT product_id, 10 as new_price 
FROM TEMP 
WHERE   start_date > '2019-08-16' 
and product_id not in (SELECT product_id FROM temp_1)
)
SELECT * FROM temp_1
UNION 
SELECT * FROM temp_2;


CREATE TABLE medium_1174 
(
delivery_id                 int ,
customer_id                 int ,
order_date                  date,
customer_pref_delivery_date date
);

INSERT INTO medium_1174 VALUES 
(1,1,'2019-08-01','2019-08-02'),
(2,2,'2019-08-02','2019-08-02'),
(3,1,'2019-08-11','2019-08-12'),
(4,3,'2019-08-24','2019-08-24'),
(5,3,'2019-08-21','2019-08-22'),
(6,2,'2019-08-11','2019-08-13'),
(7,4,'2019-08-09','2019-08-09');

WITH get_first_order as 
(
	SELECT delivery_id, customer_id , order_date, 
	customer_pref_delivery_date,
	RANK() OVER(PARTITION BY customer_id ORDER BY order_date ASC ) as rnk
	FROM medium_1174
)
SELECT 
	ROUND((COUNT(customer_id)/(SELECT COUNT(DISTINCT customer_id) FROM medium_1174))*100 ,2) as immediate_percentage 
FROM get_first_order
WHERE rnk = 1 and 
order_date = customer_pref_delivery_date;	

CREATE TABLE medium_1193 (
	id         int    ,
	country    varchar(2),
	state      enum ('approved','declined'),
	amount     int    ,
	trans_date date   
);

INSERT INTO medium_1193 VALUES 
(121,'US','approved',1000,'2018-12-18'),
(122,'US','declined',2000,'2018-12-19'),
(123,'US','approved',2000,'2019-01-01'),
(124,'DE','approved',2000,'2019-01-07');

SELECT 
CONCAT(YEAR(trans_date),'-',MONTH(trans_date)) month,
country, count(*) as trans_count, 
SUM(CASE WHEN state = 'approved' 
	 THEN 1
	 ELSE 0
END) as approved_count,
SUM(amount) trans_total_amount,
SUM(CASE WHEN state = 'approved' 
	 THEN amount
	 ELSE 0
END) as approved_total_amount
FROM medium_1193
GROUP BY 
month,
country ;

CREATE TABLE medium_1204 
( person_id   int    ,
  person_name varchar(9),
  weight      int    ,
  turn        int    );

INSERT INTO medium_1204 VALUES 
(5,'Alice'    ,250,1),
(4,'Bob'      ,175,5),
(3,'Alex'     ,350,2),
(6,'John Cena',400,3),
(1,'Winston'  ,500,6),
(2,'Marie'    ,200,4);

WITH cumulative_sum as 
(
SELECT person_id, person_name, weight, turn ,
SUM(weight) OVER(ORDER BY turn) as sum_c
FROM medium_1204 
)
SELECT person_name 
FROM cumulative_sum 
WHERE sum_c <= 1000
ORDER BY turn desc
limit 1;

WITH cumulative_sum as 
(
SELECT person_id, person_name, weight, turn ,
SUM(weight) OVER(ORDER BY turn) as sum_c
FROM medium_1204 
)
SELECT person_name 
FROM cumulative_sum 
WHERE sum_c = (
SELECT MAX(sum_c) from cumulative_sum 
WHERE sum_c<= 1000
);


CREATE TABLE medium_1321 (
	customer_id int    ,
	name        varchar(7),
	visited_on  date   ,
	amount      int    
);

INSERT INTO medium_1321 VALUES 
(1,'Jhon'   ,'2019-01-01',100),
(2,'Daniel' ,'2019-01-02',110),
(3,'Jade'   ,'2019-01-03',120),
(4,'Khaled' ,'2019-01-04',130),
(5,'Winston','2019-01-05',110), 
(6,'Elvis'  ,'2019-01-06',140), 
(7,'Anna'   ,'2019-01-07',150),
(8,'Maria'  ,'2019-01-08',80 ),
(9,'Jaze'   ,'2019-01-09',110), 
(1,'Jhon'   ,'2019-01-10',130), 
(3,'Jade'   ,'2019-01-10',150);


WITH TEMP AS (
SELECT  
	   visited_on,
	   SUM(amount) as amount
	   FROM medium_1321
GROUP BY visited_on
), TEMP_1 AS (
SELECT
	   visited_on,
	   sum(amount) OVER (
			ORDER BY visited_on rows 6 preceding
			) amount,
	   ROUND(AVG(amount) OVER (
        ORDER BY visited_on 
			ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
		),2) AS average_amount
FROM TEMP
)
SELECT visited_on,amount,average_amount  
FROM TEMP_1
WHERE DATEDIFF(visited_on, (SELECT MIN(visited_on) FROM medium_1321)) >= 6
ORDER BY visited_on ;




