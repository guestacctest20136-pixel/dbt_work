{{ config(materialized='table') }}

with start_station as (
    SELECT start_station_id station_id,
    start_station_name station_name,
    start_station_latitude latitude,
    start_station_longitude longitude,
    ST_GEOGPOINT(start_station_longitude, start_station_latitude) AS geo_point FROM `dbtproject-500914.dbt_citibike.citibike_trips`
),

end_station as (
    SELECT end_station_id station_id,
        end_station_name station_name,
    end_station_latitude latitude,
    end_station_longitude longitude,
    ST_GEOGPOINT(end_station_latitude, end_station_longitude) AS geo_point FROM `dbtproject-500914.dbt_citibike.citibike_trips`
),

city_station as (
    SELECT * FROM start_station
    UNION ALL
    SELECT * FROM end_station
),

deduped AS (
    SELECT
        station_id,
        station_name,
        latitude,
        longitude,
        ROW_NUMBER() OVER (
            PARTITION BY station_id
            ORDER BY station_name ASC
        ) AS rn
    FROM city_station
),

final AS (
    SELECT
        station_id,
        station_name,
        latitude,
        longitude,
        ST_GEOGPOINT(longitude, latitude) AS geo_point   -- ✅ build AFTER dedup
    FROM deduped
    WHERE rn = 1
)

SELECT * FROM final
ORDER BY station_id