#!/bin/bash
set -e

echo [*] configuring $REPLICATION_ROLE instance

###########################################################################################
## postgresql.conf
###########################################################################################

echo "
# DB Version: 12
# OS Type: linux
# DB Type: oltp
# Total Memory (RAM): 29 GB
# CPUs num: 24
# Connections num: 300
# Data Storage: ssd

max_connections = 300
shared_buffers = 7424MB
effective_cache_size = 22272MB
maintenance_work_mem = 1856MB
checkpoint_completion_target = 0.9
wal_buffers = 16MB
default_statistics_target = 100
random_page_cost = 1.1
effective_io_concurrency = 200
work_mem = 6335kB
min_wal_size = 2GB
max_wal_size = 8GB
max_worker_processes = 24
max_parallel_workers_per_gather = 4
max_parallel_workers = 24
max_parallel_maintenance_workers = 4" >> "$PGDATA/postgresql.conf"

###########################################################################################
## pg_hba.conf
###########################################################################################

if [[  -n "$REPLICATION_USER" ]]; then
    echo "host replication $REPLICATION_USER 0.0.0.0/0 trust" >> "$PGDATA/pg_hba.conf"
fi
