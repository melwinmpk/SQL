mysql> create database training;
Query OK, 1 row affected (0.01 sec)

use training;

mysql> CREATE TABLE demography (
    ->     CustID int NOT NULL AUTO_INCREMENT,
    ->     Name varchar(50),
    ->     Age int,
    ->     Gender varchar(1),
    ->     PRIMARY KEY (CustID)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> INSERT INTO demography (Name,Age,Gender) VALUES ('John',25,'M');
Query OK, 1 row affected (0.01 sec)


mysql> INSERT INTO demography (Name,Age,Gender) VALUES
    -> ('Pawan',26,'M'),
    -> ('Hema',31,'F');
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0


mysql> INSERT INTO demography (Name,Gender) VALUES ('Rekha','M');
Query OK, 1 row affected (0.00 sec)

mysql> Update demography
    -> SET Age = NULL
    -> WHERE Name = 'John';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from demography;
+--------+-------+------+--------+
| CustID | Name  | Age  | Gender |
+--------+-------+------+--------+
|      1 | John  | NULL | M      |
|      2 | Pawan |   26 | M      |
|      3 | Hema  |   31 | F      |
|      4 | Rekha | NULL | M      |
+--------+-------+------+--------+
4 rows in set (0.00 sec)

mysql> DELETE FROM demography;
Query OK, 4 rows affected (0.00 sec)

mysql> DROP TABLE demography;
Query OK, 0 rows affected (0.01 sec)


mysql> select account_id, cust_id, avail_balance from account
    -> where status = 'ACTIVE' and avail_balance > 2500 ;
+------------+---------+---------------+
| account_id | cust_id | avail_balance |
+------------+---------+---------------+
|          3 |       1 |       3000.00 |
|         12 |       4 |       5487.09 |
|         15 |       6 |      10000.00 |
|         17 |       7 |       5000.00 |
|         18 |       8 |       3487.19 |
|         22 |       9 |       9345.55 |
|         24 |      10 |      23575.12 |
|         27 |      11 |       9345.55 |
|         28 |      12 |      38552.05 |
|         29 |      13 |      50000.00 |
+------------+---------+---------------+
10 rows in set (0.00 sec)

mysql> select * from account where YEAR(open_date) = 2002;
+------------+------------+---------+------------+------------+--------------------+--------+----------------+-------------+---------------+-----------------+
| account_id | product_cd | cust_id | open_date  | close_date | last_activity_date | status | open_branch_id | open_emp_id | avail_balance | pending_balance |
+------------+------------+---------+------------+------------+--------------------+--------+----------------+-------------+---------------+-----------------+
|          7 | CHK        |       3 | 2002-11-23 | NULL       | 2004-11-30         | ACTIVE |              3 |          13 |       1057.75 |         1057.75 |
|          8 | MM         |       3 | 2002-12-15 | NULL       | 2004-12-05         | ACTIVE |              3 |          13 |       2212.50 |         2212.50 |
|         14 | CHK        |       6 | 2002-08-24 | NULL       | 2004-11-29         | ACTIVE |              1 |           1 |        122.37 |          122.37 |
|         24 | CHK        |      10 | 2002-09-30 | NULL       | 2004-12-15         | ACTIVE |              4 |          16 |      23575.12 |        23575.12 |
|         25 | BUS        |      10 | 2002-10-01 | NULL       | 2004-08-28         | ACTIVE |              4 |          16 |          0.00 |            0.00 |
+------------+------------+---------+------------+------------+--------------------+--------+----------------+-------------+---------------+-----------------+
5 rows in set (0.00 sec)

mysql> select account_id, avail_balance, pending_balance from account
    -> where avail_balance != pending_balance;
+------------+---------------+-----------------+
| account_id | avail_balance | pending_balance |
+------------+---------------+-----------------+
|         13 |       2237.97 |         2897.97 |
|         22 |       9345.55 |         9845.55 |
+------------+---------------+-----------------+
2 rows in set (0.00 sec)

mysql> select account_id, product_cd from account where account_id in (1,10,23,27);
+------------+------------+
| account_id | product_cd |
+------------+------------+
|          1 | CHK        |
|         10 | CHK        |
|         23 | CD         |
|         27 | BUS        |
+------------+------------+
4 rows in set (0.00 sec)

mysql> select account_id, avail_balance from account
    -> where avail_balance between 100 and 200;
+------------+---------------+
| account_id | avail_balance |
+------------+---------------+
|          5 |        200.00 |
|         14 |        122.37 |
|         21 |        125.67 |
+------------+---------------+
3 rows in set (0.00 sec)


mysql> Select count(*) from account;
+----------+
| count(*) |
+----------+
|       24 |
+----------+
1 row in set (0.00 sec)

mysql> Select * from account limit 2;
+------------+------------+---------+------------+------------+--------------------+--------+----------------+-------------+---------------+-----------------+
| account_id | product_cd | cust_id | open_date  | close_date | last_activity_date | status | open_branch_id | open_emp_id | avail_balance | pending_balance |
+------------+------------+---------+------------+------------+--------------------+--------+----------------+-------------+---------------+-----------------+
|          1 | CHK        |       1 | 2000-01-15 | NULL       | 2005-01-04         | ACTIVE |              2 |          10 |       1057.75 |         1057.75 |
|          2 | SAV        |       1 | 2000-01-15 | NULL       | 2004-12-19         | ACTIVE |              2 |          10 |        500.00 |          500.00 |
+------------+------------+---------+------------+------------+--------------------+--------+----------------+-------------+---------------+-----------------+
2 rows in set (0.00 sec)

mysql> Select * from account limit 2 offset 2;
+------------+------------+---------+------------+------------+--------------------+--------+----------------+-------------+---------------+-----------------+
| account_id | product_cd | cust_id | open_date  | close_date | last_activity_date | status | open_branch_id | open_emp_id | avail_balance | pending_balance |
+------------+------------+---------+------------+------------+--------------------+--------+----------------+-------------+---------------+-----------------+
|          3 | CD         |       1 | 2004-06-30 | NULL       | 2004-06-30         | ACTIVE |              2 |          10 |       3000.00 |         3000.00 |
|          4 | CHK        |       2 | 2001-03-12 | NULL       | 2004-12-27         | ACTIVE |              2 |          10 |       2258.02 |         2258.02 |
+------------+------------+---------+------------+------------+--------------------+--------+----------------+-------------+---------------+-----------------+
2 rows in set (0.00 sec)

mysql> select YEAR(birth_date) as year, MONTH(birth_date) as month, DAY(birth_date) as day, WEEKDAY(birth_date)as week_day from individual;
+------+-------+------+----------+
| year | month | day  | week_day |
+------+-------+------+----------+
| 1972 |     4 |   22 |        5 |
| 1968 |     8 |   15 |        3 |
| 1958 |     2 |    6 |        3 |
| 1966 |    12 |   22 |        3 |
| 1971 |     8 |   25 |        2 |
| 1962 |     9 |   14 |        4 |
| 1947 |     3 |   19 |        2 |
| 1977 |     7 |    1 |        4 |
| 1968 |     6 |   16 |        6 |
+------+-------+------+----------+
9 rows in set (0.00 sec)

mysql> select SUBSTRING('Please find the substring in this string',17,9) ;
+------------------------------------------------------------+
| SUBSTRING('Please find the substring in this string',17,9) |
+------------------------------------------------------------+
| substring                                                  |
+------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT ROUND(ABS(-25.76823),-2);
+--------------------------+
| ROUND(ABS(-25.76823),-2) |
+--------------------------+
|                        0 |
+--------------------------+
1 row in set (0.00 sec)

mysql> SELECT ADDDATE(CURRENT_DATE(),30);
+----------------------------+
| ADDDATE(CURRENT_DATE(),30) |
+----------------------------+
| 2024-06-05                 |
+----------------------------+
1 row in set (0.00 sec)

mysql> select LEFT(fname,3), RIGHT(lname,3) from individual;
+---------------+----------------+
| LEFT(fname,3) | RIGHT(lname,3) |
+---------------+----------------+
| Jam           | ley            |
| Sus           | ley            |
| Fra           | ker            |
| Joh           | ard            |
| Cha           | ier            |
| Joh           | cer            |
| Mar           | ung            |
| Lou           | ake            |
| Ric           | ley            |
+---------------+----------------+
9 rows in set (0.00 sec)

mysql> select UPPER(fname) from individual WHERE LENGTH(fname) =5 ;
+--------------+
| UPPER(fname) |
+--------------+
| JAMES        |
| SUSAN        |
| FRANK        |
| LOUIS        |
+--------------+
4 rows in set (0.00 sec)

mysql> select cust_id, MAX(avail_balance), AVG(avail_balance) from account where cust_id=1 group by cust_id;
+---------+--------------------+--------------------+
| cust_id | MAX(avail_balance) | AVG(avail_balance) |
+---------+--------------------+--------------------+
|       1 |            3000.00 |        1519.250000 |
+---------+--------------------+--------------------+
1 row in set (0.00 sec)

mysql> select cust_id, count(account_id) as count from account group by cust_id;
+---------+-------+
| cust_id | count |
+---------+-------+
|       1 |     3 |
|       2 |     2 |
|       3 |     2 |
|       4 |     3 |
|       5 |     1 |
|       6 |     2 |
|       7 |     1 |
|       8 |     2 |
|       9 |     3 |
|      10 |     2 |
|      11 |     1 |
|      12 |     1 |
|      13 |     1 |
+---------+-------+
13 rows in set (0.00 sec)

mysql> select cust_id, count(account_id) as count from account group by cust_id having count(account_id) > 2;
+---------+-------+
| cust_id | count |
+---------+-------+
|       1 |     3 |
|       4 |     3 |
|       9 |     3 |
+---------+-------+
3 rows in set (0.00 sec)

mysql> select fname, birth_date from individual order by birth_date desc;
+----------+------------+
| fname    | birth_date |
+----------+------------+
| Louis    | 1977-07-01 |
| James    | 1972-04-22 |
| Charles  | 1971-08-25 |
| Susan    | 1968-08-15 |
| Richard  | 1968-06-16 |
| John     | 1966-12-22 |
| John     | 1962-09-14 |
| Frank    | 1958-02-06 |
| Margaret | 1947-03-19 |
+----------+------------+
9 rows in set (0.00 sec)


mysql> select YEAR(open_date) as year, AVG(avail_balance) FROM account
    -> GROUP BY YEAR(open_date)
    -> HAVING AVG(avail_balance) > 200
    -> ORDER BY YEAR(open_date) ;
+------+--------------------+
| year | AVG(avail_balance) |
+------+--------------------+
| 2000 |         775.173340 |
| 2001 |        1583.299988 |
| 2002 |        5393.547829 |
| 2003 |       13070.613592 |
| 2004 |       10657.351047 |
+------+--------------------+
5 rows in set (0.00 sec)

mysql> Select product_cd, Max(pending_balance) from account where
    -> product_cd IN ('CHK','SAV','CD')
    -> GROUP BY product_cd;
+------------+----------------------+
| product_cd | Max(pending_balance) |
+------------+----------------------+
| CD         |             10000.00 |
| CHK        |             38552.05 |
| SAV        |               767.77 |
+------------+----------------------+
3 rows in set (0.00 sec)


mysql> Select fname, title, d.name from employee e
    -> INNER JOIN department d ON e.dept_id = d.dept_id;
+----------+--------------------+----------------+
| fname    | title              | name           |
+----------+--------------------+----------------+
| Susan    | Operations Manager | Operations     |
| Helen    | Head Teller        | Operations     |
| Chris    | Teller             | Operations     |
| Sarah    | Teller             | Operations     |
| Jane     | Teller             | Operations     |
| Paula    | Head Teller        | Operations     |
| Thomas   | Teller             | Operations     |
| Samantha | Teller             | Operations     |
| John     | Head Teller        | Operations     |
| Cindy    | Teller             | Operations     |
| Frank    | Teller             | Operations     |
| Theresa  | Head Teller        | Operations     |
| Beth     | Teller             | Operations     |
| Rick     | Teller             | Operations     |
| John     | Loan Manager       | Loans          |
| Michael  | President          | Administration |
| Susan    | Vice President     | Administration |
| Robert   | Treasurer          | Administration |
+----------+--------------------+----------------+
18 rows in set (0.00 sec)

mysql> select pt.name product_type_name,p.name product_name
    -> from product_type pt
    -> Left join product p on pt.product_type_cd = p.product_type_cd;
+-------------------------------+-------------------------+
| product_type_name             | product_name            |
+-------------------------------+-------------------------+
| Customer Accounts             | savings account         |
| Customer Accounts             | money market account    |
| Customer Accounts             | checking account        |
| Customer Accounts             | certificate of deposit  |
| Insurance Offerings           | NULL                    |
| Individual and Business Loans | small business loan     |
| Individual and Business Loans | home mortgage           |
| Individual and Business Loans | business line of credit |
| Individual and Business Loans | auto loan               |
+-------------------------------+-------------------------+
9 rows in set (0.00 sec)

mysql> select CONCAT(t1.fname,' ',t1.lname,',',t2.fname,' is superior') as Superior
    -> from employee t1 
    -> INNER JOIN employee t2 on  t1.superior_emp_id = t2.emp_id;
+------------------------------------+
| Superior                           |
+------------------------------------+
| Susan Barker,Michael is superior   |
| Robert Tyler,Michael is superior   |
| Susan Hawthorne,Robert is superior |
| John Gooding,Susan is superior     |
| Helen Fleming,Susan is superior    |
| Chris Tucker,Helen is superior     |
| Sarah Parker,Helen is superior     |
| Jane Grossman,Helen is superior    |
| Paula Roberts,Susan is superior    |
| Thomas Ziegler,Paula is superior   |
| Samantha Jameson,Paula is superior |
| John Blake,Susan is superior       |
| Cindy Mason,John is superior       |
| Frank Portman,John is superior     |
| Theresa Markham,Susan is superior  |
| Beth Fowler,Theresa is superior    |
| Rick Tulman,Theresa is superior    |
+------------------------------------+
17 rows in set (0.00 sec)

mysql> select t1.fname,t1.lname
    -> from employee t1
    -> where t1.superior_emp_id = (
    ->     select t2.emp_id
    ->     from employee t2
    ->     where t2.fname = 'Susan' and t2.lname = 'Hawthorne'
    -> );
+---------+---------+
| fname   | lname   |
+---------+---------+
| John    | Gooding |
| Helen   | Fleming |
| Paula   | Roberts |
| John    | Blake   |
| Theresa | Markham |
+---------+---------+
5 rows in set (0.00 sec)



mysql> select fname, lname , emp_id from employee
    -> where emp_id in (
    ->     select t1.superior_emp_id from employee t1, employee t2 where t1.dept_id = 1 and t1.superior_emp_id = t2.emp_id
    -> );
+---------+-----------+--------+
| fname   | lname     | emp_id |
+---------+-----------+--------+
| Robert  | Tyler     |      3 |
| Susan   | Hawthorne |      4 |
| Helen   | Fleming   |      6 |
| Paula   | Roberts   |     10 |
| John    | Blake     |     13 |
| Theresa | Markham   |     16 |
+---------+-----------+--------+
6 rows in set (0.00 sec)