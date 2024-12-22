/*
 Sub Query is the another SQL query which is embedded with FROM, WHERE, HAVING and JOIN clause.
 */

-- Select all song detail which have length >= avg length 
SELECT *
FROM songs
WHERE length >= (
        SELECT AVG(length)
        FROM songs
    );