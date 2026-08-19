-- ============================================================
-- BQ1: Default Rate by Loan Grade (A–G)
-- ============================================================
-- Objective: Validate whether Lending Club's grading system 
--            accurately reflects credit risk (A = safest, G = riskiest)
-- Default definition: Charged Off + Late (31-120 days)
-- Dataset: data_p1 (10,000 loans, curated sample)
-- ============================================================

SELECT
    grade,
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
        END) * 100.0 / COUNT(*), 
        2
    ) AS default_rate_percent
FROM data_p1
WHERE grade IS NOT NULL
GROUP BY grade
ORDER BY grade;
