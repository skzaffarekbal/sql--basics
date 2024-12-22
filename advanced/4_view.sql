DROP VIEW product_description;

CREATE VIEW productAllDetails
AS
SELECT p.productCode,
	p.productName,
    p.quantityInStock,
    p.buyPrice,
    p.MSRP,
    p.productDescription,
    p.productLine,
    pl.textDescription AS overAllDescription
    FROM products AS p
    INNER JOIN productlines AS pl ON p.productLine = pl.productLine;

SELECT * FROM productAllDetails;

/*---------------------Rename------------------------------*/
RENAME TABLE productAllDetails TO vehicleAllDetails;
SELECT * FROM vehicleAllDetails;

# Display Views
SHOW FULL tables;

SHOW FULL tables
WHERE Table_type = 'VIEW';

SHOW FULL tables
WHERE Table_type = 'BASE TABLE';