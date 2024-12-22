/*
 SQL Wildcards
 %	Represents zero or more characters
 _	Represents a single character
 []	Represents any single character within the brackets *
 ^	Represents any character not in the brackets *
 -	Represents any single character within the specified range *
 {}	Represents any escaped character **
 */
SELECT *
FROM albums
WHERE name LIKE '%er%';
SELECT *
FROM albums
WHERE name LIKE 'scar%';
SELECT *
FROM albums
WHERE release_year LIKE '201_';
SELECT *
FROM albums
WHERE release_year LIKE '2___';