/*
 Create Table with Primary key and foreign key
 Insert data in Created Table.
 */
CREATE TABLE bands (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id) -- Primary Key of the table
);
CREATE TABLE albums (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    release_year INT,
    band_id INT NOT NULL,
    PRIMARY KEY (id),
    -- Primary Key of the table
    FOREIGN KEY (band_id) REFERENCES bands(id) -- Foreign Key of the table with references
);
/*-----------------------------------------------*/
/* Insert in bands*/
-- Insert One bands.
INSERT INTO bands (name)
VALUES ('Iron Maiden');
-- Insert Many bands.
INSERT INTO bands (name)
VALUES ('Deuce'),
    ('Avenged Sevenfold'),
    ('Ankor') ('Parks');
/* Show all bands.*/
SELECT *
FROM bands;
/*-----------------------------------------------*/
/*Insert in albums*/
INSERT INTO albums (name, release_year, band_id)
VALUES ('The Number Of The Beast', 1985, 1),
    ('Power Slave', 1984, 1),
    ('Nightmare', 2018, 2),
    ('Nightmare', 2010, 3),
    ('Nightmare', NULL, 3);
INSERT INTO albums(name, release_year, band_id)
VALUES ('Scare To Beautiful', 2021, 4);
INSERT INTO albums (name, release_year, band_id)
VALUES ('Love Story', 2014, 10);
/* Show all albums.*/
SELECT *
FROM albums;
/*Update an album*/
UPDATE albums
SET name = 'Test Album'
WHERE id = 5;
/*Insert Same Record*/
INSERT INTO albums(name, release_year, band_id)
VALUES ('Scare To Beautiful', 2021, 4);
/*Delete an album*/
DELETE FROM albums
WHERE id = 7;
SELECT *
FROM albums;