-- =====================================================================
-- SelectStatementTutorial.sql
-- =====================================================================

-- SELECT Statement

-- USE Parks_and_Recreation; # one way to precise the database

SELECT *
FROM Parks_and_Recreation.employee_demographics;

SELECT first_name, 
last_name, 
birth_date,
age,
age + 10 #the math in SQL follows the rules of PEMDAS
FROM Parks_and_Recreation.employee_demographics;

# DISTINCT takes the unique values 
SELECT DISTINCT first_name, gender
FROM Parks_and_Recreation.employee_demographics;

-- =====================================================================
-- WhereANDLikeStatements.sql
-- =====================================================================

-- WHERE CLAUSE

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary
WHERE first_name = 'Leslie'
;

SELECT *
FROM employee_salary
WHERE salary >= 50000
;

SELECT *
FROM employee_demographics
WHERE gender != 'Female'
;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT -- Logical Operators
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male'
;

SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55
;

-- LIKE Statement
-- % and _
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%'
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE '%er%'
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___' #the amount of "_" is the amount of letters after the "a", no more no less
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%' # we can combine them 
;

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;

-- =====================================================================
-- Group&OrderBYStatement.sql
-- =====================================================================

-- Group by 

SELECT *
FROM employee_demographics;

# Group by will roll up all of the values into the rows (Female and Male)
# So when we run aggregate functions (avg, min, max) we'll do it based of these rows 
SELECT gender
FROM employee_demographics
GROUP BY gender; 

# This will not work because if we are not selecting an aggregated column (like avg) (meaning, if we are not using aggregate functions in the select statement)
# It has to be in the Group By (they have to match), since we're not performing the agg function on it
SELECT first_name
FROM employee_demographics
GROUP BY  gender; 


SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY  gender; 

# We can group by several columns
SELECT occupation, salary
FROM employee_salary
GROUP BY  occupation, salary;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY  gender; 

-- ORDER BY

SELECT *
FROM employee_demographics
ORDER BY first_name DESC; # By default it is ASC(ascending)

SELECT *
FROM employee_demographics
ORDER BY gender, age DESC; # The order of the order by does matter, if we put age, gender, in this case gender would not even matter because we have no unique values

# We can select the columns by position instead of name, but it is not recommended for good practices
SELECT *
FROM employee_demographics
ORDER BY 5, 4;




-- =====================================================================
-- WhereHavingStatements.sql
-- =====================================================================

-- HAVING vs WHERE

# In sum: we use WHERE more, HAVING is for when we want to filter on agg function columns 

# We have a problem with where here, in which this would not run (with "Where")
# When we're selecting gender and perfoming agg function, this occurs only after group by groups those rows together
# so when we try to filter (with where) based of AVG(age), it hasn't been created yet because the group by hasn't happened yet
# HAVING came to fix this problem, it was specifically created for this exact example
SELECT gender, AVG (age)
FROM employee_demographics	
#WHERE AVG(age) > 40
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%' # Filter at the row level 
GROUP BY occupation
HAVING AVG(salary) > 75000 # Filter at the agg function level
;

-- =====================================================================
-- Limit&AliasingStatements.sql
-- =====================================================================

-- Limit & Aliasing

# LIMIT just limits the rows that we get
# ALIASING is just a way to change the name of the column (for the most part (it can also be used in joins etc...))

# It will just take the top 3
SELECT *
FROM employee_demographics
LIMIT 3
;

# If we wanted to get the top3 oldest employees
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3,
;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1 # The "1" means that we will start the the row 3 and then we're going to go "one" row after it
;

-- ALIASING
SELECT gender, AVG(age) AS avg_age # The "AS" is not 100% needed to be wrote, it is implied, but it's for good practices
FROM employee_demographics
GROUP BY gender
HAVING avg_age
;





-- =====================================================================
-- Joins.sql
-- =====================================================================

-- Joins (INNER, OUTER, SELF)

# Joins allow to combine two tables or more together if they have a common column (at least similar data)
SELECT * 
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- Inner Joins


# An inner joins is going to return rows that are the same in both colums from both tables
# By default, JOIN represents an INNER JOIN
SELECT * 
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal 
	ON dem.employee_id = sal.employee_id # ON means we are joining the demographics table to the salary table based ON these two columns
; # in this example, we are missing employee_id number 2 for example, because in the demographics, he is not here

SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal 
	ON dem.employee_id = sal.employee_id 
;


-- Outer Joins

# A LEFT OUTER JOIN will take everything from the left table (even if there is not match) and will only return the matches from the right table
# Same thing apllies to RIGHT OUTER JOIN

# It is the same as before with inner join, because the dem table does not have employee 2 (Ron) and everything else matches
SELECT *
FROM employee_demographics AS dem # That is our left table
LEFT JOIN employee_salary AS sal 
	ON dem.employee_id = sal.employee_id 
;

# Now, with right join, it takes everything of the right table, and if something doesn't match, it will give NULL
SELECT *
FROM employee_demographics AS dem 
RIGHT JOIN employee_salary AS sal 
	ON dem.employee_id = sal.employee_id 
;

-- Self Join 

# A join that you tie the table to itself 

# Doing the secret santa example
SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_santa,
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2 
	ON emp1.employee_id + 1 = emp2.employee_id # In that ex, the next person will be the other's secret santa
;

-- Joining multiple tables together 

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal 
	ON dem.employee_id = sal.employee_id 
INNER JOIN parks_departments pd
	ON sal.dept_id = pd.department_id 
;

SELECT *
FROM parks_departments;











-- =====================================================================
-- UnionStatement.sql
-- =====================================================================

-- Unions 

# Unions allow to combine rows of data together from separate (or the same) tables

SELECT first_name, last_name
FROM employee_demographics 
UNION ALL #by default it is DISTINCT (which means it'll only take unique values)
SELECT first_name, last_name
FROM employee_salary
;

# For a cutting-budget example, we can find people who are "old" to be cut out and also people who have high salaries, to be cut out too
SELECT first_name, last_name, 'Old Man' AS Label
FROM employee_demographics 
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_demographics 
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Highly Paid Employee' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name
;



-- =====================================================================
-- StringFunctions.sql
-- =====================================================================

-- String Functions 
-- Length, UPPER/Lower, Trim, Substring, Replace, Locate, Concat

# Length
SELECT LENGTH('testeTamanho')

SELECT first_name, LENGTH(first_name) AS length
FROM employee_demographics
ORDER BY length
;

# Upper/ Lower
SELECT UPPER('sky');
SELECT LOWER('SKY');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;

# Trim going to take the white space on the front or the end and get rid of it
SELECT TRIM('    sky     ');
SELECT LTRIM('    sky     ');
SELECT RTRIM('    sky     ');

# Substring
SELECT first_name, 
LEFT(first_name, 4), # How many characters from the left/right hand side do we want to select? 
RIGHT(first_name, 4),
SUBSTRING(first_name, 3, 2), # We're going to the third position and then to the right 2 characters
SUBSTRING(birth_date, 6, 2) AS birth_month
FROM employee_demographics; 

# Replace
-- Replace specific characters with a different character of our choice

SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics; 

# Locate
SELECT LOCATE('x', 'Alexander');

SELECT first_name, LOCATE('An', first_name)
FROM employee_demographics; 

# Concat 
SELECT first_name, last_name,
CONCAT(first_name,' ', last_name) AS full_name
FROM employee_demographics; 



-- =====================================================================
-- CaseStatements.sql
-- =====================================================================

-- Case Statements 

-- Sort of like a "if/else" 

SELECT first_name, 
last_name,
age,
CASE 
	WHEN age <= 30 THEN 'Young'
	WHEN age BETWEEN 31 and 50 THEN 'Medium' 
	WHEN age >= 50 THEN 'Old'
END AS Age_Bracket
FROM employee_demographics;

-- Pay increase and bonus:
-- < 50.000 = 5%
-- > 50.000 = 7%
-- Finance = 10% -> department_id = 6

SELECT first_name, 
last_name,
salary,
CASE
	WHEN salary <= 50000 THEN salary + (salary*0.05)
	WHEN salary > 50000 THEN salary * 1.07
END AS Pay_increase,
CASE
	WHEN dept_id = 6 THEN salary * .10
END AS BONUS
FROM employee_salary;



-- =====================================================================
-- Subqueries.sql
-- =====================================================================

-- Subqueries 

# Use case: we want to know only the people who worked in the Parks and Rec dept,
# But instead of using JOINS, we can use subqueries to use data from employee_salary
SELECT *
FROM employee_demographics 
WHERE employee_id IN 
				(SELECT employee_id
					FROM employee_salary
					WHERE dept_id = 1)
; # It will match the employee's id to this new subquery (which gave a new list of only dept_id =1 employees)

-- Subqueries in the select statement

# We will create a column with the average salary to compare with each salary
SELECT first_name, salary, 
(SELECT AVG(salary)
FROM employee_salary)
FROM employee_salary
; # Otherwise it would return the avg salary for each person (which is the same salary)

-- Subqueries in the from statement

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

SELECT AVG(max_age)
FROM 
(SELECT gender, 
AVG(age) AS avg_age, 
MAX(age) AS max_age, 
MIN(age) AS min_age, 
COUNT(age) AS count_age
FROM employee_demographics
GROUP BY gender) AS Agg_table
;















-- =====================================================================
-- WindowFunction.sql
-- =====================================================================

-- Window Functions - OVER, Partition By, RollingTotal, RowNumber, Rank

# Comparing gender with salaries with Group By
SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id 
GROUP BY gender
;

-- Window functions are useful when we want extra informations (like the names)
-- To create a window function, typically we just use OVER 
-- PARTITION BY will separate the column out, kind of like grouping it
SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER()
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id 
;

SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id 
;

# for example, it won't work with group by if we want to add these extra informations
SELECT dem.first_name, dem.last_name, gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id 
GROUP BY gender, dem.first_name, dem.last_name
;



-- Example with SUM
-- We will also add a rolling total -> start at a specific
-- value and add on values from subsequent rows based off the partition 
SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id 
;

-- Row Number
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_salary_gender,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_salary_gender,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_salary_gender
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id 
; # Rank can have duplicates based off the order by, but the following row is numbered positionally (5, 5, 7) instead of (5, 5, 6)
  # DENSE rank gives the next number of the duplicate numerically instead of positionally (as in normal rank)
 # I deleted an employee that showed the use case: if a man has 50k as a salary, in RANK it will go (5, 5, 7), with the "second 5" being this tied salary, the difference between dense is just the next number (6 or 7)









-- =====================================================================
-- CTE.sql
-- =====================================================================

-- CTEs
-- Common Table Expressions (CTEs) allow you to define a subquery block that we can then reference within the main query 
-- We use it to perform some more complex calculations that we may not be able to do in a direct query, it is also more readable 
WITH CTE_Example (Gender, AVG_Sal, MAX_Sal, MIN_Sal, COUNT_Sal) AS 
(
SELECT gender, AVG(salary), MAX(salary), MIN(salary), COUNT(salary) 
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id 
GROUP BY gender
)
SELECT AVG(avg_sal)
FROM CTE_Example
;

# Comparing with a regular subquery
SELECT AVG(avg_sal)
FROM (
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id 
GROUP BY gender) example_subquery;


# To show that we can only use CTEs immediatly after we've created them (this will return an error, as it should)
SELECT AVG(avg_sal)
FROM CTE_Example
;

-- Creating multiple CTEs within one (for ex, do a more complex query or joining queries together) 

WITH CTE_Example AS 
(
SELECT employee_id, gender, birth_date
FROM employee_demographics
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS 
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2
	ON CTE_Example.employee_id = CTE_Example2.employee_id
; 





-- =====================================================================
-- TemporaryTables.sql
-- =====================================================================

-- Temporary Tables
-- They are only visible to the session they were created in
--  usually to store intermediate results for complex queries and to manipulate data before inserting into a permanent table
-- They only last while we are in the session (if we were to close the App and then go back, it would be gone)alter

-- Temp tables are used for more advanced queries, as CTEs are usually more limited (usually one level of changing/advanced thing we're doing on top of that query)

# This first way is not that used
CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

SELECT *
FROM temp_table;

INSERT INTO temp_table
VALUES('Gustavo', 'Scheidt', 'Hacksaw Ridge');

SELECT *
FROM temp_table;

# Now let's create using a better way

SELECT *
FROM employee_salary;

-- Example in which we just want a subsection of the table in which we have salary greater than 50.000

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM salary_over_50k;










-- =====================================================================
-- StoredProcedures.sql
-- =====================================================================

-- Stored Procedures
-- Way to save the SQL code so that we can reuse it over and over again
-- Really helpful for storing complex queries, simplifying repetitive code and enhancing perfomance overall

SELECT *
FROM employee_salary
WHERE salary >= 50000
;

CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000
;

CALL large_salaries();

# Using best practices to create stored procedures -> First is more complex queries, second is to run multiple queries

# Change the delimiter from ";" to "$$"
DELIMITER $$ 
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000
	;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000
	;
END $$
DELIMITER ;

CALL large_salaries3();

-- Parameters

DELIMITER $$ 
CREATE PROCEDURE large_salaries4(employee_id_param INT) # or p_employee_id
BEGIN
	SELECT salary
	FROM employee_salary
    WHERE employee_id = employee_id_param # Left is the column in the data, right one is our parameter
	;
END $$
DELIMITER ;

CALL large_salaries4(1)



-- =====================================================================
-- Triggers&Events.sql
-- =====================================================================

-- Triggers and Events 
-- A trigger is a block of code that executes automatically when an event takes place on a specific table 

# Use case: when someone is put in the salary table, we will automatically update with the employee_id, first_name and last_name on the demographics table
# So the trigger is when the data is updated in the salary table
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary # if we put "BEFORE" could be an use case where when data is deleted, something else happens
    FOR EACH ROW # this means the trigger will get activated for each row that is inserted
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name); # NEW means we're only taking the new rows that were inserted), OLD takes rows that were deleted or updated
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id) 
VALUES (13, 'Gustavo', 'Scheidt', 'CEO', '1000000', NULL); 

-- EVENTS
-- Events are simitar to triggers: triggers happen when an event takes place, whereas an event takes place when it's scheduled
-- Its more of a scheduled automator 

# Use case: the department needs to give lifetime pay to anyone over the age of 60, so we need to check it every month to see if anyone qualifies

SELECT * 
FROM employee_demographics;


DELIMITER $$
DROP EVENT IF EXISTS `delete_retirees`;
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND 
DO
BEGIN
	DELETE
	FROM employee_demographics
    WHERE age >=60;
END $$ 
DELIMITER ;
# The schedule could be "30 second", 1 day

SHOW VARIABLES LIKE 'event%';





