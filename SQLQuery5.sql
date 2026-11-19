select DB_NAME();
Use master;
select name
from sys.databases;
use customeranalysic;
go

-- CHECK 1: MISSING CUSTOMER ID

SELECT COUNT(*) AS Missing_CustomerID
FROM dbo.RetailCombined
WHERE Customer_ID IS NULL;


-- CHECK 2: NEGATIVE OR ZERO QUANTITY

SELECT COUNT(*) AS Negative_Qty
FROM dbo.RetailCombined
WHERE Quantity <= 0;


-- CHECK 3: MISSING DESCRIPTION

SELECT COUNT(*) AS Missing_Description
FROM dbo.RetailCombined
WHERE Description IS NULL;


-- CHECK 4: EXACT DUPLICATE ROWS

SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    Price,
    Customer_ID,
    Country,
    COUNT(*) AS ExactDuplicateCount
FROM dbo.RetailCombined
GROUP BY
    Invoice,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    Price,
    Customer_ID,
    Country
HAVING COUNT(*) > 1;
-- DEDUPLICATE AND PRODUCE THE FINAL CLEANED TABLE

WITH Deduped AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY
                Invoice,
                StockCode,
                Description,
                Quantity,
                InvoiceDate,
                Price,
                Customer_ID,
                Country
            ORDER BY (SELECT NULL)
        ) AS RowNum
    FROM dbo.RetailCombined
)
SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    Price,
    Customer_ID,
    Country,
    SourceSheet
INTO dbo.RetailCleaned
FROM Deduped
WHERE RowNum = 1;