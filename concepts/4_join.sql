/*
 Joins In SQL
 */
SELECT *
FROM bands;
SELECT *
FROM albums;
/*JOIN in SQL*/
SELECT *
FROM bands
    JOIN albums ON bands.id = albums.band_id;
/*JOIN with Alias*/
SELECT bands.id AS ID,
    bands.name AS band_name,
    albums.id AS album_id,
    albums.name AS album_name,
    albums.band_id
FROM bands
    JOIN albums ON bands.id = albums.band_id;
/*INNER JOIN work as JOIN :- Join those are math the condition.*/
SELECT *
FROM bands
    INNER JOIN albums ON bands.id = albums.band_id;
/*LEFT JOIN = INNER JOIN + Primary Table Row those are not matched the Join condition.*/
SELECT *
FROM bands
    LEFT JOIN albums ON bands.id = albums.band_id;
/*RIGHT JOIN = INNER JOIN + Secondary Table Row those are not matched the join Condition.*/
SELECT *
FROM albums
    RIGHT JOIN bands on bands.id = albums.band_id;

/*
FULL JOIN : Which combines the results of a LEFT JOIN and a RIGHT JOIN, including all records from both tables, even if there’s no match between them. This query will work as long as your database supports FULL JOIN. 
-- However, MySQL does not natively support FULL JOIN. If you're running this in MySQL, you'll encounter an error.
*/

-- If FULL JOIN is Supported (e.g., PostgreSQL):
SELECT bands.id AS ID,
    bands.name AS band_name,
    albums.id AS album_id,
    albums.name AS album_name,
    albums.band_id
FROM bands
FULL JOIN albums ON bands.id = albums.band_id;

-- Fix for MySQL (if  FULL JOIN not supported)
SELECT bands.id AS ID,
       bands.name AS band_name,
       albums.id AS album_id,
       albums.name AS album_name,
       albums.band_id
FROM bands
LEFT JOIN albums ON bands.id = albums.band_id

UNION

SELECT bands.id AS ID,
       bands.name AS band_name,
       albums.id AS album_id,
       albums.name AS album_name,
       albums.band_id
FROM bands
RIGHT JOIN albums ON bands.id = albums.band_id;


/*
A CROSS JOIN in SQL produces the Cartesian product of two tables, meaning every row from the first table is combined with every row from the second table. It does not require a joining condition.

Key Points:
- Row Combinations: If table1 has m rows and table2 has n rows, the result will have m * n rows.
- No ON Clause: Unlike other joins, CROSS JOIN does not use an ON condition.
- Use Cases: Generating combinations (e.g., pairing all items with all dates).
Performing operations like permutations.

- Equivalent Using Comma: This also produces a Cartesian product but is considered less readable than CROSS JOIN.
*/

SELECT *
FROM bands
    cross JOIN albums;
    
SELECT *
FROM bands, albums;

/*
SELF JOIN : A self-join in SQL is when a table is joined with itself. This allows you to compare rows within the same table. It is often used to find relationships within hierarchical data or to compare rows in scenarios like finding duplicates or pairs.
*/

/* For this query insert family.sql DB*/

SELECT * FROM family;

/* Simple Self Join */
SELECT child.name AS childName,
	child.birthYear AS birthYear,
    parent.name AS parentName
FROM family child
JOIN family parent ON child.parentId = parent.id;

/* Left Self Join*/
SELECT child.name AS childName,
	child.birthYear AS birthYear,
    parent.name AS parentName
FROM family child
LEFT JOIN family parent ON child.parentId = parent.id;

/*Right Self Join*/
SELECT child.name AS childName,
	child.birthYear AS birthYear,
    parent.name AS parentName
FROM family child
RIGHT JOIN family parent ON child.parentId = parent.id;