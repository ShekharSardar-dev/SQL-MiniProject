-- Creating both the tables
CREATE TABLE Products (
	product_id INT PRIMARY KEY,
	product_name varchar(20),
	category varchar(50),
	price DECIMAL(10,2) CHECK (price > 0),
	stock_quantity INT,
	is_available BOOLEAN,
	added_on DATE
);

CREATE TABLE Orders (
	order_id SERIAL PRIMARY KEY,
	product_id INT,
	quantity INT,
	order_date DATE,
	customer_name VARCHAR(20),
	payment_method VARCHAR(50),

	CONSTRAINT fk_product
		FOREIGN KEY (product_id)
		REFERENCES Products(product_id)
);

SELECT * FROM Products;
SELECT * FROM Orders;

-- Questions

-- Q!. Show each order along with the product name and price. 
SELECT o.order_id, p.product_id, p.product_name, p.price FROM Products p INNER JOIN Orders o ON p.product_id = o.product_id;

-- Q2. Show all products even if they were never ordered. 
SELECT p.product_id, o.order_id, p.product_name FROM Products p LEFT JOIN Orders o ON p.product_id = o.product_id;

-- Q3.Show orders for only ‘Electronics’ category.
SELECT p.product_id, o.order_id, o.customer_name, p.product_name, p.category FROM Products p INNER JOIN Orders o ON p.product_id = o.product_id WHERE p.category = 'Electronics';

-- Q4.List all orders sorted by product price (high to low).
SELECT p.product_id, o.order_id, p.product_name, o.customer_name, p.price FROM Products p RIGHT JOIN Orders o ON p.product_id = o.product_id ORDER BY p.price ASC;

-- Q5.Show number of orders placed for each product.
SELECT p.product_id, p.product_name, COUNT(o.order_id) as Total_Orders FROM Products p INNER JOIN Orders o ON p.product_id = o.product_id GROUP BY p.product_id, p.product_name;

-- Q6.Show total revenue earned per product.
SELECT p.product_id, product_name, p.price, o.quantity, (p.price * o.quantity) AS Total_revenue FROM Products p INNER JOIN Orders o ON p.product_id = o.product_id;

-- Q7.Show products where total order revenue > ₹2000.
SELECT p.product_id, product_name, p.price, o.quantity, (p.price * o.quantity) AS Total_revenue FROM Products p INNER JOIN Orders o ON p.product_id = o.product_id WHERE (p.price * o.quantity) > 2000;

-- Q8.Show unique customers who ordered ‘Fitness’ products.
SELECT DISTINCT o.customer_name AS Unique_customers, p.product_name, p.price, p.category FROM Products p INNER JOIN Orders o ON p.product_id = o.product_id WHERE p.category = 'Fitness';
