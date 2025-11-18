-- Q: What is the highest-rated Data Analyst job listing?
-- A: Let's ask SQL Server and find out...

DROP TABLE IF EXISTS dbo.t_dataanalyst;
GO

SELECT 
    [Job_Title],
    [Company_Name],
    [Rating],
    [Salary_Estimate],
    [Location],
    load_timestamp
INTO dbo.t_dataanalyst
FROM dbo.v_dataanalyst_load;