-- ================================================
-- CUSTOMER BEHAVIOUR ANALYSIS
-- Project: Olist E-commerce SQL Analysis
-- ================================================

-- Repeat vs one-time buyers
SELECT 
    CASE 
        WHEN order_count = 1 THEN 'One-time buyer'
        ELSE 'Repeat buyer'
    END AS customer_type,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM (
    SELECT 
        customer_unique_id,
        COUNT(order_id) AS order_count
    FROM olist_orders_dataset o
    JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
    GROUP BY customer_unique_id
)
GROUP BY customer_type;

-- Top 10 states by revenue and revenue per customer
SELECT 
    c.customer_state AS state,
    COUNT(DISTINCT c.customer_unique_id) AS total_customers,
    ROUND(SUM(p.payment_value), 2) AS total_revenue,
    ROUND(SUM(p.payment_value) / COUNT(DISTINCT c.customer_unique_id), 2) AS revenue_per_customer
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 10;