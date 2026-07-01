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

