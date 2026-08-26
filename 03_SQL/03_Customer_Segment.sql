-- 5. Customer segments
-- EV potential Score
SELECT
    buyer_id,
    age,
    annual_income_usd,
    daily_commute_km,
    range_anxiety_level,
    home_charging_possible,
    subsidy_available,
    environmental_concern_level,
    (
        CASE
            WHEN range_anxiety_level = 'Low' THEN 2
            ELSE 0
        END + CASE
            WHEN home_charging_possible = 'Yes' THEN 2
            ELSE 0
        END + CASE
            WHEN subsidy_available = 'Yes' THEN 1
            ELSE 0
        END + CASE
            WHEN environmental_concern_level >= 4 THEN 1
            ELSE 0
        END + CASE
            WHEN annual_income_usd >= 100000 THEN 1
            ELSE 0
        END + CASE
            WHEN daily_commute_km < 50 THEN 1
            ELSE 0
        END
    ) AS ev_potential_score
FROM
    ev_adoption;

-- Check the Score Distribution
WITH
    customer_scores AS (
        SELECT
            buyer_id,
            age,
            annual_income_usd,
            daily_commute_km,
            range_anxiety_level,
            home_charging_possible,
            subsidy_available,
            environmental_concern_level,
            (
                CASE
                    WHEN range_anxiety_level = 'Low' THEN 2
                    ELSE 0
                END + CASE
                    WHEN home_charging_possible = 'Yes' THEN 2
                    ELSE 0
                END + CASE
                    WHEN subsidy_available = 'Yes' THEN 1
                    ELSE 0
                END + CASE
                    WHEN environmental_concern_level >= 4 THEN 1
                    ELSE 0
                END + CASE
                    WHEN annual_income_usd >= 100000 THEN 1
                    ELSE 0
                END + CASE
                    WHEN daily_commute_km < 50 THEN 1
                    ELSE 0
                END
            ) AS ev_potential_score
        FROM
            ev_adoption
    )
SELECT
    ev_potential_score,
    COUNT(*) AS customers
FROM
    customer_scores
GROUP BY
    ev_potential_score
ORDER BY
    ev_potential_score;

-- Convert the ev_potential_score into customer segments
WITH
    customer_scores AS (
        SELECT
            buyer_id,
            age,
            annual_income_usd,
            daily_commute_km,
            range_anxiety_level,
            home_charging_possible,
            subsidy_available,
            environmental_concern_level,
            (
                CASE
                    WHEN range_anxiety_level = 'Low' THEN 2
                    ELSE 0
                END + CASE
                    WHEN home_charging_possible = 'Yes' THEN 2
                    ELSE 0
                END + CASE
                    WHEN subsidy_available = 'Yes' THEN 1
                    ELSE 0
                END + CASE
                    WHEN environmental_concern_level >= 4 THEN 1
                    ELSE 0
                END + CASE
                    WHEN annual_income_usd >= 100000 THEN 1
                    ELSE 0
                END + CASE
                    WHEN daily_commute_km < 50 THEN 1
                    ELSE 0
                END
            ) AS ev_potential_score
        FROM
            ev_adoption
    )
SELECT
    buyer_id,
    ev_potential_score,
    CASE
        WHEN ev_potential_score >= 5 THEN 'High Potential'
        WHEN ev_potential_score >= 3 THEN 'Medium Potential'
        ELSE 'Low Potential'
    END AS customer_segment
FROM
    customer_scores;

-- Check the segment size
WITH
    customer_scores AS (
        SELECT
            buyer_id,
            age,
            annual_income_usd,
            daily_commute_km,
            range_anxiety_level,
            home_charging_possible,
            subsidy_available,
            environmental_concern_level,
            (
                CASE
                    WHEN range_anxiety_level = 'Low' THEN 2
                    ELSE 0
                END + CASE
                    WHEN home_charging_possible = 'Yes' THEN 2
                    ELSE 0
                END + CASE
                    WHEN subsidy_available = 'Yes' THEN 1
                    ELSE 0
                END + CASE
                    WHEN environmental_concern_level >= 4 THEN 1
                    ELSE 0
                END + CASE
                    WHEN annual_income_usd >= 100000 THEN 1
                    ELSE 0
                END + CASE
                    WHEN daily_commute_km < 50 THEN 1
                    ELSE 0
                END
            ) AS ev_potential_score
        FROM
            ev_adoption
    ),
    segmented_customers AS (
        SELECT
            buyer_id,
            ev_potential_score,
            CASE
                WHEN ev_potential_score >= 5 THEN 'High Potential'
                WHEN ev_potential_score >= 3 THEN 'Medium Potential'
                ELSE 'Low Potential'
            END AS customer_segment
        FROM
            customer_scores
    )
SELECT
    customer_segment,
    COUNT(*) AS total_customers
FROM
    segmented_customers
GROUP BY
    customer_segment
ORDER BY
    total_customers DESC;

-- Analyze the segments
WITH
    customer_scores AS (
        SELECT
            buyer_id,
            age,
            annual_income_usd,
            daily_commute_km,
            range_anxiety_level,
            home_charging_possible,
            subsidy_available,
            environmental_concern_level,
            will_buy_ev,
            (
                CASE
                    WHEN range_anxiety_level = 'Low' THEN 2
                    ELSE 0
                END + CASE
                    WHEN home_charging_possible = 'Yes' THEN 2
                    ELSE 0
                END + CASE
                    WHEN subsidy_available = 'Yes' THEN 1
                    ELSE 0
                END + CASE
                    WHEN environmental_concern_level >= 4 THEN 1
                    ELSE 0
                END + CASE
                    WHEN annual_income_usd >= 100000 THEN 1
                    ELSE 0
                END + CASE
                    WHEN daily_commute_km < 50 THEN 1
                    ELSE 0
                END
            ) AS ev_potential_score
        FROM
            ev_adoption
    ),
    segmented_customers AS (
        SELECT
            *,
            CASE
                WHEN ev_potential_score >= 5 THEN 'High Potential'
                WHEN ev_potential_score >= 3 THEN 'Medium Potential'
                ELSE 'Low Potential'
            END AS customer_segment
        FROM
            customer_scores
    )
SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN will_buy_ev = 'Yes' THEN 1
            ELSE 0
        END
    ) AS ev_buyers,
    ROUND(
        SUM(
            CASE
                WHEN will_buy_ev = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS ev_adoption_pct
FROM
    segmented_customers
GROUP BY
    customer_segment
ORDER BY
    ev_adoption_pct DESC;

-- Insights
-- Customer segmentation identified three EV-potential groups. 
-- The High Potential segment contains 6,446 customers 
-- and has an EV purchase intention rate of 23.58%, 
-- compared with 9.22% for the Medium Potential segment
-- and 1.82% for the Low Potential segment. 
-- This indicates that the rule-based EV potential score effectively 
-- differentiates customers based on their observed EV purchase intention.
-- Recommendations
-- EV manufacturers should prioritize the High Potential segment for targeted 
-- marketing campaigns because it represents the largest customer segment 
-- and has the highest observed EV purchase intention. 
-- Medium-potential customers could be targeted with incentives 
-- and educational campaigns addressing their barriers, while Low-potential 
-- customers may require longer-term awareness and infrastructure initiatives