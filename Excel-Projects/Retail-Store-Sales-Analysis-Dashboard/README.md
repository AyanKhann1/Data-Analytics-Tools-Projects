# Khan Store Sales Dashboard

## 1. Overview

This project analyzes 2022 sales data for Khan Store using Excel. The goal was to understand overall store performance, customer behavior, order trends, brand contribution, delivery status, and B2B order share.

The final output is an Excel dashboard that gives a quick business view of sales, orders, customers, product categories, and operational performance.

## 2. Business Problem

The store needed a clear way to understand sales performance across brands, months, states, customer segments, and order status. Without a dashboard, it would be difficult to quickly answer important business questions such as:

- Which brand generated the highest number of orders?
- Which month had the strongest sales and order volume?
- Which states contributed the most orders?
- What percentage of orders came from women?
- How many orders were delivered, returned, cancelled, or refunded?
- How much of the business came from B2B orders?

## 3. Objective

- Clean and prepare the sales dataset for analysis.
- Calculate key sales and order KPIs.
- Identify top-performing brands, months, states, and customer segments.
- Analyze order status and B2B contribution.
- Build a dashboard that communicates insights clearly for business users.

## 4. Tools Used

- Microsoft Excel
- Pivot Tables
- Pivot Charts
- Data cleaning
- Descriptive statistics
- Dashboard design

## 5. Dataset

The dataset contains sales store order data for 2022.

Based on the analysis, the dataset includes fields related to:

- Order ID
- Order date or month
- Sales amount
- Brand or sales channel
- State
- Customer gender
- Customer age group
- Product size
- Product category
- Order status
- B2B order flag

Assumption:

> This project uses store sales data for portfolio analysis. If the original dataset contains any private or sensitive fields, a cleaned sample version should be shared in the GitHub repository instead of confidential raw data.

## 6. Process

- Reviewed the raw dataset to understand columns, structure, and business meaning.
- Checked for missing values, abnormal entries, and data quality issues.
- Cleaned the dataset so it could be used for accurate analysis.
- Used descriptive statistics to calculate total sales, average sales, minimum and maximum sales, product categories, product sizes, and other summary values.
- Created Pivot Tables to analyze sales and orders by brand, month, state, gender, age group, order status, and B2B category.
- Built Pivot Charts to convert the analysis into a visual dashboard.
- Designed the dashboard to highlight the most important business insights at the top and supporting breakdowns below.

## 7. Key Metrics

- Total orders: 31,047
- Orders from women: 69.4%
- Average sales: INR 682.07
- Total sales: INR 21.07M
- Product sizes: 11
- Product categories: 8
- Top brand by orders: Amazon with 11,016 orders
- Best month: March with INR 1.93M sales and 2,819 orders
- Top state by orders: Maharashtra with 4,519 orders
- Delivered orders: approximately 28,600
- B2B order share: approximately 0.96%

Note:

> The dashboard screenshot should be updated to show the confirmed total sales value of INR 21.07M.

## 8. Dashboard / Output

### Main Dashboard

Add the final Excel dashboard screenshot here:

```markdown
![Khan Store Sales Dashboard](assets/khan-store-sales-dashboard.png)
```

This dashboard summarizes total orders, women customer share, average sales, total sales, product sizes, and product categories. It also shows brand-wise orders, monthly sales and orders, top states, customer segment spending, order delivery status, and B2B order share.

### Dataset Preview

Add a screenshot of the cleaned dataset or sample data here:

```markdown
![Cleaned Dataset Preview](assets/cleaned-dataset-preview.png)
```

### Pivot Table Summary

Add a screenshot of key Pivot Tables here:

```markdown
![Pivot Table Summary](assets/pivot-table-summary.png)
```

## 9. Key Insights

- Amazon was the leading brand/channel with 11,016 orders in 2022, making it the largest contributor by order volume.
- March was the strongest month, generating INR 1.93M in sales and 2,819 orders.
- Maharashtra had the highest number of orders among the top states, with 4,519 orders.
- Women placed the majority of orders, contributing 69.4% of total orders.
- Around 28,600 orders were delivered out of 31,047 total orders, showing that most orders reached the customer successfully.
- B2B orders made up only around 0.96% of total orders, meaning the store was mainly driven by non-B2B customers.

## 10. Recommendations

- Focus marketing efforts on high-performing channels such as Amazon, while reviewing why other brands/channels have lower order volume.
- Study March performance in more detail to understand whether promotions, seasonality, or product demand caused the sales increase.
- Prioritize Maharashtra and other top-order states for targeted campaigns, inventory planning, and delivery optimization.
- Since women represent the majority of orders, create customer campaigns and product recommendations aligned with this segment.
- Monitor returned, cancelled, and refunded orders to identify operational issues and improve customer experience.
- Since B2B share is very small, decide whether to keep B2B as a minor segment or create a separate strategy to grow it.

## 11. Business Impact

This dashboard helps the store quickly understand sales performance and customer behavior without manually reviewing raw data. It can support decisions around marketing, product planning, channel focus, inventory allocation, and customer segmentation.

The analysis also helps identify which parts of the business are performing well and where deeper investigation may be needed, such as lower-performing channels, order returns, cancellations, and B2B growth.

## 12. What I Learned

- Cleaning and preparing sales data for analysis.
- Using descriptive statistics to summarize business performance.
- Creating Pivot Tables for brand, month, state, customer, and order-status analysis.
- Designing an Excel dashboard with KPIs and business storytelling.
- Turning raw sales data into insights and recommendations for decision-making.

## 13. Files

| File | Description |
|---|---|
| `README.md` | Project case study |
| `assets/khan-store-sales-dashboard.png` | Final dashboard screenshot |
| `assets/cleaned-dataset-preview.png` | Placeholder for cleaned dataset screenshot |
| `assets/pivot-table-summary.png` | Placeholder for Pivot Table screenshot |
| `files/khan-store-sales-dashboard.xlsx` | Excel workbook with cleaned data, Pivot Tables, and dashboard |
| `data/sample-sales-data.csv` | Optional sample or cleaned dataset for GitHub |
