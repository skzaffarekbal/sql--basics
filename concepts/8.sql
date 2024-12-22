/*
 SQL HAVING Clause
 The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.
 */
SELECT b.id AS band_id,
    b.name AS band_name,
    COUNT(a.id) AS num_albums
FROM bands AS b
    LEFT JOIN albums AS a ON b.id = a.band_id
GROUP BY b.id
HAVING num_albums = 1;
-- Having with Order By
SELECT b.id AS band_id,
    b.name AS band_name,
    COUNT(a.id) as num_albums
FROM bands AS b
    LEFT JOIN albums AS a ON b.id = a.band_id
GROUP BY b.id
HAVING num_albums >= 1
ORDER BY num_albums ASC;
-- Having with Order By and Where
SELECT b.id AS band_id,
	b.name AS band_name,
    COUNT(a.id) AS num_albums
FROM bands AS b
	LEFT JOIN albums AS a ON b.id = a.band_id
WHERE b.name NOT IN ('Deuce')
GROUP BY b.id
HAVING num_albums >= 1
ORDER BY num_albums;