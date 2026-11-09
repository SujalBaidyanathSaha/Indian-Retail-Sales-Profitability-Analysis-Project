# SQL Business Analysis

## Purpose

PostgreSQL was used to validate the cleaned dataset and perform structured business analysis using aggregations, CTEs, window functions, ranking, conditional aggregation, and time-series analysis.

The SQL analysis focused on understanding business performance and investigating the discount-profitability relationship identified during the initial Excel analysis.

## Data Validation

The PostgreSQL table contained:

| Check | Result |
|---|---:|
| Total Rows | 100,000 |
| Unique Orders | 100,000 |
| Unique Customers | 100,000 |
| Unique Product IDs | 100,000 |

The main financial KPIs matched the Excel results.

| KPI | Result |
|---|---:|
| Total Sales | ₹250.84 Cr |
| Total Profit | ₹37.55 Cr |
| Profit Margin | 14.97% |
| Transactions | 100,000 |
| Total Quantity | 549,376 |
| Avg. Transaction Value | ₹25,084 |
| Avg. Discount | 25.13% |
| Avg. Shipping Days | 3.99 |

---

## Yearly Performance

| Year | Sales | Profit | Margin | Sales YoY | Profit YoY |
|---|---:|---:|---:|---:|---:|
| 2019 | ₹50.22 Cr | ₹7.51 Cr | 14.96% | — | — |
| 2020 | ₹50.08 Cr | ₹7.50 Cr | 14.98% | -0.28% | -0.15% |
| 2021 | ₹50.13 Cr | ₹7.51 Cr | 14.99% | 0.10% | 0.12% |
| 2022 | ₹50.20 Cr | ₹7.50 Cr | 14.95% | 0.13% | -0.11% |
| 2023 | ₹50.23 Cr | ₹7.52 Cr | 14.97% | 0.06% | 0.18% |

### Finding

Business performance remained highly stable from 2019 to 2023. Sales, profit, transaction volume, and profit margin showed very little year-over-year movement.

---

## Product Performance

Each of the six product categories contributed approximately 16.5–16.7% of total company sales.

Seasonal Fruits & Vegetables ranked first in sales, while Household Items ranked first in profit. Fast Food ranked fifth in sales but second in profit due to its slightly higher profit margin.

However, the differences between categories were small.

### Finding

No category dominated company performance. Product-category contribution and profitability were highly balanced.

---

## Geographic and Segment Performance

State contribution was also evenly distributed.

Rajasthan generated the highest sales contribution at approximately 10.20%, while Uttar Pradesh generated approximately 9.78%.

Profit margins remained close to 15% across every state.

Consumer and Corporate customers were also almost evenly split:

| Segment | Sales | Profit | Avg. Transaction | Margin |
|---|---:|---:|---:|---:|
| Corporate | ₹125.51 Cr | ₹18.78 Cr | ₹25,169 | 14.96% |
| Consumer | ₹125.33 Cr | ₹18.78 Cr | ₹25,000 | 14.98% |

### Finding

Neither geography nor customer segment showed a material profitability difference.

---

## Monthly Performance

Monthly sales fluctuated moderately but no strong recurring seasonal pattern was identified.

The highest individual month was May 2023, while February 2019 recorded the lowest sales.

Profit margins remained broadly stable across monthly periods.

---

## Discount Analysis

Discounting produced the strongest profitability difference in the dataset.

| Discount Band | Avg. Transaction Value | Avg. Profit / Transaction | Profit Margin | Profit Contribution |
|---|---:|---:|---:|---:|
| 0–10% | ₹24,964 | ₹4,756 | 19.05% | 23.79% |
| 10–20% | ₹25,236 | ₹4,305 | 17.06% | 22.82% |
| 20–30% | ₹25,096 | ₹3,784 | 15.08% | 20.00% |
| 30–40% | ₹25,011 | ₹3,277 | 13.10% | 17.62% |
| 40–50% | ₹25,108 | ₹2,784 | 11.09% | 15.77% |

Average transaction value remained close to ₹25,000 across all discount levels.

However, from the lowest to highest discount band:

- average profit per transaction declined by approximately 41.5%;
- profit margin declined from 19.05% to 11.09%;
- profit contribution fell despite the highest-discount group having the largest transaction share.

### Category Validation

The margin decline was present across all six categories.

Low-discount margins were approximately 19%, while high-discount margins were approximately 11%.

The low-to-high discount margin gap was roughly 7.8–8.1 percentage points across categories.

### Time Validation

The relationship was also consistent across all five years.

Each year followed approximately the same pattern:

`19% → 17% → 15% → 13% → 11%`

as discount levels increased.

### Finding

Higher discount levels were consistently associated with lower profitability, while average transaction value remained broadly unchanged.

The relationship was visible across the overall business, every major product category, and every year in the dataset.

This makes discounting the strongest profitability pattern identified during the SQL analysis.

The analysis shows association rather than proof of causation.

---

## Shipping Performance

All four shipping modes generated similar sales, profit, transaction counts, and shipping durations.

Average shipping time was approximately four days for every mode, including Same Day.

### Finding

Ship Mode did not provide a meaningful operational performance difference and should be interpreted cautiously due to the limitations of the source data.

---

## SQL Techniques Used

The analysis used:

- Aggregate functions
- GROUP BY and ORDER BY
- CTEs
- CASE WHEN
- Window functions
- LAG
- RANK
- PARTITION BY
- FILTER
- DATE_TRUNC and EXTRACT
- Contribution calculations
- Year-over-year growth
- Conditional aggregation

## SQL Conclusion

SQL confirmed that most business dimensions were unusually stable.

Year, product category, geography, customer segment, and shipping mode showed relatively small differences.

Discounting remained the main area requiring deeper investigation.

Transactions with higher discounts generated almost the same average sales value as low-discount transactions but substantially lower profit per transaction and profit margin.

This relationship was consistent across categories and years, so the next stage of the project will use Python to examine the relationship statistically and determine how strongly discount, sales, profit, quantity, and margin are related.