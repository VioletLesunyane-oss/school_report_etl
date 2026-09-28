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


/*====================================================================
    4. BRONZE LAYER
====================================================================

    Purpose:
    - Store the raw student marks data.
    - Split the source data into Grade 10, Grade 11 and Grade 12.
    - Preserve the source values without business transformations.
====================================================================*/

USE edutech_stg;
GO


/*--------------------------------------------------------------------
    4.1 GRADE 10 BRONZE TABLE
--------------------------------------------------------------------*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables AS a
    INNER JOIN sys.schemas AS b
        ON a.schema_id = b.schema_id
    WHERE b.name = 'bronze'
      AND a.name = 'prelim_science_students_marks_g10'
)
BEGIN

    CREATE TABLE bronze.prelim_science_students_marks_g10
    (
        student_id                   NVARCHAR(50),
        student_name                 NVARCHAR(200),
        grade                        NVARCHAR(10),
        mathematics_mark             DECIMAL(5,2),
        physical_science_mark        DECIMAL(5,2),
        life_sciences_mark            DECIMAL(5,2),
        english_home_language_mark   DECIMAL(5,2),
        life_orientation_mark        DECIMAL(5,2),
        information_technology_mark  DECIMAL(5,2),
        agricultural_science_mark    DECIMAL(5,2),
        total_mark                   DECIMAL(6,2),
        average_mark                 DECIMAL(5,2)
    );

END;
GO


/*--------------------------------------------------------------------
    Load Grade 10 records from the raw Bronze source table.

    10A and 10B are grouped together as Grade 10.
--------------------------------------------------------------------*/

INSERT INTO bronze.prelim_science_students_marks_g10
(
    student_id,
    student_name,
    grade,
    mathematics_mark,
    physical_science_mark,
    life_sciences_mark,
    english_home_language_mark,
    life_orientation_mark,
    information_technology_mark,
    agricultural_science_mark,
    total_mark,
    average_mark
)
SELECT
    student_id,
    student_name,
    grade,
    mathematics_mark,
    physical_science_mark,
    life_sciences_mark,
    english_home_language_mark,
    life_orientation_mark,
    information_technology_mark,
    agricultural_science_mark,
    total_mark,
    average_mark
FROM edutech_stg.bronze.prelim_science_students_marks
WHERE grade IN ('10A', '10B');
GO


/*--------------------------------------------------------------------
    4.2 GRADE 11 BRONZE TABLE
--------------------------------------------------------------------*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables AS a
    INNER JOIN sys.schemas AS b
        ON a.schema_id = b.schema_id
    WHERE b.name = 'bronze'
      AND a.name = 'prelim_science_students_marks_g11'
)
BEGIN

    CREATE TABLE bronze.prelim_science_students_marks_g11
    (
        student_id                   NVARCHAR(50),
        student_name                 NVARCHAR(200),
        grade                        NVARCHAR(10),
        mathematics_mark             DECIMAL(5,2),
        physical_science_mark        DECIMAL(5,2),
        life_sciences_mark            DECIMAL(5,2),
        english_home_language_mark   DECIMAL(5,2),
        life_orientation_mark        DECIMAL(5,2),
        information_technology_mark  DECIMAL(5,2),
        agricultural_science_mark    DECIMAL(5,2),
        total_mark                   DECIMAL(6,2),
        average_mark                 DECIMAL(5,2)
    );

END;
GO


/*--------------------------------------------------------------------
    Load Grade 11 records from the raw Bronze source table.

    11A and 11B are grouped together as Grade 11.
--------------------------------------------------------------------*/

INSERT INTO bronze.prelim_science_students_marks_g11
(
    student_id,
    student_name,
    grade,
    mathematics_mark,
    physical_science_mark,
    life_sciences_mark,
    english_home_language_mark,
    life_orientation_mark,
    information_technology_mark,
    agricultural_science_mark,
    total_mark,
    average_mark
)
SELECT
    student_id,
    student_name,
    grade,
    mathematics_mark,
    physical_science_mark,
    life_sciences_mark,
    english_home_language_mark,
    life_orientation_mark,
    information_technology_mark,
    agricultural_science_mark,
    total_mark,
    average_mark
FROM edutech_stg.bronze.prelim_science_students_marks
WHERE grade IN ('11A', '11B');
GO


/*--------------------------------------------------------------------
    4.3 GRADE 12 BRONZE TABLE
--------------------------------------------------------------------*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables AS a
    INNER JOIN sys.schemas AS b
        ON a.schema_id = b.schema_id
    WHERE b.name = 'bronze'
      AND a.name = 'prelim_science_students_marks_g12'
)
BEGIN

    CREATE TABLE bronze.prelim_science_students_marks_g12
    (
        student_id                   NVARCHAR(50),
        student_name                 NVARCHAR(200),
        grade                        NVARCHAR(10),
        mathematics_mark             DECIMAL(5,2),
        physical_science_mark        DECIMAL(5,2),
        life_sciences_mark            DECIMAL(5,2),
        english_home_language_mark   DECIMAL(5,2),
        life_orientation_mark        DECIMAL(5,2),
        information_technology_mark  DECIMAL(5,2),
        agricultural_science_mark    DECIMAL(5,2),
        total_mark                   DECIMAL(6,2),
        average_mark                 DECIMAL(5,2)
    );

END;
GO


/*--------------------------------------------------------------------
    Load Grade 12 records from the raw Bronze source table.

    12A and 12B are grouped together as Grade 12.
--------------------------------------------------------------------*/

INSERT INTO bronze.prelim_science_students_marks_g12
(
    student_id,
    student_name,
    grade,
    mathematics_mark,
    physical_science_mark,
    life_sciences_mark,
    english_home_language_mark,
    life_orientation_mark,
    information_technology_mark,
    agricultural_science_mark,
    total_mark,
    average_mark
)
SELECT
    student_id,
    student_name,
    grade,
    mathematics_mark,
    physical_science_mark,
    life_sciences_mark,
    english_home_language_mark,
    life_orientation_mark,
    information_technology_mark,
    agricultural_science_mark,
    total_mark,
    average_mark
FROM edutech_stg.bronze.prelim_science_students_marks
WHERE grade IN ('12A', '12B');
GO


/*====================================================================
    5. SILVER LAYER
====================================================================

    Purpose:
    - Prepare cleaned/structured data for analysis.
    - Separate the data into Grade 10, Grade 11 and Grade 12 tables.
    - TRUNCATE existing Silver data before reloading it.
      This performs a FULL REFRESH and prevents duplicate rows caused
      by repeatedly running the load script.

    Note:
    TRUNCATE removes the existing rows but keeps the table structure.
====================================================================*/


/*--------------------------------------------------------------------
    5.1 GRADE 10 SILVER TABLE
--------------------------------------------------------------------*/

USE edutech_dwh;
GO

-- Full refresh: remove existing Grade 10 Silver records.
TRUNCATE TABLE silver.prelim_science_students_marks_g10;
GO


IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables AS a
    INNER JOIN sys.schemas AS b
        ON a.schema_id = b.schema_id
    WHERE b.name = 'silver'
      AND a.name = 'prelim_science_students_marks_g10'
)
BEGIN

    CREATE TABLE silver.prelim_science_students_marks_g10
    (
        student_id                   NVARCHAR(50),
        student_name                 NVARCHAR(200),
        grade                        NVARCHAR(10),
        mathematics_mark             DECIMAL(5,2),
        physical_science_mark        DECIMAL(5,2),
        life_sciences_mark            DECIMAL(5,2),
        english_home_language_mark   DECIMAL(5,2),
        life_orientation_mark        DECIMAL(5,2),
        information_technology_mark  DECIMAL(5,2),
        agricultural_science_mark    DECIMAL(5,2),
        total_mark                   DECIMAL(6,2),
        average_mark                 DECIMAL(5,2)
    );

END;
GO


/*--------------------------------------------------------------------
    Load Grade 10 data from Bronze into Silver.

    B = Bronze source table
    S = Silver destination table

    Only Grade 10 records are loaded.
--------------------------------------------------------------------*/

INSERT INTO silver.prelim_science_students_marks_g10
(
    student_id,
    student_name,
    grade,
    mathematics_mark,
    physical_science_mark,
    life_sciences_mark,
    english_home_language_mark,
    life_orientation_mark,
    information_technology_mark,
    agricultural_science_mark,
    total_mark,
    average_mark
)
SELECT
    B.student_id,
    B.student_name,
    B.grade,
    B.mathematics_mark,
    B.physical_science_mark,
    B.life_sciences_mark,
    B.english_home_language_mark,
    B.life_orientation_mark,
    B.information_technology_mark,
    B.agricultural_science_mark,
    B.total_mark,
    B.average_mark
FROM edutech_stg.bronze.prelim_science_students_marks AS B
WHERE B.grade IN ('10A', '10B');
GO


/*--------------------------------------------------------------------
    5.2 GRADE 11 SILVER TABLE
--------------------------------------------------------------------*/

-- Full refresh: remove existing Grade 11 Silver records.
TRUNCATE TABLE silver.prelim_science_students_marks_g11;
GO


IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables AS a
    INNER JOIN sys.schemas AS b
        ON a.schema_id = b.schema_id
    WHERE b.name = 'silver'
      AND a.name = 'prelim_science_students_marks_g11'
)
BEGIN

    CREATE TABLE silver.prelim_science_students_marks_g11
    (
        student_id                   NVARCHAR(50),
        student_name                 NVARCHAR(200),
        grade                        NVARCHAR(10),
        mathematics_mark             DECIMAL(5,2),
        physical_science_mark        DECIMAL(5,2),
        life_sciences_mark            DECIMAL(5,2),
        english_home_language_mark   DECIMAL(5,2),
        life_orientation_mark        DECIMAL(5,2),
        information_technology_mark  DECIMAL(5,2),
        agricultural_science_mark    DECIMAL(5,2),
        total_mark                   DECIMAL(6,2),
        average_mark                 DECIMAL(5,2)
    );

END;
GO


/*--------------------------------------------------------------------
    Load Grade 11 data from Bronze into Silver.

    Only Grade 11 records are loaded.
--------------------------------------------------------------------*/

INSERT INTO silver.prelim_science_students_marks_g11
(
    student_id,
    student_name,
    grade,
    mathematics_mark,
    physical_science_mark,
    life_sciences_mark,
    english_home_language_mark,
    life_orientation_mark,
    information_technology_mark,
    agricultural_science_mark,
    total_mark,
    average_mark
)
SELECT
    B.student_id,
    B.student_name,
    B.grade,
    B.mathematics_mark,
    B.physical_science_mark,
    B.life_sciences_mark,
    B.english_home_language_mark,
    B.life_orientation_mark,
    B.information_technology_mark,
    B.agricultural_science_mark,
    B.total_mark,
    B.average_mark
FROM edutech_stg.bronze.prelim_science_students_marks AS B
WHERE B.grade IN ('11A', '11B');
GO


/*--------------------------------------------------------------------
    5.3 GRADE 12 SILVER TABLE
--------------------------------------------------------------------*/

-- Full refresh: remove existing Grade 12 Silver records.
TRUNCATE TABLE silver.prelim_science_students_marks_g12;
GO


IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables AS a
    INNER JOIN sys.schemas AS b
        ON a.schema_id = b.schema_id
    WHERE b.name = 'silver'
      AND a.name = 'prelim_science_students_marks_g12'
)
BEGIN

    CREATE TABLE silver.prelim_science_students_marks_g12
    (
        student_id                   NVARCHAR(50),
        student_name                 NVARCHAR(200),
        grade                        NVARCHAR(10),
        mathematics_mark             DECIMAL(5,2),
        physical_science_mark        DECIMAL(5,2),
        life_sciences_mark           DECIMAL(5,2),
        english_home_language_mark   DECIMAL(5,2),
        life_orientation_mark        DECIMAL(5,2),
        information_technology_mark  DECIMAL(5,2),
        agricultural_science_mark    DECIMAL(5,2),
        total_mark                   DECIMAL(6,2),
        average_mark                 DECIMAL(5,2)
    );

END;
GO


/*--------------------------------------------------------------------
    Load Grade 12 data from Bronze into Silver.

    Only Grade 12 records are loaded.
--------------------------------------------------------------------*/

INSERT INTO silver.prelim_science_students_marks_g12
(
    student_id,
    student_name,
    grade,
    mathematics_mark,
    physical_science_mark,
    life_sciences_mark,
    english_home_language_mark,
    life_orientation_mark,
    information_technology_mark,
    agricultural_science_mark,
    total_mark,
    average_mark
)
SELECT
    B.student_id,
    B.student_name,
    B.grade,
    B.mathematics_mark,
    B.physical_science_mark,
    B.life_sciences_mark,
    B.english_home_language_mark,
    B.life_orientation_mark,
    B.information_technology_mark,
    B.agricultural_science_mark,
    B.total_mark,
    B.average_mark
FROM edutech_stg.bronze.prelim_science_students_marks AS B
WHERE B.grade IN ('12A', '12B');
GO


/*====================================================================
    6. SILVER LAYER VALIDATION
====================================================================

    Purpose:
    Confirm that the three Silver tables contain the expected data
    after the Bronze-to-Silver loading process.
====================================================================*/


/*--------------------------------------------------------------------
    6.1 View Grade 10 Silver data
--------------------------------------------------------------------*/

SELECT *
FROM silver.prelim_science_students_marks_g10;
GO


/*--------------------------------------------------------------------
    6.2 View Grade 11 Silver data
--------------------------------------------------------------------*/

SELECT *
FROM silver.prelim_science_students_marks_g11;
GO


/*--------------------------------------------------------------------
    6.3 View Grade 12 Silver data
--------------------------------------------------------------------*/

SELECT *
FROM silver.prelim_science_students_marks_g12;
GO
