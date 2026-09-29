/*====================================================================
    EDUTECH DATA WAREHOUSE PROJECT
    Medallion Architecture: Staging → Bronze → Silver

    Purpose:
    - Create the staging and data warehouse databases.
    - Create the required Bronze, Silver and Gold schemas.
    - Split the raw student marks data by grade band.
    - Load Grade 10, Grade 11 and Grade 12 data into Bronze tables.
    - Load Bronze data into the corresponding Silver tables.
    - Use TRUNCATE for a full refresh of Silver tables.
====================================================================*/


/*--------------------------------------------------------------------
    1. CREATE STAGING DATABASE
--------------------------------------------------------------------*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.databases
    WHERE name = 'edutech_stg'
)
BEGIN
    CREATE DATABASE edutech_stg;
END;
GO


/*--------------------------------------------------------------------
    1.1 CREATE BRONZE SCHEMA IN THE STAGING DATABASE
--------------------------------------------------------------------*/

USE edutech_stg;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = 'bronze'
)
BEGIN
    EXECUTE ('CREATE SCHEMA bronze');
END;
GO


/*--------------------------------------------------------------------
    2. CREATE DATA WAREHOUSE DATABASE
--------------------------------------------------------------------*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.databases
    WHERE name = 'edutech_dwh'
)
BEGIN
    CREATE DATABASE edutech_dwh;
END;
GO


/*--------------------------------------------------------------------
    2.1 CREATE SILVER SCHEMA
--------------------------------------------------------------------*/

USE edutech_dwh;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = 'silver'
)
BEGIN
    EXECUTE ('CREATE SCHEMA silver');
END;
GO


/*--------------------------------------------------------------------
    2.2 CREATE GOLD SCHEMA
--------------------------------------------------------------------*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = 'gold'
)
BEGIN
    EXECUTE ('CREATE SCHEMA gold');
END;
GO



/*====================================================================
    3. VERIFY DATABASE SCHEMAS
====================================================================*/


/*--------------------------------------------------------------------
    3.1 Verify the Bronze schema in the staging database
--------------------------------------------------------------------*/

USE edutech_stg;
GO

SELECT
    name AS schema_name
FROM sys.schemas
WHERE name IN ('bronze', 'silver', 'gold');
GO


/*--------------------------------------------------------------------
    3.2 Verify the Silver and Gold schemas in the data warehouse
--------------------------------------------------------------------*/

USE edutech_dwh;
GO

SELECT
    name AS schema_name
FROM sys.schemas
WHERE name IN ('bronze', 'silver', 'gold');
GO



