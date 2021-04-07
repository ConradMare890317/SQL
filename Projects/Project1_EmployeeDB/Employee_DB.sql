CREATE TABLE departments (
    depts_id bigserial,
    depts varchar(100),
    city varchar(100),
    CONSTRAINT depts_key PRIMARY KEY (depts_id),
    CONSTRAINT depts_city_unique UNIQUE (depts, city)
);

CREATE TABLE employees (
    emps_id bigserial,
    first_name varchar(100),
    last_name varchar(100),
    salary integer,
    depts_id integer REFERENCES departments (depts_id),
    CONSTRAINT emps_key PRIMARY KEY (emps_id),
    CONSTRAINT emps_depts_unique UNIQUE (emps_id, depts_id)
);

INSERT INTO departments (depts, city)
VALUES
    ('Tax', 'Atlanta'),
    ('IT', 'Boston');

INSERT INTO employees (first_name, last_name, salary, depts_id)
VALUES
    ('Nancy', 'Jones', 62500, 1),
    ('Lee', 'Smith', 59300, 1),
    ('Soo', 'Nguyen', 83000, 2),
    ('Janet', 'King', 95000, 2);
	
SELECT emps_id,last_name, salary
	FROM employees JOIN departments
	ON employees.depts_id = departments.depts_id;