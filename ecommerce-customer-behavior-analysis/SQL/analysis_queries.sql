-- =====================================================
-- CONSUMER PSYCHOLOGY IN ECOMMERCE ANALYSIS
-- SQL Analytical Queries
-- =====================================================



-- =====================================================
-- 1. Expensive = Safer?
-- Do expensive purchases increase decision time?
-- =====================================================

SELECT
    CASE
        WHEN purchase_amount >= 300 THEN 'Expensive'
        ELSE 'Affordable'
    END AS price_category,

    COUNT(*) AS total_orders,

    AVG(time_to_decision) AS avg_decision_time,

    AVG(purchase_amount) AS avg_purchase

FROM ecommerce_clean

GROUP BY price_category;



-- =====================================================
-- 2. Discounts & Impulsive Purchases
-- Do discounts increase impulsive buying?
-- =====================================================

SELECT
    discount_used,
    purchase_intent,

    COUNT(*) AS total_orders,

    AVG(purchase_amount) AS avg_purchase

FROM ecommerce_clean

GROUP BY discount_used, purchase_intent

ORDER BY total_orders DESC;



-- =====================================================
-- 3. Loyalty & Spending
-- Do loyal customers spend more?
-- =====================================================

SELECT
    brand_loyalty,

    COUNT(*) AS total_customers,

    AVG(purchase_amount) AS avg_purchase,

    AVG(time_to_decision) AS avg_decision_time

FROM ecommerce_clean

GROUP BY brand_loyalty

ORDER BY avg_purchase DESC;

-- =====================================================
-- 4. Income & Decision Time
-- Do high-income customers take longer to decide?
-- =====================================================

SELECT
    income_level,

    AVG(time_to_decision) AS avg_decision_time,

    AVG(purchase_amount) AS avg_purchase,

    COUNT(*) AS total_customers

FROM ecommerce_clean

GROUP BY income_level

ORDER BY avg_decision_time DESC;



-- =====================================================
-- 5. Online vs In-Store Psychology
-- Are online shoppers more impulsive?
-- =====================================================

SELECT
    purchase_channel,
    purchase_intent,

    COUNT(*) AS total_orders,

    AVG(purchase_amount) AS avg_purchase

FROM ecommerce_clean

GROUP BY purchase_channel, purchase_intent

ORDER BY total_orders DESC;



-- =====================================================
-- 6. Social Media Influence
-- Does social media increase spending?
-- =====================================================

SELECT
    social_media_influence,

    AVG(purchase_amount) AS avg_purchase,

    AVG(time_to_decision) AS avg_decision_time,

    COUNT(*) AS total_customers

FROM ecommerce_clean

GROUP BY social_media_influence

ORDER BY avg_purchase DESC;



-- =====================================================
-- 7. Discount Sensitivity by Income
-- Are high-income customers less sensitive to discounts?
-- =====================================================

SELECT
    income_level,
    discount_sensitivity,

    COUNT(*) AS total_customers,

    AVG(purchase_amount) AS avg_purchase

FROM ecommerce_clean

GROUP BY income_level, discount_sensitivity

ORDER BY income_level, avg_purchase DESC;

-- =====================================================
-- 8. Emotional Purchases by Category
-- Which product categories trigger emotional purchases?
-- =====================================================

SELECT
    purchase_category,
    purchase_intent,
    COUNT(*) AS total_orders,
    ROUND(AVG(purchase_amount), 2) AS avg_purchase
FROM ecommerce_clean
WHERE purchase_intent IN ('Impulsive', 'Wants-based')
GROUP BY purchase_category, purchase_intent
HAVING COUNT(*) > 10
ORDER BY avg_purchase DESC;



-- =====================================================
-- 9. Customer Satisfaction vs Spending
-- Do satisfied customers spend more and decide faster?
-- =====================================================

SELECT
    customer_satisfaction,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount), 2) AS avg_purchase,
    ROUND(AVG(time_to_decision), 2) AS avg_decision_time
FROM ecommerce_clean
GROUP BY customer_satisfaction
ORDER BY customer_satisfaction DESC;



-- =====================================================
-- 10. Payment Methods & Spending Psychology
-- Which payment methods lead to higher spending?
-- =====================================================

SELECT
    payment_method,
    COUNT(*) AS total_orders,
    ROUND(AVG(purchase_amount), 2) AS avg_purchase,
    ROUND(AVG(time_to_decision), 2) AS avg_decision_time
FROM ecommerce_clean
GROUP BY payment_method
ORDER BY avg_purchase DESC;