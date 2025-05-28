-- Top-selling product
SELECT product_name, SUM(quantity) AS total_sold
FROM sales
GROUP BY product_name
ORDER BY total_sold DESC;

-- Monthly sales
SELECT MONTH(sale_date) AS month, SUM(quantity * price) AS revenue
FROM sales
GROUP BY MONTH(sale_date);
