-- ============================================================
-- BQ3: Home Ownership Impact on Default Risk
-- ============================================================
-- Objective: Compare default risk across home ownership status 
--            (MORTGAGE / RENT / OWN) as a proxy for financial 
--            stability
-- Default definition: Charged Off + Late (31-120 days)
-- Dataset: data_p1 (10,000 loans, curated sample)
-- Note: No 'ANY'/'NONE' category present in curated sample — 
--       no additional filter needed
-- ============================================================

SELECT
    home_ownership,
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
GROUP BY home_ownership
ORDER BY default_rate_percent DESC;
