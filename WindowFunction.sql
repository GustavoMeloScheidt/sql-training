-- Window Functions - OVER, Partition By, RollingTotal, RowNumber, Rank

# Comparing gender with salaries with Group By
SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id 
GROUP BY gender
;

-- Window functions are useful when we want extra informations (like the names)
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
-- We will also add a rolling total -> start at a 
-- specific value and add on values from subsequent rows based off the partition 
SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id 
;

-- Row Number
SELECT dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER()
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id 
;








