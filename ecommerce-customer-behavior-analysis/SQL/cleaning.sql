-- =====================================================
-- ECOMMERCE CUSTOMER BEHAVIOR
-- DATA CLEANING
-- PostgreSQL
-- =====================================================


-- =====================================================
-- 1. Create raw table
-- =====================================================

DROP TABLE IF EXISTS ecommerce_raw;

CREATE TABLE ecommerce_raw (
    customer_id TEXT,
    age TEXT,
    gender TEXT,
    income_level TEXT,
    marital_status TEXT,
    education_level TEXT,
    occupation TEXT,
    location TEXT,
    purchase_category TEXT,
    purchase_amount TEXT,
    frequency_of_purchase TEXT,
    purchase_channel TEXT,
    brand_loyalty TEXT,
    product_rating TEXT,
    time_spent_on_product_research_hours TEXT,
    social_media_influence TEXT,
    discount_sensitivity TEXT,
    return_rate TEXT,
    customer_satisfaction TEXT,
    engagement_with_ads TEXT,
    device_used_for_shopping TEXT,
    payment_method TEXT,
    time_of_purchase TEXT,
    discount_used TEXT,
    customer_loyalty_program_member TEXT,
    purchase_intent TEXT,
    shipping_preference TEXT,
    time_to_decision TEXT
);


-- =====================================================
-- 2. Inspect raw data
-- =====================================================

SELECT *
FROM ecommerce_raw
LIMIT 10;


-- =====================================================
-- 3. Check total number of rows
-- =====================================================

SELECT COUNT(*) AS total_rows
FROM ecommerce_raw;


-- =====================================================
-- 4. Check duplicate rows
-- =====================================================

SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM ecommerce_raw
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- =====================================================
-- 5. Check missing values in important columns
-- =====================================================

SELECT
    SUM(
        CASE
            WHEN customer_id IS NULL
                 OR TRIM(customer_id) = ''
                 OR customer_id = 'None'
            THEN 1
            ELSE 0
        END
    ) AS missing_customer_id,

    SUM(
        CASE
            WHEN age IS NULL
                 OR TRIM(age) = ''
                 OR age = 'None'
            THEN 1
            ELSE 0
        END
    ) AS missing_age,

    SUM(
        CASE
            WHEN purchase_amount IS NULL
                 OR TRIM(purchase_amount) = ''
                 OR purchase_amount = 'None'
            THEN 1
            ELSE 0
        END
    ) AS missing_purchase_amount,

    SUM(
        CASE
            WHEN time_to_decision IS NULL
                 OR TRIM(time_to_decision) = ''
                 OR time_to_decision = 'None'
            THEN 1
            ELSE 0
        END
    ) AS missing_decision_time

FROM ecommerce_raw;


-- =====================================================
-- 6. Create cleaned analytical table
-- =====================================================

DROP TABLE IF EXISTS ecommerce_clean;

CREATE TABLE ecommerce_clean AS

SELECT
    NULLIF(TRIM(customer_id), '') AS customer_id,

    NULLIF(
        NULLIF(TRIM(age), ''),
        'None'
    )::INT AS age,

    NULLIF(TRIM(gender), '') AS gender,

    NULLIF(TRIM(income_level), '') AS income_level,

    NULLIF(TRIM(marital_status), '') AS marital_status,

    NULLIF(TRIM(education_level), '') AS education_level,

    NULLIF(TRIM(occupation), '') AS occupation,

    NULLIF(TRIM(location), '') AS location,

    NULLIF(TRIM(purchase_category), '') AS purchase_category,

    NULLIF(
        NULLIF(
            REPLACE(TRIM(purchase_amount), '$', ''),
            ''
        ),
        'None'
    )::NUMERIC AS purchase_amount,

    NULLIF(
        NULLIF(TRIM(frequency_of_purchase), ''),
        'None'
    )::INT AS frequency_of_purchase,

    NULLIF(TRIM(purchase_channel), '') AS purchase_channel,

    NULLIF(TRIM(brand_loyalty), '') AS brand_loyalty,

    NULLIF(TRIM(product_rating), '') AS product_rating,

    NULLIF(
        NULLIF(
            TRIM(time_spent_on_product_research_hours),
            ''
        ),
        'None'
    )::NUMERIC AS research_hours,

    NULLIF(TRIM(social_media_influence), '')
        AS social_media_influence,

    NULLIF(TRIM(discount_sensitivity), '')
        AS discount_sensitivity,

    NULLIF(TRIM(return_rate), '') AS return_rate,

    NULLIF(TRIM(customer_satisfaction), '')
        AS customer_satisfaction,

    NULLIF(TRIM(engagement_with_ads), '')
        AS engagement_with_ads,

    NULLIF(TRIM(device_used_for_shopping), '')
        AS device_used_for_shopping,

    NULLIF(TRIM(payment_method), '') AS payment_method,

    NULLIF(TRIM(time_of_purchase), '') AS time_of_purchase,

    NULLIF(TRIM(discount_used), '') AS discount_used,

    NULLIF(TRIM(customer_loyalty_program_member), '')
        AS customer_loyalty_program_member,

    NULLIF(TRIM(purchase_intent), '') AS purchase_intent,

    NULLIF(TRIM(shipping_preference), '')
        AS shipping_preference,

    NULLIF(
        NULLIF(TRIM(time_to_decision), ''),
        'None'
    )::INT AS time_to_decision

FROM ecommerce_raw;


-- =====================================================
-- 7. Validate cleaned table
-- =====================================================

SELECT *
FROM ecommerce_clean
LIMIT 10;


-- =====================================================
-- 8. Check cleaned row count
-- =====================================================

SELECT COUNT(*) AS cleaned_rows
FROM ecommerce_clean;


-- =====================================================
-- 9. Check basic numeric ranges
-- =====================================================

SELECT
    MIN(age) AS min_age,
    MAX(age) AS max_age,

    MIN(purchase_amount) AS min_purchase,
    MAX(purchase_amount) AS max_purchase,

    MIN(time_to_decision) AS min_decision_time,
    MAX(time_to_decision) AS max_decision_time

FROM ecommerce_clean;


-- =====================================================
-- 10. Check category values
-- =====================================================

SELECT DISTINCT purchase_channel
FROM ecommerce_clean
ORDER BY purchase_channel;

SELECT DISTINCT purchase_intent
FROM ecommerce_clean
ORDER BY purchase_intent;

SELECT DISTINCT income_level
FROM ecommerce_clean
ORDER BY income_level;

SELECT DISTINCT payment_method
FROM ecommerce_clean
ORDER BY payment_method;
