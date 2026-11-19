-- CONFIRM THE CONVERSION WORKED CLEANLY
USE customeranalysic;
GO

SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'RetailCombined';
USE customeranalysic;
GO

SELECT TOP 5 *
FROM dbo.[year data 2009-2010];

SELECT TOP 5 *
FROM dbo.[data 2010-2011];

SELECT COUNT(*) AS Total_Rows
FROM dbo.RetailCombined;

SELECT COUNT(*) AS Failed_Dates
FROM dbo.RetailCombined
WHERE InvoiceDate IS NULL;

SELECT COUNT(*) AS Failed_Prices
FROM dbo.RetailCombined
WHERE Price IS NULL;