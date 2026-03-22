DELIMITER //
CREATE PROCEDURE updateProduct(IN p_id INT, IN p_name VARCHAR(50))
BEGIN
    UPDATE Products SET productName = p_name WHERE Id = p_id;
END //
DELIMITER ;