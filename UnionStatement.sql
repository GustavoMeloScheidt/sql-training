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

