-- Database created using PgAdmin's Database Create feature
-- Database name = ev_adoption_db



-- Create the table for EV data

CREATE TABLE ev_adoption(
buyer_id VARCHAR(20) PRIMARY KEY,
age INT,
gender VARCHAR(10),
annual_income_usd DECIMAL(10,2),
city_type VARCHAR(20),
daily_commute_km DECIMAL(6,2),
number_of_cars_owned INT,
current_car_type VARCHAR(20),
charging_stations_near_home INT,
charging_stations_near_work INT,
home_charging_possible VARCHAR(10),
environmental_concern_level INT,
subsidy_available VARCHAR(10),
range_anxiety_level VARCHAR(10),
will_buy_ev VARCHAR(10),
age_group VARCHAR(20)
);


-- Import the CSV file using the pgAdmin's import/export feature
-- I have imported the clean ev adoption dataset and the file name is
-- ev_adoption_and_range_anxiety_clean



-- Check the data

SELECT *
FROM ev_adoption
LIMIT 10;

-- Check rows

SELECT COUNT(*)
FROM ev_adoption;

