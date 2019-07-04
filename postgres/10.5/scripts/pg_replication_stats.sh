#!/bin/bash

metrics=(write flush replay)

DSD_FILE=/var/run/datadog/dsd.socket
DOCKER_NAMESPACE=`printenv DOCKER_NAMESPACE`
DOCKER_SERVICENAME=`printenv DOCKER_SERVICENAME`
# only send metrics if Datadog is running (i.e. dsd.socket exists)
if [[ -e $DSD_FILE ]]; then
    r_outgoing=`pgmetrics -h localhost -U postgres -w --no-pager -f json | jq '.replication_outgoing[0]'`
    if [[ r_outgoing != 'null' ]]; then
	# must be master send outgoing stats, we only send master
	# first do lsn metics as counters
        sent_lsn=`echo $r_outgoing | jq '.sent_lsn'`
        sent_lsn=`echo "$sent_lsn" | tr -d \"`
        sent_lsn=`echo "$sent_lsn" | tr -d /`
        sent_lsn=$((16#$sent_lsn))
        for i in ${metrics[@]}
        do
          value=`echo $r_outgoing | jq '.'$i'_lsn'`
          value=`echo "$value" | tr -d \"`
          value=`echo "$value" | tr -d /`
          value=$((16#$value))	# convert from Hex to integer
          lag=$((sent_lsn - value)) # data lag is determined by this difference
          string=`printf "postgres.replication.master.lag.data.%s:%d|g|#com.docker.stack.namespace:%s,com.docker.swarm.service.name:%s" $i $lag $DOCKER_NAMESPACE $DOCKER_SERVICENAME`
          echo -n $string | nc -U -u -w1 /var/run/datadog/dsd.socket
        done

        # then do lag metrics
        for i in ${metrics[@]}
        do
          value=`echo $r_outgoing | jq '.'$i'_lag'`
          string=`printf "postgres.replication.master.lag.time.%s:%d|g|#com.docker.stack.namespace:%s,com.docker.swarm.service.name:%s" $i $value $DOCKER_NAMESPACE $DOCKER_SERVICENAME`
          echo -n $string | nc -U -u -w1 /var/run/datadog/dsd.socket
        done
    fi
fi

