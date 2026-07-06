{{ config(materialized='table') }}

with start_station as (
    SELECT start_station_id AS station_id, start_station_name AS station_name FROM `dbtproject-500914.dbt_citibike.citibike_trips`
),

end_station as (
    SELECT end_station_id   AS station_id, end_station_name   AS station_name FROM `dbtproject-500914.dbt_citibike.citibike_trips`
),

city_station as (
    SELECT * FROM start_station
    UNION DISTINCT
    SELECT * FROM end_station
),

deduped AS (
    SELECT
        station_id,
        station_name,
        ROW_NUMBER() OVER (
            PARTITION BY station_id
            ORDER BY station_name ASC  -- picks alphabetically first name
        ) AS rn
    FROM city_station
),

final AS (
    SELECT station_id, station_name
    FROM deduped
    WHERE rn = 1
)

SELECT * FROM final
ORDER BY station_id