# LENDING CLUB PORTFOLIO ANALYSIS — FINDINGS

## Summary

This analysis examines default risk across 10,000 Lending Club loans (random sample, seed 42, from 71,454 records) through 4 segmentation dimensions: credit grade, loan purpose, home ownership status, and loan amount. Default is defined as **Charged Off** or **Late (31-120 days)** status, reflecting loans that have functionally entered a problematic collectibility phase, not just final write-off (WO).

**Key finding:** Credit grade is the strongest and most consistent separator of default risk (monotonic from A to G, and still monotonic when loans in Current status are excluded). The RENT vs other statuses pattern and the small vs larger loan pattern are also stable. In contrast, two findings that initially looked counter-intuitive (Medium > Large in BQ4 and MORTGAGE < OWN in BQ3) turn out to be statistically weak and need further analysis.

**Important note on the denominator:** 41.5% of loans in the sample are still in **Current** status (not yet fully run). Default rates in this document are calculated over all loans, so they show the share of loans already in trouble when the data was pulled, not the final rate. A sensitivity check (excluding Current loans) is shown in each BQ.

---

## BQ1: Default Rate by Loan Grade (A–G)

### Results
| Grade | Total Loans | Defaulted | Default Rate | Default Rate excl. Current |
|---|---|---|---|---|
| A | 2,098 | 53 | 2.53% | 4.80% |
| B | 2,775 | 219 | 7.89% | 14.07% |
| C | 2,820 | 372 | 13.19% | 22.33% |
| D | 1,562 | 305 | 19.53% | 31.61% |
| E | 548 | 168 | 30.66% | 42.32% |
| F | 158 | 59 | 37.34% | 46.09% |
| G | 39 | 16 | 41.03% | 50.00% |

### Interpretation
Default rate rises **progressively and monotonically** from grade A to G, from 2.53% to 41.03% (roughly 16x). This pattern is consistent with how Lending Club's grading system is meant to work: the higher the risk grade assigned upfront, the higher the realized default.

When Current loans are excluded, rates rise in every grade and the order stays monotonic. However, the A-to-G ratio drops from roughly 16x to roughly 10x, because the share of Current loans is much larger in grade A (47%) than in grade G (18%). In other words, the "16x" figure is partly driven by the loan status mix, not purely by differences in risk.

### Field Perspective (comparison with WOM Finance experience)
Grading is an early-stage risk mitigation step that both reduces risk and speeds up consumer analysis. In my experience monitoring post-disbursement consumers, applying grading tended to reduce bad debt levels, in line with the BQ1 pattern above.

One challenge encountered in the field is the **"appealed consumer"** case: a consumer already rejected by the credit analyst based on grading, but then resubmitted (appealed) by the sales/marketing team due to sales target pressure. These consumers often become problematic, both in actual repayment capacity and credit character.

Grading is easier to apply to existing (Repeat Order) consumers since payment history is already available. For new consumers, grading can still be applied using external data such as SLIK (Indonesia's Financial Information Service System) and Credit Bureau records as the basis for assessing prior credit history.

### Data Notes
- Grade G has only 39 loans (32 excluding Current). The pattern remains consistent, but this sample size should be noted as a limitation.

---

## BQ2: Default Rate by Loan Purpose

### Results
| Purpose Group | Total Loans | Defaulted | Default Rate | Default Rate excl. Current |
|---|---|---|---|---|
| Debt Consolidation | 5,759 | 765 | 13.28% | 21.33% |
| Others | 1,912 | 201 | 10.51% | 20.47% |
| Credit Card | 2,329 | 226 | 9.70% | 17.63% |

### Interpretation
Contrary to initial expectations (credit card was assumed to be the higher-risk segment, reflecting borrowers trapped in a credit card debt cycle), the results show **debt consolidation** as the highest-risk segment and **credit card** as the lowest. The debt consolidation vs credit card gap (3.58 pp) is statistically significant (z ≈ 4.5), and the order holds when Current loans are excluded. Excluding Current, the gap between debt consolidation and "others" narrows (21.33% vs 20.47%).

Hypothesis: borrowers applying for debt consolidation loans may already be at a deeper point of financial distress. This refinancing attempt could be a last resort before default, rather than a successful debt resolution.

### Field Perspective (comparison with WOM Finance experience)
*Hypothesis from field experience, not tested in this data.*

This pattern is commonly observed in the field. Consumers under financial pressure are often offered a Repeat Order (RO) loan while they already have an outstanding arrears that month, meaning their business operations stall because billing obligations can't be met in the same period. On one hand, this is a sound marketing strategy since it identifies a genuine consumer need. In reality, however, many RO applications happen because the borrower's business condition has already deteriorated, or because they're using the new loan to pay off debt elsewhere ("borrowing from Peter to pay Paul"), making their future repayment capacity significantly weaker.

### Data Notes
- The "others" grouping combines 11 minor purpose categories (medical, car, house, etc.) to avoid individual sample sizes that are too small for meaningful comparison.

---

## BQ3: Home Ownership Impact on Default Risk

### Results
| Home Ownership | Total Loans | Defaulted | Default Rate | Default Rate excl. Current |
|---|---|---|---|---|
| Rent | 3,929 | 582 | 14.81% | 24.73% |
| Own | 1,207 | 137 | 11.35% | 20.21% |
| Mortgage | 4,864 | 473 | 9.72% | 16.78% |

### Interpretation
As expected: borrowers with **RENT** status have the highest default rate (14.81%), while **MORTGAGE** has the lowest (9.72%). This is in line with the idea that asset/collateral ownership correlates with better financial stability. The order holds when Current loans are excluded.

The RENT vs OWN gap (3.46 pp) is statistically significant (z ≈ 3.0). However, the OWN vs MORTGAGE gap (1.63 pp) is weak (z ≈ 1.7), so it cannot yet be concluded that MORTGAGE is safer than OWN. If this difference holds up in a larger dataset, one hypothesis is that mortgage borrowers have already passed stricter bank underwriting (qualified buyer screening), while OWN status can stem from various sources (inheritance, cash purchase without strict credit screening, etc.) that don't consistently reflect credit quality.

### Field Perspective (comparison with WOM Finance experience)
*Hypothesis from field experience, not tested in this data.*

Home ownership status is an important variable in credit analysis. Borrowers with a mortgage generally go through a stricter banking assessment process, including **DSR (Debt Service Ratio)** calculations. As long as the DSR remains within a reasonable range despite a large installment burden, this actually signals that the borrower is a reasonable credit risk (having already passed strict underwriting).

On the other hand, private home ownership (OWN) can come from various sources, inheritance being one of them. This is why OWN status doesn't automatically reflect a good credit history, even though it can still be a positive factor in terms of financial capacity.

---

## BQ4: Loan Amount vs Default Risk

### Results
| Loan Amount Bin | Total Loans | Defaulted | Default Rate | Default Rate excl. Current |
|---|---|---|---|---|
| Medium ($10k–$20k) | 3,757 | 510 | 13.57% | 22.98% |
| Large (>$20k) | 2,579 | 329 | 12.76% | 23.86% |
| Small (≤$10k) | 3,664 | 353 | 9.63% | 15.67% |

### Interpretation
The initial hypothesis (larger loans = heavier repayment burden = higher default risk) is only partly in line with the data. **Small** is clearly the lowest: its gap with Large (3.12 pp) is statistically significant (z ≈ 3.9).

In contrast, the **Medium vs Large** gap is only 0.82 pp and not significant (z ≈ 0.9). When Current loans are excluded, the order actually reverses (Large 23.86%, Medium 22.98%). The conclusion that holds: small loans are safer, while Medium and Large are practically equal in this sample.

### Field Perspective (comparison with WOM Finance experience)
*Hypothesis from field experience at WOM. The appeal-to-Branch-Manager mechanism does not automatically apply to Lending Club (a P2P platform), and the Medium vs Large gap in this data is not significant.*

Medium-scale loans tend to be more vulnerable due to approval authority limits: if rejected by the credit analyst, the final appeal decision at this tier is typically only escalated as far as the Branch Manager level. This makes risk mitigation at the medium segment more susceptible to sales interests, compared to larger loans that usually require approval at a higher level with stricter scrutiny.

If a Medium > Large pattern shows up consistently in a larger dataset, this mechanism could be one of the explanations.

---

## Conclusions & Business Recommendations

1. **Credit grade remains the most consistent indicator** in this sample, and its monotonic pattern holds when Current loans are excluded. This is in line with using grade as the primary basis for risk pricing and underwriting decisions.
2. **Loan purpose and loan amount warrant deeper analysis.** Some segment gaps are still too small to draw conclusions from, and the patterns likely interact with other variables (cross-analysis needed: purpose × grade, or loan amount × grade) to understand the root cause.
3. **Post-disbursement (after-sales) monitoring data could serve as an additional grading indicator.** Field experience shows that a consumer's actual condition after disbursement often differs from their profile at application. Incorporating post-disbursement data into the grading model could help prevent the same pattern from recurring.
4. **Default rates should be read in the context of loan status.** With 41.5% of loans still Current, further analysis should use loans that have fully run (vintage analysis) so rates are not diluted.

---

## Data & Methodology

- **Dataset:** Lending Club (Kaggle), random sample of 10,000 from 71,454 records (seed 42)
- **Key columns:** grade, purpose, home_ownership, loan_amnt, loan_status
- **Default definition:** Charged Off + Late (31-120 days). Other statuses (Fully Paid, Current, In Grace Period, Late 16-30 days, Default) are counted as non-default. The "Default" status contains only 1 loan.
- **Status mix:** Fully Paid 46.0%, Current 41.5%, Charged Off 11.0%, other 1.5%
- **Statistical test:** two-proportion z-test on aggregate counts; |z| ≥ 1.96 treated as significant at the 5% level
- **Tools:** SQL (MySQL Workbench)
- **Full queries:** see `queries/` folder

---

## Next Steps

- Cross-analysis of grade × purpose and grade × loan amount. A first pass at grade × purpose produced 74 combinations, many with very few loans (5 combinations have only 1 loan), so a minimum loan count is needed before comparing or ranking them.
- Vintage analysis: recompute default rates using only loans that have fully run.
- Window functions: default-rate ranking by grade (CTE + RANK) is done; next is ranking within segments (PARTITION BY).
