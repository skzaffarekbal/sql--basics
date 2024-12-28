/*
 Select data with Limit, Alias (AS), Order By (ASC/DESC)
 Select with Where Clause 
 And, Or, Between, Like
 */
/*Operation with bands table*/
SELECT *
FROM bands;
SELECT *
FROM bands
LIMIT 2;
SELECT name,
    id
FROM bands;
SELECT id AS 'ID',
    name AS 'Band Name'
FROM bands;
SELECT *
FROM bands
ORDER BY name ASC;
SELECT *
FROM bands
ORDER BY name DESC;
/*----------------------------------*/
/* Operation with Albums Table*/
SELECT *
FROM albums;
SELECT name
FROM albums;
SELECT DISTINCT name
FROM albums;
UPDATE albums
SET name = 'Test Album'
WHERE id = 5;
SELECT *
FROM albums
WHERE release_year < 2000;
SELECT *
FROM albums
WHERE name LIKE '%er%'
    OR band_id = 2;
SELECT *
FROM albums
WHERE release_year = 1984
    AND band_id = 1;
SELECT *
FROM albums
WHERE release_year BETWEEN 2000 AND 2018;
SELECT *
FROM albums
WHERE release_year IN (2018, 2010, 2021);
SELECT *
FROM albums
WHERE release_year IS NULL;
SELECT *
FROM albums
WHERE release_year IS NOT NULL;