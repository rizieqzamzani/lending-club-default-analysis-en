# Lending Club Loan Default Analysis

## Overview
A default risk analysis on 10,000 Lending Club loans across 4 segmentation dimensions using SQL. This project combines data analysis with field perspective from experience as a Branch Collection Head at a multifinance company.

## Background
As a former Branch Collection Head at WOM Finance, I handled post-disbursement collections and credit analysis first-hand — from consumer grading and loan appeal processes to managing problem accounts. This project uses Lending Club's public dataset to test whether the credit risk patterns I observed in the field also show up in the data.

## Dataset
- **Source:** [Lending Club — Kaggle](https://www.kaggle.com/datasets/wordsforthewise/lending-club)
- **Sample:** 10,000 loans, random sample (seed 42) from 71,454 records
- **Columns:** 9 key variables (grade, purpose, home_ownership, loan_amnt, loan_status, term, int_rate, annual_inc, id)
- **Default definition:** Charged Off + Late (31-120 days)
- **Default rate** = defaulted loans ÷ all loans in the segment (all loan statuses are in the denominator)

## Business Questions

| BQ | Question | Key Finding |
|---|---|---|
| **BQ1** | Default rate per loan grade (A–G)? | Monotonic increase: A (2.53%) → G (41.03%), roughly **16x** |
| **BQ2** | Which purpose defaults most often? | Debt consolidation (13.28%) is highest, above credit card (9.70%) |
| **BQ3** | Does home ownership affect default risk? | RENT (14.81%) is higher than OWN (11.35%) and MORTGAGE (9.72%) |
| **BQ4** | Do larger loans default more? | Small (up to $10k) is lowest (9.63%); Medium (13.57%) and Large (12.76%) differ only slightly |

## Key Insights

**1. Credit grade is the strongest separator in this sample.** Default rate increases monotonically from A to G with no anomalies, consistent with grading serving as a basis for risk pricing. Note: grade G contains only 39 loans.

**2. Two findings that differ from initial expectations:**
- **BQ2:** Debt consolidation carries higher risk than credit card (a 3.6 pp gap, statistically significant). *Hypothesis from field experience (not tested in this data):* borrowers refinancing existing debt are likely already at a deeper point of financial distress ("borrowing from Peter to pay Paul").
- **BQ4:** Medium ($10-20k) is slightly above Large (>$20k), but the gap is only 0.8 pp and **not statistically significant** (z ≈ 0.9). The only clear pattern is that Small is lower than the other two. *Hypothesis from field experience:* differences in approval authority at the mid-size tier. This mechanism comes from my WOM experience and may not apply to Lending Club.

**3. Home ownership as a financial stability proxy.** RENT is higher than OWN (a 3.5 pp gap, significant). MORTGAGE is slightly lower than OWN, but the 1.6 pp gap is weak (z ≈ 1.7), so no conclusion yet. *Hypothesis to test:* mortgaged borrowers have already passed stricter bank underwriting (DSR screening).

## Limitations
- The sample is a random draw of 10,000 loans from a 71,454-loan source file, which is a slice of data rather than the full Lending Club dataset.
- The default-rate denominator includes all loans, including those still in Current status (not yet fully run), so rates may be lower than final rates.
- "Default" includes Late (31-120 days), which is problematic collectibility rather than final write-off.
- Some segments are small (for example, grade G = 39 loans). Segment comparisons use a simple two-proportion test on aggregate counts, not a full statistical model.
- The analysis is descriptive (correlation), not causal.

## Repo Structure

```
lending-club-default-analysis/
├── README.md              ← you are here
├── queries/
│   ├── 01_default_rate_by_grade.sql
│   ├── 02_default_rate_by_purpose.sql
│   ├── 03_home_ownership_impact.sql
│   └── 04_loan_amount_vs_default.sql
├── results/
│   ├── 01_default_rate_by_grade.csv
│   ├── 02_default_rate_by_purpose.csv
│   ├── 03_home_ownership_impact.csv
│   └── 04_loan_amount_vs_default.csv
├── data/
│   └── lending_club_10k.csv
└── docs/
    └── findings.md        ← full analysis + field perspective
```

## Tools
- SQL (MySQL Workbench)
- Dataset: Lending Club (Kaggle)

## About
**Muhamad Rizieq Zamzani** — Economics graduate (GPA 3.73/4.0), ex-Branch Collection Head at WOM Finance. Transitioning to Data Analyst / Credit Risk Analyst role. Domain expertise in credit risk, collections, grading, and default behavior.

- GitHub: [github.com/rizieqzamzani](https://github.com/rizieqzamzani)
- LinkedIn: [linkedin.com/in/rizieqzamzani](https://linkedin.com/in/rizieqzamzani)
