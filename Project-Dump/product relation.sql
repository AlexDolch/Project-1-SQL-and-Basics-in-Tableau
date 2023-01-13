-- 1. What categories of tech products does Magist have?

-- 2. How many products of these tech categories have been sold 
--  (within the time window of the database snapshot)? 
--  What percentage does that represent from the overall number of products sold?

-- 3. What’s the average price of the products being sold?

-- 4. Are expensive tech products popular?


-- Christopher:
SELECT product_category_name_english, COUNT(product_id)
FROM products
    LEFT JOIN product_category_name_translation 
    USING(product_category_name)
GROUP BY product_category_name
ORDER BY COUNT(product_id) DESC
LIMIT 10;

select product_category_name_english, count(*),
CASE
WHEN price < 5 THEN 'super low'
WHEN price < 25 THEN 'cheap'
WHEN price < 100 THEN 'midgrade'
WHEN price < 540 THEN 'upmarket'
WHEN price >= 540 THEN 'above AVG Eniac item price'
END PriceCat
from products p
join order_items o 
    on o.product_id = p.product_id
join product_category_name_translation pt
    on pt.product_category_name = p.product_category_name
WHERE product_category_name_english = 'computers_accessories'
group by PriceCat;

SELECT product_category_name_english, COUNT(o.product_id) 'Times Ordered'
FROM products P
    LEFT JOIN product_category_name_translation 
    USING(product_category_name)

    JOIN order_items o
    USING(product_id)
GROUP BY product_category_name_english
ORDER BY COUNT(o.product_id) DESC;

SELECT product_category_name_english, COUNT(*), SUM(price), AVG(price)
FROM orders o
JOIN customers c USING(customer_id)
JOIN geo g
    ON g.zip_code_prefix = c.customer_zip_code_prefix
JOIN order_items USING(order_id)
JOIN products USING(product_id)
JOIN product_category_name_translation USING(product_category_name)
WHERE g.city = 'sao paulo' AND product_category_name IN ('eletronicos', 'informatica_acessorios', 'pcs')
GROUP BY product_category_name_english;

select product_category_name_english, AVG(price)
from products p
join order_items o on o.product_id = p.product_id
join product_category_name_translation using(product_category_name)
where product_category_name_english in ('computers','computers_accessories','consoles_games', 'electronics','tablets_printing_image')
group by product_category_name_english;

select COUNT(price)
from products p
join order_items o on o.product_id = p.product_id
join product_category_name_translation using(product_category_name)
where product_category_name_english in ('computers','computers_accessories','consoles_games', 'electronics','tablets_printing_image') AND (price) >= 710;