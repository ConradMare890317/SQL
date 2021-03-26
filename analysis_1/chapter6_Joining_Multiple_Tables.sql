--Joining multiple tables
CREATE TABLE chapter6_schools_enrollment (
    id integer,
    enrollment integer
);

CREATE TABLE chapter6_schools_grades (
    id integer,
    grades varchar(10)
);

INSERT INTO chapter6_schools_enrollment (id, enrollment)
VALUES
    (1, 360),
    (2, 1001),
    (5, 450),
    (6, 927);

INSERT INTO chapter6_schools_grades (id, grades)
VALUES
    (1, 'K-3'),
    (2, '9-12'),
    (5, '6-8'),
    (6, '9-12');

SELECT lt.id, lt.left_school, en.enrollment, gr.grades
FROM chapter6_schools_left AS lt LEFT JOIN chapter6_schools_enrollment AS en
    ON lt.id = en.id
LEFT JOIN chapter6_schools_grades AS gr
    ON lt.id = gr.id;
