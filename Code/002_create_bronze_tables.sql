
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

