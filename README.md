# EV Adoption Analysis & Customer Segmentation

## Project Overview

This project analyzes 10,000 EV buyers to understand factors associated with EV purchase intention and identify customer segments with higher potential for EV adoption.

The project follows an end-to-end analytics workflow using Python, PostgreSQL, and Power BI.

## 📝 Terminology Note

The terms **Customer** and **Buyer** are used in different parts of this project but refer to the same customer population.

- **Python / Pandas:** Customer terminology was used during data cleaning and exploratory analysis.
- **PostgreSQL / SQL:** Customer terminology was used during data overview, business analysis, and segmentation analysis.
- **Power BI:** Buyer terminology was retained in the dashboard because the source field is `buyer_id` and the analysis focuses on EV purchase intention.

Therefore, terms such as **Customer**, **Buyer**, **Customer Segment**, and **Buyer Segment** may appear across different project components. They refer to the same underlying population unless explicitly stated otherwise.

## Business Objective

The objective is to understand:
- Which customers are more likely to purchase an EV?
- What factors are associated with EV purchase intention?
- How subsidy availability relates to purchase intention
- Whether charging accessibility influences purchase intention
- How range anxiety relates to purchase intention
- Which customer groups represent stronger opportunities
- Which customers should be prioritized for targeted EV marketing

## 📊 Dataset

The dataset contains **10,000 buyer records** and includes demographic, financial, behavioral, and EV-related characteristics.

### Key Columns

| Column | Description |
|---|---|
| `buyer_id` | Unique buyer identifier |
| `age` | Buyer age |
| `gender` | Buyer gender |
| `annual_income_usd` | Annual income |
| `city_type` | Type of city |
| `daily_commute_km` | Daily commuting distance |
| `number_of_cars_owned` | Number of cars owned |
| `current_car_types` | Current vehicle type |
| `charging_station_near_home` | Charging availability near home |
| `charging_station_near_work` | Charging availability near work |
| `home_charging_possible` | Whether home charging is possible |
| `environmental_concern_level` | Environmental concern level from 1–5 |
| `subsidy_available` | Whether an EV subsidy is available |
| `range_anxiety_level` | Level of EV range anxiety |
| `will_buy_ev` | Whether the buyer intends to buy an EV |



## Tools & Technologies

### Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Jupyter Notebook

### PostgreSQL
- PostgreSQL
- pgAdmin
- Database and table creation
- Data Import/Export
- SQL business analysis
- CTEs
- CASE statements
- Aggregations
- Conditional aggregation
- Percentage calculations

### Power BI
- Power Query
- DAX
- Calculated columns
- Measures
- KPI development
- Slicers
- Interactive visualizations
- Customer segmentation
- Dashboard design

                    🚗 RAW EV DATASET
                           │
                           ▼
                 🐍 PYTHON / PANDAS
                           │
            ┌──────────────┼──────────────┐
            ▼              ▼              ▼
       Data Cleaning   Data Validation   Basic EDA
            │              │              │
            └──────────────┼──────────────┘
                           ▼
                  Missing Value Treatment
                           │
                           ▼
                    Outlier Analysis
                           │
                           ▼
                 Export Cleaned Dataset
                           │
                           ▼
                🐘 POSTGRESQL / pgAdmin
                           │
                    Import Clean Data
                           │
            ┌──────────────┼──────────────┐
            ▼              ▼              ▼
       Data Overview   Business Analysis  Customer
                                         Segmentation
            │              │              │
            └──────────────┼──────────────┘
                           ▼
                  Identify Key Factors
                  for EV Potential
                           │
                           ▼
                    📊 POWER BI
                           │
            ┌──────────────┼──────────────┐
            ▼              ▼              ▼
       DAX Measures   Calculated Columns  Data Modeling
                           │
                           ▼
                EV_Potential_Score
                           │
                           ▼
                   Customer_Segment
                           │
                           ▼
                 4 DASHBOARD PAGES
                           │
        ┌──────────────────┼──────────────────┐
        ▼                  ▼                  ▼
   Dashboard 1       Dashboard 2        Dashboard 3
 EV Adoption        Adoption Drivers     Segmentation
   Overview
        │                  │                  │
        └──────────────────┼──────────────────┘
                           ▼
                    Dashboard 4
                Key Insights & Actions
                           │
                           ▼
                 💡 BUSINESS INSIGHTS
                           │
                           ▼
                🎯 RECOMMENDATIONS

## 1. Python — Data Cleaning, Validation & Initial EDA

The raw dataset was first examined, cleaned, and validated using Python and Pandas.

### Data Cleaning

The following checks were performed:
- Missing-value analysis
- Duplicate checks
- Data-type validation
- Categorical-value validation
- Numerical range checks
- Outlier analysis
- General data-quality validation

### Missing Value Treatment

Missing values were identified in:
- `annual_income_usd`
- `daily_commute_km`
- `environmental_concern_level`

The missingness was investigated to determine whether the missing values followed a meaningful systematic pattern. No meaningful systematic pattern was identified.

Median imputation was used to handle the missing values.

| Column | Missing Values | Treatment |
|---|---:|---|
| `annual_income_usd` | 178 | Median |
| `daily_commute_km` | 181 | Median |
| `environmental_concern_level` | 184 | Median |

The median was selected because it is less affected by extreme values and outliers.

### Outlier Analysis

Potential outliers were identified in:
- `annual_income_usd`
- `daily_commute_km`
- `number_of_cars_owned`

The flagged observations were investigated using their actual values and business context.

Although some observations were statistically identified as outliers, they were considered reasonable and plausible customer values. Therefore, they were retained rather than removed.

> Statistical outliers are not automatically data errors. Each potential outlier was evaluated based on business context before deciding whether to remove or retain it.

### Basic Exploratory Data Analysis

After cleaning, basic EDA was performed to understand:
- Age distribution
- Gender distribution
- Income distribution
- City type
- Current car type
- Daily commute
- Charging availability
- Home charging feasibility
- Environmental concern
- Subsidy availability
- Range anxiety
- EV purchase intention

The cleaned dataset was then exported from Python for further analysis.

## 2. PostgreSQL — Data Analysis

The cleaned dataset was imported into PostgreSQL using pgAdmin's Import/Export Data feature.

PostgreSQL was used for data overview, business analysis, and customer segmentation.

### Database Setup

The workflow included:
- Creating the database
- Creating the required table
- Importing the cleaned dataset using pgAdmin
- Validating the imported data
- Performing SQL-based analysis

### Data Overview

Initial SQL analysis included:
- Total number of records
- Distinct values
- Categorical distributions
- Minimum and maximum values
- Numerical summaries

## 3. SQL Business Analysis

SQL was used to answer business-oriented questions related to EV adoption.

The analysis included:
- Overall EV purchase intention
- Purchase intention by gender
- Purchase intention by age group
- Purchase intention by income group
- Purchase intention by city type
- Purchase intention by current car type
- Purchase intention by range anxiety
- Purchase intention by home charging
- Purchase intention by subsidy availability
- Purchase intention by environmental concern
- Purchase intention by daily commute

The analysis focused primarily on purchase intention rates when comparing different customer groups.

### Purchase Intention Rate

```text
EV Intenders within a group
--------------------------- × 100
Total Buyers within the group
```

This allows customer groups of different sizes to be compared fairly.

## 4. EV Potential Score & Customer Segmentation

A rule-based EV Potential Score was calculated in SQL to identify buyers with characteristics associated with higher EV potential.

### Scoring Framework

| Factor | Condition | Points |
|---|---|---:|
| Range Anxiety | Low | +2 |
| Home Charging | Yes | +2 |
| Subsidy Available | Yes | +1 |
| Environmental Concern | >= 4 | +1 |
| Annual Income | >= $100,000 | +1 |
| Daily Commute | < 50 km | +1 |

Maximum score: 8 points.

### Customer Segments

| Score | Customer Segment |
|---:|---|
| 5–8 | High Potential |
| 3–4 | Medium Potential |
| 0–2 | Low Potential |

### Segment Distribution

| Segment | Buyers | Share |
|---|---:|---:|
| High Potential | 6,446 | 64.46% |
| Medium Potential | 2,235 | 22.35% |
| Low Potential | 1,319 | 13.19% |
| **Total** | **10,000** | **100%** |

### High-Potential Purchase Intention

Among the 6,446 High-Potential buyers, 1,520 indicated that they would buy an EV.

High-Potential Purchase Intention Rate: **23.58%**

> The EV Potential Score is a rule-based customer segmentation framework created for this project. It is intended for customer prioritization and is not a machine-learning prediction model.

## 5. Power BI Dashboard Development

The cleaned data was connected to Power BI from PostgreSQL for interactive dashboard development.

Multiple DAX measures and calculated columns were created for:
- KPI calculations
- Purchase intention rate
- Customer segmentation
- EV potential analysis
- Income groups
- Daily commute groups
- Percentage calculations
- Conditional calculations
- Dynamic dashboard metrics
- EV Potential Score
- Customer Segement

The report also includes:
- Interactive slicers
- Navigation buttons
- KPI cards
- Cross-filtering
- Dynamic visualizations
- Consistent dashboard design

## 6. Power BI Dashboard Pages

The Power BI report contains four dashboard pages.

### Dashboard 1 — EV Adoption Overview

Provides an executive-level overview of the buyer population and EV purchase behavior.

Key analysis:
- Total buyers
- EV purchase intention
- Gender
- Age groups
- Income groups
- City type
- Current car type
- Subsidy availability
- EV adoption overview

### Dashboard 2 — EV Adoption Drivers

Analyzes major factors associated with EV purchase intention.

Key analysis:
- EV Purchase Intention by Subsidy
- EV Purchase Intention by Range Anxiety
- EV Purchase Intention by Home Charging
- EV Purchase Intention by Environmental Concern
- EV Purchase Intention by Current Car Type
- EV Purchase Intention by Daily Commute

The dashboard emphasizes purchase intention rate when comparing groups rather than relying only on total buyer counts.

### Dashboard 3 — EV Buyer Segmentation

Identifies high-potential customers and analyzes priority customer segments.

Key analysis:
- EV Potential Score
- High / Medium / Low Potential segments
- High-Potential Buyers
- High-Potential Purchase Intention
- High-Potential Buyers by Income Group
- High-Potential Buyers by Age Group
- High-Potential Buyers by Current Car Type
- Purchase Intention by Customer Segment

Key KPI: **6,446 High-Potential Buyers**

High-Potential Purchase Intention: **23.58%**

### Dashboard 4 — Key Insights & Recommendations

Summarizes the most important findings and converts them into actionable business recommendations.

Key areas:
- Range anxiety
- Charging accessibility
- Subsidy availability
- Environmental concern
- High-potential customer segment
- Target customer opportunities

# 📊 Dashboard Preview

The Power BI report consists of four interactive dashboard pages designed to provide an executive overview, identify EV adoption drivers, segment potential buyers, and communicate actionable business insights.

## Dashboard 1 — EV Adoption Overview

Provides a high-level view of the EV buyer population, purchase intention, demographics, and key customer characteristics.

![Dashboard 1 - EV Adoption Overview](Images/01_executive_overview.png)

---

## Dashboard 2 — EV Adoption Drivers

Explores the key factors associated with EV purchase intention, including subsidy availability, range anxiety, charging accessibility, environmental concern, and commuting behavior.

![Dashboard 2 - EV Adoption Drivers](Images/02_adoption_drivers.png)

---

## Dashboard 3 — EV Buyer Segmentation

Focuses on customer segmentation using the EV Potential Score and identifies High-, Medium-, and Low-Potential customer groups.

![Dashboard 3 - EV Buyer Segmentation](Images/03_buyer_segmentation.png)

---

## Dashboard 4 — Key Insights & Recommendations

Summarizes the major findings from the analysis and translates them into actionable business recommendations.

![Dashboard 4 - Key Insights & Recommendations](Images/04_key_insights.png)


## Key Business Insights

### 1. High-Potential Customer Opportunity

64.46% of buyers fall into the High-Potential segment based on the rule-based EV Potential Score.

**Recommendation:** Prioritize this segment with targeted EV offers, financing options, charging solutions, and personalized marketing.

### 2. Range Anxiety

Range anxiety is an important factor associated with EV purchase intention.

**Recommendation:** Communicate real-world driving range, charging infrastructure, and charging convenience more effectively.

### 3. Home Charging

Home charging availability is associated with EV purchase intention.

**Recommendation:** Improve access to convenient home-charging solutions and installation support.

### 4. Subsidy Availability

Subsidy availability is associated with differences in EV purchase intention.

**Recommendation:** Clearly communicate available incentives and affordability programs to potential buyers.

### 5. Environmental Concern

Environmental concern shows an association with EV purchase intention.

**Recommendation:** Highlight the environmental benefits of EV ownership in relevant marketing campaigns.

## Top Business Priority

### Target High-Potential Buyers

The analysis identified 6,446 High-Potential buyers, representing 64.46% of the customer base.

The business can prioritize this segment through:
- Targeted EV offers
- Financing and affordability incentives
- Home-charging solutions
- Range-focused communication
- Personalized marketing campaigns

## Key Takeaways

The analysis highlights several factors associated with EV purchase intention, including:
- Range anxiety
- Home charging availability
- Subsidy availability
- Environmental concern
- Income
- Age
- Daily commuting behavior
- Current vehicle type

The customer segmentation analysis identifies a large High-Potential customer segment that can be used as a priority audience for targeted EV marketing strategies.

## Skills Demonstrated

- Data Cleaning
- Data Validation
- Missing Value Treatment
- Outlier Analysis
- Exploratory Data Analysis
- Python
- Pandas
- PostgreSQL
- SQL
- pgAdmin
- Database & Table Creation
- Data Import/Export
- CTEs
- CASE Statements
- Conditional Aggregation
- DAX
- Power BI
- KPI Development
- Customer Segmentation
- Data Visualization
- Business Analysis
- Insight Generation
- Business Recommendations

## Author

**Imran Ansari**

Data Analytics Portfolio Project

**Tools:** Python | PostgreSQL | SQL | Power BI | Excel

## Project Summary

**Cleaned and explored data in Python → analyzed and segmented customers in PostgreSQL → built 4 interactive Power BI dashboards → generated business insights and recommendations.**
