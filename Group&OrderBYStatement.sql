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


