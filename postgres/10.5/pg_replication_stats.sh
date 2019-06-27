#!/bin/bash

metrics=(write flush replay)

# first do lsn metics as counters
sent_lsn=`pgmetrics -h localhost -U postgres -w --no-pager -f json | jq '.replication_outgoing[0].sent_lsn'`
sent_lsn=`echo "$sent_lsn" | tr -d \"`
sent_lsn=`echo "$sent_lsn" | tr -d /`
sent_lsn=$((16#$sent_lsn))
for i in ${metrics[@]}
do
  value=`pgmetrics -h localhost -U postgres -w --no-pager -f json | jq '.replication_outgoing[0].'$i'_lsn'`
  value=`echo "$value" | tr -d \"`
  value=`echo "$value" | tr -d /`
  value=$((16#$value))	# convert from Hex to integer
  lag=$((sent_lsn - value)) # data lag is determined by this difference
  string=`printf "postgres.replication.master.lag.data.%s:%d|g\n" $i $lag`
  echo -n $string | nc -U -u -w1 /var/run/datadog/dsd.socket
done

# then do lag metrics
for i in ${metrics[@]}
do
  value=`pgmetrics -h localhost -U postgres -w --no-pager -f json | jq '.replication_outgoing[0].'$i'_lag'`
  string=`printf "postgres.replication.master.lag.time.%s:%d|g\n" $i $value`
  echo -n $string | nc -U -u -w1 /var/run/datadog/dsd.socket
done

