# docker build -t imqs/postgres:qa-11 .
FROM postgres:11

RUN apt-get update
RUN apt-get install -y postgis postgresql-11-postgis-3 jq netcat-openbsd cron

COPY initdb /docker-entrypoint-initdb.d
RUN chmod 755 /docker-entrypoint-initdb.d/01-postgres-config.sh
RUN chmod 755 /docker-entrypoint-initdb.d/02-init.sh

HEALTHCHECK --interval=5s --timeout=5s --retries=5 CMD pg_isready -U postgres
