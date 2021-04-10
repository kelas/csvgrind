/ VendorID,
/ tpep_pickup_datetime,
/ tpep_dropoff_datetime,
/ passenger_count,
/ trip_distance,
/ pickup_longitude,
/ pickup_latitude,
/ RatecodeID,
/ store_and_fwd_flag,
/ dropoff_longitude,
/ dropoff_latitude,
/ payment_type,
/ fare_amount,
/ extra,
/ mta_tax,
/ tip_amount,
/ tolls_amount,
/ improvement_surcharge,
/ total_amount

\t ycab:("IPPIEFFICFFIEEEEEEE";enlist",")0:`:csv/taxi.csv

/select pas:sum passenger_count,dist:sum trip_distance,plon:avg pickup_longitude,plat:avg pickup_latitude,dlon:avg dropoff_longitude,dlat:avg dropoff_latitude,tol:sum total_amount from ycab

round:{floor .5+x}

\t r:10#`year`cnt xdesc select cnt:count VendorID by passenger_count,tpep_pickup_datetime.year,round trip_distance from ycab

show r

/:~
\\