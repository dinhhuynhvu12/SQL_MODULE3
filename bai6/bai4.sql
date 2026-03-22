CREATE VIEW product_info_view AS
SELECT productCode, productName, productPrice, productStatus
FROM Products; 
DROP VIEW product_info_view;