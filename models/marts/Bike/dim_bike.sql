-- models/dim_bike.sql

SELECT DISTINCT
    bikeid AS bike_id 
FROM `dbtproject-500914.dbt_citibike.citibike_trips`
WHERE bikeid IS NOT NULL