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
# So when we run aggregate functions (avg, min, max) we will do it based of these rows
SELECT gender
FROM employee_demographics
GROUP BY gender;

# This will not work because if we are not selecting an aggregated column (like avg) (meaning, if we are not using aggregate functions in the select statement)
# It has to be in the Group By (they have to match), since we are not performing the agg function on it
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
# When were selecting gender and perfoming agg function, this occurs only after group by groups those rows together
# so when we try to filter (with where) based of AVG(age), it hasn't been created yet because the group by has not happened yet
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
LIMIT 3
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












