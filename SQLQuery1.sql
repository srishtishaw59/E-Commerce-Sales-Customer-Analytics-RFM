create database customeranalysic;
USE customeranalysic;
GO
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

SELECT COUNT(*) AS total_rows
FROM dbo.[year data 2009-2010];

SELECT COUNT(*) AS total_rows
FROM dbo.[data 2010-2011];

