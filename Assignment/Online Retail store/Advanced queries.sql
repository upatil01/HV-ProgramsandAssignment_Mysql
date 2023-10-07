-- Advanced Queries:

-- 9. Retrieve a list of customers who have placed orders for products with a price higher than $100.
SELECT c.customer_id, c.first_name, c.last_name 
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id 
JOIN products p on o.product_id = p.product_id 
WHERE p.price > 100;

-- 10. List the customers who have placed orders for products from at least three different categories.
SELECT c.customer_id, c.first_name, c.last_name FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
JOIN Products p ON o.product_id = p.product_id 
GROUP BY c.customer_id, c.first_name, c.last_name 
HAVING COUNT(DISTINCT p.category_id) >= 3;

-- 11. Find the products with the highest and lowest average customer ratings (if a rating table is available).
-- To find the products with the highest and lowest average customer ratings, assuming we have a Ratings table with product_id and rating columns, we could use the following SQL query:
WITH AvgRatings AS (
    SELECT product_id, AVG(rating) AS avg_rating
    FROM Ratings
    GROUP BY product_id
),
MaxMinRating AS (
    SELECT MAX(avg_rating) AS max_rating, MIN(avg_rating) AS min_rating FROM AvgRatings
)
SELECT p.product_id, p.product_name, ar.avg_rating
FROM Products p
JOIN AvgRatings ar ON p.product_id = ar.product_id
JOIN MaxMinRating mmr ON ar.avg_rating = mmr.max_rating OR ar.avg_rating = mmr.min_rating;
-- Not able to test as rating table not available


-- 12. Calculate the total revenue generated from each category.
SELECT c.category_id, c.category_name, SUM(o.total_amount) as total_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Orders o ON p.product_id = o.product_id
GROUP BY c.category_id, c.category_name;