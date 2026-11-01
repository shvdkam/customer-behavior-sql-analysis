# Supply Chain Performance Analysis | Tableau

**55% of 63.6K orders were delivered late. The biggest problem was First Class shipping: only 5% of First Class orders arrived on time, compared with 62% for Standard Class.**

I built two interactive Tableau dashboards that connect sales and profit with delivery performance, and used them to find where the company loses reliability.

## Dashboards

### Executive Overview

![Executive Overview](executive-overview.png)

| KPI | Value |
|---|---:|
| Total sales | 36.5M |
| Total profit | 3.93M |
| Profit margin | 10.8% |
| Sales YoY growth (latest year) | -4.0% |
| Orders | 63.6K |
| Average order value | 573 |

Filters: year, market, category.

### Delivery & Operations

![Delivery & Operations Performance](delivery-operations.png)

| KPI | Value |
|---|---:|
| On-time delivery | 45% |
| Late delivery rate | 55% |
| Average delivery time | 3.5 days |

Filters: year, market, shipping mode.

## Key findings

**1. Shipping mode explains the delays, the market doesn't.**

| Shipping mode | Orders | On-time delivery |
|---|---:|---:|
| Standard Class | 38,094 | 62% |
| Same Day | 3,451 | 54% |
| Second Class | 12,333 | 23% |
| First Class | 9,751 | 5% |

Late delivery rates by market are almost the same, from 54.4% (LATAM) to 55.2% (Europe). So the problem isn't one region. It sits in how the faster shipping modes are planned or promised.

**2. Volume is not the cause.** Standard Class handles 60% of all orders and still has the best on-time rate.

**3. The problem is not getting better.** On-time delivery stays around 45% across the whole period, with no lasting improvement.

**4. Sales are concentrated in two markets.** Europe (29.8%) and LATAM (28.2%) bring 58% of sales. The company is profitable (10.8% margin), but sales fell 4.0% in the latest year.

## Recommendations

1. Investigate First Class first: promised delivery times, warehouse processing and carriers.
2. Use Standard Class as the benchmark for what a working process looks like.
3. Treat delays as a company-wide process issue, not a regional one.
4. Set an on-time delivery target per shipping mode, starting from the 45% baseline.
5. Watch the -4.0% sales trend by market and category.
6. Review categories where high sales come with a below-average margin.

## How I calculated the main metrics

```text
On-Time Delivery  = IF [Late_delivery_risk] = 0 THEN 1 ELSE 0 END   (averaged)
Profit Margin     = SUM([Profit]) / SUM([Sales])
Sales YoY Growth  = (SUM([Sales]) - LOOKUP(SUM([Sales]), -1)) / ABS(LOOKUP(SUM([Sales]), -1))
```

## Files

- `Supply Chain Performance Analysis.twbx`: the full Tableau workbook. Download it and open it in Tableau to use the filters.
- `executive-overview.png`, `delivery-operations.png`: dashboard screenshots.

**Tools:** Tableau (calculated fields, table calculations, interactive filters)
