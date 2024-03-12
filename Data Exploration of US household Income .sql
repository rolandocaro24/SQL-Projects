-- Data Exploration US Household Income

SELECT * FROM `US Household Income`.ushouseholdincome_statistics;

SELECT * FROM `US Household Income`.us_household_income;


-- Finding the State with the largest amount of Land
SELECT State_Name, SUM(AWater), SUM(ALand)
FROM us_household_income
GROUP BY State_Name
ORDER BY SUM(ALand) DESC;

-- Finding the State with the largest amount of Water
SELECT State_Name, SUM(AWater), SUM(ALand)
FROM us_household_income
GROUP BY State_Name
ORDER BY SUM(AWater) DESC;

-- Finding the State with the largest amount of Land (Top 10) 
SELECT State_Name, SUM(AWater), SUM(ALand)
FROM us_household_income
GROUP BY State_Name
ORDER BY SUM(ALand) DESC
LIMIT 10 
;

-- Finding the State with the largest amount of Water (Top 10) 
SELECT State_Name, SUM(AWater), SUM(ALand)
FROM us_household_income
GROUP BY State_Name
ORDER BY SUM(AWater) DESC
LIMIT 10 
;



SELECT u.State_Name, Type, `Primary`, Mean, Median
FROM us_household_income u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE mean <> 0
;


-- Finding accurate values by eliminating the 0 or Nulls
SELECT u.State_Name,ROUND(AVG(Mean),2), ROUND(AVG(Median),2)
FROM us_household_income u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0 
GROUP By u.State_Name
ORDER By 2 DESC
LIMIT 10 ;

-- Finding the Type of Household with highest earning income 
SELECT Type,COUNT(Type), ROUND(AVG(Mean),2), ROUND(AVG(Median),2)
FROM us_household_income u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0 
GROUP By Type
HAVING COUNT(Type) > 100
ORDER By 3 DESC
LIMIT 20 ;

-- Finding where State is the Type Community coming from 
SELECT * 
FROM us_household_income
WHERE Type = 'Community';

-- Finding the State and City with the highest Salary 
SELECT u.State_Name, City, ROUND(AVG(Mean),1)
FROM us_household_income u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
GROUP BY City, State_Name
ORDER BY ROUND(AVG(Mean),1) DESC
;

