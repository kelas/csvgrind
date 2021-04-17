#!/bin/sh

csv=csv/taxi100m.csv

ls -lah $csv

#cl="clickhouse-client --host toaster"
pg='sudo -u postgres psql -d postgres'

$pg -c 'DROP TABLE IF EXISTS trips'

$pg -c 'CREATE TABLE trips (
  vendor_id               char(1),
  pickup_datetime         timestamp,
  dropoff_datetime        timestamp,
  passenger_count         int,
  trip_distance           float8,
  pickup_longitude        float8,
  pickup_latitude         float8,
  rate_code_id            int,
  store_and_fwd_flag      char(1),
  dropoff_longitude       float8,
  dropoff_latitude        float8,
  payment_type            char(2),
  fare_amount             float4,
  extra                   float4,
  mta_tax                 float4,
  tip_amount              float4,
  tolls_amount            float4,
  improvement_surcharge   float4,
  total_amount            float4
);'

tail -n +2 $csv | time -p $pg -c'\COPY trips FROM csv/taxi100m.csv CSV header;'

time -p $pg -c'SELECT 
       passenger_count,
       extract(year from pickup_datetime) AS year,
       round(trip_distance) AS distance,
       count(*)
FROM trips
GROUP BY passenger_count,
         year,
         distance
ORDER BY year,
         count(*) DESC
LIMIT 10;'

#:~
