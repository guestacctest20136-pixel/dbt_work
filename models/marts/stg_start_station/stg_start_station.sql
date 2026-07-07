SELECT start_station_id station_id,
    start_station_name station_name,
    start_station_latitude latitude,
    start_station_longitude longitude,
    ST_GEOGPOINT(start_station_longitude, start_station_latitude) AS geo_point 
FROM `dbtproject-500914.dbt_citibike.citibike_trips`