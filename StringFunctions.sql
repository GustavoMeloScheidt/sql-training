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

