#!/bin/bash
set -e

if  [ $REPLICATION_ROLE = "slave" ]; then
    # stop postgres instance and reset PGDATA,
    # confs will be copied by pg_basebackup
    pg_ctl -D "$PGDATA" -m fast -w stop
    # make sure standby's data directory is empty
    rm -r "$PGDATA"/*

    pg_basebackup \
         --write-recovery-conf \
         --pgdata="$PGDATA" \
         --wal-method=fetch \
         --username=$REPLICATION_USER \
         --host=$POSTGRES_MASTER_SERVICE_HOST \
         --port=$POSTGRES_MASTER_SERVICE_PORT \
         --progress \
         --verbose

    # useless postgres start to fullfil docker-entrypoint.sh stop
    pg_ctl -D "$PGDATA" \
         -o "-c listen_addresses=''" \
         -w start
fi