SELECT end_station_id station_id,
    end_station_name station_name,
    end_station_latitude latitude,
    end_station_longitude longitude,
    ST_GEOGPOINT(end_station_longitude, end_station_latitude) AS geo_point 
FROM `dbtproject-500914.dbt_citibike.citibike_trips`