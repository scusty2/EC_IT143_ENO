/*****************************************************************************************************************
NAME:    EC_IT143_W5.2_Data_Analyst_Jobs_eo.sql
PURPOSE: Answers four questions about the Data Analyst Jobs dataset
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/24/2025   Erica Okere   Built this script for EC IT143 Deliverable 5.2

RUNTIME: 
Xm Xs

NOTES: 
This script answers four questions (mine and classmates’) about the Data Analyst Jobs dataset.
******************************************************************************************************************/

-- Q1: Compare the average salary per title per location to see if location impacts pay
-- A1: This query groups by job title and location, then calculates the average salary.

WITH Cleaned AS (
    SELECT Job_Title,
           Location,
           -- Extract the minimum salary (before the dash)
           CAST(REPLACE(REPLACE(
               SUBSTRING(Salary_Estimate, 2, CHARINDEX('-', Salary_Estimate) - 2),
               'K','000'),'$','') AS INT) AS MinSalary,

           -- Extract the maximum salary (after the dash, before the parenthesis)
           CAST(REPLACE(REPLACE(
               SUBSTRING(Salary_Estimate, CHARINDEX('-', Salary_Estimate) + 1,
                         CHARINDEX('(', Salary_Estimate) - CHARINDEX('-', Salary_Estimate) - 2),
               'K','000'),'$','') AS INT) AS MaxSalary
    FROM [EC_IT143_DA].[dbo].[DataAnalyst]
    WHERE Salary_Estimate LIKE '$%K-%K%'  -- only rows with ranges
)
SELECT Job_Title, Location,
       AVG((MinSalary + MaxSalary) / 2) AS AvgSalary
FROM Cleaned
GROUP BY Job_Title, Location;

-- Q2: Which sectors offer the most job listings for data analysts, and average company size
-- A2: This query counts job listings per sector and averages company size
WITH Cleaned AS (
    SELECT Sector,
           CASE 
               WHEN Size = '-1' THEN NULL
               WHEN Size LIKE '%Unknown%' THEN NULL
               WHEN Size LIKE '%to%' 
                    THEN (CAST(LEFT(Size, CHARINDEX(' ', Size)-1) AS INT) 
                          + CAST(SUBSTRING(Size, CHARINDEX('to', Size)+3, 
                                           CHARINDEX('employees', Size)-CHARINDEX('to', Size)-3) AS INT)) / 2
               WHEN Size LIKE '%+%' 
                    THEN CAST(REPLACE(LEFT(Size, CHARINDEX('+', Size)), '+','') AS INT)
               ELSE CAST(Size AS INT)
           END AS CompanySize
    FROM [EC_IT143_DA].[dbo].[DataAnalyst]
)
SELECT Sector, COUNT(*) AS JobCount, AVG(CompanySize) AS AvgCompanySize
FROM Cleaned
WHERE CompanySize IS NOT NULL
GROUP BY Sector;

-- Q3: What is the average salary estimate for data analyst roles by industry in New York?
-- A3: This query filters for New York and groups by industry

WITH Cleaned AS (
    SELECT Industry,
           Location,
           CAST(REPLACE(REPLACE(
               SUBSTRING(Salary_Estimate, 2, CHARINDEX('-', Salary_Estimate) - 2),
               'K','000'),'$','') AS INT) AS MinSalary,
           CAST(REPLACE(REPLACE(
               SUBSTRING(Salary_Estimate, CHARINDEX('-', Salary_Estimate) + 1,
                         CHARINDEX('(', Salary_Estimate) - CHARINDEX('-', Salary_Estimate) - 2),
               'K','000'),'$','') AS INT) AS MaxSalary
    FROM [EC_IT143_DA].[dbo].[DataAnalyst]
    WHERE Location LIKE 'New York%'   -- broader filter to catch 'New York, NY'
)
SELECT Industry,
       AVG((MinSalary + MaxSalary) / 2) AS AvgSalaryNY
FROM Cleaned
WHERE MinSalary IS NOT NULL AND MaxSalary IS NOT NULL
GROUP BY Industry;

-- Q4: Find house listings with ≥3 bedrooms matched with jobs >$100K in same locality
-- A4: This query joins housing and job datasets by locality
WITH CleanedJobs AS (
    SELECT Job_Title,
           Location,
           CAST(REPLACE(REPLACE(
               SUBSTRING(Salary_Estimate, 2, CHARINDEX('-', Salary_Estimate) - 2),
               'K','000'),'$','') AS INT) AS MinSalary,
           CAST(REPLACE(REPLACE(
               SUBSTRING(Salary_Estimate, CHARINDEX('-', Salary_Estimate) + 1,
                         CHARINDEX('(', Salary_Estimate) - CHARINDEX('-', Salary_Estimate) - 2),
               'K','000'),'$','') AS INT) AS MaxSalary
    FROM [EC_IT143_DA].[dbo].[DataAnalyst]
    WHERE Salary_Estimate LIKE '$%K-%K%'
)
SELECT h.Address,
       h.Beds,
       j.Job_Title,
       ( (j.MinSalary + j.MaxSalary) / 2 ) AS SalaryMidpoint
FROM [EC_IT143_DA].[dbo].[NY-House-Dataset] h
JOIN CleanedJobs j
  ON j.Location LIKE '%' + h.Locality + '%'
WHERE h.Beds >= 3
  AND ( (j.MinSalary + j.MaxSalary) / 2 ) > 100000;

