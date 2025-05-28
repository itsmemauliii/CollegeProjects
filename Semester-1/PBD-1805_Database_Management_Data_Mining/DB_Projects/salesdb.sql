CREATE DATABASE IF NOT EXISTS salesdb;
USE salesdb;

CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10, 2),
    sale_date DATE
);

-- Sample data
INSERT INTO sales (product_name, quantity, price, sale_date)
VALUES ('Pen', 10, 5.00, '2025-01-01'),
       ('Notebook', 5, 50.00, '2025-01-03'),
       ('Pen', 3, 5.00, '2025-01-04');
