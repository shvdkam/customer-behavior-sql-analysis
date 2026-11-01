# Consumer Behavior Analysis | SQL (PostgreSQL)

**Most of the factors that "should" drive spending barely changed it. Across 1,000 customers, average purchase differed by less than 6% between payment methods, and expensive purchases (300+) took almost the same time to decide as cheaper ones (7.6 vs 7.5 days).**

I cleaned a raw e-commerce customer dataset in PostgreSQL and answered 13 business questions about price, discounts, loyalty, income, channel, social media and payment methods.

## Data

- 1,000 customers, one purchase record each
- Customer data: income, loyalty, satisfaction, social media influence, discount sensitivity
- Purchase data: category, amount, intent (for example impulsive or wants-based), channel, payment method, time to decision

## What I did

**1. Cleaning** ([`SQL/cleaning.sql`](SQL/cleaning.sql))
- checked record count, duplicate customer IDs and missing values
- trimmed text, turned empty markers into `NULL`
- converted text columns to numeric types and cleaned purchase amounts
- created a separate clean table `ecommerce_clean` and checked value ranges

**2. Analysis** ([`SQL/analysis_queries.sql`](SQL/analysis_queries.sql))
- `GROUP BY` with `COUNT`, `AVG`, `ROUND`
- `CASE WHEN` to build groups (for example expensive vs affordable)
- subqueries to compare groups with the overall average
- percentages of impulsive purchases within each channel

## Key findings

**1. Price doesn't slow decisions down.**

| Purchase | Orders | Avg. decision time | Avg. amount |
|---|---:|---:|---:|
| Expensive (300+) | 447 | 7.6 days | 401 |
| Affordable | 553 | 7.5 days | 173 |

**2. Payment method changes spending only a little.** Averages range from 268 (cash) to 283 (other methods), with PayPal at 278.

**3. Satisfaction doesn't predict spending.** Average purchase by satisfaction score goes from 256 to 294 with no clear direction.

**4. Emotional categories stand out.** Jewelry, electronics, home appliances and luxury goods often appear among impulsive purchases, and impulsive jewelry purchases average 323.

**5. Social media influence is linked to higher spending and faster decisions.** This is an association, not proof that social media causes it.

Full answers to all 13 questions: [`insights/business_insights.md`](insights/business_insights.md). Query results: [`screenshots/`](screenshots).

## What this means for a business

Price, payment method and satisfaction alone are weak signals for predicting spend in this data. Segments built on purchase intent and category, plus social media influence, look more useful for targeting.

## Limitations

- 1,000 records, so small differences between groups can be noise.
- One purchase per customer: the data can't show lifetime value or repeat purchases.
- The results are associations, not causes.

**Tools:** PostgreSQL, pgAdmin 4
