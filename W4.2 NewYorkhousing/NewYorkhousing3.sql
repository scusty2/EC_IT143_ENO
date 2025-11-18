-- Q: What is the most expensive property in the New York housing dataset?
-- A: Let's ask SQL Server and find out...

DROP TABLE IF EXISTS dbo.t_nyhousing;
GO

SELECT 
    v.[TYPE],
    v.[PRICE],
    v.[BEDS],
    v.[BATH],
    v.[PROPERTYSQFT],
    v.[ADDRESS],
    v.load_timestamp
INTO dbo.t_nyhousing
FROM dbo.v_nyhousing_load AS v;