DROP PROCEDURE IF EXISTS dbo.usp_hello_world_load;
GO

CREATE PROCEDURE dbo.usp_hello_world_load
AS
/*****************************************************************************************************************
NAME:    dbo.usp_hello_world_load
PURPOSE: Stored procedure to reload Hello World data from view into table

MODIFICATION LOG:
Ver      Date        Author              Description
-----   ----------   ------------------  ---------------------------------------------------------------
1.0     11/17/2025   Enkemdirim Okere    Built this script for EC IT143

RUNTIME: Xm Xs

NOTES: 
This script exists to help me learn steps 4–8 in the Answer-Focused Approach for T-SQL.
******************************************************************************************************************/

BEGIN

-- 1) Reload Data

    TRUNCATE TABLE dbo.t_hello_world;

    INSERT INTO dbo.t_hello_world
    SELECT v.my_message,
           v.current_date_time
    FROM dbo.v_helloworld_load AS v;
   -- 2) Review results

    SELECT t.*
    FROM dbo.t_hello_world AS t;
END;
GO
EXEC dbo.usp_hello_world_load;