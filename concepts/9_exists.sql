/*
 SQL EXISTS Operator
 The EXISTS operator is used to test for the existence of any record in a subquery.
 
 The EXISTS operator returns TRUE if the subquery returns one or more records.
 
 Syntax :-
 SELECT column_name(s)
 FROM table_name
 WHERE EXISTS
 (SELECT column_name FROM table_name WHERE condition);
 */
SELECT *
FROM bands;
SELECT *
FROM albums;
SELECT id AS band_id,
    name AS band_name
FROM bands
WHERE EXISTS(
        SELECT id,
            name
        FROM albums
        WHERE albums.band_id = bands.id
    );
SELECT id AS band_id,
    name AS band_name
FROM bands
WHERE EXISTS(
        SELECT *
        FROM albums
        WHERE albums.band_id = bands.id
            AND albums.release_year BETWEEN 2000 AND 2020
    );
-- NOT EXIST
SELECT id AS band_id,
    name AS band_name
FROM bands
WHERE NOT EXISTS(
        SELECT *
        FROM albums
        WHERE albums.band_id = bands.id
    );