-- Q: What is the most expensive property in the New York housing dataset?
-- A: Let's ask SQL Server and find out...

SELECT TOP 1 [TYPE], [PRICE], [ADDRESS], [BEDS], [BATH], [PROPERTYSQFT]
FROM [EC_IT143_DA].[dbo].[NY-House-Dataset]
ORDER BY [PRICE] DESC;
EXEC dbo.usp_nyhousing_load;