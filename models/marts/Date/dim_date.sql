-- models/dim_date.sql

SELECT DISTINCT
    CAST(starttime AS DATE)                          AS trip_date,
    EXTRACT(YEAR  FROM starttime)                    AS year,
    EXTRACT(MONTH FROM starttime)                    AS month,
    FORMAT_DATE('%B', CAST(starttime AS DATE))       AS month_name,
    EXTRACT(QUARTER FROM starttime)                  AS quarter,
    FORMAT_DATE('%A', CAST(starttime AS DATE))       AS day_of_week,
    EXTRACT(DAYOFWEEK FROM starttime)                AS day_of_week_num,
    IF(EXTRACT(DAYOFWEEK FROM starttime) IN (1,7), TRUE, FALSE) AS is_weekend,
    CASE
        WHEN EXTRACT(MONTH FROM starttime) IN (12,1,2) THEN 'Winter'
        WHEN EXTRACT(MONTH FROM starttime) IN (3,4,5)  THEN 'Spring'
        WHEN EXTRACT(MONTH FROM starttime) IN (6,7,8)  THEN 'Summer'
        ELSE 'Fall'
    END AS season
FROM `dbtproject-500914.dbt_citibike.citibike_trips`