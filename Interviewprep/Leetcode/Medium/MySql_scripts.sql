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



CREATE TABLE medium_1341_movies (
	movie_id int,    
	title    varchar(8)
);

CREATE TABLE medium_1341_users (
	user_id int,
	name varchar(6)
);

CREATE TABLE medium_1341_movierating (
	movie_id   int ,
	user_id    int ,
	rating     int ,
	created_at date
);

INSERT INTO medium_1341_movies VALUES 
(1,'Avengers'),
(2,'Frozen 2'),
(3,'Joker');

INSERT INTO medium_1341_users VALUES 
(1,'Daniel'),
(2,'Monica'),
(3,'Maria'),
(4,'James');

INSERT INTO medium_1341_movierating VALUES 
(1,1,3,'2020-01-12'),
(1,2,4,'2020-02-11'),
(1,3,2,'2020-02-12'),
(1,4,1,'2020-01-01'),
(2,1,5,'2020-02-17'), 
(2,2,2,'2020-02-01'), 
(2,3,2,'2020-03-01'),
(3,1,3,'2020-02-22'), 
(3,2,4,'2020-02-25');

SELECT (
WITH temp_u as (
SELECT u.name, length(u.name) namelength, AVG(rating)
FROM medium_1341_movierating mr 
LEFT JOIN medium_1341_users u 
	  ON mr.user_id = u.user_id
GROUP BY u.name 
ORDER BY  u.name,
          namelength 
limit 1
)
SELECT name 
FROM temp_u ) as results

UNION

SELECT (
with temp_m as ( 
	SELECT m.title, length(m.title) title_length, AVG(rating)        
	FROM medium_1341_movierating mr 
	LEFT JOIN medium_1341_movies m 
		  on mr.movie_id = m.movie_id 
	WHERE  MONTH(mr.created_at) = 2 
	and    YEAR(mr.created_at) = 2020
	GROUP BY m.title 
	ORDER BY AVG(rating) desc, 
			 m.title,
			 title_length  
limit 1
)
SELECT title 
FROM temp_m ) as results
		 
	  

CREATE TABLE medium_176 (
id     int,
salary int
);

INSERT INTO medium_176 VALUES 
(1,100),
(2,200),
(3,300);

SELECT MAX(salary) as SecondHighestSalary
FROM  medium_176 
WHERE salary != ( SELECT MAX(salary) FROM medium_176);

CREATE TABLE medium_180 (
	id int,
	num varchar(1)
);

INSERT INTO medium_180 VALUES
(1,'1'),
(2,'1'),
(3,'1'),
(4,'2'),
(5,'1'),
(6,'2'),
(7,'2');

WITH TEMP AS (
SELECT id,num, 
	   LAG(num,1,NULL)
	   OVER(ORDER BY id) as lag_1,
	   LAG(num,2,NULL)
	   OVER(ORDER BY id) as lag_2
FROM medium_180
)
SELECT distinct num as ConsecutiveNums 
FROM TEMP 
WHERE num = lag_1 and num = lag_2;

CREATE TABLE medium_1907 (
	account_id int,
	income     int
);

INSERT INTO medium_1907 VALUES
(3,108939),
(2,12747 ),
(8,87709 ),
(6,91796 );

WITH TEMP AS (
	SELECT account_id, income,
		   CASE WHEN income < 20000
					THEN "Low Salary"
				WHEN income BETWEEN 20000 AND 50000
					THEN "Average Salary"
				WHEN income > 50000
					THEN "High Salary"
			END category
	FROM medium_1907
)
SELECT category, COUNT(*) as accounts_count
FROM TEMP
GROUP BY category;

SELECT "Low Salary" as category, 
       count(*) as accounts_count
FROM medium_1907
WHERE income < 20000
UNION 
SELECT "Average Salary" as category, 
       count(*) as accounts_count
FROM medium_1907
WHERE income BETWEEN 20000 AND 50000
UNION
SELECT "High Salary" as category, 
       count(*) as accounts_count
FROM medium_1907
WHERE income > 50000;

CREATE TABLE medium_1934_signups (
	user_id    int     ,
	time_stamp datetime
);

CREATE TABLE medium_1934_confirmations (
	user_id    int     ,
	time_stamp datetime,
	action     ENUM  ('confirmed','timeout')  
);

INSERT INTO medium_1934_signups VALUES 
(3,'2020-03-21 10:16:13'),
(7,'2020-01-04 13:57:59'),
(2,'2020-07-29 23:09:44'),
(6,'2020-12-09 10:39:37');

INSERT INTO medium_1934_confirmations VALUES 
(3,'2021-01-06 03:30:46','timeout'),
(3,'2021-07-14 14:00:00','timeout'),
(7,'2021-06-12 11:57:29','confirmed'),
(7,'2021-06-13 12:58:28','confirmed'),
(7,'2021-06-14 13:59:27','confirmed'),
(2,'2021-01-22 00:00:00','confirmed'),
(2,'2021-02-28 23:59:59','timeout');

SELECT s.user_id, 
		CASE WHEN
		(SUM(
			CASE WHEN action = 'confirmed' 
				 THEN 1
				 ELSE 0
			END)/COUNT(action))  
		IS NULL THEN 0.00 
		ELSE 
		ROUND(SUM(
			CASE WHEN action = 'confirmed' 
				 THEN 1
				 ELSE 0
			END)/COUNT(action),2) END as confirmation_rate
FROM medium_1934_signups s
LEFT JOIN medium_1934_confirmations c 
	 ON s.user_id = c.user_id
GROUP BY s.user_id;

CREATE TABLE medium_550 (
	player_id    int ,
	device_id    int ,
	event_date   date,
	games_played int 
);

INSERT INTO medium_550 VALUES 
(1,2,'2016-03-01',5),
(1,2,'2016-03-02',6),
(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),
(3,4,'2018-07-03',5);

WITH TEMP AS (
SELECT player_id, 
	   event_date, 
	   LEAD(event_date,1,NULL) 
	   OVER(PARTITION BY player_id 
			ORDER BY event_date) as lag_date,
	   RANK() 
	   OVER(PARTITION BY player_id 
			ORDER BY event_date) as rnk
FROM medium_550 )
SELECT ROUND(count(*)/(SELECT count(DISTINCT player_id) FROM medium_550),2) 
as fraction
FROM TEMP
WHERE ADDDATE(event_date, INTERVAL 1 DAY) = lag_date 
AND rnk = 1;

CREATE TABLE medium_585 (
	pid      int  ,
	tiv_2015 float,
	tiv_2016 float,
	lat      float,
	lon      float
);