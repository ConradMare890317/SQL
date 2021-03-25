--CREATE TABLE chapter4_importing_and_exporting_data (
--);

--EXAMPLES:


--WORKING WITH DELIMITED TEXT FILES

--Typical comma-delimited file data row:
--John,Doe,123 Main St.,Hyde Park,NY,845-555-1212

--Quoting columns that contain delimiters:
--John,Doe,"123 Main St., Apartment 200",Hyde Park,NY,845-555-1212

--Handling header rows:
--FIRSTNAME,LASTNAME,STREET,CITY,STATE,PHONE
--John,Doe,"123 Main St., Apartment 200",Hyde Park,NY,845-555-1212


--USING COPY TO IMPORT DATA

--COPY table_name
--FROM 'C:\YourDirectory\your_file.csv'
--WITH (FORMAT CSV, HEADER);

--Input and output file format:
-- Use 'FORMAT format_name'

--Presence of a header row:
--Use 'HEADER'

--Delimiter:
--DELIMITER 'charachter' = A single character you can use to specify wich charachter you use as delimiter


--IMPORTING CENSUS DATA DESCRIBING COUNTIES
--(Creating a new table)


--IMPORTING A SUBSET OF COLUMNS
--(Creating a new table)