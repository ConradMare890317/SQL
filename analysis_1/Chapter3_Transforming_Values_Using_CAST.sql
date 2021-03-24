SELECT timestamp_column, CAST(timestamp_column AS varchar(10))
FROM chapter3_date_time_types;

SELECT numeric_column,
	CAST(numeric_column AS integer),
	CAST(numeric_column AS varchar(6))
FROM chapter3_number_data_types;

SELECT CAST(char_column AS integer) FROM chapter3_char_data_types;