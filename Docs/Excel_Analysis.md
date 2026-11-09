# Excel Analysis

## Purpose

Excel and Power Query were used for data cleaning, validation, KPI calculation, and initial descriptive business analysis.

## Overall Business Performance

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

The business generated approximately ₹250.84 crore in sales and ₹37.55 crore in profit, with an overall profit margin of 14.97%.

---

## Yearly Performance

| Year | Sales | Profit | Margin | Sales YoY |
|---|---:|---:|---:|---:|
| 2019 | ₹50.22 Cr | ₹7.51 Cr | 14.96% | — |
| 2020 | ₹50.08 Cr | ₹7.50 Cr | 14.98% | -0.28% |
| 2021 | ₹50.13 Cr | ₹7.51 Cr | 14.99% | 0.10% |
| 2022 | ₹50.20 Cr | ₹7.50 Cr | 14.95% | 0.13% |
| 2023 | ₹50.23 Cr | ₹7.52 Cr | 14.97% | 0.06% |

### Finding

Business performance remained almost flat from 2019 to 2023.

Sales stayed close to ₹50 crore per year, while profit remained around ₹7.5 crore and margins stayed near 15%.

There was no meaningful long-term growth or decline.

---

## Product Performance Summary

| Metric | Highest | Lowest |
|---|---|---|
| Category Sales | Seasonal Fruits & Vegetables | Furniture |
| Category Profit | Household Items | Furniture |
| Category Margin | Fast Food — 15.03% | Furniture — 14.93% |
| Sub-Category Sales | Mops — ₹10.96 Cr | Chairs — ₹9.95 Cr |
| Sub-Category Margin | Microwaves — 15.20% | Tables — 14.83% |

### Finding

Product performance was highly balanced.

Differences between categories and sub-categories were relatively small, indicating that product mix was not a major driver of profitability.

---

## Geographic and Segment Summary

| Dimension | Highest Sales | Lowest Sales | Margin Range |
|---|---|---|---:|
| Region | East | West | 14.91%–15.02% |
| State | Rajasthan | Uttar Pradesh | 14.91%–15.05% |
| City Type | Tier 1 | Village | 14.92%–15.01% |
| Outlet Type | Large | Small | 14.91%–15.00% |

Customer segments were also nearly evenly split:

| Segment | Sales | Profit | Margin |
|---|---:|---:|---:|
| Corporate | ₹125.51 Cr | ₹18.78 Cr | 14.96% |
| Consumer | ₹125.33 Cr | ₹18.78 Cr | 14.98% |

### Finding

Geography, outlet type, city type, and customer segment showed only minor differences.

These dimensions did not appear to be major profitability drivers.

---

## Discount Analysis

Discounting produced the clearest difference in profitability.

| Discount Band | Avg. Sales / Transaction | Avg. Profit / Transaction | Profit Margin |
|---|---:|---:|---:|
| 0–10% | ₹24,964 | ₹4,756 | 19.05% |
| 10–20% | ₹25,236 | ₹4,305 | 17.06% |
| 20–30% | ₹25,096 | ₹3,784 | 15.08% |
| 30–40% | ₹25,011 | ₹3,277 | 13.10% |
| 40–50% | ₹25,108 | ₹2,784 | 11.09% |

From the lowest to the highest discount band:

- Average sales per transaction changed by only about **0.6%**.
- Average profit per transaction declined by about **41.5%**.
- Profit margin declined from **19.05% to 11.09%**.

The same margin decline appeared across all six major product categories.

### Finding

Higher discount levels were strongly associated with lower profitability, while average transaction value remained almost unchanged.

This was the strongest business pattern identified during the Excel analysis.

---

## Shipping Analysis

| Ship Mode | Avg. Shipping Days | Profit Margin |
|---|---:|---:|
| First Class | 4.00 | 14.95% |
| Same Day | 3.99 | 14.99% |
| Second Class | 3.97 | 14.97% |
| Standard Class | 4.00 | 14.97% |

### Finding

Shipping duration and profitability were almost identical across all shipping modes.

The Ship Mode labels therefore did not provide a meaningful operational performance difference in this dataset.

---

## Excel Conclusion

The Excel analysis showed that most business dimensions were unusually stable and evenly distributed.

Year, product category, geography, customer segment, outlet type, and shipping mode showed only minor differences.

The strongest pattern was discounting.

Higher discount levels were associated with sharply lower profit margins and lower profit per transaction, while average sales per transaction remained nearly unchanged.

Because of this, discounting will be investigated further in SQL and Python to understand whether the relationship remains consistent across different business dimensions.