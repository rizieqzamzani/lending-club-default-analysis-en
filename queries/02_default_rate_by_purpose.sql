-- ============================================================
-- BQ2: Default Rate by Loan Purpose (Grouped)
-- ============================================================
-- Objective: Identify which borrower purpose segment carries 
--            highest default risk (debt_consolidation vs 
--            credit_card vs others)
-- Default definition: Charged Off + Late (31-120 days)
-- Dataset: data_p1 (10,000 loans, curated sample)
-- Grouping rationale: debt_consolidation + credit_card = 80% 
--                     of dataset, grouped for cleaner comparison
-- ============================================================

SELECT
    CASE
        WHEN purpose = 'debt_consolidation' THEN 'debt_consolidation'
        WHEN purpose = 'credit_card' THEN 'credit_card'
        ELSE 'others'
    END AS purpose_group,
    COUNT(*) AS total_loans,
    SUM(CASE 
        WHEN loan_status IN ('Charged Off', 'Late (31-120 days)') 
        THEN 1 
        ELSE 0 
    END) AS defaulted_loans,
    ROUND(
        SUM(CASE 
            WHEN loan_status IN ('Charged Off', 'Late (31-120 days)') 
            THEN 1 
            ELSE 0 
        END) * 100.0 / COUNT(*), 2
    ) AS default_rate_percent
FROM data_p1
WHERE purpose IS NOT NULL
GROUP BY purpose_group
ORDER BY default_rate_percent DESC;
