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













