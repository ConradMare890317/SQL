-- 2.1
SELECT school, first_name, last_name
FROM teachers
ORDER BY school, last_name;

--2.2
SELECT first_name, last_name, school, salary
FROM teachers
WHERE first_name LIKE 'S%' -- remember that LIKE is case-sensitive!
      AND salary > 40000;
	  
--2.3
SELECT last_name, first_name, school, hire_date, salary
FROM teachers
WHERE hire_date >= '2010-01-01'
ORDER BY salary DESC;