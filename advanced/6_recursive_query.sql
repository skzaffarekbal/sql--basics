/* **************
   SQL Recursive Query
   Video URL - https://youtu.be/7hZYh9qXxe4?si=iEHTgFkc8S_hM7Se
 ************** */

/*
Use classicmodels employees table
*/

/*
- A recursive query in SQL is a query that refers to itself in its definition. This is typically done using a Common Table Expression (CTE) with the WITH keyword. Recursive queries are commonly used for hierarchical or graph-based data, such as organizational charts or finding parent-child relationships.

Syntax : 

WITH [RECURSIVE] cte_name AS 
    (
        SELECT query (Non Recursive query or the Base query)

            UNION [ALL]

        SELECT query (Recursive query using cte_name [with a terminal condition])
    )
SELECT * FROM cte_name;


Key Points:

-> Termination: Recursive queries terminate when the recursive member returns no rows.
To avoid infinite recursion, ensure there is a stopping condition (e.g., no more children).

-> Union vs Union All: Use UNION ALL unless you need to eliminate duplicates (using UNION).

-> Performance: Recursive queries can be resource-intensive. Add filters or limits (LIMIT, WHERE) to control recursion depth.

-> Depth Control: Add a "level" column or a stopping condition to limit recursion.

*/

-- Example Queries

-- Q1. Display number from 1 to 10 without using any in build functions.
WITH RECURSIVE numbers AS 
(
	SELECT 1 AS num
    UNION
    SELECT num + 1 FROM numbers WHERE num < 10 
)
SELECT * FROM numbers;

-- Q2. Summing n Numbers (Recursive Query) n = 100
WITH RECURSIVE numbers AS
(
	SELECT 1 AS n
    UNION
    SELECT n + 1 FROM numbers WHERE n < 100
)
SELECT SUM(n) AS totalSum,
	ROUND(AVG(n), 2) AS average,
    MIN(n) AS minNumber,
    MAX(n) AS maxNumber
FROM numbers;

-- Q3. Find the hierarchy of employees.

WITH RECURSIVE employee_hierarchy AS (
    -- Anchor member: Start with employees who do not report to anyone
    SELECT 
        employeeNumber, 
        CONCAT(firstName , ' ', lastName) AS name,
        jobTitle, 
        reportsTo,
        1 AS level
    FROM employees 
    WHERE reportsTo IS NULL

    UNION ALL

    -- Recursive member: Find employees reporting to the current hierarchy level
    SELECT 
        E.employeeNumber, 
        CONCAT(E.firstName , ' ', E.lastName) AS name,
        E.jobTitle, 
        E.reportsTo,
        H.level + 1 AS level
    FROM employees E
    JOIN employee_hierarchy H ON E.reportsTo = H.employeeNumber
)
SELECT * FROM employee_hierarchy;

-- Q4. Find the hierarchy of employees with their respective manager.

WITH RECURSIVE employee_hierarchy AS
(
	SELECT employeeNumber,
		CONCAT(firstName, ' ', lastName) AS employeeName,
        jobTitle,
        reportsTo,
        1 AS level
	FROM employees
    WHERE reportsTo IS NULL
    UNION ALL
    SELECT E.employeeNumber,
		CONCAT(E.firstName, ' ', E.lastName) AS employeeName,
        E.jobTitle,
        E.reportsTo,
        H.level + 1 AS level
	FROM employees AS E
		JOIN employee_hierarchy H ON E.reportsTo = H.employeeNumber
)
-- SELECT * FROM employee_hierarchy
SELECT EH.employeeName,
	EH.jobTitle,
	CONCAT(ES.firstName, ' ', ES.lastName) AS managerName,
    EH.level
FROM employee_hierarchy AS EH
	LEFT JOIN employees ES ON ES.employeeNumber = EH.reportsTo;

-- Q5. Find the hierarchy of employees under a given manager (employeeNumber = 1076).

WITH RECURSIVE employee_hierarchy AS (
    -- Anchor member: Start with employees who do not report to anyone
    SELECT 
        employeeNumber, 
        CONCAT(firstName , ' ', lastName) AS name,
        jobTitle, 
        reportsTo,
        1 AS level
    FROM employees 
    WHERE employeeNumber = 1056

    UNION ALL

    -- Recursive member: Find employees reporting to the current hierarchy level
    SELECT 
        E.employeeNumber, 
        CONCAT(E.firstName , ' ', E.lastName) AS name,
        E.jobTitle, 
        E.reportsTo,
        H.level + 1 AS level
    FROM employee_hierarchy H
    JOIN employees E ON E.reportsTo = H.employeeNumber
)
-- SELECT * FROM employee_hierarchy;
SELECT EH.employeeNumber,
	EH.name,
	EH.jobTitle,
	CONCAT(ES.firstName, ' ', ES.lastName) AS managerName,
    EH.reportsTo AS managerId,
    EH.level
FROM employee_hierarchy AS EH
	LEFT JOIN employees ES ON ES.employeeNumber = EH.reportsTo;

-- Q6. Find the hierarchy of managers for a given employee. (employeeNumber = 1702).

WITH RECURSIVE employee_hierarchy AS
(
	SELECT employeeNumber,
		CONCAT(firstName, ' ', lastName) AS employeeName,
        jobTitle,
        reportsTo,
        1 AS level
	FROM employees
    WHERE employeeNumber = 1702
    UNION ALL
    SELECT E.employeeNumber,
		CONCAT(E.firstName, ' ', E.lastName) AS employeeName,
        E.jobTitle,
        E.reportsTo,
        H.level + 1 AS level
	FROM employees AS E
		JOIN employee_hierarchy H ON H.reportsTo = E.employeeNumber
)
-- SELECT * FROM employee_hierarchy
SELECT EH.employeeNumber,
	EH.employeeName,
	EH.jobTitle,
	CONCAT(ES.firstName, ' ', ES.lastName) AS managerName,
    EH.reportsTo AS managerId,
    EH.level
FROM employee_hierarchy AS EH
	LEFT JOIN employees ES ON ES.employeeNumber = EH.reportsTo;
