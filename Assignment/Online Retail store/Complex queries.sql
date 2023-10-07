-- Complex Queries:

-- 13. Retrieve the names of customers who have placed orders in the last 30 days.
SELECT DISTINCT c.first_name, c.last_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY);

-- 14. List the products that have been out of stock for more than 7 days.
SELECT product_name
FROM Products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM Orders
    WHERE order_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
);

-- 15. Find the products that have the highest fluctuation in price (i.e., the products where the difference between the highest and lowest prices is the greatest).
SELECT product_name,
       MAX(price) as highest_price,
       MIN(price) as lowest_price,
       MAX(price) - MIN(price) as price_fluctuation
FROM Products
GROUP BY product_name
ORDER BY price_fluctuation DESC
LIMIT 1;

-- 16. Create a summary report showing the category names, the total number of products in each category, and the total revenue generated from products in each category.
SELECT c.category_name,
       COUNT(p.product_id) as total_products,
       SUM(o.total_amount) as total_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Orders o ON p.product_id = o.product_id
GROUP BY c.category_name;