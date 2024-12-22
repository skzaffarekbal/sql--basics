/*
 9. Delete the Band and Album you added in #8
 
 The order of how you delete the records is important since album has a foreign key to band.
 */
DELETE FROM albums
WHERE id = 19;
SELECT *
FROM albums;
DELETE FROM bands
WHERE id = 8;
SELECT *
FROM bands;