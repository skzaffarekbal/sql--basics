/* **************
   SQL Window Function - Part #2
   Video URL - https://youtu.be/zAmJPdZu8Rg?si=02alYlmeVKGSfget
 ************** */

/*
Insert data from smartProduct.sql file
*/

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

-- Q.7 Write a query to segregate all the expensive phones, mid range phones and the cheaper phones.
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