#!/bin/sh

csv=csv/taq.csv
ls -lah $csv

cl="clickhouse-client --host toaster.kparc.io"

$cl --query="DROP TABLE IF EXISTS taq"

$cl <<EOF
CREATE TABLE taq (
  time  UInt64,
  exch  FixedString(1),
  sym   String,
  vol   Int32,
  trade Float32
) ENGINE = Log;
EOF

tail -n +2 $csv |  tr \| ,  | time -p $cl --query="INSERT INTO taq FORMAT CSV"

#:~
