# 📊 Indian Retail Sales & Profitability Analysis

**An end-to-end retail data analysis project using Excel, PostgreSQL, Python, and Power BI.**

Analyzing 100,000 retail transactions across India from 2019–2023 to understand sales performance, profitability, product trends, and the relationship between discounts and profit margins.

---

## 🧭 Project Navigation

- [Overview](#-project-overview)
- [Dashboard Preview](#-power-bi-dashboard)
- [Key Business Insights](#-key-business-insights)
- [Tools & Workflow](#️-tools--workflow)
- [Dataset](#-dataset)
- [Project Files](#-project-files)
- [Limitations](#️-limitations)

---

## 🎯 Project Overview

Retail businesses need to understand not only how much they sell, but also how much profit they generate.

This project explores key business questions:

- How have sales and profits changed over time?
- Which product categories and sub-categories perform best?
- How does performance vary across states, regions, and customer segments?
- How are discount levels associated with profitability?
- Are there meaningful differences in shipping performance?

**Objective:** Transform raw retail transaction data into actionable business insights through data cleaning, analysis, and interactive reporting.

## 📈 Power BI Dashboard

The Power BI report contains three interactive pages, designed to help users explore different aspects of retail performance.

### 1. Executive Overview

High-level business performance, KPIs, yearly trends, category sales, state performance, and customer segments.

![Executive Overview](Power%20BI/Executive%20Overview.png)

### 2. Product & Market Performance

Explores product categories, sub-categories, states, regions, outlet types, and city-level performance.

![Product & Market Performance](Power%20BI/Product%20&%20Market%20Performance.png)

### 3. Profitability & Discount Analysis

Examines discount bands, profit margins, and how profitability changes across discount levels.

![Profitability & Discount Analysis](Power%20BI/Profitability%20&%20Discount%20Analysis.png)

**Explore the report:**
- [Interactive Power BI Report (.pbix)](Power%20BI/Retail%20Store%20Sales%20&%20Profitability%20Analysis%20Dashboard.pbix)
- [Dashboard PDF](Power%20BI/Indian_Retail_Sales_Profitability_Analysis.pdf)

## 💡 Key Business Insights

### Overall Performance

| Metric | Result |
|---|---:|
| Total Sales | ₹250.84 Cr |
| Total Profit | ₹37.55 Cr |
| Profit Margin | 14.97% |
| Transactions | 100,000 |
| Average Discount | 25.13% |
| Average Shipping Time | 3.99 days |

### Major Findings

**1. Stable Yearly Performance**

Sales and profits remained relatively flat between 2019 and 2023, with no meaningful year-on-year growth.

**2. Balanced Product Categories**

Sales were distributed fairly evenly across the six product categories. No single category dominated overall sales.

**3. Discounts and Profitability**

Profit margins declined as discount levels increased:

| Discount Band | Profit Margin |
|---|---:|
| 0–10% | 19.05% |
| 40–50% | 11.09% |

Average profit per transaction also declined by approximately 41.5% between these two discount bands.

This suggests an association between higher discounts and lower profitability; it does not establish causation.

**4. Shipping Performance**

Average shipping time was approximately 3.99 days. The data showed no meaningful difference in average shipping duration across shipping modes.

## 🛠️ Tools & Workflow

| Tool | Application |
|---|---|
| Microsoft Excel | Data cleaning, exploration, and initial analysis |
| PostgreSQL | Data validation and SQL-based business analysis |
| Python (Pandas) | Exploratory data analysis |
| Power BI | Interactive dashboard development |

**Analysis workflow:**

`Data Preparation → Excel Analysis → SQL Analysis → Python EDA → Power BI Dashboard`

## 📁 Dataset

- **Source:** [Store Data – Kaggle](https://www.kaggle.com/datasets/abuhumzakhan/store-data)
- **Records:** 100,000 transactions
- **Original Columns:** 25
- **Cleaned Columns:** 27
- **Analysis Period:** 2019–2023

Data preparation included checking missing values, duplicate records, data types, inconsistent fields, and creating additional date and shipping-related columns.

## 📂 Project Files

| File | Description |
|---|---|
| `docs/business_problem.md` | Business problem and project objectives |
| `docs/Data Dictionary & Quality Report.md` | Column definitions and data quality checks |
| `docs/excel_analysis.md` | Summary of Excel analysis |
| `sql/retail_business_analysis.sql` | SQL business analysis queries |
| `Power BI/` | Power BI report, PDF export, and screenshots |

## ⚠️ Limitations

- Customer ID and Order ID are unique per row, so reliable repeat-purchase and customer-retention analysis is not supported.
- Some original date and geographical fields were inconsistent and were excluded or analyzed independently where appropriate.
- Discount findings indicate association, not causation.
- Results represent the supplied dataset and should not automatically be generalized to the entire Indian retail market.

---

## 🏁 Conclusion

This project demonstrates an end-to-end data analysis workflow, covering data preparation, validation, SQL querying, exploratory analysis, and interactive business reporting.

The key takeaway: **Revenue alone does not tell the full story. Understanding profitability alongside sales is essential for better business decisions.**
