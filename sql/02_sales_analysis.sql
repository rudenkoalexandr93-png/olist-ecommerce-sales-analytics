/*
====================================================
Project : Olist Brazilian E-Commerce Analysis
File    : 02_sales_analysis.sql

Purpose:
Analyze sales performance, customer behavior,
logistics, and operational efficiency
using PostgreSQL.

Business Questions:
1. Total Revenue
2. Average Order Value (AOV)
3. Monthly Revenue Trend
4. Revenue by Product Category
5. Average Selling Price (ASP) by Category
6. Revenue by Seller
7. Revenue by State
8. Average Delivery Time by State
9. Month-over-Month Revenue Growth
10. Estimated Delivery Accuracy
11. Payment Method Performance
12. Review Scores by Category
13. Delivery Time by Category
====================================================
*/

-- =====================================================
--Business Question 1: What is the total revenue?
-- =====================================================

SELECT
    SUM(op.payment_value) AS total_revenue
FROM olist.order_payments op
JOIN olist.orders o
    ON op.order_id = o.order_id
WHERE 
    o.order_status = 'delivered';

-- =====================================================
-- Business Question 2: What is the Average Order Value?
-- =====================================================

WITH order_totals AS (
	SELECT op.order_id,
		SUM(op.payment_value) AS order_value
	FROM olist.order_payments op
    JOIN olist.orders o
        ON op.order_id = o.order_id
    WHERE 
        o.order_status = 'delivered'
    GROUP BY 
        op.order_id 
    )
SELECT 
	AVG(order_value) AS average_order_value
FROM order_totals;

-- =====================================================
-- Business Question 3: How has monthly revenue changed over time?
-- =====================================================

SELECT  
	DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
    SUM(op.payment_value)  AS monthly_revenue
FROM olist.order_payments op
JOIN olist.orders o
    ON op.order_id = o.order_id
WHERE 
    o.order_status = 'delivered'
GROUP BY 
    order_month 
ORDER BY  
    order_month 
;

-- =====================================================
-- Business Question 4: Which product categories generate the highest revenue?
-- =====================================================

SELECT  
	COALESCE(pcnt.product_category_name_english, 'Unknown') AS category,
    SUM(oi.price) AS category_revenue
FROM olist.order_items AS oi 
JOIN olist.orders AS o
    ON o.order_id = oi.order_id
JOIN olist.products AS p 
	ON oi.product_id = p.product_id 
LEFT JOIN olist.product_category_name_translation AS pcnt 
	ON p.product_category_name = pcnt.product_category_name 
WHERE 
    o.order_status = 'delivered'
GROUP BY 
	pcnt.product_category_name_english
ORDER BY 
	category_revenue DESC;

-- =====================================================
-- Business Question 5: Which product categories have the highest Average Selling Price (ASP)?
-- =====================================================    


SELECT  
	COALESCE(pcnt.product_category_name_english, 'Unknown') AS category,
    AVG(oi.price) AS average_selling_price
FROM olist.order_items AS oi 
JOIN olist.orders AS o
    ON o.order_id = oi.order_id
JOIN olist.products AS p 
	ON oi.product_id = p.product_id 
LEFT JOIN olist.product_category_name_translation AS pcnt 
	ON p.product_category_name = pcnt.product_category_name 
WHERE 
    o.order_status = 'delivered'
GROUP BY 
	pcnt.product_category_name_english
ORDER BY 
	average_selling_price DESC;

-- =====================================================
-- Business Question 6: Which sellers generate the highest revenue?
-- =====================================================

SELECT  
	s.seller_id,
	COUNT(DISTINCT oi.order_id) AS completed_orders,
    SUM(oi.price) AS seller_revenue,
    AVG(oi.price) AS average_product_price
FROM olist.order_items AS oi 
JOIN olist.sellers AS s
    ON oi.seller_id = s.seller_id
JOIN olist.orders AS o
    ON o.order_id = oi.order_id
WHERE 
    o.order_status = 'delivered'
GROUP BY 
	s.seller_id
ORDER BY 
	seller_revenue DESC;

-- =====================================================
-- Business Question 7: Which Brazilian states generate the highest revenue?
-- =====================================================

SELECT  
	c.customer_state,
    SUM(oi.price ) AS state_revenue
FROM olist.order_items AS oi 
JOIN olist.orders AS o
    ON o.order_id = oi.order_id
JOIN olist.customers AS c
    ON o.customer_id = c.customer_id
WHERE 
    o.order_status = 'delivered'
GROUP BY 
	c.customer_state
ORDER BY 
	state_revenue DESC;

-- =====================================================
-- Business Question 8: What is the average delivery time by state?
-- =====================================================

SELECT  
	c.customer_state,
    AVG(
    o.order_delivered_customer_date -
    o.order_purchase_timestamp
    ) AS avg_delivery_time
FROM olist.orders AS o
JOIN olist.customers AS c
    ON o.customer_id = c.customer_id
WHERE 
    o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 
	c.customer_state
ORDER BY 
	avg_delivery_time DESC;

-- =====================================================
-- Business Question 9: How has revenue changed compared to the previous month (MoM Growth)?    
-- =====================================================

WITH monthly_revenue AS (
	  SELECT  
		DATE_TRUNC('month', o.order_purchase_timestamp) AS revenue_month,
	    SUM(op.payment_value)  AS monthly_revenue
	FROM olist.order_payments op
	JOIN olist.orders o
	    ON op.order_id = o.order_id
	WHERE 
	    o.order_status = 'delivered'
	GROUP BY 1  
),
lagged_revenue AS (
    SELECT 
        revenue_month,
        monthly_revenue,
        LAG(monthly_revenue, 1) OVER (ORDER BY revenue_month) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT 
    revenue_month,
    monthly_revenue,
    previous_month_revenue,
    ROUND(
    CAST(
        ((monthly_revenue - previous_month_revenue) / NULLIF(previous_month_revenue, 0)) * 100
        AS numeric
    ),
    2
) AS mom_growth_percent
FROM lagged_revenue;

-- =====================================================
-- Business Question 10: How accurate are estimated delivery dates?
-- =====================================================

SELECT 
    c.customer_state,
    COUNT(*) AS delivered_orders,
    AVG(
        o.order_delivered_customer_date - 
        o.order_estimated_delivery_date) AS average_delivery_delay
FROM olist.orders AS o
JOIN olist.customers AS c
    ON o.customer_id = c.customer_id
WHERE 
    o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 
	c.customer_state
ORDER BY 
	average_delivery_delay DESC;

-- =====================================================
-- Business Question 11: Which payment methods generate the highest revenue?
-- =====================================================

SELECT 
    op.payment_type,
    COUNT(DISTINCT op.order_id) AS  completed_orders,
    SUM(op.payment_value) AS total_revenue,
    AVG(op.payment_value) AS avg_payment
FROM olist.order_payments AS op
JOIN olist.orders AS o
    ON op.order_id = o.order_id
WHERE 
    o.order_status = 'delivered'
GROUP BY 
	op.payment_type
ORDER BY 
	total_revenue DESC;

-- =====================================================
-- Business Question 12: How do review scores vary across product categories?
-- =====================================================

SELECT 
    COALESCE(pcnt.product_category_name_english, 'Unknown') AS category,
    COUNT(r.review_score) AS total_reviews,
    AVG((r.review_score):: NUMERIC)  AS avg_review_score
FROM olist.order_reviews AS r
JOIN olist.order_items AS oi
    ON r.order_id = oi.order_id
JOIN olist.products AS p
    ON oi.product_id = p.product_id
LEFT JOIN olist.product_category_name_translation AS pcnt 
	ON p.product_category_name = pcnt.product_category_name 
WHERE 
    p.product_category_name IS NOT NULL
GROUP BY 
	pcnt.product_category_name_english
ORDER BY 
	avg_review_score DESC;

-- =====================================================
-- Business Question 13: Which product categories have the longest average delivery time?
-- =====================================================

SELECT 
    COALESCE(pcnt.product_category_name_english, 'Unknown') AS category,
    AVG(
        o.order_delivered_customer_date -
        o.order_purchase_timestamp) AS avg_delivery_time
FROM olist.orders AS o
JOIN olist.order_items AS oi
    ON o.order_id = oi.order_id
JOIN olist.products AS p
    ON oi.product_id = p.product_id
LEFT JOIN olist.product_category_name_translation AS pcnt 
	ON p.product_category_name = pcnt.product_category_name 
WHERE
     o.order_status = 'delivered'
     AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 
	pcnt.product_category_name_english
ORDER BY 
	avg_delivery_time DESC;
