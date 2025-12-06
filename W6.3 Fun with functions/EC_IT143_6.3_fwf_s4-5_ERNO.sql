
-- Source: https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name
-- Verified that LEFT() and CHARINDEX() can isolate the first name from a full name string.
--Step 5
-- EC_IT143_6.3_fwf_s5_eo.sql
CREATE FUNCTION dbo.fn_GetFirstName (@ContactName NVARCHAR(100))
RETURNS NVARCHAR(50)
AS
BEGIN
    RETURN LEFT(@ContactName, CHARINDEX(' ', @ContactName + ' ') - 1);
END;
GO