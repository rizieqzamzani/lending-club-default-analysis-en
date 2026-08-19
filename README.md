# Lending Club Loan Default Analysis

## Overview
A default risk analysis on 10,000 Lending Club loans across 4 segmentation dimensions using SQL. This project combines data analysis with field perspective from experience as a Branch Collection Head at a multifinance company.

## Background
As a former Branch Collection Head at WOM Finance, I handled post-disbursement collections and credit analysis first-hand — from consumer grading, loan appeal processes, to managing problem accounts. This project validates credit risk patterns observed in the field using Lending Club's public dataset.

## Dataset
- **Source:** [Lending Club — Kaggle](https://www.kaggle.com/datasets/wordsforthewise/lending-club)
- **Sample:** 10,000 loans (curated from 71,454 records)
- **Columns:** 9 key variables (grade, purpose, home_ownership, loan_amnt, loan_status, term, int_rate, annual_inc, id)
- **Default definition:** Charged Off + Late (31-120 days)

## Business Questions

| BQ | Question | Key Finding |
|---|---|---|
| **BQ1** | Default rate per loan grade (A–G)? | Perfectly progressive: A (2.53%) → G (41.03%), a **16x** difference |
| **BQ2** | Which purpose defaults most often? | Debt consolidation (13.28%) highest — not credit card |
| **BQ3** | Does home ownership affect default risk? | RENT (14.81%) > OWN (11.35%) > MORTGAGE (9.72%) |
| **BQ4** | Do larger loans default more? | Medium ($10-20k) is actually highest (13.57%), not Large |

## Key Insights

**1. Credit grade is the strongest predictor.** Default rate increases monotonically from A to G with no anomalies — Lending Club's grading system proves valid as a basis for risk pricing.

**2. Two counter-intuitive findings:**
- **BQ2:** Debt consolidation carries higher risk than credit card payoff — borrowers refinancing existing debt are likely already at a deeper point of financial distress ("borrowing from Peter to pay Paul")
- **BQ4:** Medium-sized loans ($10-20k) carry higher risk than large loans (>$20k) — possibly due to differences in approval scrutiny and authority level

**3. Home ownership as a financial stability proxy** is confirmed — but MORTGAGE is safer than OWN, likely because mortgaged borrowers have already passed stricter bank underwriting (DSR screening).

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
