-- Q1: List all customers from Mumbai along with their total order value
SELECT 
    c.customer_name, 
    SUM(p.unit_price * oi.quantity) AS total_order_value
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_id, c.customer_name;

-- Q2: Find the top 3 products by total quantity sold
SELECT 
    p.product_name, 
    SUM(oi.quantity) AS total_quantity
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC
LIMIT 3;

-- Q3: List all sales representatives and the number of unique customers they have handled
SELECT 
    sr.sales_rep_name, 
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM SalesReps sr
LEFT JOIN Orders o ON sr.sales_rep_id = o.sales_rep_id
GROUP BY sr.sales_rep_id, sr.sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
SELECT 
    o.order_id, 
    SUM(p.unit_price * oi.quantity) AS total_value
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY o.order_id
HAVING total_value > 10000
ORDER BY total_value DESC;

-- Q5: Identify any products that have never been ordered
SELECT 
    p.product_name
FROM Products p
LEFT JOIN OrderItems oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;
