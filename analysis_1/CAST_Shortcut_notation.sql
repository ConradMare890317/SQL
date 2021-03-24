SELECT timestamp_column, CAST(timestamp_column AS varchar(10))
FROM chapter3_date_time_types;

SELECT timestamp_column::varchar(10)
FROM chapter3_date_time_types;