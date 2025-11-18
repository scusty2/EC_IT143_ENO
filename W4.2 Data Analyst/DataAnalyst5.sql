-- Q: What is the highest-rated Data Analyst job listing?
-- A: Let's ask SQL Server and find out...

--1) Reload data
TRUNCATE TABLE dbo.t_dataanalyst;

INSERT INTO dbo.t_dataanalyst
SELECT 
    [Job_Title],
    [Company_Name],
    [Rating],
    [Salary_Estimate],
    [Location],
    load_timestamp
FROM dbo.v_dataanalyst_load;

--2) Review results
SELECT *
FROM dbo.t_dataanalyst;