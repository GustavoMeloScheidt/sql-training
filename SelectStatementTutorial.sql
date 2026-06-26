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