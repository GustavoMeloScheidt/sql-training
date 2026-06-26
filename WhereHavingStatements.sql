-- HAVING vs WHERE

# In sum: we use WHERE more, HAVING is for when we want to filter on agg function columns 

# We have a problem with where here, in which this would not run (with "Where")
# When we're selecting gender and perfoming agg function, this occurs only after group by groups those rows together
# so when we try to filter (with where) based of AVG(age), it hasn't been created yet because the group by hasn't happened yet
# HAVING came to fix this problem, it was specifically created for this exact example
SELECT gender, AVG (age)
FROM employee_demographics	
#WHERE AVG(age) > 40
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%' # Filter at the row level 
GROUP BY occupation
HAVING AVG(salary) > 75000 # Filter at the agg function level
;