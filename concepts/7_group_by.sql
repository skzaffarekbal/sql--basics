/*
 The GROUP BY statement groups rows that have the same values into summary rows, like "find the number of customers in each country".
 
 The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns.
 */
SELECT band_id,
    COUNT(band_id) AS albums
FROM albums
GROUP BY band_id;
SELECT albums.band_id,
    bands.name,
    COUNT(albums.band_id) AS albums
FROM albums
    JOIN bands ON albums.band_id = bands.id
GROUP BY band_id;
SELECT b.id AS band_id,
    b.name AS band_name,
    COUNT(a.id) AS num_albums
FROM bands AS b
    LEFT JOIN albums AS a ON b.id = a.band_id
GROUP BY b.id
ORDER BY num_albums DESC;