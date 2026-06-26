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









