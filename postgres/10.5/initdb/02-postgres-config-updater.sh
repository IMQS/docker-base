#!/bin/bash
set -e

echo [*] configuring $REPLICATION_ROLE instance

if [[ -n "$MAX_CONNECTIONS" ]]; then
    echo "max_connections = $MAX_CONNECTIONS" >> "$PGDATA/postgresql.conf"
fi

# We set master replication-related parameters for both slave and master,
# so that the slave might work as a primary after failover.
if [[ -n "$WAL_LEVEL" ]]; then
    echo "wal_level = hot_standby" >> "$PGDATA/postgresql.conf"
fi

if [[ -n "$WAL_KEEP_SEGMENTS" ]]; then
    echo "wal_keep_segments = $WAL_KEEP_SEGMENTS" >> "$PGDATA/postgresql.conf"
fi

if [[ -n "$MAX_WAL_SENDERS" ]]; then
    echo "max_wal_senders = $MAX_WAL_SENDERS" >> "$PGDATA/postgresql.conf"
fi

if [[ -n "$MAX_REPLICATION_SLOTS" ]]; then
    echo "max_replication_slots = $MAX_REPLICATION_SLOTS" >> "$PGDATA/postgresql.conf"
fi

if [[  -n "$REPLICATION_USER" ]]; then
    echo "host replication $REPLICATION_USER 0.0.0.0/0 trust" >> "$PGDATA/pg_hba.conf"
fi
