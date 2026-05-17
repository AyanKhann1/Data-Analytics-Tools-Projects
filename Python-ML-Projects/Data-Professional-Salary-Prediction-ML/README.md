# Data Professional Salary Prediction Model

## Overview

This project builds a machine learning model to predict salary using a data professional salary dataset. The goal is to understand how salary changes based on factors such as **work year, experience level, and remote work ratio**, then train a regression model that can estimate salary from these inputs.

The project includes exploratory data analysis, feature preparation, log transformation, model training, and model evaluation.

## Business Problem

Companies, recruiters, and professionals often need a data-backed way to understand salary expectations. Salary can vary based on seniority, work year, remote setup, location, company size, and job-related factors.

The core question for this project was:

**Can we build a model that predicts salary from the available dataset and explains which factors influence compensation?**

## Objective

- Explore the salary dataset and understand its structure.
- Analyze salary distribution and key patterns.
- Prepare features for model training.
- Apply log transformation to handle salary skewness.
- Train a regression model to predict salary.
- Evaluate model performance using RMSE and R2 score.
- Document limitations and improvement opportunities.

## Dataset Summary

The dataset contains **151,445 salary records** with no missing values.

Key fields available in the dataset:

- `work_year`
- `experience_level`
- `employment_type`
- `job_title`
- `salary`
- `salary_currency`
- `salary_in_usd`
- `employee_residence`
- `remote_ratio`
- `company_location`
- `company_size`

For the first model, the notebook uses a simplified feature set:

- `work_year`
- `experience_level`
- `remote_ratio`

The target variable is:

- `salary`

## Analysis Process

### 1. Data Understanding

The dataset was loaded and reviewed for columns, data types, shape, and missing values. The dataset had **151,445 rows** and no missing values, which made it suitable for direct exploratory analysis and baseline modeling.

### 2. Feature Selection

The first model was intentionally kept simple. Columns such as job title, location, company size, employment type, salary currency, and salary in USD were removed from the baseline model.

This allowed the project to first test whether broad features like experience level, work year, and remote work ratio could explain salary variation.

### 3. Exploratory Data Analysis

The notebook analyzes:

- Salary distribution
- Log salary distribution
- Experience level distribution
- Remote work ratio distribution
- Salary by experience level
- Salary by remote ratio
- Salary by work year

The original salary distribution was highly skewed, so log transformation was applied before model training.

### 4. Encoding

Experience level was converted into numeric values:

| Experience Level | Encoded Value |
|---|---:|
| EN | 0 |
| MI | 1 |
| SE | 2 |
| EX | 3 |

### 5. Model Training

A **Linear Regression** model was trained after splitting the data into training and testing sets.

Train-test split:

- Training rows: **121,156**
- Testing rows: **30,289**
- Test size: **20%**
- Random state: **42**

### 6. Model Evaluation

The model was evaluated on the log-transformed salary target.

| Metric | Value |
|---|---:|
| RMSE | 0.4703 |
| R2 Score | 0.1350 |

## Key Findings

- Salary values were highly skewed, so log transformation was needed to make the target more suitable for regression.
- Experience level is an important salary signal, but by itself it is not enough to fully explain salary variation.
- Remote work ratio and work year add useful context, but the baseline model has limited predictive power.
- The low R2 score shows that salary prediction needs richer features such as job title, company location, employee residence, company size, and salary currency handling.

## Recommendations

- Use this model as a **baseline model**, not the final production model.
- Add job title, company size, company location, and employee residence as encoded features.
- Use `salary_in_usd` for a cleaner global salary comparison across currencies.
- Compare Linear Regression with stronger models such as Random Forest, Gradient Boosting, XGBoost, or LightGBM.
- Add cross-validation to get a more reliable performance estimate.
- Analyze model errors by experience level, country, remote ratio, and job category.

## Business Impact

This project shows how machine learning can be used to create a salary prediction framework. Even though the first model is simple, it creates a clear baseline and highlights what additional features are needed to improve prediction quality.

For hiring teams or compensation analysts, this type of model can support:

- salary benchmarking
- compensation planning
- market research
- hiring budget estimation
- role-level salary comparison

## Tools Used

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Scikit-learn
- Jupyter Notebook

## Files

```text
Data-Professional-Salary-Prediction-ML/
|-- README.md
|-- data/
|   |-- salaries.csv
|-- notebooks/
|   |-- salary_prediction_model.ipynb
|-- requirements.txt
```

## How To Run

1. Open the notebook:

```text
notebooks/salary_prediction_model.ipynb
```

2. Install the required libraries:

```bash
pip install -r requirements.txt
```

3. Run the notebook cells from top to bottom.

The notebook reads the dataset from:

```text
../data/salaries.csv
```

## Limitations

This is a baseline model. The current model uses only a small number of features, so performance is limited. Future versions should include richer categorical features and compare multiple model types to improve prediction accuracy.
