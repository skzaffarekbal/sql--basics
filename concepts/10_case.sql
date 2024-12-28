/*
 SQL CASE Expression
 The CASE expression goes through conditions and returns a value when the first condition is met (like an if-then-else statement). So, once a condition is true, it will stop reading and return the result. If no conditions are true, it returns the value in the ELSE clause.
 
 If there is no ELSE part and no conditions are true, it returns NULL.
 */
SELECT *
FROM albums;
SELECT a.id AS album_id,
    a.name AS album_name,
    b.name AS band_name,
    a.release_year,
    CASE
        WHEN a.release_year < 2000 THEN "90's Album"
        WHEN a.release_year >= 2000
        AND a.release_year <= 2010 THEN "New 20's Album"
        WHEN a.release_year > 2010
        AND a.release_year <= 2020 THEN 'ZenG Album'
        WHEN a.release_year > 2020
        AND a.release_year <= 2024 THEN 'New Album'
        ELSE 'Upcoming Album'
    END AS album_type
FROM albums AS a
    LEFT JOIN bands AS b ON a.band_id = b.id;