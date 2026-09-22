# 🛒 Consumer Behavior SQL Analysis

## Project Overview

This project analyzes ecommerce customer behavior using **PostgreSQL**.

The goal of the project is to explore how factors such as **income, discounts, purchase intent, customer satisfaction, social media influence, brand loyalty, shopping channel, and payment methods** are associated with purchasing behavior.

The project follows a complete analytical workflow: from data cleaning and validation to SQL analysis and interpretation of the results from a business perspective.

---

## Business Questions

The analysis focuses on the following questions:

1. Do expensive purchases require more decision time?
2. Are discounts associated with impulsive purchasing behavior?
3. Do more loyal customers spend more?
4. Do higher-income customers take longer to make purchase decisions?
5. Does purchase intent differ between online and in-store channels?
6. Is stronger social media influence associated with higher spending?
7. Does discount sensitivity differ across income groups?
8. Which product categories show stronger emotional purchasing behavior?
9. Is customer satisfaction associated with spending or decision time?
10. Which payment methods are associated with higher spending?
11. Which product categories have the highest average purchase amount?
12. Which loyalty groups spend above or below the overall customer average?
13. What percentage of purchases are impulsive within each shopping channel?

---

## Analytical Workflow

**Business Questions → Data Cleaning → Data Validation → SQL Analysis → Results → Business Insights**

### 1. Data Cleaning

The raw dataset was imported into PostgreSQL and reviewed before analysis.

The cleaning process included:

* checking the total number of records;
* checking duplicate customer IDs;
* identifying missing values in key fields;
* removing unnecessary whitespace;
* converting missing-value indicators into `NULL`;
* converting text fields into appropriate numeric data types;
* cleaning purchase amount values;
* creating a separate analytical table;
* validating numerical ranges and categorical values.

The cleaning queries are available here:

[`cleaning.sql`](SQL/cleaning.sql)

---

### 2. SQL Analysis

The cleaned dataset was analyzed in PostgreSQL to explore relationships between customer characteristics and purchasing behavior.

SQL techniques used in the project include:

* filtering with `WHERE`;
* aggregation with `COUNT()`, `AV

