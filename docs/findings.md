# LENDING CLUB PORTFOLIO ANALYSIS — FINDINGS

## Summary

This analysis examines default risk across 10,000 Lending Club loans (curated sample from 71,454 records) through 4 segmentation dimensions: credit grade, loan purpose, home ownership status, and loan amount. Default is defined as **Charged Off** or **Late (31-120 days)** status — reflecting loans that have functionally entered a problematic collectibility phase, not just final write-off (WO).

**Key finding:** Credit grade is the strongest and most consistent predictor of default risk (perfectly progressive A→G). However, two other dimensions — loan purpose and loan amount — show patterns that don't fully match initial expectations, opening room for further analysis.

---

## BQ1: Default Rate by Loan Grade (A–G)

### Results
| Grade | Total Loans | Defaulted | Default Rate |
|---|---|---|---|
| A | 2,098 | 53 | 2.53% |
| B | 2,775 | 219 | 7.89% |
| C | 2,820 | 372 | 13.19% |
| D | 1,562 | 305 | 19.53% |
| E | 548 | 168 | 30.66% |
| F | 158 | 59 | 37.34% |
| G | 39 | 16 | 41.03% |

### Interpretation
Default rate rises **progressively and monotonically** from grade A to G — from 2.53% to 41.03%, nearly a 16x increase. This confirms that Lending Club's grading system works as designed: the higher the risk grade assigned upfront, the higher the actual realized default risk.

### Field Perspective (comparison with WOM Finance experience)
Grading is an early-stage risk mitigation step that both reduces risk and speeds up consumer analysis. Based on post-disbursement consumer monitoring, grading has proven effective at reducing bad debt levels — consistent with the BQ1 results above.

One challenge encountered in the field is the **"appealed consumer"** case — a consumer already rejected by the credit analyst based on grading, but then resubmitted (appealed) by the sales/marketing team due to sales target pressure. These consumers often become problematic, both in actual repayment capacity and credit character.

Grading is easier to apply to existing (Repeat Order) consumers since payment history is already available. For new consumers, grading can still be applied using external data such as SLIK (Indonesia's Financial Information Service System) and Credit Bureau records as the basis for assessing prior credit history.

### Data Notes
- Grade G has only 39 loans (small sample) — the pattern remains consistent but should be noted as a limitation.

---

## BQ2: Default Rate by Loan Purpose

### Results
| Purpose Group | Total Loans | Defaulted | Default Rate |
|---|---|---|---|
| Debt Consolidation | 5,759 | 765 | 13.28% |
| Others | 1,912 | 201 | 10.51% |
| Credit Card | 2,329 | 226 | 9.70% |

### Interpretation
Contrary to initial expectations (credit card was assumed to be the higher-risk segment, reflecting borrowers trapped in a credit card debt cycle), the results instead show **debt consolidation** as the highest-risk segment, while **credit card** is actually the lowest.

A possible explanation: borrowers applying for debt consolidation loans may already be at a deeper point of financial distress — this refinancing attempt could be a last resort before default, rather than a successful debt resolution.

### Field Perspective (comparison with WOM Finance experience)
This pattern is commonly observed in the field. Consumers under financial pressure are often offered a Repeat Order (RO) loan while they already have an outstanding arrears that month — meaning their business operations stall because billing obligations can't be met in the same period. On one hand, this is a sound marketing strategy since it identifies a genuine consumer need. In reality, however, many RO applications happen because the borrower's business condition has already deteriorated, or because they're using the new loan to pay off debt elsewhere ("borrowing from Peter to pay Paul") — making their future repayment capacity significantly weaker.

### Data Notes
- The "others" grouping combines 11 minor purpose categories (medical, car, house, etc.) to avoid individual sample sizes that are too small for meaningful comparison.

---

## BQ3: Home Ownership Impact on Default Risk

### Results
| Home Ownership | Total Loans | Defaulted | Default Rate |
|---|---|---|---|
| Rent | 3,929 | 582 | 14.81% |
| Own | 1,207 | 137 | 11.35% |
| Mortgage | 4,864 | 473 | 9.72% |

### Interpretation
As expected: borrowers with **RENT** status have the highest default rate (14.81%), while **MORTGAGE** has the lowest (9.72%) — confirming that asset/collateral ownership correlates with better financial stability.

Interestingly, **MORTGAGE** is actually lower than **OWN** (fully-paid home, no mortgage payments) — even though OWN would intuitively seem most stable given the absence of a housing payment burden. A possible explanation: mortgage borrowers have already passed stricter bank underwriting (qualified buyer screening), while OWN status can stem from various sources (inheritance, cash purchase without strict credit screening, etc.) that don't consistently reflect credit quality.

### Field Perspective (comparison with WOM Finance experience)
Home ownership status is an important variable in credit analysis. Borrowers with a mortgage generally go through a stricter banking assessment process — including **DSR (Debt Service Ratio)** calculations. As long as the DSR remains within a reasonable range despite a large installment burden, this actually signals that the borrower is a reasonable credit risk (having already passed strict underwriting).

On the other hand, private home ownership (OWN) can come from various sources — inheritance being one of them. This is why OWN status doesn't automatically reflect a good credit history, even though it can still be a positive factor in terms of financial capacity.

---

## BQ4: Loan Amount vs Default Risk

### Results
| Loan Amount Bin | Total Loans | Defaulted | Default Rate |
|---|---|---|---|
| Medium ($10k–$20k) | 3,757 | 510 | 13.57% |
| Large (>$20k) | 2,579 | 329 | 12.76% |
| Small (≤$10k) | 3,664 | 353 | 9.63% |

### Interpretation
The initial hypothesis (larger loans = heavier repayment burden = higher default risk) was not fully confirmed. Instead, the **Medium** segment carries the highest risk — not Large.

A possible explanation: larger loans (>$20k) likely go through a higher level of approval scrutiny, so borrowers who qualify in this category tend to have stronger credit profiles. Medium-sized loans, meanwhile, sit in an approval "comfort zone" — large enough to become a significant burden, but not large enough to trigger extra scrutiny.

### Field Perspective (comparison with WOM Finance experience)
Medium-scale loans tend to be more vulnerable due to approval authority limits — if rejected by the credit analyst, the final appeal decision at this tier is typically only escalated as far as the Branch Manager level. This makes risk mitigation at the medium segment more susceptible to sales interests, compared to larger loans that usually require approval at a higher level with stricter scrutiny.

As a result, many credit decisions at the medium segment tend to prioritize sales achievement over risk mitigation — which likely explains why the default rate in the Medium segment is actually higher than in the Large segment.

---

## Conclusions & Business Recommendations

1. **Credit grade remains the most reliable indicator** for risk pricing — Lending Club's grading system is valid and should continue to serve as the primary basis for underwriting decisions.
2. **Loan purpose and loan amount warrant deeper analysis** — the non-straightforward patterns suggest interaction with other variables (potentially requiring cross-analysis: purpose × grade, or loan amount × grade) to understand the root cause.
3. **Post-disbursement (after-sales) monitoring data could serve as an additional grading indicator** — field data shows that a consumer's actual condition post-disbursement often differs from their profile at application. Incorporating post-disbursement data into the grading model could help prevent the same pattern from recurring.

---

## Data & Methodology

- **Dataset:** Lending Club (Kaggle), curated from 71,454 → 10,000 records
- **Key columns:** grade, purpose, home_ownership, loan_amnt, loan_status
- **Default definition:** Charged Off + Late (31-120 days)
- **Tools:** SQL (MySQL Workbench)
- **Full queries:** see `queries/` folder

---

## Next Steps

- Cross-analysis: grade × purpose, grade × loan amount (identify interaction effects between variables)
- Deeper investigation into counter-intuitive segments (BQ2, BQ4)
- Window functions: default rate ranking per segment, running totals, etc. (skill development)
