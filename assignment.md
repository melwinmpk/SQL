MySQL Assignment

Assignment 1 - Basic Statements:
1. Create a database named training.
2. Create a table ‘demography’ with the following columns inside training database
a. CustID integer auto-increment
b. Name varchar(50)
c. Age integer
d. Gender varcahr(1)
3. Insert the following values into the table ‘demography’
a. Name=’John’, Age=25, Gender=’M’
4. Insert the following values into the table ‘demography’ using a single query
a. Name = ’Pawan’, Age = 26, Gender=’M’
b. Name = ‘Hema’, Age=31, Gender=’F’
5. Insert the following value into the table ‘demography’
a. Name = ‘Rekha’, Gender=’F’
6. Retrieve all rows and columns from table ‘demography’
7. Update the age to NULL for Name = ‘John’. Note that the NULL used here is MySQL
NULL and not string NULL.
8. Retrieve all the rows from table ‘demography’ where Age is NULL.
9. Delete all the rows from the table ‘demography’.
10. Drop the table ‘demography’

Assignment 2 – Where Clause:
Run the queries present in MySQL_Assignment_data file before proceeding to the
assignments for this module
1. Retrieve the account ID, customer ID, and available balance for all accounts
whose status equals &#39;ACTIVE&#39; and whose available balance is greater than
$2,500.
2. Construct a query that retrieves all accounts opened in 2002.
3. Retrieve the account ID, available balance and pending balance for all
accounts where available balance is not equal to pending balance.
4. Retrieve account ID, Product code for the account ID’s 1,10,23,27
5. Retrieve account ID, available balance from all those accounts whose
available balance is in between 100 and 200.

Assignment 3 - Operators and Functions:
1. Construct a query that counts the number of rows in the account table.
2. Retrieve the first two rows from account table
3. Retrieve the third and fourth row from account table.
4. retrieve year of birth, month of birth, day of birth, weekday of birth for all the
individuals from the table individual
5. Write a query that returns the 17th through 25th characters of the string
&#39;Please find the substring in this string&#39;.

6. Write a query that returns the absolute value and sign (-1, 0, or 1) of the
number -25.76823.Also return the number rounded to the nearest hundredth.
7. Write a query that adds 30 days to the current date.
8. Retrieve the first three letters of first name and last three letters of last name
from the table individual.
9. Retrieve the first names in Upper case from individual whose first name consists
of five characters.
10. Retrieve the maximum balance and average balance from the account table
for customer ID = 1.

Assignment 4 – Group by:
1. Construct a query to count the number of accounts held by each customer.
Show the customer ID and the number of accounts for each customer.
2. Modify the previous query to fetch only those customers who has more than
two accounts.
3. Retrieve first name and date of birth from individual and sort them from
youngest to oldest.
4. From the account table, retrieve the year of account opening (year part of
open_date) and average available balance (avail_balance) present in the accounts
that are opened in each calendar year. Retrieve the year only if the average balance
is greater than 200. Also sort the results based on calendar year.
5. Retrieve the product code and maximum pending balance for the product codes
(CHK, SAV, CD) present in account table.

Assignment 5 – Joins and sub-query:
1. Retrieve first name, title and department name by joining tables employee and
department using department id.
2. Left join table product with table product_type (product_type left join product) to
retrieve product_type.name and product.name from the tables.
3. Using inner join, Retrieve the full employee name (fname followed by a space and
then lname), Superior name (using superior_emp_id) from the employee table.
Ex, for Susan Barker, Michael is superior
4. Using subquery, retrieve the fname and lname of the employees whose superior is
‘Susan Hawthorne’ from employee
5. In employee table, retrieve the superior names (fname and lname) present in
department 1. A person is superior if he/she is superior to atleast one person in the
given department. Use sub-query concept.
