-- Q: What is the most expensive property in the New York housing dataset?
-- A: Let's ask SQL Server and find out...
--1) Reload data

TRUNCATE TABLE dbo.t_nyhousing;

INSERT INTO dbo.t_nyhousing
SELECT 
    [TYPE],
    [PRICE],
    [BEDS],
    [BATH],
    [PROPERTYSQFT],
    [ADDRESS],
    load_timestamp
FROM dbo.v_nyhousing_load;

--2) Review results
SELECT *
FROM dbo.t_nyhousing;