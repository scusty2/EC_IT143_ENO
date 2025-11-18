DROP VIEW IF EXISTS dpo.v_hello_world_load;
GO
CREATE VIEW dbo.v_hello_world_load
AS
/*****************************************************************************************************************
NAME:    dbo.v.hello_world_load
PURPOSE: Create the Hello World - Load view

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     011/17/2025   ENkemdirimOkere       1. Built this script for EC IT143


RUNTIME: 
Xm Xs

NOTES: 
This script exists to help me learn steps 4-8 in the Answer Focused Approach for T-SQL ...
 
******************************************************************************************************************/

SELECT 'Hello World' As my_message,
      GETDATE() AS current_date_time;