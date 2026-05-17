# Data Professional Salary Prediction Model

## Overview

This project builds a baseline machine learning model to predict salary using a data professional salary dataset.

The goal was to understand whether salary can be estimated using simple input features such as **work year, experience level, and remote work ratio**.

## Business Problem

Salary planning is important for hiring teams, recruiters, compensation analysts, and job seekers. Salaries can vary based on seniority, year, work setup, location, company size, and role type.

The core question for this project was:

**Can we build a model that predicts salary from the available dataset and identify what needs to improve for stronger prediction accuracy?**

## Dataset Summary

The dataset contains **151,445 salary records** with no missing values.

Key columns include:

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

## Code Walkthrough

### 1. Import Required Libraries

The project starts by importing libraries for data handling, visualization, model training, and evaluation.

```python
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score, mean_squared_error
```

### 2. Load The Dataset

The dataset is loaded into a Pandas DataFrame for analysis.

```python
df = pd.read_csv("../data/salaries.csv")
```

### 3. Review Dataset Columns

Before modeling, I checked the available columns to understand what information could be used.

```python
df.columns
```

The dataset includes salary, experience level, job title, location, company size, remote ratio, and other job-related fields.

### 4. Select Baseline Features

For the first version of the model, I kept the feature set simple. I removed columns that needed deeper categorical encoding or currency handling.

```python
df.drop(
    columns=[
        "employment_type",
        "job_title",
        "company_location",
        "company_size",
        "employee_residence",
        "salary_in_usd",
        "salary_currency",
        "job_title",
    ],
    inplace=True
)
```

After this step, the model uses:

- `work_year`
- `experience_level`
- `remote_ratio`
- `salary`

### 5. Check Dataset Structure

I checked the dataset shape, column types, and missing values before moving into analysis.

```python
df.info()
df.shape
```

Result:

```text
Rows: 151,445
Columns used in baseline model: 4
Missing values: 0
```

### 6. Summary Statistics

Summary statistics helped identify the salary range, central tendency, and spread.

```python
df.describe()
```

Key observations:

- Minimum salary: **14,000**
- Median salary: **147,000**
- Mean salary: approximately **162,838**
- Maximum salary: **30,400,000**

The very high maximum salary indicated that salary distribution was strongly skewed.

### 7. Salary Distribution

I first visualized the raw salary distribution.

```python
plt.hist(df["salary"], bins=50)
plt.xlabel("Salary")
plt.ylabel("Frequency")
plt.title("Salary Distribution")
plt.show()
```

The salary distribution was highly skewed, meaning a small number of very high salary values were stretching the distribution.

### 8. Log Salary Distribution

To make the salary distribution more suitable for regression, I checked the log-transformed salary distribution.

```python
plt.hist(np.log1p(df["salary"]), bins=100)
plt.title("Log Salary Distribution")
plt.show()
```

The log-transformed salary was more balanced than the original salary distribution.

### 9. Experience Level Distribution

Experience level is an important compensation signal, so I checked how records were distributed across experience groups.

```python
df["experience_level"].value_counts().plot(kind="bar")
plt.show()
```

This helped confirm whether the model had enough records across different seniority levels.

### 10. Remote Ratio Distribution

Remote work setup can influence compensation, so I checked the distribution of remote work categories.

```python
df["remote_ratio"].value_counts().plot(kind="bar")
plt.show()
```

This helped identify how many roles were onsite, hybrid, or fully remote.

### 11. Salary By Experience Level

I compared salary across experience levels to check whether higher seniority generally aligned with higher salary.

```python
sns.boxplot(x="experience_level", y="salary", data=df)
plt.title("Salary by Experience Level")
plt.show()
```

This view helped identify differences in salary distribution between entry, mid, senior, and executive levels.

### 12. Salary By Remote Ratio

I checked whether salary varied meaningfully across remote work categories.

```python
sns.boxplot(x=df["remote_ratio"], y=df["salary"])
plt.title("Salary by Remote Ratio")
plt.show()
```

Remote ratio was useful context, but it was not enough by itself to explain salary differences.

### 13. Salary By Work Year

I compared salary across work years to observe year-level salary movement.

```python
sns.boxplot(x=df["work_year"], y=df["salary"])
plt.title("Salary by Work Year")
plt.show()
```

This helped check whether compensation changed across years in the dataset.

### 14. Encode Experience Level

Machine learning models need numeric inputs. I converted experience level into an ordered numeric feature.

```python
exp_mapping = {
    "EN": 0,
    "MI": 1,
    "SE": 2,
    "EX": 3
}

df["experience_level_enc"] = df["experience_level"].map(exp_mapping)
```

Encoding logic:

| Experience Level | Meaning | Encoded Value |
|---|---|---:|
| EN | Entry-level | 0 |
| MI | Mid-level | 1 |
| SE | Senior-level | 2 |
| EX | Executive-level | 3 |

After encoding, the original text column was removed.

```python
df.drop(columns=["experience_level"], inplace=True)
```

### 15. Apply Log Transformation

Because salary was highly skewed, I created a log-transformed target variable.

```python
df["salary_log"] = np.log(df["salary"])
```

Then I compared the original and transformed salary distributions.

```python
sns.histplot(df["salary"], bins=50)
plt.title("Salary (Original)")
plt.show()

sns.histplot(df["salary_log"], bins=50)
plt.title("Salary (Log Transformed)")
plt.show()
```

This made the target variable more suitable for a baseline regression model.

### 16. Define Features And Target

The model predicts `salary_log`, while the original salary column is removed from the feature set.

```python
x = df.drop(columns=["salary_log", "salary"])
y = df["salary_log"]
```

Features used:

- `work_year`
- `remote_ratio`
- `experience_level_enc`

Target:

- `salary_log`

### 17. Train-Test Split

The data was split into training and testing sets.

```python
x_train, x_test, y_train, y_test = train_test_split(
    x,
    y,
    random_state=42,
    test_size=0.2
)
```

Split result:

```python
print(x_train.shape)
print(x_test.shape)
print(y_train.shape)
print(y_test.shape)
```

Output:

```text
(121156, 3)
(30289, 3)
(121156,)
(30289,)
```

### 18. Train Linear Regression Model

I used Linear Regression as the baseline model.

```python
lr = LinearRegression()
lr.fit(x_train, y_train)
```

Linear Regression is a good starting point because it is simple, explainable, and useful for creating a baseline before testing more advanced models.

### 19. Make Predictions

The trained model was used to predict salaries on the test set.

```python
y_pred = lr.predict(x_test)
```

### 20. Evaluate Model Performance

The model was evaluated using RMSE and R2 score.

```python
rmse = np.sqrt(mean_squared_error(y_test, y_pred))
r2 = r2_score(y_test, y_pred)

print("RMSE:", rmse)
print("R2 Score:", r2)
```

Model output:

```text
RMSE: 0.4703
R2 Score: 0.1350
```

## Model Interpretation

The model created a working baseline, but the R2 score shows that the current feature set explains only a limited portion of salary variation.

This is expected because salary is influenced by several important factors that were not included in the baseline model, such as:

- job title
- company location
- employee residence
- company size
- employment type
- salary currency
- role specialization

## Key Findings

- Salary values were highly skewed, so log transformation was useful.
- Experience level is an important salary signal.
- Work year and remote ratio add context but are not enough to strongly predict salary.
- The baseline Linear Regression model gives a starting point, but not a final high-accuracy model.
- Better performance will likely require richer categorical features and stronger algorithms.

## Recommendations For Improvement

- Use `salary_in_usd` as the target for cleaner global salary comparison.
- Encode job title, company location, employee residence, company size, and employment type.
- Compare Linear Regression with Random Forest, Gradient Boosting, XGBoost, or LightGBM.
- Add cross-validation for more reliable model evaluation.
- Analyze prediction errors by job title, country, experience level, and remote ratio.
- Build a feature importance view to explain what drives salary predictions.

## Tools Used

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Scikit-learn
- Jupyter Notebook

## Project Files

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

Install dependencies:

```bash
pip install -r requirements.txt
```

Open and run the notebook:

```text
notebooks/salary_prediction_model.ipynb
```

The notebook reads the dataset from:

```text
../data/salaries.csv
```
