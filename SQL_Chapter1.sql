SELECT
	numeric_column * 1000000 AS "Fixed",
	real_column * 1000000 AS "Float"
FROM number_data_types
WHERE numeric_column = .7;