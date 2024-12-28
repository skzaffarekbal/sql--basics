/*
 Joins In SQL
 */
SELECT *
FROM bands;
SELECT *
FROM albums;
/*JOIN in SQL*/
SELECT *
FROM bands
    JOIN albums ON bands.id = albums.band_id;
/*JOIN with Alias*/
SELECT bands.id AS ID,
    bands.name AS band_name,
    albums.id AS album_id,
    albums.name AS album_name,
    albums.band_id
FROM bands
    JOIN albums ON bands.id = albums.band_id;
/*INNER JOIN work as JOIN*/
SELECT *
FROM bands
    INNER JOIN albums ON bands.id = albums.band_id;
/*LEFT JOIN*/
SELECT *
FROM bands
    LEFT JOIN albums ON bands.id = albums.band_id;
/*RIGHT JOIN*/
SELECT *
FROM albums
    RIGHT JOIN bands on bands.id = albums.band_id;