#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	CREATE ROLE imqs SUPERUSER CREATEDB CREATEROLE REPLICATION LOGIN PASSWORD '$POSTGRES_PASSWORD';
	CREATE ROLE auth CREATEDB LOGIN PASSWORD '$AUTH_POSTGRES_PASSWORD';
	CREATE DATABASE auth OWNER auth;
EOSQL
