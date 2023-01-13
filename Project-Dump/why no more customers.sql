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
    
-- this query leads to a big loss in the newest order count (2018, Month 8-10)
-- which might indicate some shit happened there (join with order_reviews, order_payments e.g.?)?

SELECT
	order_status, review_score, review_comment_title, review_comment_message
FROM 	
	orders
		INNER JOIN order_reviews ON order_reviews.order_id = orders.order_id
WHERE 
	YEAR(order_purchase_timestamp) = '2018'
    AND MONTH(order_purchase_timestamp) IN (8, 9, 10)
    AND review_comment_message IS NOT NULL;

-- (last AND statement might leave the whole query with less meaningfullness?)
-- so far it might be interesting to compare the average review scores per month?
-- not having looked at payments yet...

SELECT
	YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp), AVG(review_score)
FROM 	
	orders
		INNER JOIN order_reviews ON order_reviews.order_id = orders.order_id
ORDER BY
	YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp);
