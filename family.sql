CREATE TABLE family (
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL,
    birthYear INT,
    parentId INT,
    PRIMARY KEY(id),
    FOREIGN KEY(parentId) REFERENCES family(id)
);

INSERT INTO family (name, birthYear, parentId)
VALUES ('Abdul', 1940, null),
	('Jahur', 1970, 1),
    ('Zaffar', 1998,2),
    ('Tahur', 1972, 1),
    ('Noor', 1975, 1),
	('Vicky', 1998, 4),
	('Nasir', 2003, 5),
    ('Nesad', 2005, 5),
    ('Sabur', 1980, 1),
	('Jabur', 1988, 1),
	('Ahmad', 2015, 10),
    ('Jarina', 1955, null);