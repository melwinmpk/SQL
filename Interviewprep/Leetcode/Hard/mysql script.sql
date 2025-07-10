CREATE TABLE hard_185_employee (
	id           int    ,
	name         varchar(5),
	salary       int    ,
	departmentId int    
); 

CREATE TABLE hard_185_department (
	id   int    ,
	name varchar(5)	
);

INSERT INTO hard_185_employee VALUES 
(1,'Joe'  ,85000,1),
(2,'Henry',80000,2),
(3,'Sam'  ,60000,2),
(4,'Max'  ,90000,1),
(5,'Janet',69000,1),
(6,'Randy',85000,1),
(7,'Will' ,70000,1);

INSERT INTO hard_185_department VALUES 
(1,'IT'),
(2,'Sales');

WITH TEMP AS (
	SELECT 
		e.id,e.name as Employee,e.salary as Salary,d.id as did,d.name as Department,
		DENSE_RANK() OVER(PARTITION BY d.id ORDER BY e.salary desc) as rnk
	FROM hard_185_employee e 
	INNER JOIN hard_185_department d 
		  ON e.departmentId = d.id
)	
SELECT Department, Employee, Salary 
FROM TEMP
WHERE rnk <= 3;
	