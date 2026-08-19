-- ============================================================
-- BQ4: Loan Amount vs Default Risk
-- ============================================================
-- Objective: Test whether larger loan amounts correlate with 
--            higher default risk (repayment burden hypothesis)
-- Default definition: Charged Off + Late (31-120 days)
-- Dataset: data_p1 (10,000 loans, curated sample)
-- Bins: Small (<=$10k) / Medium ($10-20k) / Large (>$20k)
-- ============================================================

SELECT
    CASE
        WHEN loan_amnt <= 10000 THEN 'Small'
        WHEN loan_amnt <= 20000 THEN 'Medium'
        ELSE 'Large'
    END AS loan_amount_bin,
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
GROUP BY loan_amount_bin
ORDER BY default_rate_percent DESC;
