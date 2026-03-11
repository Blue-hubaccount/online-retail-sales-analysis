-- Creation of database
CREATE DATABASE retail_analysis;

-- Specification to use the created database
USE retail_analysis;

-- View all imported data from a CSV file
select * from online_retail;

-- Total Revenue
SELECT SUM(CAST(Quantity AS FLOAT)* UnitPrice) AS TotalRevenue
FROM online_retail
WHERE ISNUMERIC(Quantity) = 1;

-- This counts all products sold 
SELECT Description,
SUM(CAST(Quantity AS FLOAT) * UnitPrice) AS TotalSold
FROM online_retail
WHERE ISNUMERIC(Quantity) = 1
GROUP BY Description
ORDER BY TotalSold DESC;

-- Top products sold 
SELECT Description,
SUM(CAST(Quantity AS FLOAT)) AS TotalSold
FROM online_retail
WHERE ISNUMERIC(Quantity) = 1
GROUP BY Description
ORDER BY TotalSold DESC;

-- Revenue by Country 
SELECT Country,
SUM(CAST(Quantity AS FLOAT) * UnitPrice) AS Revenue
FROM online_retail
WHERE ISNUMERIC(Quantity) = 1
GROUP BY Country
ORDER BY Revenue DESC;

-- Monthly Sales Trend - also did some data cleaning 
SELECT
YEAR(TRY_CONVERT(datetime, InvoiceDate)) AS Year,
MONTH(TRY_CONVERT(datetime, InvoiceDate)) AS Month,
SUM(TRY_CONVERT(FLOAT, Quantity) * UnitPrice) AS Revenue
FROM online_retail
WHERE TRY_CONVERT(FLOAT, Quantity) > 0
GROUP BY
YEAR(TRY_CONVERT(datetime, InvoiceDate)),
MONTH(TRY_CONVERT(datetime, InvoiceDate))
ORDER BY Year, Month;

-- Top 10 items that sell the most
SELECT TOP 10
Description,
SUM(TRY_CONVERT(FLOAT, Quantity)) AS TotalSold
FROM online_retail
WHERE TRY_CONVERT(FLOAT, Quantity) > 0
GROUP BY Description
ORDER BY TotalSold DESC;

-- Country that generates the most money
SELECT
Country,
SUM(TRY_CONVERT(FLOAT, Quantity) * UnitPrice) AS Revenue
FROM online_retail
WHERE TRY_CONVERT(FLOAT, Quantity) > 0
GROUP BY Country
ORDER BY Revenue DESC;

-- Top 10 Customers that spent the most
SELECT TOP 10
CustomerID,
SUM(TRY_CONVERT(FLOAT, Quantity) * UnitPrice) AS TotalSpent
FROM online_retail
WHERE TRY_CONVERT(FLOAT, Quantity) > 0
AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY TotalSpent DESC;



