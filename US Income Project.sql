SELECT * FROM `US Household Income`.ushouseholdincome_statistics;

SELECT * 
FROM `US Household Income`.us_household_income;

SELECT COUNT(id)
FROM us_household_income;

SELECT COUNT(id)
FROM ushouseholdincome_statistics;

SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id 
HAVING COUNT(id) > 1
;

-- Finding duplicates from Household Income 
SELECT *
FROM
(
SELECT row_id, 
id, 
ROW_NUMBER() OVER(Partition By id ORDER BY id) as id_duplicate
FROM us_household_income) as row_id
WHERE id_duplicate > 1
; 


-- Eliminating these duplicates from Household Income 
DELETE FROM us_household_income
WHERE row_id IN (
SELECT row_id
FROM
(
SELECT row_id, 
id, 
ROW_NUMBER() OVER(Partition By id ORDER BY id) as id_duplicate
FROM us_household_income) as row_id
WHERE id_duplicate > 1)
; 


-- Finding duplicates in Household Statistics (No duplicates found) 
SELECT id, COUNT(id)
FROM ushouseholdincome_statistics
GROUP BY id 
HAVING COUNT(id) > 1
;

-- FOund a mispelling in the database 

SELECT DISTINCT State_Name 
FROM us_household_income
GROUP By State_Name
ORDER BY 1;

-- Correct the error of spelling in the table 
UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE  State_Name = 'georia';

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE  State_Name = 'alabama';


-- Look into the empty spots and found one 
SELECT Place
FROM us_household_income
Where Place = ''
;


-- Updated the table with the correct place after studying the data 
UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont' ; 

-- Found a misspelling in the Type and update it 
SELECT Type, Count(Type) 
FROM us_household_income
GROUP By Type; 

UPDATE us_household_income 
SET Type = 'Borough'
WHERE Type = 'Boroughs';

-- Looking for a mistake in Land or Water and there was no issues 
SELECT ALand, AWater
FROM us_household_income 
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND  (ALand = 0 OR ALand = '' OR ALand IS NULL)
; 


