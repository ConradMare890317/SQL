CREATE TABLE chapter12_retirees (
    id int,
    first_name varchar(50),
    last_name varchar(50)
);

INSERT INTO chapter12_retirees 
VALUES (2, 'Lee', 'Smith'),
       (4, 'Janet', 'King');
	   
-- Generating values for the IN operator
SELECT first_name, last_name
FROM chapter6_employees
WHERE emp_id IN (
    SELECT id
    FROM chapter12_retirees);
	
-- Checking whether values exist (returns all rows from employees
-- if the expression evaluates as true)
SELECT first_name, last_name
FROM chapter6_employees
WHERE EXISTS (
    SELECT id
    FROM chapter12_retirees);
	
-- Using a correlated subquery to find matching values from employees
-- in retirees.
SELECT first_name, last_name
FROM chapter6_employees
WHERE EXISTS (
    SELECT id
    FROM chapter12_retirees
    WHERE id = chapter6_employees.emp_id);
