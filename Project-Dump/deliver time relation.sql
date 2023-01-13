-- 1. What’s the average time between the order being placed and the product being delivered?

-- 2. How many orders are delivered on time vs orders delivered with a delay?

-- 3. Is there any pattern for delayed orders, e.g. big products being delayed more often?


-- Christoph:
select -- order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, 
Count(*),
    CASE
        WHEN datediff(order_delivered_customer_date, order_purchase_timestamp) IS NULL THEN 'Canceled/Undeliverable'
        WHEN datediff(order_delivered_customer_date, order_purchase_timestamp) <= 1 THEN 'Same Day' 
        WHEN datediff(order_delivered_customer_date, order_purchase_timestamp) <= 3 THEN 'Priority' 
        WHEN datediff(order_delivered_customer_date, order_purchase_timestamp) <= 7 THEN 'Same Week'
        WHEN datediff(order_delivered_customer_date, order_purchase_timestamp) <= 14 THEN 'Two Weeks'
        WHEN datediff(order_delivered_customer_date, order_purchase_timestamp) <= 30 THEN 'One Month'
        WHEN datediff(order_delivered_customer_date, order_purchase_timestamp) <= 60 THEN 'Two Months'
        ELSE 'Eternal'
    END AS Judgement
from orders
GROUP BY Judgement
Order by FIELD(Judgement, 'Same Day', 'Priority', 'Same Week', 'Two Weeks', 'One Month', 'Two Months', 'Eternal', 'Canceled/Undeliverable');

SELECT CASE
    WHEN timediff(order_delivered_customer_date, order_estimated_delivery_date) < 0 THEN 'Early'
    WHEN timediff(order_delivered_customer_date, order_estimated_delivery_date) > 48 THEN 'Over two days'
    WHEN timediff(order_delivered_customer_date, order_estimated_delivery_date) > 168 THEN 'A week?'
    ELSE 'Bit late'
END Judgement,
COUNT(*)
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY Judgement;