# Consumer Behavior Analysis | SQL (PostgreSQL)

**Most of the factors that "should" drive spending barely changed it. Payment method, satisfaction, income and social media influence all moved the average purchase by a few dollars, and the differences are within random noise. The one clear signal: impulsive purchases are smaller ($257 on average, compared with $292 for wants-based purchases).**

I cleaned a raw e-commerce customer dataset in PostgreSQL, answered 13 business questions about price, discounts, loyalty, income, channel, social media and payment methods, and then checked which differences are real by adding 95% confidence intervals.

## Data

- Ecommerce Consumer Behavior Analysis Data (Kaggle), file `Ecommerce_Consumer_Behavior_Analysis_Data.csv`
- 1,000 customers, one purchase record each, 28 columns
- Customer data: income, loyalty (1–5), satisfaction (1–10), social media influence, discount sensitivity
- Purchase data: category, amount, intent (impulsive, need-based, planned, wants-based), channel, payment method, time to decision (1–14 days)
- Amounts are in US dollars (the raw data has a `$` sign, which I removed during cleaning)

## What I did

**1. Cleaning** ([`cleaning.sql`](ecommerce-customer-behavior-analysis/SQL/cleaning.sql))
- checked record count, duplicate customer IDs (none) and missing values
- trimmed text, turned empty markers into `NULL`
- converted amounts, scores and decision time to numeric types
- created a separate clean table `ecommerce_clean` and checked value ranges

Two problems I found and fixed along the way:
- **One category was split into three.** The raw file has "Travel & Leisure (Flights", "Hotels" and "Packages)" as separate categories (117 orders in total). It's clearly one category, "Travel & Leisure (Flights, Hotels, Packages)", cut at the commas. The other columns in these rows are correct, so I merged the three labels back into one.
- **Satisfaction was sorted as text.** In my first version, the 1–10 score was stored as text, so it sorted as 9, 8, 7 … 2, 10, 1. I changed satisfaction, loyalty and product rating to integers.

**2. Analysis** ([`analysis_queries.sql`](ecommerce-customer-behavior-analysis/SQL/analysis_queries.sql))
- `GROUP BY` with `COUNT`, `AVG`, `ROUND`
- `CASE WHEN` to build groups (for example expensive vs affordable)
- a CTE with `RANK()` to rank categories by average purchase
- a subquery to compare loyalty groups with the overall average
- conditional aggregation for the share of impulsive purchases per channel
- `STDDEV_SAMP` and `SQRT` for 95% confidence intervals, and `WIDTH_BUCKET` for a histogram of amounts

## Key findings

**1. Price doesn't slow decisions down.**

| Purchase | Orders | Avg. decision time | Avg. amount |
|---|---:|---:|---:|
| Expensive ($300+) | 447 | 7.6 days | $401 |
| Affordable | 553 | 7.5 days | $173 |

**2. Impulsive purchases are the smallest.** The average impulsive purchase is $257 (95% interval $242–$272). Wants-based purchases average $292 ($275–$309). The two intervals don't overlap, so this is the one difference in the data I'd call real.

**3. Payment method, satisfaction and income don't matter much.** By payment method, averages go from $268 (cash) to $283 (other methods), and all the intervals overlap. By satisfaction score, they go from $256 to $294 with no direction: the highest average is at score 4 and the lowest at score 10. High and middle income customers spend almost the same ($276 vs $275).

**4. Social media influence: a small gap that isn't proven.** Customers with high social media influence spend $284 on average, customers with none $263. That looks like a $21 gap, but the intervals ($268–$300 and $247–$279) overlap, so with 1,000 customers I can't say it's real. Decision time is almost the same (7.4 vs 7.8 days).

**5. The most loyal customers spend the least per purchase.** Loyalty level 5 averages $256, which is $19.50 below the overall average of $275. Levels 2 and 3 are the highest ($287). The intervals still overlap a little, so this needs more data, but it's a pattern worth checking.

**6. Online shoppers aren't more impulsive.** 27.0% of in-store purchases are impulsive, 26.4% online and 21.2% in mixed channels. Discounts don't change it either: 24.6% of purchases with a discount are impulsive, and 25.1% without one.

**7. Category rankings are shaky.** Software & Apps has the highest average purchase ($316) and Arts & Crafts the lowest ($221). But each category has only about 40 orders, so the interval around each average is roughly ±$40, and most of the ranking can change with new data.

Full answers to all questions: [`business_insights.md`](ecommerce-customer-behavior-analysis/insights/business_insights.md). Query results: [`screenshots`](ecommerce-customer-behavior-analysis/screenshots).

## What this means for a business

In this data, price, payment method, satisfaction, income and social media influence are weak signals for predicting how much a customer spends. Purchase intent is the only factor with a clear effect. If I had to build segments for marketing, I'd start from intent, and I'd test the loyalty pattern on more data before acting on it.

## Limitations

- 1,000 records, so small differences between groups can be noise. That's why I added confidence intervals.
- One purchase per customer: the data can't show lifetime value or repeat purchases. This matters for the loyalty finding, because loyal customers may buy more often even if each purchase is smaller.
- Purchase amounts are spread almost evenly between $50 and $500 (100–120 orders in every $50 range), and most groups are about the same size. Real sales data usually isn't this even, so the dataset may be generated. That would also explain why most factors have no effect.
- The results are associations, not causes.

**Tools:** PostgreSQL, pgAdmin 4
