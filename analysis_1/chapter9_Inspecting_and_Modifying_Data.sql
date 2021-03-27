--CHAPTER9 - INSPECTING AND MODIFYING DATA:


--Importing the FSIS Meat, Poultry, and Egg Inspection Directory

CREATE TABLE chapter9_meat_poultry_egg_inspect (
    est_number varchar(50) CONSTRAINT est_number_key PRIMARY KEY,
    company varchar(100),
    street varchar(100),
    city varchar(30),
    st varchar(2),
    zip varchar(5),
    phone varchar(14),
    grant_date date,
    activities text,
    dbas text
);

COPY chapter9_meat_poultry_egg_inspect
FROM 'C:\Users\conra\OneDrive\Desktop\SQL\SQL\analysis_1\MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

CREATE INDEX company_idx ON chapter9_meat_poultry_egg_inspect (company);

-- Count the rows imported:
SELECT count(*) FROM chapter9_meat_poultry_egg_inspect;

-- Finding multiple companies at the same address
SELECT company,
       street,
       city,
       st,
       count(*) AS address_count
FROM chapter9_meat_poultry_egg_inspect
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;

--Grouping and counting states
SELECT st, 
       count(*) AS st_count
FROM chapter9_meat_poultry_egg_inspect
GROUP BY st
ORDER BY st;

--Using IS NULL to find missing values in the st column
SELECT est_number,
       company,
       city,
       st,
       zip
FROM chapter9_meat_poultry_egg_inspect
WHERE st IS NULL;

--Using GROUP BY and count() to find inconsistent company names

SELECT company,
       count(*) AS company_count
FROM chapter9_meat_poultry_egg_inspect
GROUP BY company
ORDER BY company ASC;

--Using length() and count() to test the zip column

SELECT length(zip),
       count(*) AS length_count
FROM chapter9_meat_poultry_egg_inspect
GROUP BY length(zip)
ORDER BY length(zip) ASC;

--Filtering with length() to find short zip values

SELECT st,
       count(*) AS st_count
FROM chapter9_meat_poultry_egg_inspect
WHERE length(zip) < 5
GROUP BY st
ORDER BY st ASC;

--Backing up a table

CREATE TABLE chapter9_meat_poultry_egg_inspect_backup AS
SELECT * FROM chapter9_meat_poultry_egg_inspect;

-- Check number of records:
SELECT 
    (SELECT count(*) FROM chapter9_meat_poultry_egg_inspect) AS original,
    (SELECT count(*) FROM chapter9_meat_poultry_egg_inspect_backup) AS backup;

--Creating and filling the st_copy column with ALTER TABLE and UPDATE

ALTER TABLE chapter9_meat_poultry_egg_inspect ADD COLUMN st_copy varchar(2);

UPDATE chapter9_meat_poultry_egg_inspect
SET st_copy = st;

--Checking values in the st and st_copy columns

SELECT st,
       st_copy
FROM chapter9_meat_poultry_egg_inspect
ORDER BY st;

--Updating the st column for three establishments

UPDATE chapter9_meat_poultry_egg_inspect
SET st = 'MN'
WHERE est_number = 'V18677A';

UPDATE chapter9_meat_poultry_egg_inspect
SET st = 'AL'
WHERE est_number = 'M45319+P45319';

UPDATE chapter9_meat_poultry_egg_inspect
SET st = 'WI'
WHERE est_number = 'M263A+P263A+V263A';

-- Restoring original st column values

-- Restoring from the column backup
UPDATE chapter9_meat_poultry_egg_inspect
SET st = st_copy;

-- Restoring from the table backup
UPDATE chapter9_meat_poultry_egg_inspect original
SET st = backup.st
FROM chapter9_meat_poultry_egg_inspect_backup backup
WHERE original.est_number = backup.est_number; 

--Creating and filling the company_standard column

ALTER TABLE chapter9_meat_poultry_egg_inspect ADD COLUMN company_standard varchar(100);

UPDATE chapter9_meat_poultry_egg_inspect
SET company_standard = company;

--Use UPDATE to modify field values that match a string

UPDATE chapter9_meat_poultry_egg_inspect
SET company_standard = 'Armour-Eckrich Meats'
WHERE company LIKE 'Armour%';

SELECT company, company_standard
FROM chapter9_meat_poultry_egg_inspect
WHERE company LIKE 'Armour%';

--Creating and filling the zip_copy column

ALTER TABLE chapter9_meat_poultry_egg_inspect ADD COLUMN zip_copy varchar(5);

UPDATE chapter9_meat_poultry_egg_inspect
SET zip_copy = zip;

--Modify codes in the zip column missing two leading zeros

UPDATE chapter9_meat_poultry_egg_inspect
SET zip = '00' || zip
WHERE st IN('PR','VI') AND length(zip) = 3;

--Modify codes in the zip column missing one leading zero

UPDATE chapter9_meat_poultry_egg_inspect
SET zip = '0' || zip
WHERE st IN('CT','MA','ME','NH','NJ','RI','VT') AND length(zip) = 4;

--Creating and filling a state_regions table

CREATE TABLE state_regions (
    st varchar(2) CONSTRAINT st_key PRIMARY KEY,
    region varchar(20) NOT NULL
);

COPY state_regions
FROM 'C:\YourDirectory\state_regions.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

-- Listing 9-19: Adding and updating an inspection_date column

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN inspection_date date;

UPDATE meat_poultry_egg_inspect inspect
SET inspection_date = '2019-12-01'
WHERE EXISTS (SELECT state_regions.region
              FROM state_regions
              WHERE inspect.st = state_regions.st 
                    AND state_regions.region = 'New England');

-- Listing 9-20: Viewing updated inspection_date values

SELECT st, inspection_date
FROM meat_poultry_egg_inspect
GROUP BY st, inspection_date
ORDER BY st;

-- Listing 9-21: Delete rows matching an expression

DELETE FROM meat_poultry_egg_inspect
WHERE st IN('PR','VI');

-- Listing 9-22: Remove a column from a table using DROP

ALTER TABLE meat_poultry_egg_inspect DROP COLUMN zip_copy;

-- Listing 9-23: Remove a table from a database using DROP

DROP TABLE meat_poultry_egg_inspect_backup;

-- Listing 9-24: Demonstrating a transaction block

-- Start transaction and perform update
START TRANSACTION;

UPDATE meat_poultry_egg_inspect
SET company = 'AGRO Merchantss Oakland LLC'
WHERE company = 'AGRO Merchants Oakland, LLC';

-- view changes
SELECT company
FROM meat_poultry_egg_inspect
WHERE company LIKE 'AGRO%'
ORDER BY company;

-- Revert changes
ROLLBACK;

-- See restored state
SELECT company
FROM meat_poultry_egg_inspect
WHERE company LIKE 'AGRO%'
ORDER BY company;

-- Alternately, commit changes at the end:
START TRANSACTION;

UPDATE meat_poultry_egg_inspect
SET company = 'AGRO Merchants Oakland LLC'
WHERE company = 'AGRO Merchants Oakland, LLC';

COMMIT;

-- Listing 9-25: Backing up a table while adding and filling a new column

CREATE TABLE meat_poultry_egg_inspect_backup AS
SELECT *,
       '2018-02-07'::date AS reviewed_date
FROM meat_poultry_egg_inspect;

-- Listing 9-26: Swapping table names using ALTER TABLE

ALTER TABLE meat_poultry_egg_inspect RENAME TO meat_poultry_egg_inspect_temp;
ALTER TABLE meat_poultry_egg_inspect_backup RENAME TO meat_poultry_egg_inspect;
ALTER TABLE meat_poultry_egg_inspect_temp RENAME TO meat_poultry_egg_inspect_backup;