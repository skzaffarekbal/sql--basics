/*
 12. Get the number of Songs for each Band
 
 This is one of the toughest question on the list. It will require you to chain together two joins instead of just one.
 
 Return the band name as Band, the number of songs as Number of Songs.
 */
-- Solution (a)
SELECT bands.name AS Band,
    COUNT(songs.id) AS 'Number Of Songs'
FROM bands
    JOIN albums ON bands.id = albums.band_id
    JOIN songs ON albums.id = songs.album_id
GROUP BY bands.id;
-- Solution (b)
SELECT bands.name AS Band,
    SUM(album_songs) AS 'Number Of Songs'
FROM bands
    JOIN (
        SELECT albums.id AS album_id,
            albums.band_id,
            COUNT(songs.album_id) AS album_songs
        FROM albums
            JOIN songs ON albums.id = songs.album_id
        GROUP BY albums.id
    ) AS album_songs ON bands.id = album_songs.band_id
GROUP BY bands.id;