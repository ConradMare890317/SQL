CREATE TABLE percent_change (
    department varchar(20),
    spend_2014 numeric(10,2),
    spend_2017 numeric(10,2)
);

INSERT INTO percent_change
VALUES
    ('Building', 250000, 289000),
    ('Assessor', 178556, 179500),
    ('Library', 87777, 90001),
    ('Clerk', 451980, 650000),
    ('Police', 250000, 223000),
    ('Recreation', 199000, 195000);

SELECT department,
       spend_2014,
       spend_2017,
       round( (spend_2017 - spend_2014) /
                    spend_2014 * 100, 1 ) AS "pct_change"
FROM percent_change;

SELECT sum(p0010001) AS "County Sum",
round(avg(p0010001), 0) AS "County Average"
FROM us_counties_2010;

CREATE TABLE percentile_test (
	numbers integer
);

INSERT INTO percentile_test (numbers) VALUES
	(1), (2), (3), (4), (5), (6);
	
SELECT
	percentile_cont(.5)
	WITHIN GROUP (ORDER BY numbers),
	percentile_disc(.5)
	
WITHIN GROUP (ORDER BY numbers)
FROM percentile_test;

SELECT sum(p0010001) AS "County Sum",
	round(avg(p0010001), 0) AS "County Average",
	percentile_cont(.5)
	WITHIN GROUP (ORDER BY p0010001) AS "County Median"
FROM us_counties_2010;

SELECT unnest(
	percentile_cont(array[.25,.5,.75])
	WITHIN GROUP (ORDER BY p0010001)
	) AS "quartiles"
FROM us_counties_2010;

CREATE OR REPLACE FUNCTION _final_median(anyarray)
	RETURNS float8 AS
$$
	WITH q AS
(
	SELECT val
	FROM unnest($1) val
	WHERE VAL IS NOT NULL
	ORDER BY 1
),
cnt AS
(
	SELECT COUNT(*) AS c FROM q
)
SELECT AVG(val)::float8
FROM
(
	SELECT val FROM q
	LIMIT 2 - MOD((SELECT c FROM cnt), 2)
	OFFSET GREATEST(CEIL((SELECT c FROM cnt) / 2.0) - 1,0)
) q2;
$$
LANGUAGE sql IMMUTABLE;

CREATE AGGREGATE median(anyelement) (
	SFUNC=array_append,
	STYPE=anyarray,
	FINALFUNC=_final_median,
	INITCOND='{}'
);

SELECT sum(p0010001) AS "County Sum",
	round(AVG(p0010001), 0) AS "County Average",
	median(p0010001) AS "County Median",
	percentile_cont(.5)
	WITHIN GROUP (ORDER BY p0010001) AS "50th Percentile"
FROM us_counties_2010;

