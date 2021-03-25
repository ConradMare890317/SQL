COPY chapter4_us_counties_2010
FROM 'C:\Users\conra\OneDrive\Desktop\SQL\SQL\analysis_1\us_counties_2010.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM chapter4_us_counties_2010

SELECT geo_name, state_us_abbreviation, area_land
FROM chapter4_us_counties_2010
ORDER BY area_land DESC
LIMIT 3;

SELECT geo_name, state_us_abbreviation, internal_point_lon
FROM chapter4_us_counties_2010
ORDER BY internal_point_lon DESC
LIMIT 5;