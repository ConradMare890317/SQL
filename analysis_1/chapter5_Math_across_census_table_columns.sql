--MATH ACROSS CENSUS TABLE COLUMNS

SELECT	geo_name,
		state_us_abbreviation AS "st",
		p0010001 AS "Total Population",
		p0010003 AS "White Alone",
		p0010004 AS "Black or African American Alone",
		p0010005 AS "Am Indian/Alaska Native Alone",
		p0010006 AS "Asian Alone",
		p0010007 AS "Native Hawaiian and Other Pacific Islander Alone",
		p0010008 AS "Some Other Race Alone",
		p0010009 AS "Two or More Races"
	
FROM chapter4_us_counties_2010;

--Adding and subtracting columns

SELECT geo_name,
		state_us_abbreviation AS "st",
		p0010003 AS "White Alone",
		p0010004 AS "Black Alone",
		p0010003 + p0010004 AS "Total White and Black"
FROM chapter4_us_counties_2010;

--Checking Census data totals

SELECT geo_name,
       state_us_abbreviation AS "st",
       p0010001 AS "Total",
       p0010003 + p0010004 + p0010005 + p0010006 + p0010007
           + p0010008 + p0010009 AS "All Races",
       (p0010003 + p0010004 + p0010005 + p0010006 + p0010007
           + p0010008 + p0010009) - p0010001 AS "Difference"
FROM chapter4_us_counties_2010
ORDER BY "Difference" DESC;

--Calculating the percent of the population that is Asian by county (percent of the whole)

SELECT geo_name,
       state_us_abbreviation AS "st",
       (CAST(p0010006 AS numeric(8,1)) / p0010001) * 100 AS "pct_asian"
FROM chapter4_us_counties_2010
ORDER BY "pct_asian" DESC;

--Calculating percent change

CREATE TABLE chapter5_percent_change (
    department varchar(20),
    spend_2014 numeric(10,2),
    spend_2017 numeric(10,2)
);

INSERT INTO chapter5_percent_change
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
FROM chapter5_percent_change;

--Using sum() and avg() aggregate functions

SELECT sum(p0010001) AS "County Sum",
       round(avg(p0010001), 0) AS "County Average"
FROM chapter4_us_counties_2010;

--Testing SQL percentile functions

CREATE TABLE chapter5_percentile_test (
    numbers integer
);

INSERT INTO chapter5_percentile_test (numbers) VALUES
    (1), (2), (3), (4), (5), (6);

SELECT
    percentile_cont(.5)
    WITHIN GROUP (ORDER BY numbers),
    percentile_disc(.5)
    WITHIN GROUP (ORDER BY numbers)
FROM chapter5_percentile_test;

--Using sum(), avg(), and percentile_cont() aggregate functions

SELECT sum(p0010001) AS "County Sum",
       round(avg(p0010001), 0) AS "County Average",
       percentile_cont(.5)
       WITHIN GROUP (ORDER BY p0010001) AS "County Median"
FROM chapter4_us_counties_2010;

-- Passing an array of values to percentile_cont()

-- quartiles
SELECT percentile_cont(array[.25,.5,.75])
       WITHIN GROUP (ORDER BY p0010001) AS "quartiles"
FROM chapter4_us_counties_2010;

-- quintiles (all 4 at once)
SELECT percentile_cont(array[.2,.4,.6,.8])
       WITHIN GROUP (ORDER BY p0010001) AS "quintiles"
FROM chapter4_us_counties_2010;

-- deciles
SELECT percentile_cont(array[.1,.2,.3,.4,.5,.6,.7,.8,.9])
       WITHIN GROUP (ORDER BY p0010001) AS "deciles"
FROM chapter4_us_counties_2010;


--Using unnest() to turn an array into rows

SELECT unnest(
            percentile_cont(array[.25,.5,.75])
            WITHIN GROUP (ORDER BY p0010001)
            ) AS "quartiles"
FROM chapter4_us_counties_2010;







