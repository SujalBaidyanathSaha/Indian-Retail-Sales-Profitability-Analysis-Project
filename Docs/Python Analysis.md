# Python Exploratory Data Analysis

## Purpose

Python was used to validate the cleaned retail dataset, explore key numerical variables, and further investigate the relationship between discounting and profitability identified during the Excel and SQL analysis.

The analysis was performed using Pandas, NumPy, and Matplotlib.

## Data Validation

The cleaned dataset contained:

| Check | Result |
|---|---:|
| Rows | 100,000 |
| Columns | 27 |
| Missing Values | 0 |
| Duplicate Rows | 0 |
| Unique Orders | 100,000 |
| Unique Customers | 100,000 |
| Unique Product IDs | 100,000 |

The main KPIs calculated in Python matched the results obtained in Excel and PostgreSQL.

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

## Exploratory Analysis

Numerical distributions were reviewed for Sales, Profit, and Discount.

Sales were broadly distributed across the available transaction range, while Profit showed greater concentration toward lower values.

No major data-quality issue was identified during the exploratory analysis.

## Discount and Profitability Analysis

Transactions were divided into five discount bands using Pandas.

| Discount Band | Avg. Sales | Avg. Profit | Profit Margin |
|---|---:|---:|---:|
| 0–10% | ₹24,964 | ₹4,756 | 19.05% |
| 10–20% | ₹25,236 | ₹4,305 | 17.06% |
| 20–30% | ₹25,096 | ₹3,784 | 15.08% |
| 30–40% | ₹25,011 | ₹3,277 | 13.10% |
| 40–50% | ₹25,108 | ₹2,784 | 11.09% |

Average transaction Sales remained close to ₹25,000 across all discount levels.

However, profitability declined consistently as discounts increased.

From the lowest to highest discount band:

- Profit Margin declined from 19.05% to 11.09%.
- The margin gap was approximately 7.96 percentage points.
- Average Profit per transaction declined by approximately 41.5%.

## Category Validation

The discount analysis was repeated across product categories.

All six categories showed a similar pattern, with low-discount margins close to 19% and high-discount margins close to 11%.

The margin difference was approximately 8 percentage points across categories.

This indicates that the pattern was not being driven by one individual product category.

## Python Conclusion

Python confirmed and expanded the main finding identified in Excel and SQL.

Higher discount levels were consistently associated with lower Profit and Profit Margin, while average transaction Sales remained relatively unchanged.

Discounting therefore represents the clearest profitability pattern identified in the dataset.

The analysis demonstrates an association between discount level and profitability and should not be interpreted as proof that discounting alone caused the decline in Profit Margin.