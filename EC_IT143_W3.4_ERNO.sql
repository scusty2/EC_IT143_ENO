/*****************************************************************************************************************
NAME:    [dbo].[v_w3_schools_customers]
PURPOSE: w3 Schools _ Customers

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     011/15/2025   E/NkemdirimOkere       1. Built this script for EC IT143


RUNTIME: 
Xm Xs

NOTES: 
Built for 3.4 Adventure Works Create-Answers 
- Adventure Works medadata > https://dataedo.com/samples/html/AdventureWorks
 
******************************************************************************************************************/

-- Q1: What are the five most expensive products in terms of list price in the Production? 
-- Author (Fredrick Eubechi Dinnaye Chibuzor)
-- A1: Road-150 Red List price $3578.27 (There are actually 5 different ones62,44,48,52,56)
-- Purpose see most expensive products.

SELECT TOP 5 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

-- Q2: How many employees are currently listed? 
-- Author (Fredrick Eubechi Dinnaye Chibuzor)
--A2: 290
-- Purpose List current employees.

SELECT COUNT(*) AS EmployeeCount
FROM HumanResources.Employee;

-- Q3: We are planning to design new items and we need to know what is the name and product is top 1 best seller product to use it as a model and inspiration. 
-- Author (Inrid Mieles Serato)
--Q3: revised> We are planning to design new items. Which product is the top-selling item we can use as a model?
--A3:Top selling item is AWC Logo Cap 8,311 sold
-- Purpose To see top selling items, put them in order of descending price

SELECT TOP 1 
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalSold
FROM Sales.SalesOrderDetail AS sod
JOIN Production.Product AS p
    ON sod.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalSold DESC;

--Q4: I need to open a new operations location, but I need to determine which city has the most customers and how many stores are in each city. 
-- Author (Inrid Mieles Serato)
--Q4: revised> I need to open a new operations location. Which city had the most customers, and how many stores are in each city?
--A4: London had the most Customers!But Toronto has the most Stores with 24 (but not even close to the most customers.), followed by London that has 14.
-- purpose to list each city in order of how many customers they have and to see the number of stores in each city.
-- Customers per city
SELECT 
    City,
    COUNT(DISTINCT BusinessEntityID) AS CustomerCount
FROM Sales.vIndividualCustomer
GROUP BY City
ORDER BY CustomerCount DESC;

-- Stores per city
SELECT 
    City,
    COUNT(DISTINCT BusinessEntityID) AS StoreCount
FROM Sales.vStoreWithAddresses
GROUP BY City
ORDER BY StoreCount DESC;

-- Q5:During Q4 2013, our executive team wants to understand customer purchasing patterns for women’s clothing.
-- Can you provide a breakdown of total order quantities and average unit price by product color and size for female customers only? 
-- Author (Nana Yaw Kwarteng)
--Q5: Revised: Can you provide a breakdown of total order quantities and average unit price by product color and size for all clothing items sold in Q4 2013? 
--purpose to show the total of all units sold to female customers.  Then the average price of those units.  
-- What was the average color and size of those units, but only for female customers.
-- New purpose changed to*Show total units sold and average price for clothing products by color and size during Q4 2013. 
-- Since females was not a catagory that exisited.

Select Count (*) AS Ordercount
FROM Sales.SalesOrderHeader
Where OrderDate >= '2013-10-01' And OrderDate < '2014-01-01';

Select Distinct ProductLine
From Production.Product;
-- Q5 revision there is no Catagory for Women's clothing. So question needs to be revised.
SELECT  
    p.Color,
    p.Size,
    SUM(sod.OrderQty) AS TotalOrderQty,
    AVG(sod.UnitPrice) AS AvgUnitPrice
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE  
    pc.Name = 'Clothing'
    AND soh.OrderDate >= '2013-10-01' AND soh.OrderDate < '2014-01-01'
GROUP BY  
    p.Color, p.Size
ORDER BY  
    p.Color, p.Size;



--Q6:We’re planning a promotion for our mountain bike line next summer. I need a report showing total revenue, quantity sold, 
-- and average discount percentage for all mountain bike models sold in 2012, grouped by country and sales territory.
-- Author (Nana Yaw Kwarteng)
--A6: Total sold in Southwest was 4,520 The average discount was .0111.  Looking at the list it does appear 
-- that people with higher dicounts had higher sales and higher revenue.
-- Purpose find the sum of total revenue.  Then find the total quantitity sold.  After that find an average of 
-- the discount % for all bikes sold in 2012.  Then you will group by country and where they were sold.  The purpose is 
-- to know where is the best region to hold your sales and what is the best discount to give in those areas.

SELECT 
    st.CountryRegionCode,
    st.Name AS SalesTerritory,
    SUM(sod.LineTotal) AS TotalRevenue,
    SUM(sod.OrderQty) AS TotalQuantitySold,
    AVG(sod.UnitPriceDiscount) AS AvgDiscountPercent
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
WHERE 
    p.ProductLine = 'M' -- Mountain bikes
    AND YEAR(soh.OrderDate) = 2012
GROUP BY 
    st.CountryRegionCode, st.Name
ORDER BY 
    TotalRevenue DESC;
--Q7:Which columns in the Employee table store dates or times? 
-- Author (Erica Nkemdirim Okere)
--A7: Column_name is BirthDate and Hire Date 
-- purpose: Purpose select date/time fields for HR update. 

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME= 'Employee'
AND Data_TYPE IN ('date','datetime2','smalldatetime','time');

--Q8: Which tables in AdventureWorks contain a column named 'EmailAddress'? 
--Author (Erica Nkemdirim Okere)
--A8 Table_Name would show EmailAddress, ProductReveiw, vAdditionalContactInfo, vEmployee,
--vIndividualCustomer, vSalesPerson, vStoresWithContacts, vVendorWith Contacts
-- Purpose: Locate email data accross tables

SELECT DISTINCT TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EmailAddress';


SELECT GETDATE() AS my_date;
--Date is 2025-11-15-15:09:25.280