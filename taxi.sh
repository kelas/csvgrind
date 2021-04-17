#!/bin/sh

csv=csv/taxi100m.csv

ls -lah $csv

#cl="clickhouse-client --host toaster"
cl="clickhouse-client --host localhost"

$cl --query="DROP TABLE IF EXISTS trips"

$cl <<EOF
CREATE TABLE trips (
  vendor_id               String,
  pickup_datetime         DateTime,
  dropoff_datetime        Nullable(DateTime),
  passenger_count         Nullable(UInt8),
  trip_distance           Nullable(Float64),
  pickup_longitude        Nullable(Float64),
  pickup_latitude         Nullable(Float64),
  rate_code_id            Nullable(UInt8),
  store_and_fwd_flag      Nullable(FixedString(1)),
  dropoff_longitude       Nullable(Float64),
  dropoff_latitude        Nullable(Float64),
  payment_type            Nullable(String),
  fare_amount             Nullable(Float32),
  extra                   Nullable(Float32),
  mta_tax                 Nullable(Float32),
  tip_amount              Nullable(Float32),
  tolls_amount            Nullable(Float32),
  improvement_surcharge   Nullable(Float32),
  total_amount            Nullable(Float32)
) ENGINE = Log
EOF

tail -n +2 $csv | time -p $cl --query="INSERT INTO trips FORMAT CSV"

time -p $cl <<EOF
SELECT TOP 10
       passenger_count,
       toYear(pickup_datetime) AS year,
       round(trip_distance) AS distance,
       count(*)
FROM trips
GROUP BY passenger_count,
         year,
         distance
ORDER BY year,
         count(*) DESC;
EOF

#:~
