/*
 4. Get all Bands that have Albums
 
 There are multiple different ways to solve this problem, but they will all involve a join.
 
 Return the band name as Band Name.
 */
-- Solution(a)
SELECT DISTINCT bands.name AS 'Band Name'
FROM bands
    JOIN albums ON bands.id = albums.band_id;
-- Solution(b)
SELECT b.name AS 'Band Name'
FROM bands AS b
    LEFT JOIN albums AS a ON b.id = a.band_id
GROUP BY b.id
HAVING COUNT(a.id) > 0;