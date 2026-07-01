-- Triggers and Events 
-- A trigger is a block of code that executes automatically when an event takes place on a specific table 

# Use case: when someone is put in the salary table, we will automatically update with the employee_id, first_name and last_name on the demographics table
# So the trigger is when the data is updated in the salary table
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary # if we put "BEFORE" could be an use case where when data is deleted, something else happens
    FOR EACH ROW # this means the trigger will get activated for each row that is inserted
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name); # NEW means we're only taking the new rows that were inserted), OLD takes rows that were deleted or updated
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id) 
VALUES (13, 'Gustavo', 'Scheidt', 'CEO', '1000000', NULL); 

-- EVENTS
-- Events are simitar to triggers: triggers happen when an event takes place, whereas an event takes place when it's scheduled
-- Its more of a scheduled automator 

# Use case: the department needs to give lifetime pay to anyone over the age of 60, so we need to check it every month to see if anyone qualifies

SELECT * 
FROM employee_demographics;


DELIMITER $$
DROP EVENT IF EXISTS `delete_retirees`;
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND 
DO
BEGIN
	DELETE
	FROM employee_demographics
    WHERE age >=60;
END $$ 
DELIMITER ;
# The schedule could be "30 second", 1 day

SHOW VARIABLES LIKE 'event%';



