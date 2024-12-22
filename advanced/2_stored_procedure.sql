------------------------------------------------------------

-- Stored Procedure
-- a) Top 10 Most Profitable Products 
DELIMITER &&
CREATE PROCEDURE sp_top10ProfitableProducts()
BEGIN
SELECT productName, 
	productLine, 
	productVendor, 
	productDescription,
    quantityInStock,
    buyPrice,
    MSRP,
    (MSRP-buyPrice) AS Profit
FROM products
ORDER BY Profit DESC
LIMIT 10;
END &&
DELIMITER ;

CALL sp_top10ProfitableProducts();

------------------------------------------------------------

-- b) SP Using IN Operator
-- Dynamic Rank with Dynamic Type Profitable Products
DELIMITER &&
CREATE PROCEDURE sp_dynamicProfitRankOnProductType(IN productType VARCHAR(32), 
IN rankNumber INT)
BEGIN
SELECT RANK() OVER(ORDER BY (MSRP-buyPrice) DESC) AS Ranks,
	productName, 
	productLine, 
	productVendor, 
	productDescription,
    quantityInStock,
    buyPrice,
    MSRP,
    (MSRP-buyPrice) AS Profit
FROM products
WHERE productLine = productType
LIMIT rankNumber;
END &&
DELIMITER ;

CALL sp_dynamicProfitRankOnProductType("Motorcycles", 5);

------------------------------------------------------------

-- c) SP Using IN Operator
-- Dynamically update an attribute of the products table value

DELIMITER &&
CREATE PROCEDURE sp_dynamicProductPriceUpdate(IN inputProductCode VARCHAR(15),
IN keyName VARCHAR(20), IN keyValue FLOAT)
BEGIN
	-- Declare a variable to hold the SQL query.
	DECLARE sql_query VARCHAR(255);
	-- Construct the SQL query dynamically.
	SET @sql_query = CONCAT('UPDATE products SET `', keyName, '` = ', QUOTE(keyValue), ' WHERE productCode = ', QUOTE(inputProductCode));
	-- Prepare and execute the SQL statement.
	PREPARE stmt FROM @sql_query;
	EXECUTE stmt;
	-- Deallocate the prepared statement.
	DEALLOCATE PREPARE stmt;
END &&
DELIMITER ;

CALL sp_dynamicProductPriceUpdate('S10_1678', 'buyPrice', 48.80);

------------------------------------------------------------

-- d) SP Using both OUT and IN Operator
-- Dynamic Count for specific productLine

DELIMITER &&
CREATE PROCEDURE sp_countOfSpecificProduct(IN productType VARCHAR(32), OUT productCount INT)
BEGIN
	IF productType = 'All' THEN
		SELECT COUNT(productCode) INTO productCount
		FROM products;
	ELSE
        SELECT COUNT(productCode) INTO productCount
		FROM products
		WHERE productLine = productType;
	END IF;
END &&
DELIMITER ;

CALL sp_countOfSpecificProduct('Motorcycles', @motorCycleCount);
CALL sp_countOfSpecificProduct('Classic Cars', @classicCarCount);
CALL sp_countOfSpecificProduct('Vintage Cars', @vintageCarCount);
CALL sp_countOfSpecificProduct('Trucks and Buses', @truckBusCount);
CALL sp_countOfSpecificProduct('Ships', @shipCount);
CALL sp_countOfSpecificProduct('Trains', @trainCount);
CALL sp_countOfSpecificProduct('Planes', @planeCount);
CALL sp_countOfSpecificProduct('All', @allCount);

SELECT @motorCycleCount AS motorCycleCount,
	@classicCarCount AS classicCarCount,
    @vintageCarCount AS vintageCarCount,
    @truckBusCount AS truckBusCount,
    @shipCount AS shipCount,
    @trainCount AS trainCount,
    @planeCount AS planeCount,
    @allCount AS allCount;

------------------------------------------------------------

-- Use to drop a procedure.
DROP PROCEDURE sp_dynamicProductPriceUpdates;
