# Atliq Hardwares Sales Performance Analysis

## 1. Overview

This project analyzes **Atliq Hardwares' 2020 and 2021 sales data** using SQL. The analysis focuses on product growth, segment performance, customer discounts, quarterly sales quantity, and business opportunities for the management team.

The goal was to convert raw business data into clear SQL-based insights that can help leadership understand what changed between 2020 and 2021.

## 2. Business Problem

Atliq Hardwares expanded its business and needed to understand how performance changed from **2020 to 2021**. Management wanted to identify changes in product portfolio, customer behavior, market performance, and sales quantity before planning the next year.

The business needed answers to questions such as:

- Did the product portfolio increase in 2021?
- Which product segments had the highest product counts?
- Which segment had the largest product increase?
- Which customers received the highest pre-invoice discounts in India?
- Which quarter had the highest sold quantity?

## 3. Objective

- Compare product growth between **2020 and 2021**.
- Identify high-performing product segments.
- Find the segment with the biggest increase in unique products.
- Analyze discount patterns for key customers in the Indian market.
- Identify the strongest quarter by sold quantity.
- Use SQL to create business-ready outputs for management review.

## 4. Key Insights

- Unique products increased from **245 in 2020** to **334 in 2021**, showing a broader product portfolio.
- **Accessories** had the largest increase in unique products, growing from **69 products in 2020** to **103 products in 2021**.
- **Notebook** had the highest product count with **129 products**, followed by **Accessories with 116** and **Peripherals with 84**.
- In the Indian market, **Flipkart** was one of the top customers receiving a high average pre-invoice discount in fiscal year 2021.
- **Q4 had the highest sold quantity in 2021**, with **17,447,125 units sold**, higher than Q1, Q2, and Q3.
- The results suggest that product expansion, customer discounting, and seasonal demand should be reviewed together before planning future growth.

## 5. Recommendations

- Prioritize the **Accessories** segment because it had the strongest product expansion from 2020 to 2021.
- Use the strong **Notebook** and **Accessories** product counts to design bundle offers, cross-selling campaigns, and segment-specific promotions.
- Review high-discount customers such as **Flipkart** to confirm whether discounting is supporting profitable growth.
- Study **Q4 performance** in detail to understand whether seasonal demand, promotions, or product availability caused the sales spike.
- Strengthen inventory and supply chain planning before Q4 so the business can handle higher demand without stock or fulfillment issues.
- Combine this SQL analysis with margin and profitability data in future work to understand whether growth is also financially efficient.

## 6. Business Impact

This analysis helps Atliq Hardwares understand where its product portfolio expanded, which segments deserve more attention, and when sales demand is strongest.

The project can support decisions around **product planning, customer discount strategy, seasonal inventory planning, sales forecasting, and market expansion**.

## 7. Key Metrics

- **Unique products in 2020:** 245
- **Unique products in 2021:** 334
- **Increase in unique products:** 89
- **Highest product-count segment:** Notebook with 129 products
- **Second-highest product-count segment:** Accessories with 116 products
- **Largest product increase by segment:** Accessories, from 69 to 103 products
- **Top discounted customer example:** Flipkart in India, fiscal year 2021
- **Highest sold quantity quarter:** Q4 2021 with 17,447,125 units sold

## 8. Tools Used

- SQL
- Joins
- CTEs
- Aggregate functions
- Conditional statements
- Window functions
- Data manipulation functions
- Filtering and sorting
- Year-over-year comparison

## 9. SQL Questions and Code

### Question 1: Which markets does Atliq Exclusive operate in within the APAC region?

```sql
SELECT DISTINCT
    market
FROM dim_customer
WHERE customer = 'Atliq Exclusive'
  AND region = 'APAC';
```

### Question 2: What is the percentage increase in unique products from 2020 to 2021?

```sql
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
```

### Question 3: What are the unique product counts for each segment?

```sql
SELECT
    segment,
    COUNT(DISTINCT product_code) AS unique_product_count
FROM dim_product
GROUP BY segment
ORDER BY unique_product_count DESC;
```

### Question 4: Which segment had the highest increase in unique products in 2021 vs. 2020?

```sql
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
```

### Question 5: Which products have the highest and lowest manufacturing costs?

```sql
SELECT
    m.product_code,
    p.product,
    m.manufacturing_cost
FROM fact_manufacturing_cost AS m
LEFT JOIN dim_product AS p
    ON m.product_code = p.product_code
ORDER BY m.manufacturing_cost DESC;
```

### Question 6: Which customers received the highest average pre-invoice discount in India in fiscal year 2021?

```sql
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
```

### Question 7: What was the gross sales amount for Atliq Exclusive by month?

```sql
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
```

### Question 8: Which quarter had the maximum total sold quantity in fiscal year 2021?

```sql
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
```

### Question 9: Which channel brought more gross sales in fiscal year 2021?

```sql
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
```

### Question 10: Which are the top 3 products in each division by sold quantity in fiscal year 2021?

```sql
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
```

## 10. Dataset

The project uses a business sales dataset for Atliq Hardwares. The data includes product, customer, sales, pricing, and discount information.

Tables used in the SQL analysis include:

- `dim_customer`
- `dim_product`
- `fact_sales_monthly`
- `fact_gross_price`
- `fact_manufacturing_cost`
- `fact_pre_invoice_deductions`

Key fields used:

- Customer
- Market
- Region
- Product code
- Product segment
- Fiscal year
- Sold quantity
- Gross price
- Manufacturing cost
- Pre-invoice discount percentage

## 11. Process

- Reviewed the business problem and converted it into SQL questions.
- Joined product, customer, sales, price, and discount tables.
- Used conditional aggregation to compare unique products across fiscal years.
- Grouped product counts by segment to identify segment-level performance.
- Used customer and discount data to identify high-discount customers in India.
- Used date logic to group sold quantity by quarter.
- Interpreted SQL outputs and converted them into business recommendations.

## 12. What I Learned

- Writing SQL queries for real business questions.
- Using joins across fact and dimension tables.
- Applying CTEs, conditional logic, and aggregate functions.
- Comparing business performance across years and segments.
- Turning SQL query outputs into management-level insights and recommendations.

## 13. Files

| File | Description |
|---|---|
| `README.md` | Business case study and project summary |
| `atliq-hardwares-analysis.sql` | SQL queries used for the analysis |
