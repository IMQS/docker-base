# docker build -t imqs/postgres:unittest-17 .
FROM postgres:17

RUN apt-get update && \
	apt-get install -y postgis postgresql-17-postgis-3 jq netcat-openbsd cron && \
	rm -rf /var/lib/apt/lists/*

COPY initdb /docker-entrypoint-initdb.d
RUN chmod 755 /docker-entrypoint-initdb.d/01-postgres-config.sh
RUN chmod 755 /docker-entrypoint-initdb.d/02-init.sh
