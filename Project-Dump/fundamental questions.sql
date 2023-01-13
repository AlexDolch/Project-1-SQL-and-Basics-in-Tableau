-- 1. How many orders are there in the dataset?
-- The orders table contains a row for each order,
-- so this should be easy to find out!
SELECT 
    COUNT(*) AS orders_count
FROM
    orders;
    
-- 2. Are orders actually delivered?
-- Look at columns in the orders table:
-- one of them is called order_status.
-- Most orders seem to be delivered, but some aren’t. 
-- Find out how many orders are delivered and how many are canceled, 
-- unavailable, or in any other status by grouping and aggregating this column.
SELECT
	COUNT(order_status), order_status
FROM 
	orders
GROUP BY
	order_status;

-- 3. Is Magist having user growth?
-- A platform losing users left and right isn’t going to be very useful to us.
-- It would be a good idea to check for the number of orders grouped
-- by year and month. Tip: you can use the functions YEAR() and MONTH() 
-- to separate the year and the month of the order_purchase_timestamp.
SELECT
	COUNT(*), YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp)
FROM 	
	orders
GROUP BY
	YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY
	YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp);
-- compare the customers

-- 4. How many products are there on the products table?
-- (Make sure that there are no duplicate products.)

SELECT
	DISTINCT COUNT(product_id)
FROM
	products;
    
-- SELECT
-- 	COUNT(DISTINCT product_id)
-- FROM
-- 	products;


-- 5. Which are the categories with the most products?
-- Since this is an external database and has been partially anonymized,
-- we do not have the names of the products. But we do know which 
-- categories products belong to.

SELECT 
    product_category_name, 
    COUNT(DISTINCT product_id) AS n_products
FROM
    products
GROUP BY 
	product_category_name
ORDER BY 
	COUNT(product_id) DESC;

-- 6. How many of those products were present in actual transactions? 
-- The products table is a “reference” of all the available products.
-- Have all these products been involved in orders? Check out the
-- order_items table to find out!

SELECT 
	count(DISTINCT product_id)
FROM
	order_items;

-- 7. What’s the price for the most expensive and cheapest products?
-- Sometimes, having a basing range of prices is informative.
-- Looking for the maximum and minimum values is also a good way
-- to detect extreme outliers.
SELECT 	
	MIN(price), MAX(price)
FROM
	order_items;
    
-- 8. What are the highest and lowest payment values?
-- Some orders contain multiple products.
-- What’sthe highest someone has paid for an order?
-- Look at the order_payments table and try to find it out.

SELECT 
	MAX(payment_value),
    MIN(payment_value)
FROM
	order_payments;