-- Create raw table

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

-- Create cleaned analytical table

DROP TABLE IF EXISTS ecommerce_clean;

CREATE TABLE ecommerce_clean AS
SELECT
    customer_id,

    NULLIF(age, 'None')::INT AS age,

    gender,
    income_level,
    marital_status,
    education_level,
    occupation,
    location,
    purchase_category,

    REPLACE(purchase_amount, '$', '')::NUMERIC AS purchase_amount,

    NULLIF(frequency_of_purchase, 'None')::INT AS frequency_of_purchase,

    purchase_channel,

    brand_loyalty,
    product_rating,

    research_hours,

    social_media_influence,
    discount_sensitivity,

    return_rate,
    customer_satisfaction,
    engagement_with_ads,

    device_used_for_shopping,
    payment_method,

    purchase_date,

    discount_used,
    customer_loyalty_program_member,
    purchase_intent,
    shipping_preference,

    NULLIF(time_to_decision, 'None')::INT AS time_to_decision

FROM ecommerce_raw;