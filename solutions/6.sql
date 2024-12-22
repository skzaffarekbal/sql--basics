/*
 6. Get the Longest Album
 
 This problem sounds a lot like #3 but the solution is quite a bit different. I would recommend looking up the SUM aggregate function.
 
 Return the album name as Name, the album release year as Release Year, and the album length as Duration.
 */
SELECT a.id AS ID,
    a.name AS 'Album Name',
    a.release_year AS 'Release Year',
    SUM(s.length) AS Duration
FROM albums AS a
    LEFT JOIN songs AS s ON a.id = s.album_id
GROUP BY a.id
ORDER BY Duration DESC
LIMIT 1;