/*
 11. Select the longest Song off each Album
 
 Return the album name as Album, the album release year as Release Year, and the longest song length as Duration.
 */
SELECT a.id AS ID,
    a.name AS Name,
    a.release_year AS 'Release Year',
    MAX(s.length) AS Duration
FROM albums AS a
    LEFT JOIN songs AS s ON a.id = s.album_id
GROUP BY a.id;
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