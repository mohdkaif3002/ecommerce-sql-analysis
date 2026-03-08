-- ================================================
-- SALES & REVENUE ANALYSIS
-- Project: Olist E-commerce SQL Analysis
-- ================================================

-- Monthly revenue trend
SELECT 
    strftime('%Y-%m', order_purchase_timestamp) AS month,
    ROUND(SUM(payment_value), 2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
WHERE order_status = 'delivered'
GROUP BY month
ORDER BY month;

-- Top 10 product categories by revenue
SELECT 
    t.product_category_name_english AS category,
    ROUND(SUM(p.payment_value), 2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM olist_orders_dataset o
JOIN olist_order_items_dataset i ON o.order_id = i.order_id
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
JOIN olist_products_dataset pr ON i.product_id = pr.product_id
JOIN product_category_name_translation t ON pr.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 10;