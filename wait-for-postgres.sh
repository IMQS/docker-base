#!/bin/bash
#
# wait-for-postgres.sh hostname [port] cmd...
#
# After ensuring that we can connect to Postgres on the given hostname:port combination, run cmd...
# port is optional. The the 2nd parameter is a number, then it is treated as a port.

set -e

host="$1"
shift
port=5432
isport='^[0-9][0-9]+$'
if [[ $1 =~ $isport ]]; then
  port=$1
  shift
fi
cmd="$@"

until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -p "$port" -U "postgres" -c '\q'; do
  >&2 echo "Postgres is unavailable on $host:$port - sleeping"
  sleep 1
done

>&2 echo "Postgres is available at $host:$port - proceeding"
exec $cmd
