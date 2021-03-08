SELECT first_name, last_name,school
FROM teachers
ORDER BY last_name ASC;

SELECT first_name
FROM teachers
WHERE first_name LIKE 'S%' 
	AND salary > 40000;
	
SELECT first_name, last_name
FROM teachers
WHERE hire_date > 'January 1, 2010'
