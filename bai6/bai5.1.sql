DELIMITER //
CREATE PROCEDURE addProduct(
    IN p_code VARCHAR(20), 
    IN p_name VARCHAR(50), 
    IN p_price DECIMAL(10,2), 
    IN p_amount INT)
BEGIN
    INSERT INTO Products(productCode, productName, productPrice, productAmount)
    VALUES (p_code, p_name, p_price, p_amount);
END //
DELIMITER ;