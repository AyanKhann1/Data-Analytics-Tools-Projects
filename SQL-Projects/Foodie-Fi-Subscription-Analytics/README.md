# Foodie-Fi Subscription Analytics Case Study

## 1. Overview

This project analyzes customer subscription behavior for Foodie-Fi, a fictional streaming platform focused on food-related content. The analysis uses SQL to understand customer acquisition, trial conversion, churn, plan upgrades, and subscription movement across different pricing tiers.

The project matters because subscription businesses need to understand how customers move from free trials to paid plans, where churn occurs, and which plan paths create stronger long-term value.

## 2. Business Problem

Foodie-Fi needs better visibility into customer subscription behavior before making product, pricing, and investment decisions. Without structured analysis, the business may not know whether customers are converting after the trial, upgrading to higher-value plans, downgrading, or leaving the platform.

## 3. Objective

- Measure total customer base and subscription activity.
- Analyze trial starts by month to understand acquisition patterns.
- Calculate customer churn and immediate post-trial churn.
- Identify how customers convert after the free trial.
- Measure upgrades to annual plans and estimate time taken to upgrade.
- Identify downgrade behavior from pro monthly to basic monthly.

## 4. Tools Used

- SQL
- Relational database concepts
- CTEs
- Joins
- Aggregations
- Date functions
- Window functions

## 5. Dataset

The project uses a fictional subscription dataset for Foodie-Fi. The dataset contains customer subscription records and plan information.

Main tables:

- `plans`: plan ID, plan name, and plan price
- `subscriptions`: customer ID, plan ID, and subscription start date

Plan examples include trial, basic monthly, pro monthly, pro annual, and churn.

Assumption:

> This is a portfolio case study dataset. It represents a realistic subscription business scenario and does not contain confidential customer data.

## 6. Process

- Reviewed the subscription model and plan rules.
- Joined customer subscription records with plan metadata.
- Used aggregations to calculate customer counts and event counts.
- Used date functions to group activity by month and year.
- Used CTEs to isolate trial users, annual plan users, churned users, and plan movement.
- Used ranking/window logic to evaluate customer journeys after trial.
- Converted SQL outputs into business-focused insights and recommendations.

## 7. Key Metrics

- Total customers
- Trial starts by month
- Plan events after 2020
- Churned customers
- Churn rate
- Immediate post-trial churn
- Conversion after trial by plan
- Customers upgraded to annual plan
- Average days to annual upgrade
- Downgrade count from pro monthly to basic monthly

## 8. Dashboard / Output

### SQL Output Placeholder

Add SQL result screenshots or exported tables here:

```markdown
![Foodie-Fi SQL Output](assets/foodie-fi-sql-output.png)
```

### Schema Placeholder

Add a simple schema or ERD here:

```markdown
![Foodie-Fi Schema](assets/foodie-fi-schema.png)
```

Recommended visuals:

- Trial starts by month
- Customer distribution by plan
- Conversion after free trial
- Churn rate summary
- Annual upgrade timing buckets

## 9. Key Insights

- Trial behavior is central to understanding Foodie-Fi's customer funnel because every customer begins with a free trial before choosing, upgrading, or cancelling a plan.
- Churn analysis helps identify whether customers are leaving immediately after the trial or after spending time on a paid plan.
- Plan conversion after trial shows which paid option is most attractive to new customers.
- Annual plan upgrades are important because they can indicate stronger customer commitment and more predictable revenue.
- Downgrade analysis helps identify customers who may still find value in the service but are not willing to continue at a higher monthly price.
- Monthly trial distribution can help the business understand whether acquisition is consistent or concentrated in specific periods.

## 10. Recommendations

- Monitor trial-to-paid conversion as a core subscription KPI.
- Review immediate post-trial churn to identify whether onboarding, pricing, or content expectations need improvement.
- Create targeted campaigns for pro monthly users who show potential to upgrade to annual plans.
- Track downgrade behavior separately from churn because downgraded customers may still be retained with the right plan strategy.
- Build a recurring subscription dashboard to monitor conversion, churn, and upgrade trends over time.

## 11. Business Impact

This analysis can help Foodie-Fi make better decisions about pricing, customer retention, product features, and marketing investment. It gives stakeholders a clearer view of where customers convert, where they drop off, and which subscription paths may support stronger recurring revenue.

## 12. What I Learned

- Translating subscription business questions into SQL queries.
- Using SQL joins, CTEs, date functions, aggregations, and window functions.
- Thinking through customer lifecycle analysis from trial to paid conversion, upgrade, downgrade, and churn.
- Communicating SQL results in a business-friendly format.

## 13. Files

| File | Description |
|---|---|
| `README.md` | Project case study |
| `assets/` | Placeholder for screenshots, output tables, and schema visuals |
| `files/Case_Study_code.sql` | SQL analysis file to be added or cleaned |
| `files/Project-Output.txt` | SQL output/results file to be added or cleaned |

