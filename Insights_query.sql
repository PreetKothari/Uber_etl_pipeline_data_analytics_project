SELECT * FROM `ivory-choir-413007.uber_data_engineering.fact_table`
LIMIT 10;

# Total fare amount by VendorID
SELECT VendorID, SUM(fare_amount) FROM `ivory-choir-413007.uber_data_engineering.fact_table`
GROUP BY VendorID
ORDER BY VendorID ASC;

# Average tip amount by different payment type
SELECT b.payment_type_name, AVG(a.tip_amount) FROM `ivory-choir-413007.uber_data_engineering.fact_table` a
JOIN `ivory-choir-413007.uber_data_engineering.payment_type_dim` b
ON a.payment_type_id = b.payment_type_id
GROUP BY b.payment_type_name
ORDER BY b.payment_type_name;

# Top 10 pickup locations based on the number of trips
WITH pickup_loc AS (SELECT pickup_location_id, CONCAT(pickup_latitude,", ",pickup_longitude) AS pickup_location FROM `ivory-choir-413007.uber_data_engineering.pickup_location_dim`)
SELECT b.pickup_location, SUM(a.trip_id) AS total_trips FROM `ivory-choir-413007.uber_data_engineering.fact_table` a
JOIN pickup_loc b
ON a.pickup_location_id = b.pickup_location_id
GROUP BY b.pickup_location
ORDER BY b.pickup_location DESC
LIMIT 10;

# Total number of trips by passenger count
SELECT b.passenger_count, COUNT(a.trip_id) AS total_trips FROM `ivory-choir-413007.uber_data_engineering.fact_table` a
JOIN `ivory-choir-413007.uber_data_engineering.passenger_count_dim` b
ON a.passenger_count_id = b.passenger_count_id
GROUP BY b.passenger_count
ORDER BY b.passenger_count DESC;

# The average fare amount by the hour of the day
SELECT b.pickup_hour, AVG(a.fare_amount) FROM `ivory-choir-413007.uber_data_engineering.fact_table` a
JOIN `ivory-choir-413007.uber_data_engineering.datetime_dim` b
ON a.datetime_id = b.datetime_id
GROUP BY b.pickup_hour
ORDER BY b.pickup_hour ASC;