/* 
 Create, Drop and Use Database
 Create, Alter, Drop Table
 */
CREATE DATABASE record_company;
-- To Create a Database.
DROP DATABASE record_company;
-- To Delete the Database
CREATE DATABASE record_company;
USE record_company;
-- To Use a Database
CREATE TABLE test (test_column INT);
-- To Create a Table
ALTER TABLE test
ADD another_column VARCHAR(255);
-- To update the table
DROP TABLE test;
-- To drop the table.