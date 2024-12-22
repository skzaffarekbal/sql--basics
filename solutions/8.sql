/*
 8. Insert a record for your favorite Band and one of their Albums
 Solution
 
 If you performed this correctly you should be able to now see that band and album in your tables.
 */
SELECT *
FROM bands;
INSERT bands(name)
VALUES('Your Band');
SELECT *
FROM albums;
INSERT albums(name, release_year, band_id)
VALUES('Your Album', 2020, 8);