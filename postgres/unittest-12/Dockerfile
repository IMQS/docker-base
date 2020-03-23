# docker build -t imqs/postgres:unittest-12 postgres/unittest-12
FROM postgres:12.2

RUN apt-get update
RUN apt-get install -y postgis postgresql-12-postgis-2.4 jq netcat-openbsd cron

COPY initdb /docker-entrypoint-initdb.d
RUN chmod 755 /docker-entrypoint-initdb.d/01-postgres-config.sh 
RUN chmod 755 /docker-entrypoint-initdb.d/02-init.sh
