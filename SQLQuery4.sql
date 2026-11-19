USE customeranalysic;
GO

-- Remove the old combined table if it exists
IF OBJECT_ID('dbo.RetailCombined', 'U') IS NOT NULL
    DROP TABLE dbo.RetailCombined;
GO

-- Combine both years into one table
SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    COALESCE(
        TRY_CONVERT(datetime2, InvoiceDate, 105),
        TRY_CONVERT(datetime2, InvoiceDate, 120)
    ) AS InvoiceDate,
    TRY_CONVERT(decimal(10,2), Price) AS Price,
    Customer_ID,
    Country,
    '2009-2010' AS SourceSheet
INTO dbo.RetailCombined
FROM dbo.[year data 2009-2010]

UNION ALL

SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    COALESCE(
        TRY_CONVERT(datetime2, InvoiceDate, 105),
        TRY_CONVERT(datetime2, InvoiceDate, 120)
    ) AS InvoiceDate,
    TRY_CONVERT(decimal(10,2), Price) AS Price,
    Customer_ID,
    Country,
    '2010-2011' AS SourceSheet
FROM dbo.[data 2010-2011];
GO

-- Check total rows
SELECT COUNT(*) AS Total_Rows
FROM dbo.RetailCombined;

-- Check failed dates
SELECT COUNT(*) AS Failed_Dates
FROM dbo.RetailCombined
WHERE InvoiceDate IS NULL;

-- Check failed prices
SELECT COUNT(*) AS Failed_Prices
FROM dbo.RetailCombined
WHERE Price IS NULL;

USE customeranalysic;
GO

SELECT TOP 10 *
FROM dbo.RetailCombined;

SELECT SourceSheet, COUNT(*) AS Total_Rows
FROM dbo.RetailCombined
GROUP BY SourceSheet;