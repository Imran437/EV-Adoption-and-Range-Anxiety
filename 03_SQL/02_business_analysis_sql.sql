-- 1. Data Overview

SELECT * FROM ev_adoption
LIMIT 10;


-- check number of rows in the data

SELECT COUNT(*) AS total_buyers
FROM ev_adoption;

-- Distinct Values

SELECT
DISTINCT city_type
FROM ev_adoption;

SELECT
DISTINCT gender
FROM ev_adoption;

SELECT
DISTINCT subsidy_available
FROM ev_adoption;

SELECT
DISTINCT current_car_type
FROM ev_adoption;

SELECT
DISTINCT will_buy_ev
FROM ev_adoption;

SELECT
DISTINCT home_charging_possible
FROM ev_adoption;

SELECT
DISTINCT range_anxiety_level
FROM ev_adoption;


-- Minimum and maximum age
SELECT MIN(age) AS min_age, MAX(age) AS max_age
FROM ev_adoption;

-- Minimum and maximum Income
SELECT MIN(annual_income_usd) AS min_income, MAX(annual_income_usd) AS max_income
FROM ev_adoption;

-- Average age

SELECT AVG(age) AS avg_age
FROM ev_adoption;

SELECT
AVG(annual_income_usd) AS avg_income
FROM ev_adoption;



-- 2. Customer Distribution

-- Total Customers by Gender

SELECT
gender,
COUNT(*) AS total_customers,
ROUND(COUNT(*) * 100.0 
/ (SELECT COUNT(*) FROM ev_adoption),2) AS customer_pct
FROM ev_adoption
GROUP BY gender
ORDER BY total_customers DESC;


-- Total Customers by City Type

SELECT
city_type,
COUNT(*) AS total_customers,
ROUND(COUNT(*) * 100.0 
/ (SELECT COUNT(*) FROM ev_adoption),2) AS customer_pct
FROM ev_adoption
GROUP BY city_type
ORDER BY total_customers DESC;

-- Total Customers by Current Car Type

SELECT current_car_type,
COUNT(*) AS total_customers,
ROUND(COUNT(*) * 100.0 
/ (SELECT COUNT(*) FROM ev_adoption),2) AS customer_pct
FROM ev_adoption
GROUP BY current_car_type
ORDER BY total_customers DESC;

-- Customer by Charging Station near home

SELECT
charging_stations_near_home,
COUNT(*) AS total_customers,
ROUND(COUNT(*) * 100.0 
/ (SELECT COUNT(*) FROM ev_adoption),2) AS customer_pct
FROM ev_adoption
GROUP BY charging_stations_near_home
ORDER BY total_customers DESC;

-- Customer by Charging Station near work

SELECT
charging_stations_near_work,
COUNT(*) AS total_customers,
ROUND(COUNT(*) * 100.0 
/ (SELECT COUNT(*) FROM ev_adoption),2) AS customer_pct
FROM ev_adoption
GROUP BY charging_stations_near_work
ORDER BY total_customers DESC; 




-- Customers by Daily Commute km

SELECT
    CASE
        WHEN daily_commute_km < 20 THEN 'Short (<20 km)'
        WHEN daily_commute_km < 50 THEN 'Medium (20-49 km)'
        ELSE 'Long (50+ km)'
    END AS commute_group,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM ev_adoption),
        2
    ) AS customer_pct
FROM ev_adoption
GROUP BY
    CASE
        WHEN daily_commute_km < 20 THEN 'Short (<20 km)'
        WHEN daily_commute_km < 50 THEN 'Medium (20-49 km)'
        ELSE 'Long (50+ km)'
    END
ORDER BY total_customers DESC;



-- Total Customers by Home Charging Possible

SELECT
home_charging_possible,
COUNT(*) AS total_customers,
ROUND(COUNT(*) * 100.0 
/ (SELECT COUNT(*) FROM ev_adoption),2) AS customer_pct
FROM ev_adoption
GROUP BY home_charging_possible
ORDER BY total_customers DESC;


-- Range Anxiety Level

SELECT
range_anxiety_level,
COUNT(*) AS total_customers,
ROUND(COUNT(*) * 100.0 
/ (SELECT COUNT(*) FROM ev_adoption),2) AS customer_pct
FROM ev_adoption
GROUP BY range_anxiety_level
ORDER BY total_customers DESC;

-- Total Customers by Environmental Concern Level

SELECT
environmental_concern_level,
COUNT(*) AS total_customers,
ROUND(COUNT(*) * 100.0 
/ (SELECT COUNT(*) FROM ev_adoption),2) AS customer_pct
FROM ev_adoption
GROUP BY environmental_concern_level
ORDER BY total_customers DESC; 

-- Total Customers by subsidy available

SELECT
subsidy_available,
COUNT(*) AS total_customers,
ROUND(COUNT(*) * 100.0 
/ (SELECT COUNT(*) FROM ev_adoption),2) AS customer_pct
FROM ev_adoption
GROUP BY subsidy_available
ORDER BY total_customers DESC;

-- Total Customers by Age Group

SELECT
age_group,
COUNT(*) AS total_customers,
ROUND(COUNT(*) * 100.0 
/ (SELECT COUNT(*) FROM ev_adoption),2) AS customer_pct
FROM ev_adoption
GROUP BY age_group
ORDER BY total_customers DESC;

-- Total Customer by Will Buy EV

SELECT
will_buy_ev,
COUNT(*) AS total_customers,
ROUND(COUNT(*) * 100.0 
/ (SELECT COUNT(*) FROM ev_adoption),2) AS customer_pct
FROM ev_adoption
GROUP BY will_buy_ev
ORDER BY total_customers DESC;

--  Businees Analysis

-- 3. Overall EV adoption rate

SELECT
ROUND(
    COUNT(*) * 100.0/ (SELECT COUNT(*) FROM ev_adoption), 
2) AS ev_adoption_pct
FROM ev_adoption
WHERE will_buy_ev = 'Yes';     


-- 4. EV adoption Analysis

-- EV adoption by age group

SELECT
    age_group,
    COUNT(*) AS ev_buyers,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM ev_adoption e2
         WHERE e2.age_group = ev_adoption.age_group),
        2
    ) AS ev_adoption_pct
FROM ev_adoption
WHERE will_buy_ev = 'Yes'
GROUP BY age_group
ORDER BY ev_adoption_pct DESC;



-- EV adoption by gender

SELECT
gender,
COUNT(*) AS ev_buyers,
ROUND(
    COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM ev_adoption e2
    WHERE e2.gender = ev_adoption.gender),
2) AS ev_adoption_pct
FROM ev_adoption
WHERE will_buy_ev = 'Yes'
GROUP BY gender
ORDER BY ev_adoption_pct DESC;



-- EV adoption by city type

SELECT
city_type,
COUNT(*) AS ev_buyers,
ROUND(
    COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM ev_adoption e2
    WHERE e2.city_type = ev_adoption.city_type),
    2
    ) AS ev_adoption_pct
FROM ev_adoption
WHERE will_buy_ev = 'Yes'
GROUP BY city_type
ORDER BY ev_adoption_pct DESC;


-- EV adoption by income group


SELECT
CASE
    WHEN annual_income_usd BETWEEN 30000 AND 49999 THEN '30K-50K'
    WHEN annual_income_usd BETWEEN 50000 AND 99999 THEN '50K-100K'
    WHEN annual_income_usd BETWEEN 100000 AND 149999 THEN '100K-150K'
    ELSE '150K+'
END AS income_group,

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

FROM ev_adoption

GROUP BY
   CASE
    WHEN annual_income_usd BETWEEN 30000 AND 49999 THEN '30K-50K'
    WHEN annual_income_usd BETWEEN 50000 AND 99999 THEN '50K-100K'
    WHEN annual_income_usd BETWEEN 100000 AND 149999 THEN '100K-150K'
    ELSE '150K+'
    END
ORDER BY ev_adoption_pct DESC;





-- EV adoption by range anxiety

SELECT
range_anxiety_level,
COUNT(*) AS ev_buyers,
ROUND(
    COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM ev_adoption e2
    WHERE e2.range_anxiety_level = ev_adoption.range_anxiety_level),
    2
    ) AS ev_adoption_pct
FROM ev_adoption
WHERE will_buy_ev = 'Yes'
GROUP BY range_anxiety_level
ORDER BY ev_adoption_pct DESC;


-- EV adoption by home charging

SELECT
home_charging_possible,
COUNT(*) AS ev_buyers,
ROUND(
    COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM ev_adoption e2
    WHERE e2.home_charging_possible = ev_adoption.home_charging_possible),
    2
) AS ev_adoption_pct
FROM ev_adoption
WHERE will_buy_ev = 'Yes'
GROUP BY home_charging_possible
ORDER BY ev_adoption_pct DESC;


-- EV adoption by workplace charging

SELECT
    CASE
        WHEN charging_stations_near_work = 0 THEN 'No Charging'
        WHEN charging_stations_near_work BETWEEN 1 AND 5 THEN '1-5 Stations'
        WHEN charging_stations_near_work BETWEEN 6 AND 10 THEN '6-10 Stations'
        ELSE '11+ Stations'
    END AS workplace_charging_group,

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

FROM ev_adoption

GROUP BY
    CASE
        WHEN charging_stations_near_work = 0 THEN 'No Charging'
        WHEN charging_stations_near_work BETWEEN 1 AND 5 THEN '1-5 Stations'
        WHEN charging_stations_near_work BETWEEN 6 AND 10 THEN '6-10 Stations'
        ELSE '11+ Stations'
    END

ORDER BY ev_adoption_pct DESC;


-- EV adoption by subsidy

SELECT
subsidy_available,
COUNT(*) AS ev_buyers,
ROUND(
    COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM ev_adoption e2
    WHERE e2.subsidy_available = ev_adoption.subsidy_available),
    2
) AS ev_adoption_pct
FROM ev_adoption
WHERE will_buy_ev = 'Yes'
GROUP BY subsidy_available
ORDER BY ev_adoption_pct DESC;


-- EV adoption by environmental concern

SELECT
environmental_concern_level,
COUNT(*) AS ev_buyers,
ROUND(
    COUNT(*) * 100.0 / 
    (SELECT COUNT(*) FROM ev_adoption e2
    WHERE e2.environmental_concern_level = ev_adoption.environmental_concern_level),
    2
) AS ev_adoption_pct
FROM ev_adoption
WHERE will_buy_ev = 'Yes'
GROUP BY environmental_concern_level
ORDER BY ev_adoption_pct DESC;

-- EV adoption by current car type

SELECT
current_car_type,
COUNT(*) AS ev_buyers,
ROUND(
    COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM ev_adoption e2
    WHERE e2.current_car_type = ev_adoption.current_car_type),
    2
) AS ev_adoption_pct
FROM ev_adoption
WHERE will_buy_ev = 'Yes'
GROUP BY current_car_type
ORDER BY ev_adoption_pct DESC;


-- EV adoption by Number of Cars owned

SELECT
    number_of_cars_owned,
    COUNT(*) AS total_customers,
    SUM(
        CASE WHEN will_buy_ev = 'Yes' THEN 1 ELSE 0 END
    ) AS ev_buyers,
    ROUND(
        SUM(
            CASE WHEN will_buy_ev = 'Yes' THEN 1 ELSE 0 END
        ) * 100.0 / COUNT(*),
        2
    ) AS ev_adoption_pct
FROM ev_adoption
GROUP BY number_of_cars_owned
ORDER BY ev_adoption_pct DESC;



-- EV adoption by Daily Commute Group

SELECT
    CASE
        WHEN daily_commute_km < 20 THEN 'Short (<20 km)'
        WHEN daily_commute_km < 50 THEN 'Medium (20-49 km)'
        ELSE 'Long (50+ km)'
    END AS commute_group,

    COUNT(*) AS total_customers,

    SUM(
        CASE WHEN will_buy_ev = 'Yes' THEN 1 ELSE 0 END
    ) AS ev_buyers,

    ROUND(
        SUM(
            CASE WHEN will_buy_ev = 'Yes' THEN 1 ELSE 0 END
        ) * 100.0 / COUNT(*),
        2
    ) AS ev_adoption_pct

FROM ev_adoption

GROUP BY
    CASE
        WHEN daily_commute_km < 20 THEN 'Short (<20 km)'
        WHEN daily_commute_km < 50 THEN 'Medium (20-49 km)'
        ELSE 'Long (50+ km)'
    END

ORDER BY ev_adoption_pct DESC;