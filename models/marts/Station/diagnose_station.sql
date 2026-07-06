-- NULLs check
SELECT
    COUNT(*)                      AS total_rows,
    COUNTIF(station_id IS NULL)   AS null_station_id,
    COUNTIF(station_name IS NULL) AS null_station_name
FROM {{ ref('dim_station') }}

/*
SELECT
    station_id,
    COUNT(DISTINCT station_name) AS name_variations,
    STRING_AGG(DISTINCT station_name) AS all_names
FROM {{ ref('dim_station') }}
GROUP BY station_id
HAVING COUNT(DISTINCT station_name) > 1
ORDER BY name_variations DESC
*/