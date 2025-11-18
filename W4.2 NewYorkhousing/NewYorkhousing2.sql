/***********************************************************************************************
NAME:    dbo.v_nyhousing_load
PURPOSE: Create a view to load selected NY housing data with a timestamp

MODIFICATION LOG:
Ver      Date        Author              Description
-----   ----------   ------------------  -------------------------------------------------------
1.0     11/17/2025   Enkemdirim Okere    Created view for EC IT143 NY Housing assignment

NOTES:
This view selects key housing attributes and adds a load timestamp for downstream use.
***********************************************************************************************/
DROP VIEW IF EXISTS dbo.v_nyhousing_load;
GO

CREATE VIEW dbo.v_nyhousing_load
AS
SELECT TOP 1 
    [TYPE],
    [PRICE],
    [BEDS],
    [BATH],
    [PROPERTYSQFT],
    [ADDRESS],
    GETDATE() AS load_timestamp
FROM [EC_IT143_DA].[dbo].[NY-House-Dataset]
ORDER BY [PRICE] DESC;