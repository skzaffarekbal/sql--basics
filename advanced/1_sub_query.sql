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
-- Select the longest Song off each Album Detail with Song Detail
SELECT a.id AS 'Album Id',
    a.name AS 'Album Name',
    a.release_year AS 'Album Release',
    s.id AS 'Song Id',
    s.name AS 'Song Name',
    s.length AS 'Duration'
FROM albums AS a
    JOIN songs AS s ON a.id = s.album_id
    JOIN (
        SELECT album_id,
            MAX(length) AS max_length
        FROM songs
        GROUP BY album_id
    ) AS sl ON s.album_id = sl.album_id
    AND s.length = sl.max_length;
/*Use classicmodels and do sub query*/
USE classicmodels;
-- Sub-Query
SELECT productCode,
    productName,
    MSRP
FROM products
WHERE productCode IN (
        SELECT productCode
        FROM orderdetails
        WHERE priceEach < 100
    );