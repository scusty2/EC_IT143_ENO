SELECT ContactName
FROM dbo.t_w3_schools_customers
WHERE dbo.fn_GetFirstName(ContactName) 
      <> LEFT(ContactName, CHARINDEX(' ', ContactName + ' ') - 1);
-- Expected: 0 rows
