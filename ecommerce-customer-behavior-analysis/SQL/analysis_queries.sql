-- =====================================================
-- CONSUMER BEHAVIOR IN ECOMMERCE
-- SQL ANALYTICAL QUERIES
-- PostgreSQL
-- =====================================================

-- This analysis explores customer purchasing behavior
-- using demographic, behavioral, and psychological factors.
-- The queries focus on spending, discounts, loyalty,
-- purchase intent, social media influence, satisfaction,
-- and payment preferences.


-- =====================================================
-- 1. Expensive Purchases & Decision Time
-- Do expensive purchases require more decision time?
-- =====================================================

SELECT
    CASE
        WHEN purchase_amount >= 300 THEN 'Expensive'
        ELSE 'Affordable'
    END AS price_category,

    COUNT(*) AS total_orders,

    ROUND(AVG(time_to_decision), 2) AS avg_decision_time,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase

FROM ecommerce_clean

GROUP BY price_category

ORDER BY avg_purchase DESC;


-- =====================================================
-- 2. Discounts & Impulsive Purchases
-- Are discounts associated with impulsive buying?
-- =====================================================

SELECT
    discount_used,
    purchase_intent,

    COUNT(*) AS total_orders,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase

FROM ecommerce_clean

GROUP BY
    discount_used,
    purchase_intent

ORDER BY total_orders DESC;


-- =====================================================
-- 3. Loyalty & Spending
-- Do more loyal customers spend more?
-- =====================================================

SELECT
    brand_loyalty,

    COUNT(*) AS total_orders,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase,

    ROUND(AVG(time_to_decision), 2) AS avg_decision_time

FROM ecommerce_clean

GROUP BY brand_loyalty

ORDER BY avg_purchase DESC;


-- =====================================================
-- 4. Income & Decision Time
-- Do higher-income customers take longer to decide?
-- =====================================================

SELECT
    income_level,

    COUNT(*) AS total_orders,

    ROUND(AVG(time_to_decision), 2) AS avg_decision_time,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase

FROM ecommerce_clean

GROUP BY income_level

ORDER BY avg_decision_time DESC;


-- =====================================================
-- 5. Online vs In-Store Purchasing Behavior
-- Does purchase intent differ between shopping channels?
-- =====================================================

SELECT
    purchase_channel,
    purchase_intent,

    COUNT(*) AS total_orders,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase

FROM ecommerce_clean

GROUP BY
    purchase_channel,
    purchase_intent

ORDER BY total_orders DESC;


-- =====================================================
-- 6. Social Media Influence
-- Is social media influence associated with higher spending?
-- =====================================================

SELECT
    social_media_influence,

    COUNT(*) AS total_orders,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase,

    ROUND(AVG(time_to_decision), 2) AS avg_decision_time

FROM ecommerce_clean

GROUP BY social_media_influence

ORDER BY avg_purchase DESC;


-- =====================================================
-- 7. Discount Sensitivity by Income
-- Does discount sensitivity differ across income groups?
-- =====================================================

SELECT
    income_level,
    discount_sensitivity,

    COUNT(*) AS total_orders,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase

FROM ecommerce_clean

GROUP BY
    income_level,
    discount_sensitivity

ORDER BY
    income_level,
    avg_purchase DESC;


-- =====================================================
-- 8. Emotional Purchases by Category
-- Which product categories show stronger emotional buying?
-- =====================================================

SELECT
    purchase_category,
    purchase_intent,

    COUNT(*) AS total_orders,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase

FROM ecommerce_clean

WHERE purchase_intent IN ('Impulsive', 'Wants-based')

GROUP BY
    purchase_category,
    purchase_intent

-- Small groups are excluded to reduce the risk of
-- drawing conclusions from very limited observations.
HAVING COUNT(*) > 10

ORDER BY avg_purchase DESC;


-- =====================================================
-- 9. Customer Satisfaction vs Spending
-- Do more satisfied customers spend more or decide faster?
-- =====================================================

SELECT
    customer_satisfaction,

    COUNT(*) AS total_orders,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase,

    ROUND(AVG(time_to_decision), 2) AS avg_decision_time

FROM ecommerce_clean

GROUP BY customer_satisfaction

ORDER BY customer_satisfaction DESC;


-- =====================================================
-- 10. Payment Methods & Spending
-- Which payment methods are associated with higher spending?
-- =====================================================

SELECT
    payment_method,

    COUNT(*) AS total_orders,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase,

    ROUND(AVG(time_to_decision), 2) AS avg_decision_time

FROM ecommerce_clean

GROUP BY payment_method

ORDER BY avg_purchase DESC;


-- =====================================================
-- ADVANCED ANALYSIS
-- =====================================================


-- =====================================================
-- 11. Product Category Spending Ranking
-- Which product categories have the highest
-- average purchase amount?
--
-- SQL concepts:
-- CTE + Window Function + RANK()
-- =====================================================

WITH category_spending AS (

    SELECT
        purchase_category,

        COUNT(*) AS total_orders,

        ROUND(AVG(purchase_amount), 2) AS avg_purchase

    FROM ecommerce_clean

    GROUP BY purchase_category
)

SELECT
    purchase_category,
    total_orders,
    avg_purchase,

    RANK() OVER (
        ORDER BY avg_purchase DESC
    ) AS spending_rank

FROM category_spending

ORDER BY spending_rank;


-- =====================================================
-- 12. Loyalty Groups vs Overall Average
-- Which loyalty groups spend above or below
-- the overall customer average?
--
-- SQL concepts:
-- Subquery + Aggregation
-- =====================================================

SELECT
    brand_loyalty,

    COUNT(*) AS total_orders,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase,

    ROUND(
        AVG(purchase_amount)
        - (SELECT AVG(purchase_amount)
           FROM ecommerce_clean),
        2
    ) AS difference_from_overall_avg

FROM ecommerce_clean

GROUP BY brand_loyalty

ORDER BY difference_from_overall_avg DESC;


-- =====================================================
-- 13. Impulsive Purchase Rate by Channel
-- What percentage of purchases are impulsive
-- within each shopping channel?
--
-- SQL concepts:
-- CASE WHEN + Conditional Aggregation + Percentage
-- =====================================================

SELECT
    purchase_channel,

    COUNT(*) AS total_orders,

    SUM(
        CASE
            WHEN purchase_intent = 'Impulsive' THEN 1
            ELSE 0
        END
    ) AS impulsive_orders,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN purchase_intent = 'Impulsive' THEN 1
                ELSE 0
            END
        )
        / COUNT(*),
        2
    ) AS impulsive_rate_pct

FROM ecommerce_clean

GROUP BY purchase_channel

ORDER BY impulsive_rate_pct DESC;


-- =====================================================
-- CHECKING WHICH DIFFERENCES ARE REAL
-- =====================================================

-- Most group averages above differ by only a few dollars.
-- With about 100-250 customers per group, part of that
-- difference can be random. These queries add an approximate
-- 95% confidence interval: avg +/- 1.96 * stddev / sqrt(n).
-- If the intervals of two groups overlap a lot, I don't treat
-- the difference between them as a real finding.


-- =====================================================
-- 14. Purchase Intent: Spending With Confidence Intervals
-- Do impulsive purchases really have a lower amount?
--
-- SQL concepts:
-- STDDEV_SAMP + SQRT + interval calculation
-- =====================================================

SELECT
    purchase_intent,

    COUNT(*) AS total_orders,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase,

    ROUND(
        AVG(purchase_amount)
        - 1.96 * STDDEV_SAMP(purchase_amount) / SQRT(COUNT(*)::NUMERIC),
        2
    ) AS ci_low,

    ROUND(
        AVG(purchase_amount)
        + 1.96 * STDDEV_SAMP(purchase_amount) / SQRT(COUNT(*)::NUMERIC),
        2
    ) AS ci_high

FROM ecommerce_clean

GROUP BY purchase_intent

ORDER BY avg_purchase DESC;


-- =====================================================
-- 15. Social Media Influence: Spending With Confidence Intervals
-- Is the higher spending of the 'High' group a real difference?
-- =====================================================

SELECT
    social_media_influence,

    COUNT(*) AS total_orders,

    ROUND(AVG(purchase_amount), 2) AS avg_purchase,

    ROUND(
        AVG(purchase_amount)
        - 1.96 * STDDEV_SAMP(purchase_amount) / SQRT(COUNT(*)::NUMERIC),
        2
    ) AS ci_low,

    ROUND(
        AVG(purchase_amount)
        + 1.96 * STDDEV_SAMP(purchase_amount) / SQRT(COUNT(*)::NUMERIC),
        2
    ) AS ci_high

FROM ecommerce_clean

GROUP BY social_media_influence

ORDER BY avg_purchase DESC;


-- =====================================================
-- 16. Distribution of Purchase Amounts
-- How are purchase amounts spread between $50 and $500?
--
-- SQL concepts:
-- WIDTH_BUCKET for a simple histogram
-- =====================================================

SELECT
    WIDTH_BUCKET(purchase_amount, 50, 500, 9) AS bucket,

    MIN(purchase_amount) AS min_amount,

    MAX(purchase_amount) AS max_amount,

    COUNT(*) AS total_orders

FROM ecommerce_clean

GROUP BY bucket

ORDER BY bucket;
