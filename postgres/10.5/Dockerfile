FROM postgres:10.5

RUN apt-get update
RUN apt-get install -y postgis postgresql-10-postgis-2.4 jq netcat-openbsd cron

COPY initdb /docker-entrypoint-initdb.d
RUN chmod 755 /docker-entrypoint-initdb.d/01-init.sh
RUN chmod 755 /docker-entrypoint-initdb.d/02-postgres-config-updater.sh 
RUN chmod 755 /docker-entrypoint-initdb.d/03-postgres-replication-starter.sh

COPY pgmetrics /usr/bin

# add all scripts
ADD scripts/ /etc/scripts/

# add all crons
RUN mkdir -p /etc/cron.d
ADD crons/ /etc/cron.d/
RUN chmod -R 0644 /etc/cron.d

