-- Expert-Level Queries:

-- 17. Retrieve a list of customers who have placed orders for every product in a specific category.
SELECT DISTINCT c.customer_id, c.first_name, c.last_name 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
JOIN Products p ON o.product_id = p.product_id 
WHERE p.category_id = 2
GROUP BY c.customer_id, c.first_name, c.last_name 
HAVING COUNT(DISTINCT p.product_id) = (
    SELECT COUNT(*) 
    FROM Products 
    WHERE category_id = 2
);

-- 18. Calculate the average order amount for each month over the past year.
SELECT extract(YEAR_MONTH FROM order_date) AS year, 
    AVG(total_amount) as average_order_amount
FROM Orders
WHERE order_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR)
GROUP BY year;

-- 19. Find the customers who have placed orders with a total amount that is significantly higher than their average order amount.
SELECT c.customer_id, c.first_name, c.last_name 
FROM Customers c 
JOIN (
    SELECT customer_id, AVG(total_amount) as avg_order_amount
    FROM Orders 
    GROUP BY customer_id
) avg_orders ON c.customer_id = avg_orders.customer_id
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.total_amount > (avg_orders.avg_order_amount * 2); -- Adjust the multiplier as needed

-- 20. Create a report that displays the top 5 best-selling products in each category.
SELECT
    p.product_name,
    c.category_name,
    COUNT(o.order_id) as position
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
JOIN Categories c ON p.category_id = c.category_id
GROUP BY p.product_id, c.category_id
HAVING COUNT(o.order_id) <= 5
ORDER BY c.category_name, position;