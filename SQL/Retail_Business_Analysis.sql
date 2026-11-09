
-- PROJECT: Indian Retail Sales & Profitability Analysis
-- DATABASE: retail_analysis
-- TABLE: retail_sales

-- PURPOSE:
-- Use SQL to investigate business performance and validate the main patterns discovered during the Excel analysis.

-- QUERY 01: DATA VALIDATION
-- Business Question:
-- Was the cleaned dataset imported correctly into PostgreSQL?

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT product_id) AS unique_product_ids
FROM retail_sales;



-- QUERY 02: OVERALL BUSINESS PERFORMANCE
-- Business Question:
-- What is the overall financial and transaction performance of the company?

SELECT
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(order_id) AS transactions,

    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_pct,

    ROUND(AVG(sales), 2) AS avg_transaction_value,

    ROUND(
        AVG(discount) * 100,
        2
    ) AS avg_discount_pct,

    ROUND(AVG(shipping_days), 2) AS avg_shipping_days

FROM retail_sales;



-- QUERY 03: YEARLY PERFORMANCE
-- Business Question:
-- How have sales, profit, transactions and margins changed across years?

SELECT
    EXTRACT(YEAR FROM order_date)::INT AS year,

    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(order_id) AS transactions,

    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_pct

FROM retail_sales

GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year;


-- QUERY 04: YEAR-OVER-YEAR GROWTH
-- Business Question:
-- How much did sales and profit increase or decrease compared with the previous year?

-- SQL Concepts:
-- CTE
-- LAG()
-- Window Functions

WITH yearly_performance AS (

    SELECT
        EXTRACT(YEAR FROM order_date)::INT AS year,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit

    FROM retail_sales

    GROUP BY
        EXTRACT(YEAR FROM order_date)
),

previous_year AS (

    SELECT
        year,
        total_sales,
        total_profit,

        LAG(total_sales) OVER (
            ORDER BY year
        ) AS previous_year_sales,

        LAG(total_profit) OVER (
            ORDER BY year
        ) AS previous_year_profit

    FROM yearly_performance
)

SELECT
    year,

    ROUND(total_sales, 2) AS total_sales,

    ROUND(
        (total_sales - previous_year_sales)
        / NULLIF(previous_year_sales, 0)
        * 100,
        2
    ) AS sales_yoy_pct,

    ROUND(total_profit, 2) AS total_profit,

    ROUND(
        (total_profit - previous_year_profit)
        / NULLIF(previous_year_profit, 0)
        * 100,
        2
    ) AS profit_yoy_pct

FROM previous_year

ORDER BY year;



-- QUERY 05: CATEGORY PERFORMANCE AND RANKING
-- Business Question:
-- Which product categories contribute the most sales and profit?

-- SQL Concepts:
-- Aggregation
-- RANK()
-- Window Functions
-- Contribution %

WITH category_performance AS (

    SELECT
        category,

        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        SUM(quantity) AS total_quantity,
        COUNT(order_id) AS transactions

    FROM retail_sales

    GROUP BY category
)

SELECT
    category,

    ROUND(total_sales, 2) AS total_sales,

    ROUND(total_profit, 2) AS total_profit,

    total_quantity,
    transactions,

    ROUND(
        total_profit / NULLIF(total_sales, 0) * 100,
        2
    ) AS profit_margin_pct,

    ROUND(
        total_sales
        / SUM(total_sales) OVER ()
        * 100,
        2
    ) AS sales_contribution_pct,

    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank,

    RANK() OVER (
        ORDER BY total_profit DESC
    ) AS profit_rank

FROM category_performance
ORDER BY sales_rank;



-- QUERY 06: SUB-CATEGORY RANKING WITHIN EACH CATEGORY
-- Business Question:
-- Which sub-categories perform best inside their own category?

-- SQL Concepts:
-- PARTITION BY
-- RANK()

WITH subcategory_performance AS (

    SELECT
        category,
        sub_category,

        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        COUNT(order_id) AS transactions

    FROM retail_sales

    GROUP BY
        category,
        sub_category
)

SELECT
    category,
    sub_category,

    ROUND(total_sales, 2) AS total_sales,

    ROUND(total_profit, 2) AS total_profit,

    ROUND(
        total_profit / NULLIF(total_sales, 0) * 100,
        2
    ) AS profit_margin_pct,

    RANK() OVER (
        PARTITION BY category
        ORDER BY total_sales DESC
    ) AS sales_rank_within_category,

    RANK() OVER (
        PARTITION BY category
        ORDER BY total_profit DESC
    ) AS profit_rank_within_category

FROM subcategory_performance

ORDER BY
    category,
    sales_rank_within_category;



-- QUERY 07: STATE PERFORMANCE
-- Business Question:
-- Which states contribute the most revenue and profit?

WITH state_performance AS (

    SELECT
        state,

        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        COUNT(order_id) AS transactions,
        AVG(sales) AS avg_transaction_value

    FROM retail_sales

    GROUP BY state
)

SELECT
    state,

    ROUND(total_sales, 2) AS total_sales,
    ROUND(total_profit, 2) AS total_profit,

    transactions,

    ROUND(avg_transaction_value, 2)
        AS avg_transaction_value,

    ROUND(
        total_profit / NULLIF(total_sales, 0) * 100,
        2
    ) AS profit_margin_pct,

    ROUND(
        total_sales
        / SUM(total_sales) OVER ()
        * 100,
        2
    ) AS sales_contribution_pct,

    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank

FROM state_performance

ORDER BY sales_rank;



-- QUERY 08: CUSTOMER SEGMENT PERFORMANCE
-- Business Question:
-- Do Consumer and Corporate customers behave differently?

SELECT
    segment,

    ROUND(SUM(sales), 2) AS total_sales,

    ROUND(SUM(profit), 2) AS total_profit,

    COUNT(order_id) AS transactions,

    SUM(quantity) AS total_quantity,

    ROUND(
        AVG(sales),
        2
    ) AS avg_transaction_value,

    ROUND(
        SUM(profit)
        / NULLIF(SUM(sales), 0)
        * 100,
        2
    ) AS profit_margin_pct

FROM retail_sales

GROUP BY segment

ORDER BY total_sales DESC;



-- QUERY 09: MONTHLY SALES TREND
-- Business Question:
-- Are there meaningful monthly trends or seasonal patterns?

-- SQL Concepts:
-- DATE_TRUNC()
-- TO_CHAR()

WITH monthly_performance AS (

    SELECT
        DATE_TRUNC(
            'month',
            order_date
        )::DATE AS month_start,

        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        COUNT(order_id) AS transactions

    FROM retail_sales

    GROUP BY
        DATE_TRUNC('month', order_date)
)

SELECT
    TO_CHAR(
        month_start,
        'YYYY-MM'
    ) AS year_month,

    ROUND(total_sales, 2) AS total_sales,

    ROUND(total_profit, 2) AS total_profit,

    transactions,

    ROUND(
        total_profit
        / NULLIF(total_sales, 0)
        * 100,
        2
    ) AS profit_margin_pct

FROM monthly_performance

ORDER BY month_start;



-- QUERY 10: DISCOUNT BAND ANALYSIS
-- Business Question:
-- How does profitability change as discount increases?

-- SQL Concepts:
-- CASE WHEN
-- CTE
-- Window Functions

WITH discount_banded AS (

    SELECT
        order_id,
        sales,
        profit,
        quantity,
        discount,

        CASE
            WHEN discount >= 0
                 AND discount < 0.10
                THEN '0-10%'

            WHEN discount >= 0.10
                 AND discount < 0.20
                THEN '10-20%'

            WHEN discount >= 0.20
                 AND discount < 0.30
                THEN '20-30%'

            WHEN discount >= 0.30
                 AND discount < 0.40
                THEN '30-40%'

            WHEN discount >= 0.40
                 AND discount <= 0.50
                THEN '40-50%'

            ELSE 'Other'
        END AS discount_band,

        CASE
            WHEN discount < 0.10 THEN 1
            WHEN discount < 0.20 THEN 2
            WHEN discount < 0.30 THEN 3
            WHEN discount < 0.40 THEN 4
            WHEN discount <= 0.50 THEN 5
            ELSE 99
        END AS discount_sort

    FROM retail_sales
),

discount_performance AS (

    SELECT
        discount_band,
        discount_sort,

        COUNT(order_id) AS transactions,

        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,

        AVG(sales) AS avg_transaction_value,
        AVG(profit) AS avg_profit_per_transaction

    FROM discount_banded

    GROUP BY
        discount_band,
        discount_sort
)

SELECT
    discount_band,

    transactions,

    ROUND(total_sales, 2) AS total_sales,

    ROUND(
        avg_transaction_value,
        2
    ) AS avg_transaction_value,

    ROUND(total_profit, 2) AS total_profit,

    ROUND(
        avg_profit_per_transaction,
        2
    ) AS avg_profit_per_transaction,

    ROUND(
        total_profit
        / NULLIF(total_sales, 0)
        * 100,
        2
    ) AS profit_margin_pct,

    ROUND(
        transactions::NUMERIC
        / SUM(transactions) OVER ()
        * 100,
        2
    ) AS transaction_share_pct,

    ROUND(
        total_profit
        / SUM(total_profit) OVER ()
        * 100,
        2
    ) AS profit_contribution_pct

FROM discount_performance

ORDER BY discount_sort;



-- QUERY 11: DISCOUNT IMPACT BY CATEGORY
-- Business Question:
-- Is the decline in profit margin at higher discounts caused
-- by one category, or does it occur across all categories?

WITH discount_banded AS (

    SELECT
        category,
        sales,
        profit,

        CASE
            WHEN discount < 0.10 THEN '0-10%'
            WHEN discount < 0.20 THEN '10-20%'
            WHEN discount < 0.30 THEN '20-30%'
            WHEN discount < 0.40 THEN '30-40%'
            ELSE '40-50%'
        END AS discount_band,

        CASE
            WHEN discount < 0.10 THEN 1
            WHEN discount < 0.20 THEN 2
            WHEN discount < 0.30 THEN 3
            WHEN discount < 0.40 THEN 4
            ELSE 5
        END AS discount_sort

    FROM retail_sales
)

SELECT
    category,
    discount_band,

    ROUND(
        SUM(sales),
        2
    ) AS total_sales,

    ROUND(
        SUM(profit),
        2
    ) AS total_profit,

    ROUND(
        SUM(profit)
        / NULLIF(SUM(sales), 0)
        * 100,
        2
    ) AS profit_margin_pct

FROM discount_banded

GROUP BY
    category,
    discount_band,
    discount_sort

ORDER BY
    category,
    discount_sort;


-- QUERY 12: LOW-DISCOUNT VS HIGH-DISCOUNT MARGIN GAP
-- Business Question:
-- For each category, how much lower is the margin on heavily
-- discounted transactions compared with low-discount ones?

-- SQL Concepts:
-- FILTER
-- Conditional Aggregation

WITH category_discount_margins AS (

    SELECT
        category,

        (
            SUM(profit) FILTER (WHERE discount < 0.10)
            /
            NULLIF(
                SUM(sales) FILTER (WHERE discount < 0.10),
                0
            )
        ) * 100 AS low_discount_margin_pct,

        (
            SUM(profit) FILTER (WHERE discount >= 0.40)
            /
            NULLIF(
                SUM(sales) FILTER (WHERE discount >= 0.40),
                0
            )
        ) * 100 AS high_discount_margin_pct

    FROM retail_sales

    GROUP BY category
)

SELECT
    category,

    ROUND(
        low_discount_margin_pct,
        2
    ) AS low_discount_margin_pct,

    ROUND(
        high_discount_margin_pct,
        2
    ) AS high_discount_margin_pct,

    ROUND(
        low_discount_margin_pct - high_discount_margin_pct,
        2
    ) AS margin_gap_percentage_points

FROM category_discount_margins

ORDER BY margin_gap_percentage_points DESC;


-- QUERY 13: DISCOUNT PATTERN OVER TIME
-- Business Question:
-- Is the discount-profitability relationship consistent
-- across different years?

WITH discount_banded AS (

    SELECT
        EXTRACT(
            YEAR FROM order_date
        )::INT AS year,

        sales,
        profit,

        CASE
            WHEN discount < 0.10 THEN '0-10%'
            WHEN discount < 0.20 THEN '10-20%'
            WHEN discount < 0.30 THEN '20-30%'
            WHEN discount < 0.40 THEN '30-40%'
            ELSE '40-50%'
        END AS discount_band,

        CASE
            WHEN discount < 0.10 THEN 1
            WHEN discount < 0.20 THEN 2
            WHEN discount < 0.30 THEN 3
            WHEN discount < 0.40 THEN 4
            ELSE 5
        END AS discount_sort

    FROM retail_sales
)

SELECT
    year,
    discount_band,

    ROUND(
        SUM(sales),
        2
    ) AS total_sales,

    ROUND(
        SUM(profit),
        2
    ) AS total_profit,

    ROUND(
        SUM(profit)
        / NULLIF(SUM(sales), 0)
        * 100,
        2
    ) AS profit_margin_pct

FROM discount_banded

GROUP BY
    year,
    discount_band,
    discount_sort

ORDER BY
    year,
    discount_sort;



-- QUERY 14: SHIPPING PERFORMANCE
-- Business Question:
-- Are different shipping modes associated with different
-- delivery times or profitability?

SELECT
    ship_mode,

    COUNT(order_id) AS transactions,

    ROUND(
        SUM(sales),
        2
    ) AS total_sales,

    ROUND(
        SUM(profit),
        2
    ) AS total_profit,

    ROUND(
        AVG(shipping_days),
        2
    ) AS avg_shipping_days,

    ROUND(
        SUM(profit)
        / NULLIF(SUM(sales), 0)
        * 100,
        2
    ) AS profit_margin_pct

FROM retail_sales

GROUP BY ship_mode

ORDER BY total_sales DESC;


-- END OF SQL ANALYSIS
