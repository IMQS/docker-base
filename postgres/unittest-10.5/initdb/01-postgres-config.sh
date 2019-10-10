#!/bin/bash
set -e

echo "wal_level = minimal" >> "$PGDATA/postgresql.conf"
echo "max_wal_senders = 0" >> "$PGDATA/postgresql.conf"
echo "fsync = off" >> "$PGDATA/postgresql.conf"
echo "synchronous_commit = off" >> "$PGDATA/postgresql.conf"
echo "full_page_writes = off" >> "$PGDATA/postgresql.conf"
