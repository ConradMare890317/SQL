--CREATE TABLE chapter3_number_data_types (
	--numeric_column numeric(20,5),
	--real_column real,
	--double_column double precision
--);

--INSERT INTO chapter3_number_data_types
--VALUES
	--(.7, .7, .7),
	--(2.13579, 2.13579, 2.13579),
	--(2.1357987654, 2.1357987654, 2.1357987654);
	
--SELECT * FROM chapter3_number_data_types;

SELECT
	numeric_column * 10000000 AS "Fixed",
	real_column * 10000000 AS "Float"
FROM chapter3_number_data_types
WHERE numeric_column = .7;