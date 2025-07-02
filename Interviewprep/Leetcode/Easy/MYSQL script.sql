create table easy_1141 (
user_id int,
session_id int,
activity_date date,
activity_type enum('open_session', 'end_session', 'scroll_down', 'send_message')
);

INSERT INTO easy_1141 
(user_id,session_id,activity_date,activity_type)
VALUES
(1,1,'2019-07-20','open_session')
,(1,1,'2019-07-20','scroll_down' )
,(1,1,'2019-07-20','end_session' )
,(2,4,'2019-07-20','open_session')
,(2,4,'2019-07-21','send_message')
,(2,4,'2019-07-21','end_session' )
,(3,2,'2019-07-21','open_session')
,(3,2,'2019-07-21','send_message')
,(3,2,'2019-07-21','end_session' )
,(4,3,'2019-06-25','open_session')
,(4,3,'2019-06-25','end_session' );


SELECT activity_date AS Day
	,count(DISTINCT user_id) AS active_users
FROM easy_1141
WHERE activity_date BETWEEN ADDDATE('2019-07-27', - 29)
		AND '2019-07-27'
GROUP BY activity_date;


create table easy_1211 ( 
query_name varchar(5),
result varchar(20),
posting int,
rating int
);

create table easy_1141 ( 
user_id int,
session_id int,
activity_date date
);

INSERT INTO easy_1211 
VALUES
('Dog','Golden Retriever',1  ,5)
,('Dog','German Shepherd' ,2  ,5)
,('Dog','Mule'            ,200,1)
,('Cat','Shirazi'         ,5  ,2)
,('Cat','Siamese'         ,3  ,3)
,('Cat','Sphynx'          ,7  ,4);


SELECT query_name, 
       ROUND(AVG(rating/posting),2) as quality, 
       (1/COUNT(*))*100 as poor_query_percentage
FROM easy_1211
GROUP BY query_name;	

WITH TEMP AS (
SELECT query_name, 
       rating/posting as individual_quality,
	   CASE WHEN rating < 3 THEN 1
	                        ELSE 0 END poor_query
	FROM easy_1211
)   
SELECT query_name,
       ROUND(AVG(individual_quality),2) as quality,
	   round( (sum(poor_query)/count(*))*100,2) as poor_query_percentage
FROM TEMP
GROUP BY query_name;


CREATE TABLE easy_1251_Prices (
	product_id int,
	start_date date,
	end_date date,
	price int
);

CREATE TABLE easy_1251_UnitsSold (
	product_id    int,
	purchase_date date,
	units int
);


INSERT INTO easy_1251_Prices VALUES 
(1,'2019-02-17','2019-02-28',5),
(1,'2019-03-01','2019-03-22',20),
(2,'2019-02-01','2019-02-20',15),
(2,'2019-02-21','2019-03-31',30);

INSERT INTO easy_1251_UnitsSold 
VALUES 
(1,'2019-02-25',100)
,(1,'2019-03-01',15 )
,(2,'2019-02-10',200)
,(2,'2019-03-22',30 );

SELECT 
t1.product_id, 
ROUND(SUM(t1.price*t2.units)/SUM(t2.units),2)
FROM easy_1251_Prices t1
INNER JOIN easy_1251_UnitsSold t2 ON
t1.product_id = t2.product_id and
purchase_date BETWEEN start_date and end_date 
GROUP BY t1.product_id
ORDER BY t1.product_id;



CREATE TABLE easy_1280_Students 
(
student_id   int,     
student_name varchar(5) 
);

CREATE TABLE easy_1280_Subjects 
(
	subject_name varchar(11)
);

CREATE TABLE easy_1280_Examinations 
(
	student_id    int,
	subject_name  varchar(11)
);

INSERT INTO easy_1280_Students VALUES 
(1 ,'Alice')
,(2 ,'Bob'  )
,(13,'John' )
,(6 ,'Alex' );

INSERT INTO easy_1280_Subjects VALUES 
('Math'       ),
('Physics'    ),
('Programming');


INSERT INTO  easy_1280_Examinations VALUES 
(1 ,'Math'       )
,(1 ,'Physics'    )
,(1 ,'Programming')
,(2 ,'Programming')
,(1 ,'Physics'    )
,(1 ,'Math'       )
,(13,'Math'       )
,(13,'Programming')
,(13,'Physics'    )
,(2 ,'Math'       )
,(1 ,'Math'       );

SELECT t1.student_id, t1.student_name, t1.subject_name, COUNT(*)
FROM (easy_1280_Students JOIN easy_1280_Subjects on 1=1) t1
LEFT JOIN easy_1280_Examinations t2 ON 
          t1.student_id = t2.student_id
GROUP BY t1.student_id, t1.student_name, t1.subject_name;

SELECT Students.student_id, Students.student_name, Subjects.subject_name, COUNT(Examinations.student_id)
FROM easy_1280_Students Students 
JOIN easy_1280_Subjects Subjects on 1=1
LEFT JOIN easy_1280_Examinations Examinations ON 
          Students.student_id = Examinations.student_id 
      AND Subjects.subject_name = Examinations.subject_name
GROUP BY Students.student_id, Students.student_name, Subjects.subject_name
ORDER BY Students.student_id, Subjects.subject_name;

select Students.student_id, student_name, Subjects.subject_name, count(Examinations.student_id) as attended_exams
from (easy_1280_Students Students join easy_1280_Subjects Subjects on 1=1) 
left join easy_1280_Examinations Examinations on (Students.student_id, Subjects.subject_name) = (Examinations.student_id, Examinations.subject_name)
group by Students.student_id, Students.student_name, Subjects.subject_name
order by Students.student_id, Subjects.subject_name;



CREATE TABLE easy_1484 (
sell_date date,    
product   varchar(10) 
);

INSERT INTO easy_1484 VALUES 
('2020-05-30','Headphone' ),
('2020-06-01','Pencil'    ),
('2020-06-02','Mask'      ),
('2020-05-30','Basketball'),
('2020-06-01','Bible'    ),
('2020-06-02','Mask'      ),
('2020-05-30','T-Shirt'  );

SELECT 
sell_date, 
count(*), 
GROUP_CONCAT( DISTINCT product ORDER BY product)
FROM easy_1484
GROUP BY sell_date;


CREATE TABLE easy_1517 
(
user_id int,
name varchar(9),
mail varchar(25)
);

INSERT INTO easy_1517 VALUES
(1,'Winston'  ,'winston@leetcode.com'   )
,(2,'Jonathan' ,'jonathanisgreat'        )
,(3,'Annabelle','bella-@leetcode.com'    )
,(4,'Sally'    ,'sally.come@leetcode.com')
,(5,'Marwan'   ,'quarz#2020@leetcode.com')
,(6,'David'    ,'david69@gmail.com'      )
,(7,'Shapiro'  ,'.shapo@leetcode.com'   );

SELECT user_id, name, mail
FROM easy_1517
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\.com$';

 
CREATE TABLE easy_1527 
(
patient_id   int     
,patient_name varchar(6) 
,conditions   varchar(15) 
);

insert into easy_1527 VALUES 		
(1,'Daniel','YFEV COUGH'   )
,(2,'Alice' , ''            )
,(3,'Bob'   ,'DIAB100 MYOP' )
,(4,'George','ACNE DIAB100' )
,(5,'Alain' ,'DIAB201'      );


SELECT patient_id, patient_name, conditions
FROM easy_1527
WHERE conditions LIKE '%DIAB1%';

CREATE TABLE easy_1661
(
machine_id    int   ,
process_id    int   ,
activity_type enum ('start','end') ,
timestamp     float 
);

INSERT INTO easy_1661 VALUES 
(0,0,'start' ,0.712),
(0,0,'end'   ,1.520),
(0,1,'start' ,3.140),
(0,1,'end'   ,4.120),
(1,0,'start' ,0.550),
(1,0,'end'   ,1.550),
(1,1,'start' ,0.430),
(1,1,'end'   ,1.420),
(2,0,'start' ,4.100),
(2,0,'end'   ,4.512),
(2,1,'start' ,2.500),
(2,1,'end'   ,5.000);

WITH start_t AS 
(
	SELECT * FROM easy_1661 WHERE activity_type = 'start'
),
end_t AS 
(
	SELECT * FROM easy_1661 WHERE activity_type = 'end'
)
SELECT s.machine_id, ROUND(AVG(e.timestamp-s.timestamp),3) as processing_time
FROM  start_t s
LEFT JOIN end_t e ON s.machine_id = e.machine_id 
                 AND s.process_id = e.process_id 
GROUP BY s.machine_id;


CREATE TABLE easy_1667 (
user_id int     ,
name    varchar(5) 
);

INSERT INTO easy_1667 VALUES 
(1,'aLice'),
(2,'bOB'  );

SELECT user_id, CONCAT( UPPER(SUBSTRING(name,1,1)), LOWER(SUBSTRING(name,2,LENGTH(name))))
FROM easy_1667;


CREATE TABLE easy_1731 (
employee_id int    ,
name        varchar(7),
reports_to  int    ,
age         int    
);

INSERT INTO easy_1731 VALUES
(9,'Hercy'  ,null,43),
(6,'Alice'  ,9   ,41),
(4,'Bob'    ,9   ,36),
(2,'Winston',null,37);

SELECT m.employee_id,m.name,count(DISTINCT m.employee_id),
       ROUND(AVG(e.age),0) 
FROM  easy_1731 e 
LEFT JOIN easy_1731 m 
      ON e.reports_to = m.employee_id
WHERE m.employee_id IS NOT NULL
GROUP BY m.employee_id,m.name
ORDER BY m.employee_id; 


CREATE TABLE easy_1789 (
employee_id   int    ,
department_id int    ,
primary_flag  enum ('Y','N')
);

INSERT INTO easy_1789 VALUES
(1,1,'N'),
(2,1,'Y'),
(2,2,'N'),
(3,3,'N'),
(4,2,'N'),
(4,3,'Y'),
(4,4,'N');

SELECT employee_id,department_id 
FROM easy_1789 
WHERE primary_flag = 'Y'

UNION 

SELECT employee_id,department_id 
FROM easy_1789
GROUP BY employee_id,department_id
HAVING COUNT(*) = 1;
 

CREATE TABLE easy_196 (
id    int    ,
email varchar(16)
); 

INSERT INTO easy_196 VALUES 
(1,'john@example.com'),
(2,'bob@example.com' ),
(3,'john@example.com');

DELETE FROM easy_196 
WHERE id IN (
	SELECT x.id FROM 
			(
			 SELECT email, min(id) as id FROM easy_196 
			 GROUP BY email
			 HAVING COUNT(*) > 1
			 ) x
);

CREATE TABLE easy_610 (
x int,
y int,
z int
);

INSERT INTO easy_610 VALUES 
(13,15,30),
(10,20,15);

SELECT x,y,z, 
CASE WHEN (x+y > z and y+z > x and x+z > y) 
	THEN 'Yes'
	ELSE 'No'
END as tringle
FROM easy_610;

SELECT *
	,
IF (
x + y > z
AND y + z > x
AND x + z > y
,'Yes'
,'No'
) AS triangle FROM easy_610;