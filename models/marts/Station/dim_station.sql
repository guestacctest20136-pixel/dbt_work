
{{ config(materialized='table') }}

with start_station as (
    select * from {{ref ('stg_start_station') }}
),

end_station as (
    select * from {{ref ('stg_end_station') }}
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