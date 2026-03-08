-- ================================================
-- ADVANCED ANALYSIS - WINDOW FUNCTIONS & CTEs
-- Project: Olist E-commerce SQL Analysis
-- ================================================

-- Month-over-month revenue growth %
WITH monthly_revenue AS (
    SELECT 
        strftime('%Y-%m', order_purchase_timestamp) AS month,
        ROUND(SUM(payment_value), 2) AS total_revenue
    FROM olist_orders_dataset o
    JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
    WHERE order_status = 'delivered'
    GROUP BY month
)
SELECT 
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND((total_revenue - LAG(total_revenue) OVER (ORDER BY month)) 
          * 100.0 / LAG(total_revenue) OVER (ORDER BY month), 2) AS growth_percentage
FROM monthly_revenue
ORDER BY month;

-- Top 3 sellers by revenue within each product category
WITH seller_category_revenue AS (
    SELECT 
        t.product_category_name_english AS category,
        i.seller_id,
        ROUND(SUM(p.payment_value), 2) AS total_revenue
    FROM olist_orders_dataset o
    JOIN olist_order_items_dataset i ON o.order_id = i.order_id
    JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
    JOIN olist_products_dataset pr ON i.product_id = pr.product_id
    JOIN product_category_name_translation t ON pr.product_category_name = t.product_category_name
    WHERE o.order_status = 'delivered'
    GROUP BY category, i.seller_id
),
ranked AS (
    SELECT 
        category,
        seller_id,
        total_revenue,
        RANK() OVER (PARTITION BY category ORDER BY total_revenue DESC) AS rank_in_category
    FROM seller_category_revenue
)
SELECT * FROM ranked
WHERE rank_in_category <= 3
ORDER BY category, rank_in_category;