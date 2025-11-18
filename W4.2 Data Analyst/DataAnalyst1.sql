-- Q: What is the highest-rated Data Analyst job listing?
-- A: Let's ask SQL Server and find out...

SELECT TOP 1 
    [Job_Title],
    [Company_Name],
    [Rating],
    [Salary_Estimate],
    [Location]
FROM dbo.DataAnalyst
ORDER BY [Rating] DESC;
EXEC dbo.usp_dataanalyst_load;