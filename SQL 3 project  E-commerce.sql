DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(50)
);

INSERT INTO customers (customer_id, customer_name, gender, age, city)
VALUES
(1, 'Amit Sharma', 'Male', 25, 'Delhi'),
(2, 'Priya Verma', 'Female', 30, 'Mumbai'),
(3, 'Rahul Singh', 'Male', 28, 'Kolkata'),
(4, 'Neha Gupta', 'Female', 24, 'Bangalore'),
(5, 'Rohit Patel', 'Male', 35, 'Ahmedabad'),
(6, 'Sneha Yadav', 'Female', 27, 'Lucknow'),
(7, 'Vikram Joshi', 'Male', 32, 'Pune'),
(8, 'Anjali Mehta', 'Female', 29, 'Jaipur'),
(9, 'Karan Malhotra', 'Male', 40, 'Chandigarh'),
(10, 'Pooja Mishra', 'Female', 26, 'Bhopal'),
(11, 'Arjun Kumar', 'Male', 31, 'Patna'),
(12, 'Riya Das', 'Female', 23, 'Kolkata'),
(13, 'Manish Tiwari', 'Male', 38, 'Indore'),
(14, 'Simran Kaur', 'Female', 34, 'Amritsar'),
(15, 'Deepak Soni', 'Male', 29, 'Raipur'),
(16, 'Kavita Jain', 'Female', 33, 'Surat'),
(17, 'Sandeep Roy', 'Male', 41, 'Hyderabad'),
(18, 'Nisha Kapoor', 'Female', 22, 'Delhi'),
(19, 'Harsh Agrawal', 'Male', 27, 'Nagpur'),
(20, 'Meera Nair', 'Female', 36, 'Chennai');

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_name VARCHAR(50),
    category VARCHAR(30),
    quantity INT,
    price DECIMAL(10,2),
    order_date DATE,
    payment_method VARCHAR(20)
);

INSERT INTO orders (order_id, customer_id, product_name, category, quantity, price, order_date, payment_method)
VALUES
(101, 1, 'Laptop', 'Electronics', 1, 55000.00, '2026-01-05', 'Credit Card'),
(102, 2, 'Smartphone', 'Electronics', 2, 18000.00, '2026-01-08', 'UPI'),
(103, 3, 'Office Chair', 'Furniture', 1, 6500.00, '2026-01-10', 'Debit Card'),
(104, 4, 'Headphones', 'Electronics', 3, 2500.00, '2026-01-12', 'Cash'),
(105, 5, 'Dining Table', 'Furniture', 1, 22000.00, '2026-01-15', 'Credit Card'),
(106, 6, 'T-Shirt', 'Clothing', 4, 800.00, '2026-01-18', 'UPI'),
(107, 7, 'Shoes', 'Footwear', 2, 3200.00, '2026-01-20', 'Debit Card'),
(108, 8, 'Watch', 'Accessories', 1, 4500.00, '2026-01-22', 'UPI'),
(109, 9, 'Microwave', 'Home Appliances', 1, 12000.00, '2026-01-24', 'Credit Card'),
(110, 10, 'Book', 'Books', 5, 500.00, '2026-01-25', 'Cash'),
(111, 11, 'Tablet', 'Electronics', 1, 28000.00, '2026-02-01', 'UPI'),
(112, 12, 'Jeans', 'Clothing', 2, 1500.00, '2026-02-03', 'Debit Card'),
(113, 13, 'Refrigerator', 'Home Appliances', 1, 35000.00, '2026-02-05', 'Credit Card'),
(114, 14, 'Backpack', 'Accessories', 2, 1800.00, '2026-02-07', 'UPI'),
(115, 15, 'Running Shoes', 'Footwear', 1, 4200.00, '2026-02-09', 'Cash'),
(116, 16, 'Sofa', 'Furniture', 1, 30000.00, '2026-02-11', 'Credit Card'),
(117, 17, 'Air Conditioner', 'Home Appliances', 1, 42000.00, '2026-02-13', 'Debit Card'),
(118, 18, 'Novel', 'Books', 3, 700.00, '2026-02-15', 'UPI'),
(119, 19, 'Bluetooth Speaker', 'Electronics', 2, 3500.00, '2026-02-18', 'Credit Card'),
(120, 20, 'Jacket', 'Clothing', 1, 2800.00, '2026-02-20', 'Cash');

SELECT * FROM customers;
SELECT * FROM orders;


--Beginner Level:

--Q1. Show all orders.
SELECT * FROM orders;

--Q2. Show customer name and city.
SELECT customer_name, city FROM customers;

--Q3. Show products with a price greater than 1000.
SELECT * FROM orders
WHERE price>1000;

--Q4. Show all customers from Delhi.
SELECT * FROM customers
WHERE city='Delhi';

--Q5. Show all orders sorted by price (highest to lowest).
SELECT * FROM orders
ORDER BY price DESC;

--Intermediate Level:

--Q6. Find the total number of orders.
SELECT COUNT(*) AS Total_Orders
FROM orders;

--Q7. Find the average product price.
SELECT ROUND(AVG(price)) AS Average_price
FROM orders;

--Q8. Find the highest product price.
SELECT MAX(price) AS highest_price
FROM orders;

--Q9. Find the lowest product price.
SELECT MIN(price) AS lowest_price
FROM orders;

--Q10. Calculate the total sales amount (price × quantity).
SELECT SUM(price*Quantity) AS total_sales
FROM orders;

--GROUP BY Questions:

--Q11. Find the number of orders in each category.
SELECT category, COUNT(*) AS Total_orders
FROM Orders
GROUP BY category;

--Q12. Find the average sales amount for each category.
SELECT category, ROUND(AVG(price*quantity)) AS Average_Sales
FROM orders
GROUP BY category;

--Q13. Find the highest sale amount in each category.
SELECT category, MAX(price*quantity) AS highest_sales
FROM orders
GROUP BY category;

--Q14. Display the categories having more than 3 orders.
SELECT category, COUNT(*) AS total_orders
FROM orders
GROUP BY category
HAVING COUNT(*) > 3;

--JOIN Questions:

--Q15. Show the customer name with the product purchased.
SELECT c.customer_name, o.product_name, o.order_date
FROM orders o
JOIN customers c 
ON o.customer_id=c.customer_id;

--Q16. Show the customer name, city, and product purchased.
SELECT c.customer_name, c.city, o.product_name
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id;


--Advanced Level:

--Q17. Display the top 5 highest sales.
SELECT *, (price*quantity) AS highest_sales
FROM orders 
ORDER BY highest_sales DESC LIMIT 5;

--Q18. Find the total sales for each customer.
SELECT customer_id, SUM(price*quantity) AS total_sales
FROM orders 
GROUP BY customer_id; 

SELECT c.customer_id, c.customer_name, SUM(o.price*quantity) AS total_sales
FROM orders o
JOIN customers c ON o.customer_id=c.Customer_id
GROUP BY c.customer_id, c.customer_name;

--Q19. Rank customers based on their total purchase amount.
SELECT customer_id, SUM(price * quantity) AS total_purchase,
RANK() OVER(ORDER BY SUM(price * quantity) DESC) AS ranking
FROM orders
GROUP BY customer_id;

--Q20. Find the second highest sale amount.
SELECT MAX(price * quantity) AS second_highest_sale
FROM orders
WHERE (price * quantity) <
(
SELECT MAX(price * quantity)
FROM orders
);