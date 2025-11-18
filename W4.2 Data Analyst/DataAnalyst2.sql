/***********************************************************************************************
NAME:    dbo.v_dataanalyst_load
PURPOSE: Create a view to load the highest-rated Data Analyst job listing with a timestamp

MODIFICATION LOG:
Ver      Date        Author              Description
-----   ----------   ------------------  -------------------------------------------------------
1.0     11/17/2025   Enkemdirim Okere    Created view for EC IT143 Data Analyst assignment

NOTES:
This view selects the top-rated Data Analyst job listing from dbo.DataAnalyst and adds a load timestamp.
It supports downstream table creation and stored procedure logic.
***********************************************************************************************/

DROP VIEW IF EXISTS dbo.v_dataanalyst_load;
GO

CREATE VIEW dbo.v_dataanalyst_load
AS
SELECT TOP 1 
    [Job_Title],
    [Company_Name],
    [Rating],
    [Salary_Estimate],
    [Location],
    GETDATE() AS load_timestamp
FROM dbo.DataAnalyst
ORDER BY [Rating] DESC;