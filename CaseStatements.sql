-- Case Statements 

-- Sort of like a "if/else" 

SELECT first_name, 
last_name,
age,
CASE 
	WHEN age <= 30 THEN 'Young'
	WHEN age BETWEEN 31 and 50 THEN 'Medium' 
	WHEN age >= 50 THEN 'Old'
END AS Age_Bracket
FROM employee_demographics;

-- Pay increase and bonus:
-- < 50.000 = 5%
-- > 50.000 = 7%
-- Finance = 10% -> department_id = 6

SELECT first_name, 
last_name,
salary,
CASE
	WHEN salary <= 50000 THEN salary + (salary*0.05)
	WHEN salary > 50000 THEN salary * 1.07
END AS Pay_increase,
CASE
	WHEN dept_id = 6 THEN salary * .10
END AS BONUS
FROM employee_salary;

