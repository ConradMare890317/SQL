--JOIN
--Using JOIN
SELECT *
FROM chapter6_schools_left JOIN chapter6_schools_right
ON chapter6_schools_left.id = chapter6_schools_right.id;

SELECT *
FROM chapter6_schools_left INNER JOIN chapter6_schools_right
ON chapter6_schools_left.id = chapter6_schools_right.id;

--Using LEFT JOIN

SELECT *
FROM chapter6_schools_left LEFT JOIN chapter6_schools_right
ON chapter6_schools_left.id = chapter6_schools_right.id;

--Using RIGHT JOIN

SELECT *
FROM chapter6_schools_left RIGHT JOIN chapter6_schools_right
ON chapter6_schools_left.id = chapter6_schools_right.id;

--Using FULL OUTER JOIN

SELECT *
FROM chapter6_schools_left FULL OUTER JOIN chapter6_schools_right
ON chapter6_schools_left.id = chapter6_schools_right.id;

--Using CROSS JOIN

SELECT *
FROM chapter6_schools_left CROSS JOIN chapter6_schools_right;

--Filtering to show missing values with IS NULL

SELECT *
FROM chapter6_schools_left LEFT JOIN chapter6_schools_right
ON chapter6_schools_left.id = chapter6_schools_right.id
WHERE chapter6_schools_right.id IS NULL;