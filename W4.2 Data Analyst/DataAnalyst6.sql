DROP PROCEDURE IF EXISTS dbo.usp_dataanalyst_load;
GO

CREATE PROCEDURE dbo.usp_dataanalyst_load
AS

/***********************************************************************************************
NAME:    dbo.usp_dataanalyst_load
PURPOSE: Stored procedure to reload the highest-rated Data Analyst job listing from view into table

MODIFICATION LOG:
Ver      Date        Author              Description
-----   ----------   ------------------  -------------------------------------------------------
1.0     11/17/2025   Enkemdirim Okere    Created procedure for EC IT143 Data Analyst assignment

NOTES:
This procedure truncates the target table, reloads the top-rated job listing from the view,
and displays the results. It mirrors the Hello World pattern using real-world job data.
***********************************************************************************************/

BEGIN
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

    SELECT *
    FROM dbo.t_dataanalyst;
END;
GO
EXEC dbo.usp_dataanalyst_load;