CREATE DATABASE sql_task_3;

-- CREATE TABLE PRODUCT
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0
);

-- PROCEDURE TO ADD NEW PRODUCT IN THE INVENTORY
DELIMITER //

CREATE PROCEDURE AddProduct(
    IN p_name VARCHAR(100),
    IN p_category VARCHAR(50),
    IN p_price DECIMAL(10,2),
    IN p_stock INT
)
BEGIN
    INSERT INTO products (name, category, price, stock)
    VALUES (p_name, p_category, p_price, p_stock);
END //

DELIMITER ;


-- PROCEDURE TO UPDATE THE STOCKS IN THE INVENTORY
DELIMITER //

CREATE PROCEDURE UpdateStock(
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    UPDATE products
    SET stock = stock + p_quantity
    WHERE product_id = p_product_id;
END //

DELIMITER ;


-- PROCEDURE TO CHECK THE AVAILABILITY OF THE PRODUCTS IN THE INVENTORY
DELIMITER //

CREATE PROCEDURE CheckAvailability(
    IN p_product_id INT,
    OUT p_stock INT
)
BEGIN
    SELECT stock INTO p_stock
    FROM products
    WHERE product_id = p_product_id;
END //

DELIMITER ;


-- ADDING NEW PRODUCTS TO THE INVENTORY
CALL AddProduct('iPhone 15', 'Electronics', 80000, 10);
CALL AddProduct('Nike Shoes', 'Footwear', 6000, 20);
CALL AddProduct('MacBook Air', 'Electronics', 120000, 5);

-- UPDATING THE STOCK AFTER ADDING MORE QUANTITY OR SELLING A PRODUCT
CALL UpdateStock(1, -2); -- Sold 2 units
CALL UpdateStock(1, 5); -- Added 5 more iPhone 15 to the stock


-- CHECKING THE AVAILABILITY OF THE STOCK IN THE INVENTORY
CALL CheckAvailability(1, @stock);
SELECT @stock AS 'Available Stock';

CALL CheckAvailability(2, @stock);
SELECT @stock AS 'Available Stock'
