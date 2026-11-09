## 1. Dataset Overview

The dataset contains retail transaction data for an Indian store business.

- **Total Rows:** 100,000
- **Total Columns:** 25
- **Missing Values:** None
- **Exact Duplicate Rows:** None
- **Order IDs:** 100,000 unique
- **Customer IDs:** 100,000 unique
- **Product IDs:** 100,000 unique
- **Date Coverage:** 2019–2023

Based on the identifier checks, each row is treated as one individual retail transaction involving one customer and one product.

---

## 2. Data Dictionary

| Column | Description | Use in Analysis |
|---|---|---|
| Customer ID | Unique customer identifier | Reference only |
| Customer Name | Customer first name | Not required for core analysis |
| Last Name | Customer surname | Not required for core analysis |
| Date of Birth | Customer date of birth | Optional demographic analysis |
| Sales | Revenue generated from the transaction | Core KPI |
| Year | Existing year field | Will not be used due to inconsistency |
| Outlet Type | Type of retail outlet | Outlet performance analysis |
| City Type | Classification of city/market | Location analysis |
| Category of Goods | Main product category | Category analysis |
| Region | Assigned business region | Regional performance |
| Country | Country of transaction | Constant value; not required |
| Segment | Customer segment | Consumer vs Corporate analysis |
| Sales Date | Date labelled as sales date | Limited use |
| Order ID | Unique transaction identifier | Transaction count |
| Order Date | Date the order was placed | Primary date for analysis |
| Ship Date | Date the order was shipped | Shipping analysis |
| Ship Mode | Shipping method | Operational analysis |
| State | State associated with transaction | State-level performance |
| Postal Code | Postal location code | Optional |
| Product ID | Unique product identifier | Reference only |
| Sub-Category | Product subgroup | Product analysis |
| Product Name | Product description | Product-level analysis |
| Quantity | Units sold | Volume analysis |
| Discount | Discount applied | Discount analysis |
| Profit | Profit generated | Core KPI |

---

## 3. Data Quality Checks

### Missing Values and Duplicates

No missing values or exact duplicate rows were found in the dataset.

This means the dataset does not require major cleaning for blanks or duplicated records.

However, several logical issues were identified during profiling.

---

### Identifier Structure

All three major identifiers are unique:

| Identifier | Unique Count |
|---|---:|
| Customer ID | 100,000 |
| Order ID | 100,000 |
| Product ID | 100,000 |

This creates a few analytical limitations.

Since every Customer ID appears once, the dataset cannot support reliable analysis of:

- repeat customers;
- customer retention;
- churn;
- purchase frequency;
- customer lifetime value.

Similarly, Product ID does not behave like a reusable product identifier. Product-level analysis will therefore rely mainly on:

**Category of Goods → Sub-Category → Product Name**

---

## 4. Date Validation

The dataset contains three main transaction-related dates:

| Date Field | Minimum | Maximum |
|---|---|---|
| Sales Date | 01-Jan-2019 | 31-Dec-2023 |
| Order Date | 01-Jan-2019 | 31-Dec-2023 |
| Ship Date | 02-Jan-2019 | 07-Jan-2024 |

### Order Date

`Order Date` will be used as the primary date for trend analysis because it forms a logical relationship with `Ship Date`.

### Ship Date

Ship Date occurs after Order Date throughout the dataset.

Shipping duration ranges approximately from:

- **Minimum:** 1 day
- **Maximum:** 7 days
- **Average:** about 4 days

A calculated `Shipping Days` column can therefore be created.

### Sales Date

Sales Date does not consistently occur before or after Order Date.

Because its business meaning cannot be reliably established from the dataset, it will not be used as the primary date for trend analysis.

---

## 5. Existing Year Field

The dataset already contains a `Year` column with values from 2019 to 2023.

However, this field does not consistently match the year extracted from Order Date or the other available date fields.

Because of this inconsistency, the existing Year column will not be used.

Instead, new date fields will be created from `Order Date`:

- Order Year
- Order Quarter
- Order Month
- Month Number
- Year-Month

This ensures that all trend analysis is based on one consistent date field.

---

## 6. Numeric Data Validation

The main numeric fields were checked for unreasonable values.

| Field | Minimum | Maximum | Approx. Average |
|---|---:|---:|---:|
| Sales | ₹100.57 | ₹49,999.89 | ₹25,084 |
| Profit | ₹6.52 | ₹14,563.67 | ₹3,755 |
| Quantity | 1 | 10 | 5.49 |
| Discount | 0% | 50% | 25.13% |

No negative Sales or Quantity values were identified.

All Profit values are positive.

Because the dataset contains no loss-making transactions, profitability analysis will focus on:

- profit contribution;
- profit margin;
- high-margin vs low-margin products;
- margin changes across categories and regions.

---

## 7. Geographic Validation

The dataset contains both `Region` and `State`.

During profiling, individual states were found across multiple regions rather than consistently belonging to one geographic region.

For this reason, the dataset does not support a reliable hierarchy such as:

`Region → State`

Region and State will therefore be analyzed as separate dimensions.

This prevents incorrect geographic assumptions from being introduced into the analysis.

---

## 8. Category Validation

The dataset contains:

- 6 main product categories;
- 24 sub-categories;
- multiple product names.

The Category and Sub-Category structure is suitable for product analysis.

One naming issue was identified:

`Sessional Fruits & Vegetables`

This appears to refer to:

`Seasonal Fruits & Vegetables`

based on its associated products and sub-categories.

This value will be standardized during cleaning.

---

## 9. Fields With Limited Analytical Value

Some fields are valid but provide little value for the current business problem.

### Country

The Country field contains only:

`India`

Since there is no variation, it does not help compare business performance and can be removed from the cleaned analytical dataset.

### Customer Name / Last Name

Customer names are not required for the planned analysis and do not provide meaningful analytical value.

They can be excluded from the final analytical model.

### Product ID

Since Product ID is unique for every row, it will be retained only as a source reference and not used to group product performance.

---

## 10. Cleaning Decisions

The following changes will be made during data preparation.

### Remove / Exclude

- Existing `Year`
- `Country`
- Customer Name
- Last Name

Other non-essential columns may be excluded later if they are not required for analysis.

### Correct

`Sessional Fruits & Vegetables`

to:

`Seasonal Fruits & Vegetables`

### Use as Primary Fields

- Order Date
- Sales
- Profit
- Quantity
- Discount
- Category of Goods
- Sub-Category
- Product Name
- Segment
- Region
- State
- Outlet Type
- City Type
- Ship Mode

### Create

- Order Year
- Order Quarter
- Order Month
- Month Number
- Year-Month
- Shipping Days

Additional calculated measures such as Profit Margin % and Discount Bands will be created during analysis.

---

## 11. Analytical Limitations

The dataset is suitable for sales and profitability analysis, but some questions cannot be answered reliably.

The project will not use the dataset for:

- customer churn analysis;
- repeat purchase analysis;
- customer lifetime value;
- RFM analysis;
- market basket analysis;
- loss-making transaction analysis.

The project will also avoid assuming that:

- Region and State form a geographic hierarchy;
- Sales Date represents the actual transaction date;
- Ship Mode names guarantee a specific delivery time.

---

## 12. Final Assessment

Overall, the dataset is technically clean, with no missing values or duplicate rows, but it contains a few structural inconsistencies that need to be handled carefully.

After applying the documented cleaning decisions, the dataset is suitable for analyzing:

- sales performance;
- profitability;
- product performance;
- regional and state performance;
- customer segments;
- discount patterns;
- time trends;
- shipping patterns;
- root-cause analysis.

The cleaned dataset will use `Order Date` as the main time field and will focus primarily on financial, product, segment, geographic, and operational performance.