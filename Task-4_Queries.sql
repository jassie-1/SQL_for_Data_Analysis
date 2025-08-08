-- ***SELECT QUERY***

-- SELECT * FROM Customers;
-- SELECT * FROM Products;
-- SELECT * FROM Orders;
-- SELECT * FROM Orders LIMIT 2;

-- ***WHERE CLAUSE***

-- SELECT * FROM Customers WHERE country= 'India'; 
-- SELECT name,price FROM Products WHERE price > 5000;
-- SELECT amount, quantity, order_date FROM Orders WHERE order_date BETWEEN '2025-04-01' AND '2025-05-31'; 

-- ***ORDER BY CLAUSE***

-- SELECT customer_id, name, email FROM Customers 
-- WHERE customer_id IN (1,3,5,7,9)
-- ORDER BY(name) DESC; 

-- SELECT name, price FROM Products 
-- WHERE name LIKE '______'
-- ORDER BY(price); 

-- SELECT quantity, amount, order_date FROM Orders 
-- WHERE quantity<5
-- ORDER BY(amount)
-- LIMIT 10; 

-- ***GROUP BY...HAVING CLAUSE***

-- SELECT quantity, SUM(amount) AS total_price FROM Orders 
-- GROUP BY(quantity) HAVING COUNT(order_id)>2;

-- SELECT customer_id, SUM(amount) AS total_paid FROM Orders 
-- GROUP BY(customer_id) HAVING total_paid>60000;

-- SELECT product_id, COUNT(quantity) AS total_quantity, SUM(amount) AS total_price FROM Orders 
-- GROUP BY(product_id) HAVING product_id>5;

-- ***AGGREGATE FUNCTIONS AND GROUP BY CLAUSE***

-- SELECT country, COUNT(customer_id) AS total_customers FROM Customers 
-- GROUP BY(country);

-- SELECT SUM(price*stock_quantity) AS total_price FROM Products;

-- SELECT MAX(quantity) AS max_quantity, 
-- Min(order_date) AS oldest_order, 
-- AVG(amount) AS avg_order_amount 
-- FROM Orders;

-- ***JOINS (INNER, LEFT, RIGHT)***

-- SELECT Customers.customer_id, Customers.name, Products.name, Orders.quantity, Orders.amount
-- FROM Orders 
-- INNER JOIN Products ON Orders.product_id= Products.product_id
-- INNER JOIN Customers ON Orders.customer_id= Customers.customer_id
-- ORDER BY(Customers.customer_id);

-- SELECT Customers.customer_id, Customers.name, Orders.order_id, Orders.amount, Orders.order_date
-- FROM Customers 
-- LEFT JOIN Orders ON Customers.customer_id=Orders.customer_id
-- ORDER BY(customer_id);

-- SELECT Products.product_id, Products.name, Orders.order_id, Orders.amount
-- FROM Orders 
-- RIGHT JOIN Products ON Products.product_id=Orders.product_id
-- ORDER BY(product_id);

-- SELECT Customers.customer_id, Customers.name, Products.product_id, Products.name AS product_name, Orders.amount, Orders.order_date
-- FROM Customers 
-- LEFT JOIN Orders ON Customers.customer_id=Orders.customer_id
-- LEFT JOIN Products ON Products.product_id=Orders.product_id
-- ORDER BY(order_date);

-- SELECT Products.product_id, Customers.name, Products.name AS product_name, Orders.quantity, Orders.amount
-- FROM Customers 
-- RIGHT JOIN Orders ON Customers.customer_id=Orders.customer_id
-- RIGHT JOIN Products ON Products.product_id=Orders.product_id
-- ORDER BY(product_id);

-- ***VIEWS***

-- CREATE VIEW all_info AS
-- SELECT c.country, c.customer_id, c.name AS customer_name,
-- p.product_id, p.name AS product_name, 
-- o.order_id, o.amount AS total_paid, o.order_date
-- FROM Orders o
-- JOIN Products p ON o.product_id= p.product_id
-- JOIN Customers c ON o.customer_id= c.customer_id
-- ORDER BY country;

-- SELECT * from all_info;

-- CREATE VIEW order_month AS
-- SELECT c.name AS customer_name, c.country,
-- p.name AS product_name, p.price AS product_price,
-- o.quantity, o.amount AS total_amount, 
-- CASE
-- WHEN o.order_date BETWEEN '2025-01-01' AND '2025-01-31' THEN "January"
-- WHEN o.order_date BETWEEN '2025-02-01' AND '2025-02-29' THEN "February"
-- WHEN o.order_date BETWEEN '2025-03-01' AND '2025-03-31' THEN "March"
-- WHEN o.order_date BETWEEN '2025-04-01' AND '2025-04-30' THEN "April"
-- WHEN o.order_date BETWEEN '2025-05-01' AND '2025-05-31' THEN "May"
-- WHEN o.order_date BETWEEN '2025-06-01' AND '2025-06-30' THEN "June"
-- WHEN o.order_date BETWEEN '2025-07-01' AND '2025-07-31' THEN "July"
-- WHEN o.order_date BETWEEN '2025-08-01' AND '2025-08-31' THEN "August"
-- END AS order_month
-- FROM Orders o
-- JOIN Products p ON o.product_id= p.product_id
-- JOIN Customers c ON o.customer_id= c.customer_id
-- ORDER BY country;

-- SELECT * from order_month;

-- CREATE VIEW product_popularity AS
-- SELECT p.name AS product_name, COUNT(o.order_id) as order_count,
-- CASE
-- WHEN COUNT(o.order_id)>= 5 THEN "HIGH"
-- WHEN COUNT(o.order_id) IN (3,4) THEN "MEDIUM"
-- WHEN COUNT(o.order_id)<3 THEN "LOW"
-- END AS popularity
-- FROM Orders o
-- JOIN Products p ON o.product_id= p.product_id
-- JOIN Customers c ON o.customer_id= c.customer_id
-- GROUP BY p.name
-- ORDER BY order_count DESC;

-- SELECT * FROM product_popularity;

-- ***INDEXES***

-- SHOW INDEXES FROM Customers;
-- SHOW INDEXES FROM Products;
-- SHOW INDEXES FROM Orders;

-- EXPLAIN SELECT * from order_month;
-- CREATE INDEX idx_orders_cid ON Orders(customer_id);
-- CREATE INDEX idx_orders_pid ON Orders(product_id);
-- CREATE INDEX idx_country ON Customers(country);
-- CREATE INDEX idx_order_date ON Orders(order_date);
-- EXPLAIN SELECT * from order_month;

-- ***SUBQUERIES***

-- SELECT name, price, stock_quantity 
-- FROM Products WHERE (
-- SELECT AVG(price) FROM Products
-- )< price;

-- SELECT customer_id, email, country
-- FROM Customers WHERE name IN(
-- SELECT name FROM Customers WHERE name LIKE '_____'
-- );

-- SELECT quantity, amount, order_date
-- FROM Orders WHERE order_date IN (
-- SELECT order_date FROM Orders WHERE MONTHNAME(order_date)= "May"
-- );
