/*
 5. Get all Bands that have No Albums
 
 This is very similar to #4 but will require more than just a join.
 
 Return the band name as Band Name.
 */
-- Solution (a)
SELECT b.name AS 'Band Name'
FROM bands AS b
    LEFT JOIN albums AS a ON b.id = a.band_id
WHERE a.id IS NULL
    AND a.band_id IS NULL;
-- Solution (b)
SELECT b.name AS 'Band Name'
FROM bands AS b
    LEFT JOIN albums AS a ON b.id = a.band_id
GROUP BY b.id
HAVING COUNT(a.id) = 0;