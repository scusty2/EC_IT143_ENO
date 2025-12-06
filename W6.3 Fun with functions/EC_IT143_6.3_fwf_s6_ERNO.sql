SELECT ContactName,
       dbo.fn_GetFirstName(ContactName) AS UDF_FirstName,
       LEFT(ContactName, CHARINDEX(' ', ContactName + ' ') - 1) AS AdHoc_FirstName
FROM dbo.t_w3_schools_customers;