SELECT geo_name,
       state_us_abbreviation,
       p0010001
FROM chapter4_us_counties_2010
WHERE p0010001 >= (
    SELECT percentile_cont(.9) WITHIN GROUP (ORDER BY p0010001)
    FROM chapter4_us_counties_2010
    )
ORDER BY p0010001 DESC;