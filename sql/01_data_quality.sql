/*
===================================================
Project: Olist Brazilian E-Commerce Analysis

File: 01_data_quality.sql

Purpose:
Validate dataset quality before business analysis.

Checks:
1. Row counts
2. Missing values
3. Duplicate primary keys
4. Order status distribution
=====================================================
*/

-- =====================================================
-- Row count by table
-- =====================================================

SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM olist.customers

UNION ALL

SELECT 'orders', COUNT(*)
FROM olist.orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM olist.order_items

UNION ALL

SELECT 'order_payments', COUNT(*)
FROM olist.order_payments

UNION ALL

SELECT 'order_reviews', COUNT(*)
FROM olist.order_reviews

UNION ALL

SELECT 'products', COUNT(*)
FROM olist.products

UNION ALL

SELECT 'sellers', COUNT(*)
FROM olist.sellers

UNION ALL

SELECT 'geolocation', COUNT(*)
FROM olist.geolocation

UNION ALL

SELECT 'product_category_translation', COUNT(*)
FROM olist.product_category_name_translation

ORDER BY row_count DESC;

-- =====================================================
-- Primary Key Validation
-- Duplicate customer_id check
-- =====================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM olist.customers;

-- =====================================================
-- Duplicate order_id check
-- =====================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders
FROM olist.orders;

-- =====================================================
-- Duplicate product_id check
-- =====================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_products
FROM olist.products;

-- =====================================================
-- Duplicate seller_id check
-- =====================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT seller_id) AS unique_sellers
FROM olist.sellers;

-- =====================================================
--Check missing value in Orders
-- =====================================================

SELECT 
	COUNT(*) AS total_orders,
	COUNT(*) FILTER (
		WHERE order_approved_at IS NULL 
		) AS missing_approved_at,
	COUNT(*) FILTER (
		WHERE order_delivered_carrier_date IS NULL 
		) AS missing_carrier_date,	
	COUNT(*) FILTER (
		WHERE order_delivered_customer_date IS NULL 
		) AS missing_customer_date	
FROM olist.orders;

-- =====================================================
--Check missing value in Reviews
-- =====================================================

SELECT 
	COUNT(*) AS total_reviews,
	COUNT(*) FILTER (
		WHERE review_comment_title IS NULL
		OR review_comment_title = ''
		) AS missing_title,
	COUNT(*) FILTER (
		WHERE review_comment_message IS NULL
		OR review_comment_message = ''
		) AS missing_message
FROM olist.order_reviews;

-- =====================================================
--Check missing value in Products
-- =====================================================

SELECT 
	COUNT(*) AS total_products,
	COUNT(*) FILTER (
		WHERE product_category_name IS NULL 
		) AS missing_category
FROM olist.products;

-- =====================================================
--Order Status Distribution
-- =====================================================

SELECT 
	order_status,
	COUNT(*) AS orders_count,
	ROUND(
		COUNT(*) * 100 
		/ SUM(COUNT(*)) OVER(), 2
		)  AS percentage
FROM olist.orders 
GROUP BY order_status 
ORDER BY orders_count DESC;
