# sudo docker build -t imqs/postgres:12-heavy .

FROM postgres:12

# Install dependencies and remove build dependencies
RUN echo "deb http://ftp.debian.org/debian stretch-backports main" | \
	tee /etc/apt/sources.list.d/backports.list && \
	apt-get update --fix-missing && \
	apt-get install -y postgis postgresql-12-postgis-3 \
					   jq netcat-openbsd \
					   cron locales locales-all \
					   postgresql-server-dev-12 libcurl4-openssl-dev \
					   git build-essential make clang-11 && \
	git clone https://github.com/pramsey/pgsql-http.git && \
	cd pgsql-http && \
	make && \
	make install && \
	apt-get remove -y postgresql-server-dev-12 git \
					  build-essential make clang-11 && \
	apt-get -y autoremove

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

# enable cron as a sevice
RUN update-rc.d cron defaults
