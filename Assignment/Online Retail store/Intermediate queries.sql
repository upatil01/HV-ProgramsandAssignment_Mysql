-- Intermediate Queries:
-- 5. Find all customers who have not placed any orders.
SELECT first_name, last_name FROM customers 
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM Orders);

-- 6. List the products with the highest and lowest prices.
SELECT product_id, product_name, price FROM products ORDER BY price DESC;

--  7. Calculate the average order amount for each customer.
SELECT customer_id, AVG(total_amount) AS avg_order_amount FROM orders GROUP BY customer_id;

-- 8. Find the categories that do not have any products.
SELECT category_name, category_id FROM categories 
WHERE category_id NOT IN (SELECT DISTINCT category_id FROM products);