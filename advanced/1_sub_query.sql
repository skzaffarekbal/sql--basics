/*
 Sub Query is the another SQL query which is embedded with FROM, WHERE, HAVING and JOIN clause.

 Types of Sub-query
 1) Scalar Or Single Row Sub-query (Return only One Row and One Column)
 2) Multi Row Sub-query
    a) Return Multi Column and Multi Row.
    b) Return One Column and Multi Row.
 3) Correlated Subquery (A query which related to the outer query.) 
 4) Nested Query
 */

-- 1 Single Row Sub-query (Return only One Row and One Column)
-- Select all song detail which have length >= avg length 
SELECT *
FROM songs
WHERE length >= (
        SELECT AVG(length)
        FROM songs
    );

-- Select the longest Song off each Album Detail with Song Detail

-- 2(b) Multi Row Sub-query (Return Multi Column and Multi Row)
-- ans 1
SELECT A.id AS 'Album Id',
    A.name AS 'Album Name',
    A.release_year AS 'Album Release',
    S.id AS 'Song Id',
    S.name AS 'Song Name',
    S.length AS 'Duration'
FROM songs S
JOIN albums A ON a.id = S.album_id
WHERE (length, album_id) IN (
	SELECT max(length), album_id
    FROM songs
    GROUP BY album_id
)
-- ans 2
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
-- 2(b) Multi Row Sub-query (Return One Column and Multi Row)
-- Correlated Subquery
SELECT productCode,
    productName,
    MSRP
FROM products
WHERE productCode IN (
        SELECT productCode
        FROM orderdetails
        WHERE priceEach < 100
    );

/* Nested Query */

/*
Insert data from smartProductSales.sql file
*/
-- Find stores whose sales better than average sale of all stores.
SELECT *
FROM (
	SELECT store_id, 
		store_name,
		SUM(quantity * cost) AS storeSale 
	FROM smartProductSales
	GROUP BY store_id, store_name
) tss
JOIN (
	SELECT round(avg(ss.storeSale)) AS totalAvgSale
	FROM (
		SELECT store_id, 
			SUM(quantity * cost) AS storeSale 
		FROM smartProductSales
		GROUP BY store_id
	) ss
) tavs
ON tss.storeSale > tavs.totalAvgSale;