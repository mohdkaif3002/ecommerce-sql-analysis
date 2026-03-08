-- ================================================
-- DELIVERY & OPERATIONS ANALYSIS
-- Project: Olist E-commerce SQL Analysis
-- ================================================

-- Average actual vs estimated delivery time
SELECT 
    ROUND(AVG(JULIANDAY(order_delivered_customer_date) - 
              JULIANDAY(order_purchase_timestamp)), 1) AS avg_actual_days,
    ROUND(AVG(JULIANDAY(order_estimated_delivery_date) - 
              JULIANDAY(order_purchase_timestamp)), 1) AS avg_estimated_days,
    ROUND(AVG(JULIANDAY(order_estimated_delivery_date) - 
              JULIANDAY(order_delivered_customer_date)), 1) AS avg_days_early
FROM olist_orders_dataset
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL;

-- Top 10 sellers with highest late delivery rate
SELECT 
    i.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(CASE 
        WHEN order_delivered_customer_date > order_estimated_delivery_date 
        THEN 1 ELSE 0 
    END) AS late_deliveries,
    ROUND(SUM(CASE 
        WHEN order_delivered_customer_date > order_estimated_delivery_date 
        THEN 1 ELSE 0 
    END) * 100.0 / COUNT(DISTINCT o.order_id), 2) AS late_percentage
FROM olist_orders_dataset o
JOIN olist_order_items_dataset i ON o.order_id = i.order_id
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
GROUP BY i.seller_id
HAVING total_orders >= 50
ORDER BY late_percentage DESC
LIMIT 10;