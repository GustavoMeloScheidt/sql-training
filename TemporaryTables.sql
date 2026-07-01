-- Temporary Tables
-- They are only visible to the session they were created in
--  usually to store intermediate results for complex queries and to manipulate data before inserting into a permanent table
-- They only last while we are in the session (if we were to close the App and then go back, it would be gone)alter

-- Temp tables are used for more advanced queries, as CTEs are usually more limited (usually one level of changing/advanced thing we're doing on top of that query)

# This first way is not that used
CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

SELECT *
FROM temp_table;

INSERT INTO temp_table
VALUES('Gustavo', 'Scheidt', 'Hacksaw Ridge');

SELECT *
FROM temp_table;

# Now let's create using a better way

SELECT *
FROM employee_salary;

-- Example in which we just want a subsection of the table in which we have salary greater than 50.000

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM salary_over_50k;








