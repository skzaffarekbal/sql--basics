/* **************
   SQL Window Function - Part #2
   Video URL - https://youtu.be/zAmJPdZu8Rg?si=02alYlmeVKGSfget
 ************** */

/*
Insert data from smartProduct.sql file
*/

/*
- The FIRST_VALUE() function retrieves the first value in the specified window or partition, based on the ORDER BY clause.

FIRST_VALUE(column_name) OVER (PARTITION BY column_name ORDER BY column_name)

- The LAST_VALUE() function retrieves the last value in the specified window or partition, based on the ORDER BY clause.

LAST_VALUE(column_name) OVER (PARTITION BY column_name ORDER BY column_name)

Note: For LAST_VALUE(), you often need to specify a window frame (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) to avoid returning intermediate results within the default frame.
*/

/*
FRAME CLAUS

- The frame clause in SQL defines a subset of rows (a "window frame") within the result set for window functions like SUM(), AVG(), ROW_NUMBER(), etc. It specifies which rows relative to the current row should be included in the calculation.

- Frame Clause Components: A frame clause consists of two parts.

1) Frame type: Determines the type of rows in the frame
	a) ROWS: Specifies rows relative to the current row.
	b) RANGE: Specifies a logical range of rows based on the ORDER BY values.

2) Frame boundaries: Define the start and end of the frame.
	a) UNBOUNDED PRECEDING: From the first row in the partition.
	b) CURRENT ROW: From the current row.
	c) N PRECEDING or N FOLLOWING: N rows before or after the current row.
	d) UNBOUNDED FOLLOWING: Till the last row in the partition.

Syntax : 

<window_function>() OVER (
  PARTITION BY column_name
  ORDER BY column_name
  {ROWS | RANGE} BETWEEN <frame_start> AND <frame_end>
)

Example: 

SELECT EmployeeID, Salary,
       SUM(Salary) OVER (
         PARTITION BY Department
         ORDER BY Salary
         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS Rolling_Sum
FROM Employees;

This calculates a rolling sum of salaries for each department and the frame includes the current row and the two preceding rows.
*/


/* FIRST_VALUE() & LAST_VALUE()*/
SELECT * FROM smartProduct;
/* FIRST_VALUE() Window Function */
-- Q.4 Write query to display the most expensive smartProduct under each category (corresponding to each record) 
SELECT *,
	FIRST_VALUE(product_name) OVER(PARTITION BY product_category ORDER BY price DESC) AS most_exp_product
FROM smartProduct;

/* LAST_VALUE() Window Function */
-- For LAST_VALUE() to get desire result we use Frame
-- Frame -> RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- Frame -> RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING

-- Q.5 Write query to display the least expensive smartProduct under each category (corresponding to each record)
SELECT *,
	LAST_VALUE(product_name) 
		OVER(
			PARTITION BY product_category ORDER BY price DESC
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
		) 
	AS least_exp_product
FROM smartProduct;

-- Q.4 & Q.5 for phone only
SELECT *,
	FIRST_VALUE(product_name) 
		OVER(
			PARTITION BY product_category ORDER BY price DESC
            ) AS most_exp_product,
	LAST_VALUE(product_name) 
		OVER(
			PARTITION BY product_category ORDER BY price DESC
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
			) AS least_exp_product
FROM smartProduct
WHERE product_category = 'Phone';

-- Alternative way for writing above query
SELECT *,
	FIRST_VALUE(product_name) OVER w AS most_exp_product,
	LAST_VALUE(product_name) OVER w AS least_exp_product
FROM smartProduct
WHERE product_category = 'Phone'
WINDOW w AS (
	PARTITION BY product_category ORDER BY price DESC
	RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
);




/* NTH_VALUE() Window Function */

/*
- The NTH_VALUE() window function in SQL retrieves the value of the Nth row within a specified window or partition. It allows you to extract a specific row's value, based on the order defined by the ORDER BY clause.

Syntax :
NTH_VALUE(column_name, N) OVER (
  PARTITION BY column_name
  ORDER BY column_name
  {ROWS | RANGE} BETWEEN <frame_start> AND <frame_end>
)

Note :
- If there are fewer than N rows in the window, NTH_VALUE() returns NULL.
- NTH_VALUE() respects the window frame, so using a specific frame clause (e.g., ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) is critical to getting the desired result.
- It's different from FIRST_VALUE() or LAST_VALUE(), as it lets you specify any position (Nth), not just the first or last.
*/

-- Q.6 Query to display 2nd Most expensive product under each category.
SELECT *,
	FIRST_VALUE(product_name) OVER w AS most_exp_product,
	LAST_VALUE(product_name) OVER w AS least_exp_product,
    NTH_VALUE(product_name, 2) OVER w AS second_exp_product
FROM smartProduct
WINDOW w AS (
	PARTITION BY product_category ORDER BY price DESC
	RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
);



/* NTILE() Window Function */

/*
- The NTILE() window function in SQL divides the rows of a result set into a specified number of approximately equal-sized buckets (or groups) and assigns a bucket number to each row.

Syntax : 

NTILE(num_buckets) OVER (
  PARTITION BY column_name
  ORDER BY column_name
)

- num_buckets: The number of buckets to divide the rows into.
- PARTITION BY: Divides the result set into partitions (optional).
- ORDER BY: Determines the order in which rows are assigned to buckets.

- NTILE() splits the rows evenly across buckets, ensuring as much balance as possible:
- If the rows cannot be evenly divided, the buckets with fewer rows are placed at the end.
- Each bucket is assigned a number from 1 to num_buckets.

NOTE :
- Uneven Rows: If the total rows are not divisible by num_buckets, the first buckets will have one extra row.
- Partitioning: If PARTITION BY is used, the buckets are created independently for each partition.
- Order of Rows: The ORDER BY clause defines the sequence in which rows are assigned to buckets.
*/

SELECT * ,
	NTILE(3) OVER(PARTITION BY product_category ORDER BY price DESC)
FROM smartProduct

-- Q.7 Write a query to segregate all the expensive phones, mid range phones and the cheaper phone.
SELECT x.brand, 
	x.product_name, 
    x.price,
    CASE WHEN x.bucket = 1 THEN 'Expensive'
		WHEN x.bucket = 2 THEN 'Mid Range'
        WHEN x.bucket = 3 THEN 'Cheaper'
	END budget_type
FROM (SELECT *,
	NTILE(3) OVER(ORDER BY price DESC) AS bucket
FROM smartProduct
WHERE product_category = 'Phone') x;

-- Q.8 Write a query to segregate all the expensive, mid range and the cheaper product.
SELECT p.product_category AS category,
	p.brand AS brand,
    p.product_name AS name,
    p.price AS price,
    CASE WHEN p.bucket = 1 THEN "Expensive"
		WHEN p.bucket = 2 THEN "Mid Range"
        WHEN p.bucket = 3 THEN "Cheaper"
    END AS budget
FROM (SELECT * ,
	NTILE(3) OVER(PARTITION BY product_category ORDER BY price DESC) AS bucket
FROM smartProduct) AS p;



/* CUME_DIST() Window Function */

/*
- The CUME_DIST() (Cumulative Distribution) window function in SQL calculates the relative position of a row within a result set or partition as a cumulative distribution, representing the proportion of rows with values less than or equal to the current row.

Syntax:
CUME_DIST() OVER (
  PARTITION BY column_name
  ORDER BY column_name
)

- PARTITION BY: Divides the result set into partitions (optional).
- ORDER BY: Specifies the order for calculating cumulative distribution.

How It Works:
Formula:

CUME_DIST = (Number of rows with values less than or equal to the current row)/(Total number of rows in the partition)
​
Returns a value between 0 and 1:

0: Before the first row.
1: At or after the last row.


Key Notes:
- Cumulative: It includes all rows up to and including the current row in the calculation.
- Ties: Rows with the same value (ties) receive the same cumulative distribution value.
- Partitioning: If PARTITION BY is specified, CUME_DIST() resets for each partition.
- Use Case: Useful for identifying percentiles or analyzing data distributions.
*/

SELECT *,
	CUME_DIST() OVER(ORDER BY price DESC) AS CumeDistribution,
	ROUND(CUME_DIST() OVER(ORDER BY price DESC) * 100, 2) AS CumeDistPer
FROM smartProduct;

-- Q.9 Query to fetch all products which are constituting the first 30% of the data in product table based on price

SELECT p.product_category AS category,
	p.brand AS brand,
    p.product_name AS name,
    p.price AS price,
    p.CumeDistribution,
    CONCAT(p.CumeDistPer, '%') AS CumeDistPercentage
FROM (
	SELECT *,
		CUME_DIST() OVER(ORDER BY price DESC) AS CumeDistribution,
		ROUND(CUME_DIST() OVER(ORDER BY price DESC) * 100, 2) AS CumeDistPer
	FROM smartProduct
) AS p
WHERE p.CumeDistPer <= 30;





/* PERCENT_RANK() Window Function */

/*
- The PERCENT_RANK() window function in SQL calculates the relative rank of a row within a result set as a percentage. The value returned by PERCENT_RANK() ranges from 0 to 1.

Syntax:

PERCENT_RANK() OVER (
    PARTITION BY column_name
    ORDER BY column_name
)

- PARTITION BY: Divides the result set into partitions for the calculation (optional).
- ORDER BY: Specifies the column to determine the ranking order.

How It Works:
Formula:
PERCENT_RANK = (Rank of current row−1) / (Total rows in partition−1)

- The first row has a rank of 0, and the last row has a rank of 1 (if the partition has more than one row).
- For a single-row partition, the value is always 0.

Key Notes:

- Relative Ranking: The percentage rank is relative to other rows in the partition.
- Ties: Rows with the same value in the ORDER BY column have the same rank, and subsequent rows skip ranks.
- Partitions: If PARTITION BY is used, the function calculates the rank independently for each partition.
- Difference from CUME_DIST():
PERCENT_RANK() starts at 0 and is based on rank.
CUME_DIST() starts at 1/Total Rows and is cumulative.
*/

SELECT *,
	PERCENT_RANK() OVER(ORDER BY price) AS PercentDecimal,
    ROUND(PERCENT_RANK() OVER(ORDER BY price) * 100, 2) AS PercentRank
FROM smartProduct;

-- Q.10 Query to identify how much percentage more expensive is 'Galaxy Z Fold 3' when compare to all Product.

SELECT product_name,
	PercentRank
FROM (
	SELECT *,
		PERCENT_RANK() OVER(ORDER BY price) AS PercentDecimal,
		ROUND(PERCENT_RANK() OVER(ORDER BY price) * 100, 2) AS PercentRank
	FROM smartProduct
) p
WHERE p.product_name = 'Galaxy Z Fold 3';
