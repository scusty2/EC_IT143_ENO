DROP PROCEDURE IF EXISTS dbo.usp_nyhousing_load;
GO

CREATE PROCEDURE dbo.usp_nyhousing_load
AS

/***********************************************************************************************
NAME:    dbo.usp_nyhousing_load
PURPOSE: Stored procedure to reload top-priced NY housing record from view into table

MODIFICATION LOG:
Ver      Date        Author              Description
-----   ----------   ------------------  -------------------------------------------------------
1.0     11/17/2025   Enkemdirim Okere    Created procedure for EC IT143 NY Housing assignment

RUNTIME: Xm Xs

NOTES:
This procedure truncates the table, reloads the top-priced housing record from the view, and displays results.
It mirrors the Hello World structure using real housing data from the NY-House-Dataset.
***********************************************************************************************/

BEGIN
    -- Step 6: Reload and Review
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

    SELECT *
    FROM dbo.t_nyhousing;
END;
GO
EXEC dbo.usp_nyhousing_load;
