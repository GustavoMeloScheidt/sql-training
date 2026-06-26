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



