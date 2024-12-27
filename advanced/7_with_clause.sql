/* **************
   SQL WITH Clause Query
   Video URL - https://youtu.be/QNfnuK-1YYY?si=0PTeLnK4iUd6TGXK
 ************** */

/*
Insert data from smartProductSales.sql file
*/

/*
The WITH clause in SQL, also known as a Common Table Expression (CTE), is used to define a temporary named result set that can be referenced within the main query. This simplifies complex queries, improves readability, and avoids repeated code.

Syntax:
WITH cte_name (column1, column2, ...) AS (
    -- Subquery
    SELECT columns
    FROM table
    WHERE conditions
)
SELECT columns
FROM cte_name
WHERE conditions;

Temporary: The CTE exists only for the duration of the query.
Readable: Makes large, complex queries easier to understand.
Reusable: The CTE can be referenced multiple times within the same query.
Recursive Support: CTEs can be recursive, enabling queries for hierarchical or iterative operations.
*/

-- Fetch employees who earn more than average salary of all employees.
WITH averageSalary(avgSalary) AS 
(
	SELECT ROUND(AVG(salary)) FROM employeeCompanyA
)
SELECT * 
FROM employeeCompanyA A, averageSalary AVS
WHERE A.salary > AVS.avgSalary;

-- Fetch employees who earn less than average salary of all employees.
WITH averageSalary AS 
(
	SELECT ROUND(AVG(salary)) AS avgSalary FROM employeeCompanyA
)
SELECT * 
FROM employeeCompanyA A, averageSalary AVS
WHERE A.salary < AVS.avgSalary;


/*
Chaining Multiple CTEs:
You can define multiple CTEs in a single query.

WITH cte1 AS (
    SELECT col1, col2
    FROM table1
),
cte2 AS (
    SELECT col3, col4
    FROM table2
)
SELECT cte1.col1, cte2.col4
FROM cte1
JOIN cte2 ON cte1.col1 = cte2.col3;
*/

-- Find stores who's sales are better than average sales of all stores.

-- see smartProductSales table data.
SELECT * FROM smartProductSales;

-- Breakdown above question into small pieces.
-- a) Total sale of all store.
SELECT s.store_id, SUM(s.cost * s.quantity) AS totalSale
FROM smartProductSales s
GROUP BY s.store_id;

-- b) Average sale of all store.
SELECT ROUND(AVG(ss.totalSale)) AS avgSale
FROM (
	SELECT s.store_id, 
		SUM(s.cost * s.quantity) AS totalSale
	FROM smartProductSales s
	GROUP BY s.store_id
) ss;

-- C) Find sales better than Average sale.

SELECT * 
FROM (
	SELECT s.store_id, SUM(s.cost * s.quantity) AS totalSale
	FROM smartProductSales s
	GROUP BY s.store_id
) tss
JOIN (
	SELECT ROUND(AVG(ss.totalSale)) AS avgSale
	FROM (
		SELECT s.store_id, 
			SUM(s.cost * s.quantity) AS totalSale
		FROM smartProductSales s
		GROUP BY s.store_id
	) ss
) tavg ON tss.totalSale > tavg.avgSale;

-- Above Query using WITH clause

WITH totalStoreSales AS (
	SELECT s.store_id, 
		SUM(s.cost * s.quantity) AS totalSale
	FROM smartProductSales s
    GROUP BY s.store_id
),
totalAvgSales AS (
	SELECT ROUND(AVG(totalSale)) AS avgSale
    FROM totalStoreSales
)
SELECT * 
FROM totalStoreSales tss
JOIN totalAvgSales tavg ON tss.totalSale > tavg.avgSale;

