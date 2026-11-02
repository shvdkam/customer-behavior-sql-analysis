# Consumer Behavior in E-commerce: Answers to the Business Questions

Answers to each query in [`analysis_queries.sql`](../SQL/analysis_queries.sql), with the numbers behind them. The data has 1,000 customers with one purchase each, amounts in US dollars. The overall average purchase is $275 and the average decision time is 7.5 days.

These are associations in one dataset, not causes. For the comparisons that looked interesting, I added 95% confidence intervals (queries 14 and 15). When the intervals of two groups overlap a lot, I don't treat the difference as a finding.

## 1. Do expensive purchases take longer to decide?

No. Purchases of $300 or more (447 orders, $401 on average) took 7.6 days to decide. Cheaper ones (553 orders, $173 on average) took 7.5 days. Price alone doesn't explain hesitation.

## 2. Are discounts linked to impulsive buying?

No. 24.6% of purchases with a discount were impulsive (128 of 521), and 25.1% without one (120 of 479). Discounts don't seem to trigger impulse purchases here.

## 3. Do more loyal customers spend more?

The opposite. Loyalty level 5 has the lowest average purchase ($256), level 4 is next ($267), and levels 2 and 3 are the highest ($287). See query 12 for the gap to the overall average.

## 4. Do higher-income customers take longer to decide?

Slightly. High income: 7.7 days, middle income: 7.4 days. They spend almost the same ($276 vs $275). The dataset only has these two income groups.

## 5. Does purchase intent differ between channels?

Not much. Each channel has roughly a quarter of each intent type. The averages differ more inside channels than between them: for example, need-based purchases in the mixed channel average $301, and impulsive online purchases $246. Query 13 shows the impulsive share per channel.

## 6. Is social media influence linked to higher spending?

There is a small gap: high influence $284, medium $280, low $273, none $263. Decision time is almost the same (7.4 days for high, 7.8 for none). Query 15 shows that the intervals overlap, so this gap isn't proven.

## 7. Does discount sensitivity differ by income?

Not in a clear way. The highest average is in high-income, "somewhat sensitive" customers ($295). The lowest is in high-income, "not sensitive" customers ($265). Income doesn't tell how sensitive a customer is to discounts: both income groups have a similar mix of the three levels.

## 8. Which categories show emotional buying?

There's no clear pattern. Among impulsive and wants-based purchases (groups with more than 10 orders), the highest averages are wants-based Groceries ($348), Health Care ($345) and Food & Beverages ($341). The highest impulsive group is Jewelry & Accessories ($323). But these groups have only 11 to 18 orders each, so their averages can move a lot with a few more purchases. I wouldn't build a campaign on this.

## 9. Do more satisfied customers spend more or decide faster?

No. By satisfaction score (1–10), the average purchase goes from $256 (score 10) to $294 (score 4) with no direction. Decision time goes from 7.1 days (score 10) to 8.1 days (score 2), also without a pattern.

## 10. Which payment methods go with higher spending?

The differences are small: other methods $283, PayPal $278, debit card $273, credit card $272, cash $268. Credit card users decide a bit faster (6.9 days, compared with 7.6–7.8 for the others).

## 11. Which categories have the highest average purchase?

After merging the split Travel & Leisure category, there are 22 categories. Software & Apps ranks first ($316), then Jewelry & Accessories ($303) and Books ($301). Arts & Crafts ($221) and Beauty & Personal Care ($234) are last. With about 40 orders per category, each average has an interval of roughly ±$40, so the middle of the ranking is not reliable.

## 12. Which loyalty groups spend above or below average?

Levels 2 and 3 spend about $11 above the overall average, level 1 is $5 above, level 4 is $8 below and level 5 is $19.50 below. Because there's only one purchase per customer, this can't show whether loyal customers buy more often. They might bring more money over time even with smaller purchases.

## 13. What share of purchases is impulsive in each channel?

In-store 27.0%, online 26.4%, mixed 21.2%. Online shopping isn't more impulsive in this data.

## 14. Is the lower spending on impulsive purchases real?

Yes, this is the one difference that holds up. Impulsive purchases average $257 (95% interval $242–$272). Wants-based purchases average $292 ($275–$309). The intervals don't overlap. Need-based ($281) and planned ($270) are in between.

## 15. Is the social media gap real?

Not with this sample. The "high" group's interval is $268–$300 and the "none" group's is $247–$279. They overlap, so the $21 gap can be random.

## 16. How are purchase amounts distributed?

Almost evenly. Every $50 range between $50 and $500 has between 100 and 120 orders. Real sales usually have many small purchases and fewer large ones, so this dataset may be generated. That would also explain why most factors show no effect.

## What I would do next

- Get data with several purchases per customer, to check whether loyal customers buy more often even though each purchase is smaller.
- Repeat the impulsive vs wants-based comparison on a larger or real dataset.
- Combine intent with category and channel once there are enough orders in each group.
