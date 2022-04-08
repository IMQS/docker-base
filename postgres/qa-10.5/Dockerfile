# docker build -t imqs/postgres:qa-10.5 postgres/qa-10.5
FROM postgres:10.5

RUN apt-get update
RUN apt-get install -y postgis postgresql-10-postgis-2.4 postgresql-10-postgis-3 \
					   jq netcat-openbsd cron

COPY initdb /docker-entrypoint-initdb.d
RUN chmod 755 /docker-entrypoint-initdb.d/01-postgres-config.sh 
RUN chmod 755 /docker-entrypoint-initdb.d/02-init.sh
