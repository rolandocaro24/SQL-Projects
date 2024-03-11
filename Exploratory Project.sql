SELECT * 
FROM worldlifexpectancy;

-- Life Increase over 15 years, Finding how country has increased their life expectancy through functions 
SELECT Country, 
MIN(`Lifeexpectancy`), 
MAX(`Lifeexpectancy`),
ROUND(MAX(`Lifeexpectancy`) - MIN(`Lifeexpectancy`),1) as Life_Increase_15_Years
FROM worldlifexpectancy
GROUP BY Country 
HAVING MIN(`Lifeexpectancy`) <> 0
AND MAX(`Lifeexpectancy`) <> 0
ORDER BY Life_Increase_15_Years ASC
;


SELECT Year, ROUND(AVG(`Lifeexpectancy`),2)
FROM worldlifexpectancy
WHERE `Lifeexpectancy` <> 0
GROUP BY Year
ORDER BY Year;



-- Correlation of GDP and Life Expectancy, it was found out that a higher GDP correlated directly to a higher life expectancy 
SELECT Country, 
ROUND(AVG(GDP),1) as GDP, 
ROUND(AVG(`Lifeexpectancy`),1) AS Life_expe
FROM worldlifexpectancy
GROUP By Country
Having GDP > 0
AND Life_expe > 0
ORDER BY GDP DESC
;

SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) as High_GDP_count, 
AVG(CASE WHEN GDP >= 1500 THEN `Lifeexpectancy` ELSE NULL END) as High_GDP_Life,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) as Low_GDP_count, 
AVG(CASE WHEN GDP <= 1500 THEN `Lifeexpectancy` ELSE NULL END) as Low_GDP_Life
FROM worldlifexpectancy
;


SELECT * 
FROM worldlifexpectancy;

-- BMI correlation to Life Expectancy 
SELECT Country, 
ROUND(AVG(`Lifeexpectancy`),2) as Life, 
ROUND(AVG(BMI),2) as Body_Mass
FROM worldlifexpectancy
GROUP BY Country
Having Life > 0
AND Body_Mass > 0
ORDER BY Body_Mass ASC
;
-- Life expectancy correlation to country status 
SELECT Status, COUNT(DISTINCT Country), 
ROUND(AVG(`Lifeexpectancy`),2) as Life
FROM worldlifexpectancy
Group BY Status
;

SELECT Country, `Lifeexpectancy`, GDP, BMI 
FROM worldlifexpectancy;


SELECT Country, Year, `Lifeexpectancy`, `AdultMortality`, 
SUM(`AdultMortality`) Over (Partition BY Country ORDER BY Year) as Rolling_Total
FROM worldlifexpectancy
WHERE Country LIKE '%United%';
