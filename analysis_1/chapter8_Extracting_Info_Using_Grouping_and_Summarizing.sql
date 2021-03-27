--Using count() for table row counts

SELECT count(*)
FROM pls_fy2014_pupld14a;

SELECT count(*)
FROM pls_fy2009_pupld09a;

--Using count() for the number of values in a column

SELECT count(salaries)
FROM pls_fy2014_pupld14a;

--Using count() for the number of distinct values in a column

SELECT count(libname)
FROM pls_fy2014_pupld14a;

SELECT count(DISTINCT libname)
FROM pls_fy2014_pupld14a;

-- Bonus: find duplicate libnames
SELECT libname, count(libname)
FROM pls_fy2014_pupld14a
GROUP BY libname
ORDER BY count(libname) DESC;

-- Bonus: see location of every Oxford Public Library
SELECT libname, city, stabr
FROM pls_fy2014_pupld14a
WHERE libname = 'OXFORD PUBLIC LIBRARY';

--Finding the most and fewest visits using max() and min()
SELECT max(visits), min(visits)
FROM pls_fy2014_pupld14a;

--Using GROUP BY on the stabr column

-- There are 56 in 2014.
SELECT stabr
FROM pls_fy2014_pupld14a
GROUP BY stabr
ORDER BY stabr;

-- Bonus: there are 55 in 2009.
SELECT stabr
FROM pls_fy2009_pupld09a
GROUP BY stabr
ORDER BY stabr;

--Using GROUP BY on the city and stabr columns

SELECT city, stabr
FROM pls_fy2014_pupld14a
GROUP BY city, stabr
ORDER BY city, stabr;

-- Bonus: We can count some of the combos
SELECT city, stabr, count(*)
FROM pls_fy2014_pupld14a
GROUP BY city, stabr
ORDER BY count(*) DESC;

--GROUP BY with count() on the stabr column

SELECT stabr, count(*)
FROM pls_fy2014_pupld14a
GROUP BY stabr
ORDER BY count(*) DESC;

--GROUP BY with count() on the stabr and stataddr columns

SELECT stabr, stataddr, count(*)
FROM pls_fy2014_pupld14a
GROUP BY stabr, stataddr
ORDER BY stabr ASC, count(*) DESC;

--Using the sum() aggregate function to total visits in libraries in 2014 and 2009

-- 2014
SELECT sum(visits) AS visits_2014
FROM pls_fy2014_pupld14a
WHERE visits >= 0;

-- 2009
SELECT sum(visits) AS visits_2009
FROM pls_fy2009_pupld09a
WHERE visits >= 0;

--Using sum() to total visits on joined 2014 and 2009 library tables

SELECT sum(pls14.visits) AS visits_2014,
       sum(pls09.visits) AS visits_2009
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.visits >= 0 AND pls09.visits >= 0;

--Using GROUP BY to track percent change in library visits by state

SELECT pls14.stabr,
       sum(pls14.visits) AS visits_2014,
       sum(pls09.visits) AS visits_2009,
       round( (CAST(sum(pls14.visits) AS decimal(10,1)) - sum(pls09.visits)) /
                    sum(pls09.visits) * 100, 2 ) AS pct_change
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.visits >= 0 AND pls09.visits >= 0
GROUP BY pls14.stabr
ORDER BY pct_change DESC;

--Using HAVING to filter the results of an aggregate query

SELECT pls14.stabr,
       sum(pls14.visits) AS visits_2014,
       sum(pls09.visits) AS visits_2009,
       round( (CAST(sum(pls14.visits) AS decimal(10,1)) - sum(pls09.visits)) /
                    sum(pls09.visits) * 100, 2 ) AS pct_change
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.visits >= 0 AND pls09.visits >= 0
GROUP BY pls14.stabr
HAVING sum(pls14.visits) > 50000000
ORDER BY pct_change DESC;