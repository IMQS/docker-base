#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	CREATE ROLE unittest_user SUPERUSER CREATEDB CREATEROLE REPLICATION LOGIN PASSWORD 'unittest_password';
EOSQL
