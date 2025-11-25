/*****************************************************************************************************************
NAME:    EC_IT143_W5.2_NY_House_Dataset_eo.sql
PURPOSE: Answers four questions about the NY House Dataset
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/24/2025   Erica Okere   Built this script for EC IT143 Deliverable 5.2

RUNTIME: 
Xm Xs

NOTES: 
This script answers four questions (mine and classmates’) about the NY House Dataset.
******************************************************************************************************************/

-- Q5: Are there neighborhoods where the average number of bedrooms is higher than the citywide average?
-- Contributor: Erica Nkemdirim Okere
SELECT SUBLOCALITY, 
       AVG(BEDS) AS AvgBedrooms
FROM [EC_IT143_DA].[dbo].[NY-House-Dataset]
GROUP BY SUBLOCALITY
HAVING AVG(BEDS) > (
    SELECT AVG(BEDS) 
    FROM [EC_IT143_DA].[dbo].[NY-House-Dataset]
);

-- Q6: What is the average salary estimate compared to the average price and sqft of housing listings?
-- Contributor: Gilmar Salgado
WITH CleanedJobs AS (
    SELECT Job_Title,
           Location,
           CAST(REPLACE(REPLACE(
               SUBSTRING(Salary_Estimate, 2, CHARINDEX('-', Salary_Estimate) - 2),
               'K','000'),'$','') AS BIGINT) AS MinSalary,
           CAST(REPLACE(REPLACE(
               SUBSTRING(Salary_Estimate, CHARINDEX('-', Salary_Estimate) + 1,
                         CHARINDEX('(', Salary_Estimate) - CHARINDEX('-', Salary_Estimate) - 2),
               'K','000'),'$','') AS BIGINT) AS MaxSalary
    FROM [EC_IT143_DA].[dbo].[DataAnalyst]
    WHERE Salary_Estimate LIKE '$%K-%K%'
)
SELECT h.LOCALITY,
       AVG(h.PRICE) AS AvgHousePrice,
       AVG((j.MinSalary + j.MaxSalary) / 2) AS AvgSalary
FROM [EC_IT143_DA].[dbo].[NY-House-Dataset] h
JOIN CleanedJobs j
  ON j.Location LIKE '%' + h.LOCALITY + '%'
GROUP BY h.LOCALITY;

-- Q7: How does the average housing price in each NYC borough compare to the average salary estimate for data analyst jobs in the same borough?
-- Contributor: Christian Ikedi Umunnabuike
WITH CleanedJobs AS (
    SELECT Job_Title,
           Location,
           CAST(REPLACE(REPLACE(
               SUBSTRING(Salary_Estimate, 2, CHARINDEX('-', Salary_Estimate) - 2),
               'K','000'),'$','') AS BIGINT) AS MinSalary,
           CAST(REPLACE(REPLACE(
               SUBSTRING(Salary_Estimate, CHARINDEX('-', Salary_Estimate) + 1,
                         CHARINDEX('(', Salary_Estimate) - CHARINDEX('-', Salary_Estimate) - 2),
               'K','000'),'$','') AS BIGINT) AS MaxSalary
    FROM [EC_IT143_DA].[dbo].[DataAnalyst]
    WHERE Salary_Estimate LIKE '$%K-%K%'
)
SELECT h.LOCALITY,
       AVG(CAST(h.PRICE AS BIGINT)) AS AvgHousePrice,
       AVG((j.MinSalary + j.MaxSalary) / 2.0) AS AvgSalary
FROM [EC_IT143_DA].[dbo].[NY-House-Dataset] h
JOIN CleanedJobs j
  ON j.Location LIKE '%' + h.LOCALITY + '%'
GROUP BY h.LOCALITY;

-- Q8: Which brokers have the most listings in high-priced areas (above $1 million)?
-- Contributor: Erica Nkemdirim Okere
SELECT BROKERTITLE, 
       COUNT(*) AS ListingCount
FROM [EC_IT143_DA].[dbo].[NY-House-Dataset]
WHERE PRICE > 1000000
GROUP BY BROKERTITLE
ORDER BY ListingCount DESC;