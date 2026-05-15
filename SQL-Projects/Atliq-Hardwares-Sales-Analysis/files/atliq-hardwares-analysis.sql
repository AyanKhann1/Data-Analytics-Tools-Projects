-- Atliq Hardwares Sales Performance Analysis
-- SQL business case study queries

-- 1. Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.
SELECT DISTINCT
    market
FROM dim_customer
WHERE customer = 'Atliq Exclusive'
  AND region = 'APAC';

-- 2. What is the percentage of unique product increase in 2021 vs. 2020?
WITH product_counts AS (
    SELECT
        COUNT(DISTINCT CASE WHEN fiscal_year = 2020 THEN product_code END) AS unique_products_2020,
        COUNT(DISTINCT CASE WHEN fiscal_year = 2021 THEN product_code END) AS unique_products_2021
    FROM fact_sales_monthly
)
SELECT
    unique_products_2020,
    unique_products_2021,
    unique_products_2021 - unique_products_2020 AS product_increase,
    ROUND(
        (unique_products_2021 - unique_products_2020) * 100.0 / unique_products_2020,
        2
    ) AS percentage_change
FROM product_counts;

-- 3. Provide a report with all unique product counts for each segment.
SELECT
    segment,
    COUNT(DISTINCT product_code) AS unique_product_count
FROM dim_product
GROUP BY segment
ORDER BY unique_product_count DESC;

-- 4. Which segment had the highest increase in unique products in 2021 vs. 2020?
WITH segment_product_counts AS (
    SELECT
        p.segment,
        COUNT(DISTINCT CASE WHEN s.fiscal_year = 2020 THEN s.product_code END) AS product_count_2020,
        COUNT(DISTINCT CASE WHEN s.fiscal_year = 2021 THEN s.product_code END) AS product_count_2021
    FROM fact_sales_monthly AS s
    INNER JOIN dim_product AS p
        ON s.product_code = p.product_code
    GROUP BY p.segment
)
SELECT
    segment,
    product_count_2020,
    product_count_2021,
    product_count_2021 - product_count_2020 AS difference
FROM segment_product_counts
ORDER BY difference DESC;

-- 5. Get the products that have the highest and lowest manufacturing costs.
SELECT
    m.product_code,
    p.product,
    m.manufacturing_cost
FROM fact_manufacturing_cost AS m
LEFT JOIN dim_product AS p
    ON m.product_code = p.product_code
ORDER BY m.manufacturing_cost DESC;

-- 6. Generate a report for the top 5 customers who received the highest average
-- pre-invoice discount percentage in fiscal year 2021 in the Indian market.
SELECT
    c.customer_code,
    c.customer,
    AVG(d.pre_invoice_discount_pct) AS average_discount_percentage
FROM dim_customer AS c
INNER JOIN fact_pre_invoice_deductions AS d
    ON c.customer_code = d.customer_code
WHERE d.fiscal_year = 2021
  AND c.market = 'India'
GROUP BY
    c.customer_code,
    c.customer
ORDER BY average_discount_percentage DESC
LIMIT 5;

-- 7. Get the gross sales amount for customer "Atliq Exclusive" by month.
SELECT
    MONTH(s.date) AS month_number,
    s.fiscal_year,
    CONCAT(ROUND(SUM(g.gross_price * s.sold_quantity) / 1000000, 2), ' M') AS gross_sales_amount
FROM fact_sales_monthly AS s
LEFT JOIN fact_gross_price AS g
    ON s.product_code = g.product_code
LEFT JOIN dim_customer AS c
    ON s.customer_code = c.customer_code
WHERE c.customer = 'Atliq Exclusive'
GROUP BY
    MONTH(s.date),
    s.fiscal_year
ORDER BY
    s.fiscal_year,
    month_number;

-- 8. In which quarter did the business get the maximum total sold quantity?
SELECT
    CASE
        WHEN MONTH(date) IN (1, 2, 3) THEN 'Q1'
        WHEN MONTH(date) IN (4, 5, 6) THEN 'Q2'
        WHEN MONTH(date) IN (7, 8, 9) THEN 'Q3'
        ELSE 'Q4'
    END AS quarter,
    SUM(sold_quantity) AS total_sold_quantity
FROM fact_sales_monthly
WHERE fiscal_year = 2021
GROUP BY quarter
ORDER BY total_sold_quantity DESC;

-- 9. Which channel brought more gross sales in fiscal year 2021?
SELECT
    c.channel,
    CONCAT(ROUND(SUM(s.sold_quantity * g.gross_price) / 1000000, 2), ' M') AS gross_sales_mln
FROM fact_sales_monthly AS s
INNER JOIN fact_gross_price AS g
    ON s.product_code = g.product_code
INNER JOIN dim_customer AS c
    ON s.customer_code = c.customer_code
WHERE s.fiscal_year = 2021
GROUP BY c.channel
ORDER BY SUM(s.sold_quantity * g.gross_price) DESC;

-- 10. Get the top 3 products in each division by total sold quantity in fiscal year 2021.
WITH ranked_products AS (
    SELECT
        p.division,
        p.product_code,
        p.product,
        SUM(s.sold_quantity) AS total_sold_quantity,
        DENSE_RANK() OVER (
            PARTITION BY p.division
            ORDER BY SUM(s.sold_quantity) DESC
        ) AS product_rank
    FROM dim_product AS p
    INNER JOIN fact_sales_monthly AS s
        ON p.product_code = s.product_code
    WHERE s.fiscal_year = 2021
    GROUP BY
        p.division,
        p.product_code,
        p.product
)
SELECT
    division,
    product_code,
    product,
    total_sold_quantity,
    product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY
    division,
    product_rank;
